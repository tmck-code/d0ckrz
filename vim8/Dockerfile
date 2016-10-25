FROM debian:jessie

RUN echo "deb http://ftp.au.debian.org/debian/ jessie main\n\
deb-src http://ftp.au.debian.org/debian/ jessie main" > /etc/apt/sources.list

RUN apt-get update

# Install python and build dep
RUN apt-get install -y \
    git \
    checkinstall\
    vim \
    curl \
    locales && \
    apt-get build-dep -y vim && \
    gem install rubocop

# Clone vim8, configure and install
RUN cd /usr/src && git clone https://github.com/vim/vim.git

RUN cd /usr/src/vim && \
    ./configure --enable-rubyinterp --enable-pythoninterp --enable-luainterp \
    --enable-gui=no --without-x --enable-multibyte --prefix=/usr && \
    checkinstall

RUN echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale

RUN echo "Australia/Melbourne" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    echo 'LANG="en_US.UTF-8"' >> /etc/default/locale

# Add vim user
RUN useradd -ms /bin/bash vim
WORKDIR /home/vim
USER vim

# Install pathogen, a vim plugin manager
RUN cd /home/vim && \
    mkdir -p .vim/autoload .vim/bundle && \
    curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

RUN export TERM=uxterm && \
    locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ADD bashrc .bashrc
