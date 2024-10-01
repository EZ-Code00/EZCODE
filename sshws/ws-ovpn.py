#!/usr/bin/python3
import socket, threading, select, sys, time, logging, os, hashlib, base64

# Direktori dan file log
log_directory = "/var/log/proxy"
log_file = "proxy.log"

# Membuat direktori jika belum ada
if not os.path.exists(log_directory):
    os.makedirs(log_directory)

# Path lengkap ke file log
log_path = os.path.join(log_directory, log_file)

# Konfigurasi logging
logging.basicConfig(filename=log_path, level=logging.DEBUG, 
                    format='%(asctime)s - %(levelname)s - %(message)s')

# Log tambahan ke console
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.DEBUG)
console_handler.setFormatter(logging.Formatter('%(asctime)s - %(levelname)s - %(message)s'))
logging.getLogger().addHandler(console_handler)

# Listen
LISTENING_ADDR = '0.0.0.0'
if sys.argv[1:]:
    LISTENING_PORT = sys.argv[1]
else:
    LISTENING_PORT = 10015

# Pass
PASS = ''

# CONST
BUFLEN = 4096 * 4
TIMEOUT = 60
DEFAULT_HOST = '127.0.0.1:1194'
GUID = '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'

class Server(threading.Thread):
    def __init__(self, host, port):
        threading.Thread.__init__(self)
        self.running = False
        self.host = host
        self.port = port
        self.threads = []
        self.threadsLock = threading.Lock()

    def run(self):
        logging.info(f"Server listening on {self.host}:{self.port}")
        self.soc = socket.socket(socket.AF_INET)
        self.soc.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.soc.settimeout(2)
        intport = int(self.port)
        self.soc.bind((self.host, intport))
        self.soc.listen(0)
        self.running = True

        try:
            while self.running:
                try:
                    c, addr = self.soc.accept()
                    c.setblocking(1)
                    logging.info(f"Accepted connection from {addr}")
                except socket.timeout:
                    continue

                conn = ConnectionHandler(c, self, addr)
                conn.start()
                self.addConn(conn)
        finally:
            self.running = False
            self.soc.close()

    def addConn(self, conn):
        try:
            self.threadsLock.acquire()
            if self.running:
                self.threads.append(conn)
        finally:
            self.threadsLock.release()

    def removeConn(self, conn):
        try:
            self.threadsLock.acquire()
            if conn in self.threads:
                self.threads.remove(conn)
        finally:
            self.threadsLock.release()

    def close(self):
        try:
            self.running = False
            self.threadsLock.acquire()

            threads = list(self.threads)
            for c in threads:
                c.close()
        finally:
            self.threadsLock.release()

class ConnectionHandler(threading.Thread):
    def __init__(self, socClient, server, addr):
        threading.Thread.__init__(self)
        self.clientClosed = False
        self.targetClosed = True
        self.client = socClient
        self.client_buffer = b''  # Buffer diubah menjadi bytes
        self.server = server
        self.addr = addr
        self.method = None
        
    def close(self):
        try:
            if not self.clientClosed:
                self.client.shutdown(socket.SHUT_RDWR)
                self.client.close()
                logging.info(f"Closed client connection from {self.addr}")
        except Exception as e:
            logging.error(f"Error closing client connection: {str(e)}")
        finally:
            self.clientClosed = True

        try:
            if not self.targetClosed:
                self.target.shutdown(socket.SHUT_RDWR)
                self.target.close()
                logging.info(f"Closed target connection for {self.addr}")
        except Exception as e:
            logging.error(f"Error closing target connection: {str(e)}")
        finally:
            self.targetClosed = True

    def run(self):
        try:
            self.client_buffer = self.client.recv(BUFLEN)
            if not self.client_buffer:
                logging.error(f"No data received from {self.addr}")
                return

            logging.debug(f"Received buffer from {self.addr}: {self.client_buffer}")

            # Decode buffer ke str untuk pencarian header
            buffer_str = self.client_buffer.decode('utf-8')

            # Periksa apakah client mengirimkan permintaan WebSocket
            upgrade_header = self.findHeader(buffer_str, 'Upgrade')
            connection_header = self.findHeader(buffer_str, 'Connection')
            websocket_key = self.findHeader(buffer_str, 'Sec-WebSocket-Key')
            
            logging.debug(f"Upgrade Header: {upgrade_header}")
            logging.debug(f"Connection Header: {connection_header}")
            logging.debug(f"WebSocket Key: {websocket_key}")

            # Cek apakah header ada
            if upgrade_header and connection_header and websocket_key:
                logging.info(f"WebSocket headers are present. Proceeding with connection.")
                # Dapatkan path dari header X-Real-Host
                path = self.findHeader(buffer_str, 'X-Real-Host') or '127.0.0.1:109'
                self.method_CONNECT(path)  # Panggil method CONNECT
            else:
                logging.info(f"Missing WebSocket headers from {self.addr}, adding default WebSocket headers.")

                # Jika tidak ada header WebSocket, tambahkan header default
                if not upgrade_header:
                    upgrade_header = 'websocket'
                
                if not connection_header:
                    connection_header = 'Upgrade'

                if not websocket_key:
                    # Generate a default WebSocket key
                    websocket_key = base64.b64encode(os.urandom(16)).decode('utf-8')
                
                # Menghasilkan `Sec-WebSocket-Accept` berdasarkan `Sec-WebSocket-Key`
                websocket_accept = self.calculate_websocket_accept(websocket_key)
                logging.debug(f"Sec-WebSocket-Accept: {websocket_accept}")

                # Mengirimkan respons WebSocket upgrade
                response = (f"HTTP/1.1 101 <b><font color='green'>Newbie Server Connected</font></b>\r\n"
                            f"Upgrade: {upgrade_header}\r\n"
                            f"Connection: {connection_header}\r\n"
                            f"Sec-WebSocket-Accept: {websocket_accept}\r\n\r\n")

                self.client.sendall(response.encode('utf-8'))
                logging.info(f"Sent WebSocket handshake response to {self.addr}")
                
                # Dapatkan path dari header X-Real-Host
                path = self.findHeader(buffer_str, 'X-Real-Host') or '127.0.0.1:109'
                self.method_CONNECT(path)  # Panggil method CONNECT
                
        except Exception as e:
            logging.error(f"Error handling connection from {self.addr}: {str(e)}")
        finally:
            self.close()
            self.server.removeConn(self)

    def findHeader(self, head, header):
        """Find a specific header in the HTTP request."""
        headers = head.split('\r\n')
        for h in headers:
            if h.lower().startswith(header.lower() + ':'):
                return h.split(':', 1)[1].strip()
        logging.debug(f"{header} not found in the header")
        return ''

    def calculate_websocket_accept(self, key):
        """Menghitung `Sec-WebSocket-Accept` berdasarkan `Sec-WebSocket-Key`."""
        accept_key = key + GUID
        sha1_result = hashlib.sha1(accept_key.encode('utf-8')).digest()
        accept_value = base64.b64encode(sha1_result).decode('utf-8')
        logging.debug(f"Calculated Sec-WebSocket-Accept: {accept_value}")
        return accept_value

    def connect_target(self, host):
        try:
            logging.info(f"Connecting to target: {host}")

            # Memisahkan hostname dan port
            if ':' in host:
                host, port = host.split(':')
                port = int(port)
            else:
                port = 443 if self.method == 'CONNECT' else sys.argv[1]

            # Menyambungkan ke target
            (soc_family, soc_type, proto, _, address) = socket.getaddrinfo(host, port)[0]
            self.target = socket.socket(soc_family, soc_type, proto)
            self.targetClosed = False
            self.target.connect(address)
            logging.info(f"Successfully connected to {host}:{port}")
        except Exception as e:
            logging.error(f"Failed to connect to target {host}: {str(e)}")
            raise e

    def method_CONNECT(self, path):
        logging.info(f"CONNECT {path} from {self.addr}")

        self.method = 'CONNECT'

        if not path:
            logging.error("No path provided for CONNECT")
            return

        self.connect_target(path)
        self.target.setblocking(0)
        self.client.setblocking(0)

        # Mengelola komunikasi antara client dan target
        while True:
            try:
                r, w, e = select.select([self.client, self.target], [], [])
                if self.client in r:
                    data = self.client.recv(BUFLEN)
                    if data:
                        logging.debug(f"Received data from client: {data}")
                        if data.startswith(b"HTTP/1.0 200 Connection established"):
                            logging.info("Connection established, proceeding with WebSocket communication")
                            continue
                        self.target.sendall(data)
                    else:
                        break

                if self.target in r:
                    data = self.target.recv(BUFLEN)
                    if data:
                        logging.debug(f"Received data from target: {data}")
                        self.client.sendall(data)
                    else:
                        break
            except Exception as e:
                logging.error(f"Error during communication: {str(e)}")
                break

        self.close()

if __name__ == '__main__':
    try:
        port = LISTENING_PORT
        server = Server(LISTENING_ADDR, port)
        server.start()

        while True:
            time.sleep(1)

    except KeyboardInterrupt:
        logging.info("Server shutting down.")
        server.close()
        sys.exit(0)
