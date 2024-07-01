.PHONY: hosts all install build up start down remove re list images delete

NAME=inception
DOCC=docker-compose
DOCKER_PATH=/usr/bin/docker-compose

all: create_vol build up

host:
	sudo sed -i 's|localhost|kmordaun.42.fr|g' /etc/hosts

install:
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o $(DOCKER_PATH)
	sudo chown $(USER) $(DOCKER_PATH)
	sudo chmod 777 $(DOCKER_PATH)

build:
	$(DOCC) -f ./srcs/$(DOCC).yml build

rm_vol:
	sudo chown -R $(USER) $(HOME)/data
	sudo chmod -R 777 $(HOME)/data
	rm -rf $(HOME)/data

create_vol:
	mkdir -p $(HOME)/data/mysql
	mkdir -p $(HOME)/data/html
	sudo chown -R $(USER) $(HOME)/data
	sudo chmod -R 777 $(HOME)/data

up:
	$(DOCC) -f ./srcs/$(DOCC).yml up -d

start:
	$(DOCC) -f ./srcs/$(DOCC).yml start

down:
	$(DOCC) -f ./srcs/$(DOCC).yml down

remove:
	sudo chown -R $(USER) $(HOME)/data
	sudo chmod -R 777 $(HOME)/data
	rm -rf $(HOME)/data
	docker volume prune -f
	docker volume rm srcs_wordpress
	docker volume rm srcs_mariadb
	docker container prune -f

re: remove delete build up

list:
	docker ps -a
	docker images -a

delete:
	cd srcs && docker-compose stop nginx
	cd srcs && docker-compose stop wordpress
	cd srcs && docker-compose stop mariadb
	docker system prune -a

logs:
	cd srcs && docker-compose logs mariadb wordpress nginx
