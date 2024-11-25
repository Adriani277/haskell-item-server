FROM haskell:latest as deps
WORKDIR /myapp

COPY stack.yaml stack.yaml.lock package.yaml ./

RUN stack build --dependencies-only --install-ghc

FROM haskell:latest as builder

COPY --from=deps /root/.stack /root/.stack

WORKDIR /myapp

COPY . .

RUN stack install --local-bin-path ./ --install-ghc

FROM alpine:latest

RUN apk add --no-cache gmp gcompat

WORKDIR /myapp

COPY --from=builder /myapp/item-server .

CMD ["./item-server"]
