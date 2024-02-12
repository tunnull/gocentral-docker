FROM golang:1.21

WORKDIR /GoCentral

COPY go.mod go.sum ./
COPY . .

#PREBUILD GOCENTRAL
RUN go build .


#PORTS
EXPOSE 16015/udp
EXPOSE 16016/udp

#DEFAULT ENV-VARS
ENV GAME="RB3:PS3"
ENV LISTENINGIP=""
ENV ADDRESS=""

CMD ["/bin/bash", "./launcher.sh"]
