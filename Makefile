.PHONY: all build up down clean

all: build up

build:
	docker-compose -f srcs/docker-compose.yml build

up:
	docker-compose -f srcs/docker-compose.yml up -d

down:
	docker-compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -af
	if [ "$(docker volume ls -q)" ]; then \
		docker volume rm $(docker volume ls -q); \
	else \
		echo "No volumes to remove"; \
	fi