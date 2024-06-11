all: up

OS := $(shell uname)
ifeq ($(OS),Linux)
    OPEN := xdg-open
else ifeq ($(OS),Darwin)
    OPEN := open
endif

up:
	docker-compose up --build

open: up
	@$(OPEN) http://localhost:8888
