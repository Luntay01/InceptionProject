.PHONY: all build up down clean

all:
	docker-compose -f srcs/docker-compose.yml build
	docker-compose -f srcs/docker-compose.yml up -d
build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker-compose -f srcs/docker-compose.yml down
	docker system prune -af
	if [ "$$(docker volume ls -q)" != "" ]; then docker volume rm $$(docker volume ls -q); fi
