# Dockerfile describing a basic test container
FROM ubuntu

# Install Node/NPM + Other Stuff
# See https://www.exratione.com/2013/12/angularjs-headless-end-to-end-testing-with-protractor-and-selenium/
# See https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
RUN apt-get update
RUN apt-get install -y python-software-properties python g++ make git xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xserver-xorg-core dbus-x11 libfontconfig1-dev chromium-browser default-jdk
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
RUN npm install -g grunt-cli bower phantomjs

# Configure xvfb service
ADD lib/xvfb /etc/init.d/xvfb
RUN chown root:root /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb
RUN update-rc.d xvfb defaults