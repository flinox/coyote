FROM golang:alpine

#ENV GOPATH /go 
#ENV PATH /usr/local/go/bin:${PATH}

WORKDIR /go

# When build container
RUN apk update && apk upgrade && apk add build-base && apk add git && apk add curl && mkdir /go/src/gopath

# When container start
#CMD ["go", "run", "main.go"]





# docker build -t coyote_connect .
# docker run -it --rm --hostname go --name go flinox/go
