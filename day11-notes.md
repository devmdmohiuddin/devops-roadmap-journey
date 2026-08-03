# Day 11 Notes - HTTP/HTTPS Inspection and UFW Firewall Configuration


# 1. Parts of an HTTP Request

An HTTP request is sent by the client (browser or `curl`) to the server requesting a resource.

### Example Request

```http
GET /search?q=devops HTTP/1.1
Host: www.google.com
User-Agent: curl/8.1.2
Accept: text/html
```

### Explanation

| Part | Description |
|------|-------------|
| **GET** | HTTP method requesting data from the server. |
| **/search?q=devops** | The requested resource (URL path) with a query parameter. |
| **HTTP/1.1** | The HTTP protocol version. |
| **Host** | Specifies which website the request is for. |
| **User-Agent** | Identifies the client making the request. |
| **Accept** | Tells the server which content type the client accepts. |

---

# 2. Parts of an HTTP Response

The server processes the request and sends a response.

### Example Response

```http
HTTP/1.1 200 OK
Content-Type: text/html; charset=UTF-8
Content-Length: 123353
Server: nginx
```

### Explanation

| Part | Description |
|------|-------------|
| **HTTP/1.1** | HTTP protocol version used in the response. |
| **200 OK** | Status code indicating the request completed successfully. |
| **Content-Type** | Type of data returned by the server. |
| **Content-Length** | Size of the response body in bytes. |
| **Server** | Name of the web server software handling the request. |

---

# 3. Difference Between 502, 503, and 504 Errors

## 502 Bad Gateway

A proxy or load balancer (such as Nginx) receives an invalid response from the backend server.

Possible reasons:

- Backend application crashed
- Backend server is misconfigured
- Communication problem between proxy and backend

---

## 503 Service Unavailable

The server is temporarily unable to handle requests.

Possible reasons:

- Server overload
- Application is under maintenance
- Too many incoming requests

---

## 504 Gateway Timeout

A proxy or load balancer waited too long for the backend server to respond.

Possible reasons:

- Backend application is responding very slowly
- Database queries are taking too long
- Network timeout

---

# 4. Why SSH Must Be Allowed Before Enabling UFW

When connected to a remote server using SSH, enabling UFW before allowing SSH traffic will block port **22**, disconnecting the current SSH session and preventing future SSH connections.

### Incorrect

```bash
sudo ufw enable
```

### Correct

```bash
sudo ufw allow 22/tcp
sudo ufw enable
```

Always allow SSH before enabling the firewall to avoid locking yourself out of the server.

---

# 7. HTTPS Summary

HTTPS is HTTP running over TLS (Transport Layer Security).

The TLS handshake works as follows:

1. The browser sends a **Client Hello** requesting a secure connection.
2. The server replies with a **Server Hello** and its TLS certificate.
3. The browser verifies the certificate using trusted Certificate Authorities (CAs) already installed in the operating system or browser.
4. The browser and server perform a secure key exchange to generate a shared secret.
5. All HTTP communication is then encrypted using that shared secret.

This ensures:

- Confidentiality (data cannot be read by attackers)
- Integrity (data cannot be modified in transit)
- Authentication (the browser verifies the server's identity)

---

# 8. Firewall vs Security Group

## Security Group

A Security Group is a cloud-level firewall (for example, AWS Security Groups).

It filters network traffic **before** it reaches the virtual machine.

```
Internet
    │
    ▼
Security Group
    │
    ▼
EC2 Instance
```

---

## UFW Firewall

`ufw` is an operating system firewall running **inside** the Linux server.

It filters traffic after it reaches the server.

```
Internet
    │
    ▼
Security Group
    │
    ▼
Ubuntu Server
    │
    ▼
UFW Firewall
    │
    ▼
Application
```

Both layers should be configured to improve security (Defense in Depth).

---

# Key Takeaways

- HTTP requests contain a method, URL, protocol version, and headers.
- HTTP responses contain a status code, headers, and optionally a response body.
- HTTPS encrypts HTTP communication using TLS.
- TLS certificates help browsers verify the identity of websites.
- A load balancer distributes traffic across multiple backend servers.
- Firewalls control which network traffic is allowed or blocked.
- A default-deny firewall policy is more secure because only required ports are opened.
- Always allow SSH (port 22) before enabling UFW to avoid losing remote access.
- Security Groups protect cloud instances before traffic reaches the server, while UFW protects the operating system itself.

---

# Commands Practiced

```bash
# Inspect HTTP headers
curl -I https://www.google.com

# UFW Commands
sudo ufw status
sudo ufw status verbose
sudo ufw enable
sudo ufw disable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw delete allow 80/tcp
```