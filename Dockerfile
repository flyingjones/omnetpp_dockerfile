FROM fedora:latest

SHELL ["/bin/bash", "-c", "-l"]

RUN dnf update -y

RUN dnf install git wget -y

RUN dnf install make gcc gcc-c++ bison flex perl \
 python2 tcl-devel tk-devel qt5-devel libxml2-devel \
 zlib-devel java doxygen graphviz OpenSceneGraph-devel osgearth-devel -y

RUN cd /home && \
 wget https://github.com/omnetpp/omnetpp/releases/download/omnetpp-5.4.1/omnetpp-5.4.1-src-linux.tgz

RUN cd /home && tar xvfz omnetpp-5.4.1-src-linux.tgz && rm omnetpp-5.4.1-src-linux.tgz


RUN cd /home/omnetpp-5.4.1 && \
  source setenv -f && \
 ./configure && \
 make -j8

RUN cd ~ && echo 'PATH=/home/omnetpp-5.4.1/bin:$PATH' >> .bashrc && echo 'export PATH' >> .bashrc

# not required for emnetpp but really usefull for python projects using omnetpp
RUN pip3 install virtualenv

WORKDIR "/home"

