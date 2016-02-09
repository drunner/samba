# drunner-samba #

Simple dService to provide samba shares. Designed to be really easy to set up for developers,
so they can share their linux checkouts to their Windows/Mac desktop and edit using their 
favourite tools.

# Example use #

~~~
drunner install drunner/samba
samba user add myname mypassword
samba share -w myname -p ro /home/myname myname
~~~


~~~

NAME
   ${SERVICENAME} - Makes host paths available via samba.
       
SYNOPSIS
   ${SERVICENAME} help           

   ${SERVICENAME} share [OPTION]... HOSTPATH SHARENAME
   ${SERVICENAME} [PASSWORD=?] user add USERNAME [PASSWORD]
   ${SERVICENAME} [PASSWORD=?] user password USERNAME [PASSWORD]
   ${SERVICENAME} user delete USERNAME
   ${SERVICENAME} getshares
   
   ${SERVICENAME} start           
   ${SERVICENAME} stop            
   ${SERVICENAME} status         
      
DESCRIPTION
   Built from ${IMAGENAME}.
   
~~~


```
SHARE OPTIONS

   -w USERNAME
        Add USERNAME with read and write access to the share (can use multiple times)

   -r USERNAME
        Add USERNAME with read only access to the share (can use multiple times)

   -p {ro/rw}
        Add public access either read only (ro) or read-write (rw)

   -f USERNAME
        All users access the share as USERNAME

   -g GROUP
        All users access the share with group GROUP

```
