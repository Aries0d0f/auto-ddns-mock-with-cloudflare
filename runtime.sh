#!/bin/sh

VERSION="v1.0.0";
AUTHOR="@Aries0d0f";

# [Cloudflare API Args]
ZONE_ID="YOUR_CLOUDFLARE_API_ID";
X_AUTH_EMAIL="YOUR_CLOUDFLARE_AUTH_EMAIL";
X_AUTH_KEY="YOUR_CLOUDFLARE_AUTH_KEY";

# [Local Environment Args]
ENV_PATH="$(pwd)";
LOG_PATH="$ENV_PATH/log";
CURRENT_IP_PATH="$LOG_PATH/current_ip.log";
CURRENT_IP=`cat "$CURRENT_IP_PATH"`;
NEW_IPv4=`curl -s http://ipv4.icanhazip.com`;
NEW_IPv6=`curl -s http://ipv6.icanhazip.com`;

# [DNS IPv4 Record Args]
IPv4_RECORD_ID="YOUR_CLOUDFLARE_DNS_RECORD_ID";
IPv4_RECORD_TYPE="A";
IPv4_DOMAIN_NAME="srv1.example.com";
IPv4_TTL="120";
IPv4_CDN_PROXY="false"

# [DNS IPv6 Record Args]
IPv6_RECORD_ID="YOUR_CLOUDFLARE_DNS_RECORD_ID";
IPv6_RECORD_TYPE="AAAA";
IPv6_DOMAIN_NAME="srv1.example.com";
IPv6_TTL="120";
IPv6_CDN_PROXY="false"

echo "========================================";
echo "[Auto DDNS mocking with Cloudflare]";
echo "Version:              $VERSION by $AUTHOR";
echo "Environment Path:     $ENV_PATH";
echo "Log Path:             $LOG_PATH";
sleep 1;
echo "Current IP Recoard:   $CURRENT_IP";
echo "Fetching IP...\rNow IP Address:       $NEW_IPv4";
sleep 2;
echo "----------------------------------------";
echo "Record to Modify:";
echo "[$IPv4_RECORD_ID] ⭢ $IPv4_RECORD_TYPE $NEW_IPv4 $IPv4_DOMAIN_NAME ttl:$IPv4_TTL CDN Proxy:$IPv4_CDN_PROXY";
echo "[$IPv6_RECORD_ID] ⭢ $IPv6_RECORD_TYPE $NEW_IPv6 $IPv6_DOMAIN_NAME ttl:$IPv6_TTL CDN Proxy:$IPv6_CDN_PROXY";
echo "========================================";
echo "Sending Request...";
sleep 2;
if [ "$NEW_IPv4" = "$CURRENT_IP" ]
then
	echo "No Change in IP Adddress, exit."
	else
		curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$IPv4_RECORD_ID" \
			-H "X-Auth-Email: $X_AUTH_EMAIL" \
			-H "X-Auth-Key: $X_AUTH_KEY" \
			-H "Content-Type: application/json" \
			--data '{"type":"'$IPv4_RECORD_TYPE'","name":"'$IPv4_DOMAIN_NAME'","content":"'$NEW_IPv4'","ttl":'$IPv4_TTL',"proxied":'$IPv4_CDN_PROXY'}' > /dev/null;

		curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$IPv4_RECORD_ID" \
			                        -H "X-Auth-Email: $X_AUTH_EMAIL" \
						                        -H "X-Auth-Key: $X_AUTH_KEY" \
									                        -H "Content-Type: application/json" \
												                        --data '{"type":"'$IPv6_RECORD_TYPE'","name":"'$IPv6_DOMAIN_NAME'","content":"'$NEW_IPv6'","ttl":'$IPv6_TTL',"proxied":'$IPv6_CDN_PROXY'}' > /dev/null;
		echo $NEW_IPv4 > $CURRENT_IP_PATH;
		echo "Update successful.";
	fi
