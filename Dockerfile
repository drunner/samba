# Ansible in a Docker container, accessed via ssh.

FROM phusion/baseimage
MAINTAINER j842

RUN apt-get update && apt-get install -y samba libnss-extrausers sudo
RUN sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf

EXPOSE 137/udp
EXPOSE 138/udp
EXPOSE 445
EXPOSE 139
EXPOSE 135

# Add user management tool
COPY ["./assets","/"]
COPY ["./drunner","/drunner"]
RUN   useradd -M PCGUEST && \
      useradd -M samba && \
      mkdir -p /tempmount /share /originals && \
      chmod a+rwx /tempmount /share /originals && \
      cp -a /etc/samba /originals/etcsamba &&  \
      cp -a /var/lib/samba /originals/varlibsamba && \
      chmod 1775 /originals/varlibsamba/usershares/ && \
      chmod +t /originals/varlibsamba/usershares/

# allow sudo to run our scripts and my_init.
RUN echo "samba ALL= (ALL) NOPASSWD: /usr/local/bin/,/sbin/my_init" > /etc/sudoers.d/samba

USER samba

VOLUME ["/etc/samba","/var/lib/samba","/var/lib/extrausers"]

CMD ["sudo","/sbin/my_init"]


