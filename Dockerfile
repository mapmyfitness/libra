FROM golang:1.11 as builder

# Install Glide
ENV GLIDE_VERSION 0.12.3
ENV GLIDE_DOWNLOAD_URL https://github.com/Masterminds/glide/releases/download/v$GLIDE_VERSION/glide-v$GLIDE_VERSION-linux-amd64.tar.gz

RUN curl -fsSL "$GLIDE_DOWNLOAD_URL" -o glide.tar.gz \
	&& tar xvzf glide.tar.gz  linux-amd64/glide \
	&& mv linux-amd64/glide /usr/local/bin \
	&& rm -rf linux-amd64 \
	&& rm glide.tar.gz

# Install dependencies
WORKDIR /go/src/github.com/underarmour/libra
COPY glide.lock glide.lock
COPY glide.yaml glide.yaml
RUN glide install

# Copy sources into the container (see .dockerignore for excluded files)
COPY . .

# Build the service app
RUN CGO_ENABLED=0 GOOS=linux go build -o /go/bin/libra github.com/underarmour/libra

# The 'runtime' container only contains ssl cert chain, and is otherwise an empty base image.
# If you find this too bare, you can instead switch to using a normal base image.
FROM scratch

# Add ssl certs
ADD ./build/ca-certificates.crt /etc/ssl/certs/

# Add binary
COPY --from=builder /go/bin/libra /bin/libra

# Expose service app ports
EXPOSE 8080

# Start the service app. Note we have to use the array style because this container does not include /bin/sh
ENTRYPOINT ["/bin/libra"]
