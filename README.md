```
mkdir venv
python3 -m venv venv/
. venv/bin/activate

gunicorn -w 4 -b [::]:5678 myapp:app
gunicorn -w 4 -b [::]:5678 --certfile=ssl-cert-snakeoil.pem --keyfile=ssl-cert-snakeoil.key myapp:app
