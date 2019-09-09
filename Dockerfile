FROM golang:1.10-alpine as builder

WORKDIR /go/src/github.com/YotpoLtd/libra/
# Copy sources into the container (see .dockerignore for excluded files)
COPY . /go/src/github.com/YotpoLtd/libra/

# Build the service app
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/bin/libra .

# The 'runtime' container only contains ssl cert chain, and is otherwise an empty base image.
# If you find this too bare, you can instead switch to using a normal base image.
FROM alpine:latest

RUN apk --no-cache add ca-certificates

# Add binary
COPY --from=builder /go/bin/libra /bin/libra

# Expose service app ports
EXPOSE 8646

# Start the service app. Note we have to use the array style because this container does not include /bin/sh
ENTRYPOINT ["/bin/libra"]