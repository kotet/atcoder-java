FROM ubuntu:18.04

RUN set -x && apt update && apt install -y --no-install-recommends openjdk-11-jdk