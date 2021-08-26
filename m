Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web08.636.1630017876073252496
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Aug 2021 15:44:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=tfDOQYHt;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id ia27so9615759ejc.10
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Aug 2021 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7YiEgq+oMJtRelJ1WkUKYYOR+eerCeBDVjITr/8/wlE=;
        b=tfDOQYHthVw6ED5Ut8bczi8retTPD52US1baMwouCYAFjBU8lMYVNY8dATIUeQl0GG
         jKtxw6bbRpCVR+wwusRWzqxzGlie5GasA9ERS4mGlanW5sqbA4zFHDz9xoxT/4GUafso
         esXWz8x4ztCwtlxDDuq5wDKefaIH08Golsc6TlwYhaK3hlzzR67IBtMZ94GEwued/8mQ
         +NZTz3pqW7Tod4lCuz5P5PjSBtc76iHghVeksDJEyMvMFojMhPObo8+oE7fkrf/MWjFJ
         8KKEwC2dNEN9/MRimCaUM1Ehw00RrLLYAiWNw8rF4Mn69mEAUJ2EmEBF85B2a3wtKzBo
         22cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7YiEgq+oMJtRelJ1WkUKYYOR+eerCeBDVjITr/8/wlE=;
        b=RnhC5xbSs3fNbEkFFNiOEfKMI8bLlBqsHyMEP4OnFAXxbMGlVYXLXJGavE9Nb+ZWM3
         SSK/CSayOzmrRf7qxUYvlWV2TvGRmz6AkchqPdPaptDRQvtmdR4dbtHM2lhtEEgAj+ha
         JDbhTi9RX96Axa1ElrlK6KH+4NnvoV9hdk7OUqI0JEtHWPDtgvav/RG9L7AunWHTIZvD
         LOtV08SKn6SVVpqeZ+K/2VIFcg+Ccvd0uaqVRxtSDo9dvxwACpmIHEfO8vPL1US4QVQE
         fkHYqMuRgTZraQ/YMKLhSn1047VDTkq4QpfPsnQeAXlTYNKlukMYO2kzIew6tcyIbIu6
         uJng==
X-Gm-Message-State: AOAM5310MERoXa9e1d7GsVNNjEgqLOA+zleRkOjZfKSe1VJQC6Sy3H/z
	vjjfVnLhChKfIQOGUKJ9F1jxZHFQ1tj7cQ==
X-Google-Smtp-Source: ABdhPJw2V4GIAyG+rufBFbl1njWDnO+/mFvtvQvOMKTR2JkhlgX+2sFJqdAlvLNshi6lP1OCYGDDSA==
X-Received: by 2002:a17:906:3a58:: with SMTP id a24mr6715667ejf.109.1630017874534;
        Thu, 26 Aug 2021 15:44:34 -0700 (PDT)
Return-Path: <martin.jansa@gmail.com>
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id y21sm2477405edu.13.2021.08.26.15.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:44:34 -0700 (PDT)
From: "Martin Jansa" <Martin.Jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: scott.murray@konsulko.com,
	Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] prserv: handle PRSERV_HOST = "127.0.0.1:0" the same as "localhost:0"
Date: Fri, 27 Aug 2021 00:44:27 +0200
Message-Id: <20210826224427.104552-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <169EE6B2B92BC747.1595@lists.openembedded.org>
References: <169EE6B2B92BC747.1595@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

* When using PRSERV_HOST =3D "localhost:0" inside
  Docker container (tested with ubuntu 20.04 and 21.04) the
  self.loop.run_until_complete never completed, so self.address
  wasn't ever assigned few lines bellow and then
    self.port =3D int(self.prserv.address.rsplit(':', 1)[1])
  in lib/prserv/serv.py caused a bit ugly exception:

bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native
Traceback (most recent call last):
  File "/OE/nodistro/honister/bitbake/bin/bitbake", line 35, in <module>
    sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
  File "/OE/nodistro/honister/bitbake/lib/bb/main.py", line 385, in bitbake=
_main
    return ui_module.main(server_connection.connection, server_connection.e=
vents,
  File "/OE/nodistro/honister/bitbake/lib/bb/ui/knotty.py", line 397, in ma=
in
    params.updateToServer(server, os.environ.copy())
  File "/OE/nodistro/honister/bitbake/lib/bb/cookerdata.py", line 75, in up=
dateToServer
    raise Exception("Unable to update the server configuration with local p=
arameters: %s" % error)
Exception: Unable to update the server configuration with local parameters:=
 Traceback (most recent call last):
  File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 90, in runCo=
mmand
    result =3D command_method(self, commandline)
  File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 286, in upda=
teConfig
    command.cooker.updateConfigOpts(options, environment, cmdline)
  File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 491, in updat=
eConfigOpts
    self.reset()
  File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 1717, in reset
    self.handlePRServ()
  File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 383, in handl=
ePRServ
    self.prhost =3D prserv.serv.auto_start(self.data)
  File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 318, in aut=
o_start
    singleton.start()
  File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 133, in sta=
rt
    self.port =3D int(self.prserv.address.rsplit(':', 1)[1])
AttributeError: 'NoneType' object has no attribute 'rsplit'

* the issue was caused by "localhost" being resolved as IPv6 address ::1
  and then asyncio failing to bind it, the same is reproducible with hashse=
rv, but
  hashserve at least shows nice error message:
    bitbake$ bitbake-hashserv -l DEBUG -b localhost:0
    Traceback (most recent call last):
      File "/OE/nodistro/honister/bitbake/bin/bitbake-hashserv", line 59, i=
n <module>
        ret =3D main()
      File "/OE/nodistro/honister/bitbake/bin/bitbake-hashserv", line 53, i=
n main
        server.serve_forever()
      File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 23=
3, in serve_forever
        self.start()
      File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 14=
4, in start_tcp
        self.server =3D self.loop.run_until_complete(server_coro)
      File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_un=
til_complete
        return future.result()
      File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
        return await loop.create_server(factory, host, port, **kwds)
      File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in creat=
e_server
        raise OSError(err.errno, 'error while attempting '
    OSError: [Errno 99] error while attempting to bind on address ('::1', 0=
, 0, 0): cannot assign requested address

* or by bitbake-prserv in prserv.log:
    bitbake$ bitbake-prserv --start --host=3Dlocalhost --port=3D42005
    bitbake$ cat prserv.log
    Traceback (most recent call last):
      File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 55, in =
<module>
        ret =3D main()
      File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 46, in =
main
        ret=3Dprserv.serv.start_daemon(options.dbfile, options.host, option=
s.port,os.path.abspath(options.logfile), options.read_only)
      File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 226, in=
 start_daemon
        run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
      File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 202, in=
 run_as_daemon
        func()
      File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 224, in=
 daemon_main
        server.serve_forever()
      File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 23=
3, in serve_forever
        self.start()
      File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 14=
4, in start_tcp
        self.server =3D self.loop.run_until_complete(server_coro)
      File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_un=
til_complete
        return future.result()
      File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
        return await loop.create_server(factory, host, port, **kwds)
      File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in creat=
e_server
        raise OSError(err.errno, 'error while attempting '
    OSError: [Errno 99] error while attempting to bind on address ('::1', 4=
2005, 0, 0): cannot assign requested address

* while 127.0.0.1 works fine:
    bitbake$ bitbake-prserv --start --host=3D127.0.0.1 --port=3D42005
    bitbake$ cat prserv.log
    DEBUG: Listening on ('127.0.0.1', 42005)
    2021-08-26 22:28:05,828 Listening on ('127.0.0.1', 42005)
    DEBUG: Opening PRServ database 'file:/OE/nodistro/honister/prserv.sqlit=
e3'
    2021-08-26 22:28:05,829 Opening PRServ database 'file:/OE/nodistro/honi=
ster/prserv.sqlite3'
    NOTE: Started PRServer with DBfile: /OE/nodistro/honister/prserv.sqlite=
3, Address: 127.0.0.1:42005, PID: 39
    2021-08-26 22:28:05,831 Started PRServer with DBfile: /OE/nodistro/honi=
ster/prserv.sqlite3, Address: 127.0.0.1:42005, PID: 39

  but 127.0.0.1:0 wasn't handled as "autostart" like localhost:0 is
  update is_local_special to allow that

* /etc/hosts file generated by docker contails localhost for both IPv4 and =
IPv6:
  $ grep localhost /etc/hosts
  127.0.0.1       localhost
  ::1     localhost ip6-localhost ip6-loopback

  even when ipv6 is disabled in dockerd as reported in:
  https://github.com/docker/for-linux/issues/250

* add a check for self.prserv.address to provide better error message:
  ERROR: Unable to start PR Server, exitting
  when something bad happens, but in this case you still need to read
  bitbake-cookerdaemon.log to see the actuall error, in this case:

90 22:30:39.008441 --- Starting bitbake server pid 90 at 2021-08-26 22:30:3=
9.008419 ---
90 22:30:39.023734 Started bitbake server pid 90
90 22:30:39.024286 Entering server connection loop
90 22:30:39.024753 Accepting [<socket.socket fd=3D6, family=3DAddressFamily=
.AF_UNIX, type=3DSocketKind.SOCK_STREAM, proto=3D0, laddr=3Dbitbake.sock>] =
([])
90 22:30:39.026314 Processing Client
90 22:30:39.026456 Connecting Client
90 22:30:39.027509 Running command ['setFeatures', [2]]
90 22:30:39.027757 Command Completed
90 22:30:39.028711 Running command ['updateConfig', {'abort': False, 'force=
': False, 'invalidate_stamp': None, 'dry_run': False, 'dump_signatures': []=
, 'extra_assume_provided': [], 'profile': False, 'prefile': [], 'postfile':=
 [], 'server_timeout': None, 'nosetscene': False, 'setsceneonly': False, 's=
kipsetscene': False, 'runall': None, 'runonly': None, 'writeeventlog': None=
, 'build_verbose_shell': False, 'build_verbose_stdout': False, 'default_log=
level': 20, 'debug_domains': {}}, {'DISTRO': '', 'PWD': '/OE/nodistro/honis=
ter', 'HOME': '/OE', 'MACHINE': 'qemux86', 'BB_ENV_EXTRAWHITE': 'MACHINE DI=
STRO TCMODE TCLIBC http_proxy ftp_proxy https_proxy all_proxy ALL_PROXY no_=
proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THR=
EADS PARALLEL_MAKE GIT_PROXY_COMMAND GIT_PROXY_IGNORE SOCKS5_PASSWD SOCKS5_=
USER WEBOS_DISTRO_BUILD_ID PSEUDO_DISABLED PSEUDO_BUILD', 'PATH': '/OE/nodi=
stro/honister/oe-core/scripts:/OE/nodistro/honister/bitbake/bin:/usr/local/=
sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', 'LC_ALL': 'en_US.UTF-8'=
, 'MACHINES': 'qemux86', 'HOSTNAME': '6a439759e3c6', 'TOPDIR': '/OE/nodistr=
o/honister', 'LANG': 'en_US.UTF-8', 'TERM': 'xterm', 'SHLVL': '1', 'BITBAKE=
_HOME': '/OE', 'BUILDDIR': '/OE/nodistro/honister/BUILD', 'OLDPWD': '/OE/no=
distro/honister/bitbake', '_': '/OE/nodistro/honister/bitbake/bin/bitbake'}=
, ['/OE/nodistro/honister/bitbake/bin/bitbake', '-k', 'zlib-native']]
Process Process-1:
Traceback (most recent call last):
  File "/usr/lib/python3.8/multiprocessing/process.py", line 315, in _boots=
trap
    self.run()
  File "/usr/lib/python3.8/multiprocessing/process.py", line 108, in run
    self._target(*self._args, **self._kwargs)
  File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 255, i=
n run
    self.start()
  File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, i=
n start_tcp
    self.server =3D self.loop.run_until_complete(server_coro)
  File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_=
complete
    return future.result()
  File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
    return await loop.create_server(factory, host, port, **kwds)
  File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_se=
rver
    raise OSError(err.errno, 'error while attempting '
OSError: [Errno 99] error while attempting to bind on address ('::1', 0, 0,=
 0): cannot assign requested address
90 22:30:39.530037 Command Completed
90 22:30:39.530913 Processing Client
90 22:30:39.531023 Disconnecting Client
90 22:30:39.531638 No timeout, exiting.
90 22:30:39.632137 Exiting
90 22:30:39.637562 Original lockfile contents: ['90\n']
90 22:30:39.638107 Exiting as we could obtain the lock

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/cooker.py   |  2 +-
 lib/prserv/serv.py | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index b2d69c28..55eed092 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -382,7 +382,7 @@ class BBCooker:
         try:
             self.prhost =3D prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError as e:
-            bb.fatal("Unable to start PR Server, exitting")
+            bb.fatal("Unable to start PR Server, exitting, check the bitba=
ke-cookerdaemon.log")
=20
         if self.data.getVar("BB_HASHSERVE") =3D=3D "auto":
             # Create a new hash server bound to a unix domain socket
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 17ae4096..68db3d3e 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -129,6 +129,8 @@ class PRServSingleton(object):
         self.prserv.start_tcp_server(self.host, self.port)
         self.process =3D self.prserv.serve_as_process()
=20
+        if not self.prserv.address:
+            raise PRServiceConfigError
         if not self.port:
             self.port =3D int(self.prserv.address.rsplit(':', 1)[1])
=20
@@ -276,7 +278,7 @@ def is_running(pid):
     return True
=20
 def is_local_special(host, port):
-    if host.strip().lower() =3D=3D 'localhost' and not port:
+    if (host =3D=3D 'localhost' or host =3D=3D '127.0.0.1') and not port:
         return True
     else:
         return False
@@ -300,7 +302,9 @@ def auto_start(d):
                 'Usage: PRSERV_HOST =3D "<hostname>:<port>"']))
         raise PRServiceConfigError
=20
-    if is_local_special(host_params[0], int(host_params[1])):
+    host =3D host_params[0].strip().lower()
+    port =3D int(host_params[1])
+    if is_local_special(host, port):
         import bb.utils
         cachedir =3D (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
         if not cachedir:
@@ -314,14 +318,11 @@ def auto_start(d):
                auto_shutdown()
         if not singleton:
             bb.utils.mkdirhier(cachedir)
-            singleton =3D PRServSingleton(os.path.abspath(dbfile), os.path=
.abspath(logfile), "localhost", 0)
+            singleton =3D PRServSingleton(os.path.abspath(dbfile), os.path=
.abspath(logfile), host, port)
             singleton.start()
     if singleton:
         host =3D singleton.host
         port =3D singleton.port
-    else:
-        host =3D host_params[0]
-        port =3D int(host_params[1])
=20
     try:
         ping(host, port)
--=20
2.30.2

