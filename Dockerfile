ARG REPO=http://mirrors.163.com
ARG DIST=bullseye
ARG SECURITY_SUF=-security
#ARG SECURITY_SUF

FROM debian:${DIST}

LABEL maintainer="Huang Rui <vowstar@gmail.com>"

# Using faster mirror
ARG REPO
ARG DIST
ARG SECURITY_SUF
RUN echo "deb ${REPO}/debian ${DIST} main non-free contrib" > /etc/apt/sources.list && \
    echo "deb ${REPO}/debian ${DIST}-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb ${REPO}/debian ${DIST}-backports main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb ${REPO}/debian-security ${DIST}${SECURITY_SUF}/updates main contrib non-free" >> /etc/apt/sources.list

#RUN echo "deb ${REPO}/debian sid main non-free contrib" > /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -yq sudo time build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python2.7 unzip zlib1g-dev lib32gcc-s1 libc6-dev-i386 subversion flex uglifyjs gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget swig rsync && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"