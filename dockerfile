FROM centos:7
WORKDIR /opt
RUN yum install -y patch gcc glibc-devel make openssl-devel pcre-devel zlib-devel gd-devel geoip-devel perl-devel wget git patch
RUN git clone https://github.com/chobits/ngx_http_proxy_connect_module.git
RUN wget http://nginx.org/download/nginx-1.9.2.tar.gz
RUN tar -xzvf nginx-1.9.2.tar.gz
RUN cd nginx-1.9.2/
RUN patch -p1 < ./ngx_http_proxy_connect_module/patch/proxy_connect.patch
RUN ./configure --add-module=/path/to/ngx_http_proxy_connect_module
RUN make && make install
