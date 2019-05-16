FROM ubuntu:16.04

# Install dependencies
RUN apt-get update
RUN apt-get -y install apache2

# Install apache and write hello world message
#RUN echo '<img src=https://memegenerator.net/img/instances/66526139/mission-success.jpg>' > /var/www/html/index.html
RUN echo '<iframe src="https://giphy.com/embed/TZf4ZyXb0lXXi" width="480" height="480" frameBorder="0" class="giphy-embed" allowFullScreen></iframe><p><a href="https://giphy.com/gifs/loop-tumblr-featured-TZf4ZyXb0lXXi">via GIPHY</a></p>' > /var/www/html/index.html
# RUN echo '<h1>Test</h1>' > /var/www/html/index.html

# Configure apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh
RUN echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh
RUN echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh
RUN echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh
RUN chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh