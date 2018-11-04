# IPv6 test in Docker (which failes)

HTTPS webservices in a Docker-swarm failes when using IPv6, but it works over IPv4 :-/
Below are the test to easly see when it failes. The server and client must be dualstacked.

In the documentatio below, the server IP addresses are 2001:db8:db0::5 and 192.168.10.5

## Step 1 - Build a http-webservice

First step, clone the repo.

```
mkdir venv
python3 -m venv venv/
. venv/bin/activate
pip3 install gunicorn

gunicorn -w 4 -b [::]:5678 myapp:app
```

Verify:
```
$ curl --connect-timeout 15 http://[2001:db8:db0::5]:5678
Hello, World!

$ curl --connect-timeout 15 http://192.168.10.5:5678
Hello, World!
```

## Step 2 - Make it a https-webservice
```
gunicorn -w 4 -b [::]:5678 --certfile=ssl-cert-snakeoil.pem --keyfile=ssl-cert-snakeoil.key myapp:app
```

Verify:
```
$ curl --connect-timeout 15 -k https://[2001:db8:db0::5]:5678
Hello, World!

$ curl --connect-timeout 15 -k https://192.168.10.5:5678
Hello, World!
```

## Step 3 - Build and run it via docker run
```
docker build -t docker_ipv6_test .
docker run --rm --init -p 5678:5678 docker_ipv6_test
```

Verify:
```
$ curl --connect-timeout 15 -k https://[2001:db8:db0::5]:5678
Hello, World!

$ curl --connect-timeout 15 -k https://192.168.10.5:5678
Hello, World!
```

## Step 4 - Deploy in docker
```
docker stack deploy -c docker-compose.yml ipv6_test
```

Verify:
```
$ curl --connect-timeout 15 -k https://[2001:db8:db0::5]:5678
curl: (28) Operation timed out after 0 milliseconds with 0 out of 0 bytes received

$ curl --connect-timeout 15 -k https://192.168.10.5:5678
Hello, World!
```
