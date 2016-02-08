# docker-samba #

Private while I'm screwing around.

# use #

Use hard links within the sambaroot path for any shares needed. Otherwise need to map the extra directories.


~~~
docker run docker-samba-configure -v $(PWD)/samba:/samba -e PASSWORD=[password] adduser [username] 
docker run docker-samba-configure -v $(PWD)/samba:/samba addshare -f [forceuser] -rwusers {[user1], [user2], ...} -rousers {[user1], [user2], ...} -public=[noaccess/ro/rw] [path]

docker run -d -h myserver $(PWD)/samba:/samba -p 137:137/udp -p 138:138/udp -p 135:135 -p 139:139 -p 445:445 docker-samba
~~~


~~~
if ! [ -d var/lib/samba ]; then 
  mkdir -p var/lib
  docker run -a stdout ${CONTAINER_PREFIX}/samba-base tar c /var/lib/samba | 
    tar xvC var/lib/ 
fi
~~~

https://github.com/dogestry/dogestry