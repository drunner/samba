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
RUN   mkdir /tempmount /share /originals && \
      useradd -M PCGUEST && \
      useradd -M samba && \
      cp -a /etc/samba /originals/etcsamba &&  \
      cp -a /var/lib/samba /originals/varlibsamba && \
      sudo chmod 1775 /originals/varlibsamba/usershares/ && \
      sudo chmod +t /originals/varlibsamba/usershares/


      
#RUN chown -R samba:root /originals

# allow my_init to be run as root by anyone.
# RUN   chown root:root /sbin/my_init && \
#       chmod 4755 /sbin/my_init && \
#       chmod a+rwx /etc/samba /var/lib/samba /var/lib/extrausers && \
#       chmod a+rx -R /usr/local/bin/ && \
#       chown -R root:root /usr/local/bin && \
#       chmod 4755 /usr/local/bin/docker-smb-*

RUN echo "samba ALL= (ALL) NOPASSWD: /usr/local/bin/,/sbin/my_init" > /etc/sudoers.d/samba

USER samba

VOLUME ["/etc/samba","/var/lib/samba","/var/lib/extrausers"]
#,"tempmount"]
CMD ["sudo" "/sbin/my_init"]

#  sudo docker run -d -v /home/j/docker/t/etcsamba:/etc/samba -v /home/j/docker/t/varlibsamba/:/var/lib/samba -v /home:/home -p 137:137/udp -p 138:138/udp -p 445:445 -p 139:139 -p 135:135 j842/samba
# need to exec in and add user and start samba. :/

