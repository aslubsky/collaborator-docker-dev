FROM aslubsky/collaborator-docker-base:2.0

WORKDIR /var/www/els

CMD ["php", "-S", "0.0.0.0:8080"]
