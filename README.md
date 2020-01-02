# Auto DDNS Mock with Cloudflare

This is a simple shell script project that turn your Cloudflare into free DDNS.

## Requirement

- A registered domain name
- A Cloudflare account (free plan is supported)
- A(n) Linux/Unix environment (**ATTENTION: WSL/macOS hasn't been tested about the platform compatibility.**)
- A power on machine with internet connection 24 hours 365 days every year.

## Recommended

- A geek heart to handle debuging
- Give a shining star for this repo. (thanks, that'll make me a good day :D)

## How to

1. Clone it :D

```sh
git clone https://github.com/Aries0d0f/auto-ddns-mock-with-cloudflare.git ddns
```

2. Change directory into the project (**this step is very important and necessary**):

```sh
cd path/to/ddns
```

3. All config arguments is in the `runtime.sh`, and you should set them up first:

**`API setup`**

- [Create your Cloudflare API Token](https://dash.cloudflare.com/profile/api-tokens)
- Zone ID displayed at the bottom-right of your Cloudflare dashboard (Overview page).
![Zone ID](https://raw.githubusercontent.com/Aries0d0f/auto-ddns-mock-with-cloudflare/master/example/zone-id.png)


```sh
  6 # [Cloudflare API Args]
  7 ZONE_ID="YOUR_CLOUDFLARE_ZONE_ID";
  8 X_AUTH_EMAIL="YOUR_CLOUDFLARE_AUTH_EMAIL";
  9 X_AUTH_KEY="YOUR_CLOUDFLARE_AUTH_KEY";
```

**`IPv4 DNS Record`**

- [How to find the DNS Record ID](#how-to-find-the-dns-record-id)

```sh
 19 # [DNS IPv4 Record Args]
 20 IPv4_RECORD_ID="YOUR_CLOUDFLARE_DNS_RECORD_ID";
 21 IPv4_RECORD_TYPE="A";
 22 IPv4_DOMAIN_NAME="srv1.example.com";
 23 IPv4_TTL="120";
 24 IPv4_CDN_PROXY="false"
```

**`IPv6 DNS Record`**

```sh
 26 # [DNS IPv6 Record Args]
 27 IPv6_RECORD_ID="YOUR_CLOUDFLARE_DNS_RECORD_ID";
 28 IPv6_RECORD_TYPE="AAAA";
 29 IPv6_DOMAIN_NAME="srv1.example.com";
 30 IPv6_TTL="120";
 31 IPv6_CDN_PROXY="false"
```

4. Run the `setup.sh`:

```sh
./setup.sh
```

5. Enjoy!

## How to find the DNS Record ID

Replace {...} with your own data.

```sh
curl -X GET "https://api.cloudflare.com/client/v4/zones/{YOUR_CLOUDFLARE_ZONE_ID}/dns_records" \
-H "x-auth-email:{YOUR_CLOUDFLARE_AUTH_EMAIL}" \
-H "x-auth-key:{YOUR_CLOUDFLARE_AUTH_KEY}" \
-H "content-type: application/json"
```

If the data was correct it must return a JSON format content like this:

```json
{
  "result": [
    {
      "id": "123456789abcdefxxxxxxxxxxxxxxxxx", <- this is your DNS Record ID.
      "type": "A",
      "name": "srv1.example.com",
      "content": "127.0.0.1",
      "proxiable": true,
      "proxied": false,
      "ttl": 120,
      "locked": false,
      "zone_id": "123456789abcdefxxxxxxxxxxxxxxxxx", <- this is your Zone ID.
      "zone_name": "example.com",
      "modified_on": "2020-01-02T03:09:32.475673Z",
      "created_on": "2020-01-02T03:09:32.475673Z",
      "meta": {
        "auto_added": false,
        "managed_by_apps": false,
        "managed_by_argo_tunnel": false
      }
    },
    ...,
  ],
  "result_info": {
    ...
  },
  "success": true,
  "errors": [],
  "messages": []
}
```

## References

- [Cloudflare API Documents](https://api.cloudflare.com/)
- [Manage dynamic IPs in Cloudflare DNS programmatically](https://support.cloudflare.com/hc/en-us/articles/360020524512-Manage-dynamic-IPs-in-Cloudflare-DNS-programmatically)