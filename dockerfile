FROM centos:7
WORKDIR /opt
RUN cd /opt
RUN yum install -y patch gcc glibc-devel make openssl-devel pcre-devel zlib-devel gd-devel geoip-devel perl-devel wget gi
t patch
RUN git clone https://github.com/chobits/ngx_http_proxy_connect_module.git
RUN wget http://nginx.org/download/nginx-1.9.2.tar.gz
RUN tar -xzvf nginx-1.9.2.tar.gz
RUN cd nginx-1.9.2/
RUN patch -p1 < /opt/ngx_http_proxy_connect_module-master/patch/proxy_connect.patch
RUN ./configure --with-http_ssl_module --add-module=/opt/ngx_http_proxy_connect_module-master/
RUN make && make install
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
