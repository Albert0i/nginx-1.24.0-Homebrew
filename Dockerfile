FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV NGINX_VER=1.20.2

USER ContainerAdministrator
RUN setx /M PATH "%PATH%;C:\nginx" &&\
    curl -OL "http://nginx.org/download/nginx-1.20.2.zip" &&\ 
    tar -xvf nginx-1.20.2.zip &&\
	ren nginx-1.20.2 nginx &&\
    del nginx-1.20.2.zip &&\
    dir 
USER ContainerUser

# In case you want to customized the image. 
#COPY conf/nginx.conf /nginx/conf/nginx.conf
#

WORKDIR /nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

#
# Build
#   docker build -t nginx:1.20.2-servercore-ltsc2019 . --no-cache 
#
# Test 
#   docker run -it --rm nginx:1.20.2-servercore-ltsc2019 cmd 
#   nginx -t 
#
# Run 
#   docker run --name nginx --rm -d -p 8080:80 nginx:1.20.2-servercore-ltsc2019
#   docker run --name nginx --rm -d -p 8080:80 -v c:\Docker\nginx-1.20.2-Homebrew\conf:c:\nginx\conf nginx:1.20.2-servercore-ltsc2019
#
# Reference:
# 1. nginx for Windows
#    http://nginx.org/en/docs/windows.html
# 2. Dockerfile - ENV與ARG參數
#    https://peihsinsu.gitbooks.io/docker-note-book/content/dockerfile-env-vs-arg.html
#

#
# EOF (2022/04/29)
#