FROM amazonlinux:2

WORKDIR /root
ADD ./bash.bashrc /root/.bashrc
ADD ./.emacs.d /root/.emacs.d

RUN yum install -y emacs jq awscli \
    aws configure set region ap-northeast-1
