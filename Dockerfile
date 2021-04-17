FROM arm64v8/alpine

RUN apk add --update tzdata
ENV TZ=Europe/Zurich

ENV FRP_VERSION 0.36.2
RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_arm64.tar.gz \
    && tar -xf frp_${FRP_VERSION}_linux_arm64.tar.gz \
    && mkdir /frpc \
    && cp frp_${FRP_VERSION}_linux_arm64/frpc* /frpc \
    && rm -rf frp_${FRP_VERSION}_linux_arm64*
    
RUN rm -rf /var/cache/apk/*

RUN mkdir /conf
VOLUME /conf

WORKDIR /frpc
ENTRYPOINT ["./frpc","-c","/conf/frpc.ini"]
