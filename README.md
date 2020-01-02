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

```sh
  6 # [Cloudflare API Args]
  7 ZONE_ID="YOUR_CLOUDFLARE_API_ID";
  8 X_AUTH_EMAIL="YOUR_CLOUDFLARE_AUTH_EMAIL";
  9 X_AUTH_KEY="YOUR_CLOUDFLARE_AUTH_KEY";
```

**`IPv4 DNS Record`**

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
