FROM debian:latest

RUN apt update && apt upgrade -y && apt install -y nginx openssl

COPY default /etc/nginx/sites-available/
COPY script.sh .
RUN chmod +x script.sh

CMD ["./script.sh"]