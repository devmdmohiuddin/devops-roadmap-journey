# Day 10 – Networking Fundamentals: DNS, IP, and Port Tracing

## 1. The Full Journey: From Typing a URL to Seeing a Webpage

When I type a URL like `https://google.com` into my browser, a lot happens behind the scenes before the webpage appears.

### Step 1: Browser Cache
The browser first checks whether it already knows the IP address for the domain. If it's cached and hasn't expired, it uses that immediately.

### Step 2: Operating System Cache
If the browser doesn't have the answer, the operating system checks its own DNS cache.

### Step 3: Recursive DNS Resolver
If the OS also doesn't know the answer, it sends the DNS query to a recursive DNS resolver (usually provided by my ISP or configured manually).

### Step 4: Root DNS Server
If the resolver doesn't have the answer cached, it asks a Root DNS Server, which tells it where to find the `.com` Top-Level Domain (TLD) servers.

### Step 5: Top-Level Domain (TLD) Server
The `.com` TLD server tells the resolver which Authoritative Name Server is responsible for `google.com`.

### Step 6: Authoritative Name Server
The authoritative name server returns the actual DNS record (A or AAAA record), which contains Google's IP address.

### Step 7: Caching the Result
The recursive resolver caches the response according to its TTL (Time To Live) and returns the IP address to my computer. My operating system and browser may also cache it for future requests.

### Step 8: TCP Connection
Now that my computer knows the IP address, it opens a TCP connection to Google's server.

Since the URL uses HTTPS, it connects to **port 443**.

### Step 9: TLS Handshake
The browser and server perform a TLS handshake to establish an encrypted connection and verify the server's certificate.

### Step 10: HTTP Request
The browser sends an HTTP request (such as `GET /`) to Google's web server.

### Step 11: Server Response
The server processes the request and sends back an HTTP response containing HTML, CSS, JavaScript, images, and other resources.

### Step 12: Browser Rendering
The browser downloads the resources, builds the page, executes JavaScript, and renders the webpage that I see.

---

# 2. Client-Server Model

The browser acts as the **client** because it initiates requests.

Google's web server acts as the **server** because it listens for incoming requests (typically on port 443 for HTTPS) and responds with the requested data.

One server can handle many clients simultaneously, which is how websites serve thousands or even millions of users.

---

# 3. Ports

An IP address identifies a machine on the network, while a port identifies a specific service running on that machine.

Some common ports are:

- Port 80 → HTTP
- Port 443 → HTTPS
- Port 22 → SSH

When I visit `https://google.com`, my browser connects to Google's IP address on **port 443**.

---

# 4. Networking Tools

## ping

`ping` tests basic network connectivity.

It sends **ICMP Echo Request** packets and waits for **ICMP Echo Reply** packets.

It tells me:

- Whether the host is reachable.
- Network latency (round-trip time).

It does **not** verify whether a web server or application is running.

---

## nslookup

`nslookup` performs a DNS lookup.

It converts a domain name into its IP address.

It is useful for quickly checking whether DNS resolution is working.

---

## dig

`dig` is a more advanced DNS lookup tool.

It provides detailed DNS information such as:

- DNS record type
- TTL
- DNS server used
- Query time
- Response status
- Authority information

It is the preferred DNS debugging tool in DevOps.

---

## curl

`curl` behaves like a web client.

It actually connects to a web server and performs an HTTP/HTTPS request.

It can be used to:

- Check whether a web service is responding.
- View HTTP response headers.
- Test APIs.
- Download files.
- Debug HTTP connectivity.

Unlike `ping`, `curl` confirms that the application itself is responding.

---

# 5. Terminal Output

## ping

```bash
mohi@fedora:~/Desktop/hands-on-works/devOps$ ping -c 4 google.com
PING google.com (142.251.220.110) 56(84) bytes of data.
64 bytes from pnmaaa-be-in-f14.1e100.net (142.251.220.110): icmp_seq=1 ttl=114 time=28.0 ms
64 bytes from pnmaaa-be-in-f14.1e100.net (142.251.220.110): icmp_seq=2 ttl=114 time=27.8 ms
64 bytes from pnmaaa-be-in-f14.1e100.net (142.251.220.110): icmp_seq=3 ttl=114 time=29.0 ms
64 bytes from pnmaaa-be-in-f14.1e100.net (142.251.220.110): icmp_seq=4 ttl=114 time=29.6 ms

--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3004ms
rtt min/avg/max/mdev = 27.798/28.603/29.591/0.733 ms
```

---

## nslookup

```bash
mohi@fedora:~/Desktop/hands-on-works/devOps$ nslookup google.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   google.com
Address: 142.251.220.110
Name:   google.com
Address: 2404:6800:4007:82f::200e
```

---

## dig

```bash
mohi@fedora:~/Desktop/hands-on-works/devOps$ dig google.com

; <<>> DiG 9.18.48 <<>> google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 17956
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494

;; QUESTION SECTION:
;google.com.            IN      A

;; ANSWER SECTION:
google.com.     132     IN      A       142.251.220.110

;; Query time: 0 msec
;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
;; WHEN: Sun Aug 02 13:38:32 +06 2026
;; MSG SIZE  rcvd: 55
```

---

## Summary

This lab helped me understand the complete networking flow behind loading a webpage:

1. DNS resolves the domain name into an IP address.
2. The client opens a connection to the server using the appropriate port.
3. HTTPS establishes encryption using TLS.
4. The client sends an HTTP request.
5. The server processes the request and sends an HTTP response.
6. The browser renders the webpage.

I also learned the differences between networking tools:

- **ping** checks basic network reachability using ICMP.
- **nslookup** performs simple DNS lookups.
- **dig** provides detailed DNS information for troubleshooting.
- **curl** performs actual HTTP/HTTPS requests to verify that a web service is working.