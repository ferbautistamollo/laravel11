# DOCKER-COMPOSE TEMPLATE

Plantilla para dockerizar un proyecto Laravel

## Requerimientos

* Docker
* Docker Compose
* Php
* Composer
* Postgres


```sh
sudo apt update
apt install docker
apt install docker-compose
```
## Clonar el proyecto

```sh
git clone https://github.com/MUTUAL-DE-SERVICIOS-AL-POLICIA/DockerComposeTemplate
```

## Crear un nuevo proyecto en Laravel con el nombre src

```sh
composer create-project laravel/laravel src

laravel new src
```

## Realizar las modificaciones de los nombres de red, puertos a usar y nombres de los contenedores en el proyecto que se encuentran en el archivo docker-compose.yml

* networks
* server
* * ports:
* * container_name
* * networks
* php
* * ports:
* * container_name
* * networks
* redis
* * ports:
* * container_name
* * networks

## levantar el proyecto

```sh
docker-compose up -d
```

## Verificar los contenedores

```sh
docker-compose ps -a
```

## Ingresar al contenedor del proyecto

```sh
docker-compose exec php sh
```