#
# Import and expose environment variables
#
cnf ?= .env
include $(cnf)
export $(shell sed 's/=.*//' $(cnf))

#
# Main
#
.PHONY: help prune config my-ciapp

help:
	@echo
	@echo "Usage: make TARGET"
	@echo
	@echo "Nginx Dockerize project automation helper for Windows version 1.1"
	@echo
	@echo "Targets:"
	@echo "	build		build custom image"
	@echo "	up  		start the server"
	@echo "	down 		stop the server"
	@echo "	ps 		show running containers"
	@echo "	logs		server logs"
	@echo "	xlogs		nginx access logs"
	@echo "	xreload		reload nginx configuration"
	@echo "	config		edit configuration"

#
# build custom image
#
build:
	docker-compose build --no-cache

#
# start the server
#
up:
	docker-compose up -d --remove-orphans

#
# stop the server
#
down:
	docker-compose down -v

#
# show running containers 
#
ps:
	docker-compose ps

#
# server logs
#
logs:
	docker-compose logs

#
# nginx access logs
#
xlogs:
	docker-compose exec nginx cmd /c type c:\nginx\logs\access.log

#
# reload nginx configuration
#
xreload:
	docker-compose exec nginx cmd /c nginx -s reload

#
# edit configuration
#
config:
	nano .env

#
# EOF (2022/06/02)
#