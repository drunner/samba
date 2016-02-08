# Ansible in a Docker container, accessed via ssh.

FROM phusion/baseimage
MAINTAINER j842

RUN apt-get update && apt-get install -y samba libnss-extrausers
RUN sed -i '/^\(passwd\|group\|shadow\):/{ s/$/ extrausers/; }' /etc/nsswitch.conf

EXPOSE 137/udp
EXPOSE 138/udp
EXPOSE 445
EXPOSE 139
EXPOSE 135

# Add user management tool
ADD ["./assets","/"]
RUN mkdir /tempmount /share
RUN useradd -M PCGUEST

VOLUME ["/etc/samba","/var/lib/samba","/var/lib/extrausers"]
#,"tempmount"]
CMD ["/sbin/my_init"]

#  sudo docker run -d -v /home/j/docker/t/etcsamba:/etc/samba -v /home/j/docker/t/varlibsamba/:/var/lib/samba -v /home:/home -p 137:137/udp -p 138:138/udp -p 445:445 -p 139:139 -p 135:135 j842/samba
# need to exec in and add user and start samba. :/

