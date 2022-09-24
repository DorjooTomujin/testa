#!/bin/bash

Start () {
    echo ""
    echo "            ------------------"
    echo "           -------------------- "
    echo "          -- DOCKERIZING TOOL --"
    echo "           --------------------"
    echo "            ------------------"

    sleep 1

    echo ""
    read -p "  >>  Press return to start dockerizing... "
    echo ""
}

DockerFile () {
    echo "  >>  Checking Dockerfile..."
    sleep 1
    if [ -e Dockerfile ]
    then
        echo "  >>  Dockerfile already exists"
        BOOL=true
        while [ $BOOL == true ]
        do
        read -p "  >>  Overwrite (y/n): " DOCKERF
        if [ "$DOCKERF" == "y" ]
        then    
            read -p "  >>  Dockerfile Port(default 3000): " PORT
            CMD='CMD [ "yarn", "start" ]'
            if [ -z $PORT ]
            then
            echo "FROM node:18
WORKDIR /nestapp
COPY package*.json .
COPY yarn.lock .
COPY pnpm-lock.yaml .
RUN yarn
COPY . . 
RUN yarn build
EXPOSE 3000
$CMD
" > Dockerfile
            else
            echo "FROM node:18
WORKDIR /nestapp
COPY package*.json .
COPY yarn.lock .
COPY pnpm-lock.yaml .
RUN yarn
COPY . . 
RUN yarn build
EXPOSE $PORT
$CMD
" > Dockerfile
            fi
            echo "  >>  Succesfully overwrote Dockerfile"
            echo ""
            BOOL=false
            sleep 1
        elif [ "$DOCKERF" == "n" ]
        then
            echo "  >>  Did not overwrite Dockerfile"
            echo ""
            BOOL=false
            sleep 1
        elif [ -z $DOCKERF ]
        then
            echo "  >>  Wrong syntax"
        else 
            echo "  >>  Wrong syntax"
        fi
        done
    else
        echo "  >>  Creating Dockerfile..."
        sleep 1
        touch Dockerfile
        read -p "  >>  Dockerfile Port(default 3000): " PORT
            CMD='CMD [ "yarn", "start" ]'
            if [ -z $PORT ]
            then
            echo "FROM node:18
WORKDIR /nestapp
COPY package*.json .
COPY yarn.lock .
COPY pnpm-lock.yaml .
RUN yarn
COPY . . 
RUN yarn build
EXPOSE 3000
$CMD
" > Dockerfile
            else
            echo "FROM node:18
WORKDIR /nestapp
COPY package*.json .
COPY yarn.lock .
COPY pnpm-lock.yaml .
RUN yarn
COPY . . 
RUN yarn build
EXPOSE $PORT
$CMD
" > Dockerfile
        fi
        echo "  >>  Dockerfile created"
        echo ""
        sleep 1
    fi
}

DockerIgnore () {
    echo "  >>  Checking .dockerignore..."
    sleep 1
    if [ -e .dockerignore ]
    then
        echo "  >>  .dockerignore already exists"
        BOOL=true
        while [ $BOOL == true ]
        do
        read -p "  >>  Overwrite (y/n): " DOCKERI
        if [ "$DOCKERI" == "y" ]
        then    
            echo "dist
Dockerfile
.dockerignore
node_modules" > .dockerignore
            echo "  >>  Succesfully overwrote .dockerignore"
            echo ""
            BOOL=false
            sleep 1
        elif [ "$DOCKERI" == "n" ]
        then
            echo "  >>  Did not overwrite .dockerignore"
            echo ""
            BOOL=false
            sleep 1
        else 
            echo "  >>  Wrong syntax"
        fi
        done
    else
        echo "  >>  Creating .dockerignore..."
        sleep 1
        touch .dockerignore
        echo "dist
Dockerfile
.dockerignore
node_modules" > .dockerignore
        echo "  >>  .dockerignore created"
        echo ""
        sleep 1
    fi
}

DockerCompose () {
    echo "  >>  Checking docker-compose.yaml..."
    sleep 1
    if [ -e docker-compose.yaml ]
    then
        echo "  >>  docker-compose.yaml already exists"
        BOOL=true
        while [ $BOOL == true ]
        do
        read -p "  >>  Overwrite (y/n): " DOCKERC
        if [ "$DOCKERC" == "y" ]
        then 
            CPORT="$(grep EXPOSE Dockerfile | cut -c 8-13)" 
            read -p "  >>  Host Port(default 3000): " HPORT
            if [ -z $HPORT ]
            then
            echo "services:
  nestjs-app:
    build:
      context: .
      dockerfile: 'Dockerfile'
    ports:
      - '3000:$CPORT'" > docker-compose.yaml
            echo "  >>  Succesfully overwrote docker-compose.yaml"
            echo ""
            BOOL=false
            sleep 1
            else 
                echo "services:
  nestjs-app:
    build:
      context: .
      dockerfile: 'Dockerfile'
    ports:
      - '$HPORT:$CPORT'" > docker-compose.yaml
            echo "  >>  Succesfully overwrote docker-compose.yaml"
            echo ""
            BOOL=false
            sleep 1
            fi
        elif [ "$DOCKERC" == "n" ]
        then
            echo "  >>  Did not overwrite docker-compose.yaml"
            echo ""
            BOOL=false
            sleep 1
        else 
            echo "  >>  Wrong syntax"
        fi
        done
    else
        echo "  >>  Creating docker-compose.yaml..."
        sleep 1
        touch docker-compose.yaml
        echo "version: '1.29.2'
services:
  nestjs-app:
    build:
      context: .
      dockerfile: 'Dockerfile'
    ports:
      - '3000:3000'" > docker-compose.yaml
        echo "  >>  docker-compose.yaml created"
        echo ""
        sleep 1
    fi
}

End () {
    echo "  >>  Done dockerizing"
    echo "  >>  Type 'docker-compose up' to start container"
    sleep 1
}

Main () {
    Start
    DockerFile
    DockerIgnore
    DockerCompose
    End
}

Main