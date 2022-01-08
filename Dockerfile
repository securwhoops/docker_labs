FROM debian:latest
LABEL maintainer="zero@zero_laba.com"
ADD docker_lab.list /etc/apt/ 
RUN apt-get update && apt upgrade -y 
RUN apt -y install nginx && apt-get clean
RUN rm -rf /var/www/* 
RUN mkdir -p var/www/company.com/img
ADD index.html /var/www/company.com
RUN chmod -R g+rx /var/www/company.com && chmod -R u+rwx /var/www/company.com && chmod -R o+r /var/www/company.com
RUN groupadd -g 1337 moiseev 
RUN useradd -g 1337 andrey #--shell /bin/bash --create-home andrey
RUN usermod -g 1337 andrey || usermod -g moiseev andrey
RUN chgrp -R moiseev /var/www/company.com && chown -R andrey /var/www/company.com
RUN sed -i 's|/var/www/html|/var/www/company.com|g' /etc/nginx/sites-enabled/default
#RUN grep -rl "user " /etc/nginx/
RUN  file="$(grep -rl "user " /etc/nginx/)" && echo "$file"
#RUN  line_file="$(grep -m1 "user " "$file")" && echo "$line_file"
RUN sed -i 's/nginx;/andrey;/1' /etc/nginx/nginx.conf 
