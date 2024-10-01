#!/bin/bash
apt install jq curl -y
curl -s https://pastebin.com/raw/Gw35j9qh > /etc/tokencf/token
DO=$(cat /etc/xray/domain | cut -d "." -f2-4)
SUB=$(cat /etc/xray/domain | cut -d "." -f1)
IP=$(curl -sS ipv4.icanhazip.com)
SUB_DOMAIN=${SUB}.${DO}
NS_DOMAIN=*.${SUB_DOMAIN}
CF_KEY=$(cat /etc/tokencf/token)
set -euo pipefail
echo "Pointing Domain for $SUB_DOMAIN..."
ZONE=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DO}&status=active" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

	RECORD=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

		RECORD1=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

	if [[ "${#RECORD}" -le 10 ]]; then
		RECORD=$(
			curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
			-H "Authorization: Bearer ${CF_KEY}" \
			-H "Content-Type: application/json" \
			--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","proxied":false}' | jq -r .result.id
		)
	else
		RESULT=$(
		curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" \
		--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","proxied":false}'
	)
	fi
		
	if [[ "${#RECORD1}" -le 10 ]]; then
		RECORD2=$(
			curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
			-H "Authorization: Bearer ${CF_KEY}" \
			-H "Content-Type: application/json" \
			--data '{"type":"A","name":"'${NS_DOMAIN}'","content":"'${IP}'","proxied":true}' | jq -r .result.id
		)
	else

	RESULT2=$(
		curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD1}" \
		-H "Authorization: Bearer ${CF_KEY}" \
		-H "Content-Type: application/json" \
		--data '{"type":"A","name":"'${NS_DOMAIN}'","content":"'${IP}'","proxied":true}'
	)	
	fi
sleep 10
clear