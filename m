Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web08.1721.1630089175595575601
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Aug 2021 11:32:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dQ1pO0GJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id l24so6075151qtj.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 27 Aug 2021 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=y3pEmY+TvgTJsBd+hLunIMP0rhqbd4YF5BNetKEde30=;
        b=dQ1pO0GJw9701sPXRXK8aF9Ixcv3XaZ5Uj+d4EH2myLW0h6AyiDZeNstXyjsFvz6xW
         GiDLxIbPGGr6SSD/6wUtwIKT/snrxNSvd8hj8a1RKxiIzewDCfHdDssWY5B4iobZVYEH
         WRgIAM4yk29lhRdMBGZ7VAvHV952uEVXG+cwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=y3pEmY+TvgTJsBd+hLunIMP0rhqbd4YF5BNetKEde30=;
        b=UeQYS7U86l3chtVElCKlokECsZ8H7K8EYMcBML/oV9F6bZu/ceYIApOFm/XIqBq9qc
         wHHcSIhLQpaGSqYQKAs6bx6qQdKJnKUHu7dBcNs//X8CZx6xvqB8c1nbgRwrsl/g4BzK
         hmwsW34CaN38JtPY76ggXMb7Sg/Qiwup4txdmj4FAtfi1zNQwtnqWt33YhmLOKq1uXAV
         7T0xGlDR+CIKi6svXnSqfi6afvx1tUzHx4xJ92UtYnmreEVV1X6khigg63oovgInyphg
         TTCj/nVM6gDWkoRpi3bTUtwc7GCgs0JyKB9PVx/c19tvmo8keqikv5vWCneHTafk4ghK
         3GMQ==
X-Gm-Message-State: AOAM5309lcB4S16mIEMSUs/Brwu0uy1rcW23zeYuHAtOXQykB2QmkxWR
	aW2HNWPw33FgpuOHf2a/bmPqgDety5iIAQ==
X-Google-Smtp-Source: ABdhPJxjQHpjjmCu1WSAkRpKfrgHiJoJQRnnVOPUnk+YnxmTJyTd+7/6OXu1GB9+pvTVui7xKIUGOw==
X-Received: by 2002:aed:3022:: with SMTP id 31mr9591756qte.343.1630089174605;
        Fri, 27 Aug 2021 11:32:54 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (192-0-174-222.cpe.teksavvy.com. [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id j23sm5299436qkl.65.2021.08.27.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 11:32:53 -0700 (PDT)
Date: Fri, 27 Aug 2021 14:32:52 -0400 (EDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: Martin Jansa <martin.jansa@gmail.com>
cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] prserv: handle PRSERV_HOST = "127.0.0.1:0" the same as "localhost:0"
In-Reply-To: <20210826224427.104552-1-Martin.Jansa@gmail.com>
Message-ID: <62c62964-5373-1fc-f1a4-f25c8613dc5@spiteful.org>
References: <169EE6B2B92BC747.1595@lists.openembedded.org> <20210826224427.104552-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 27 Aug 2021, Martin Jansa wrote:

> * When using PRSERV_HOST = "localhost:0" inside
>   Docker container (tested with ubuntu 20.04 and 21.04) the
>   self.loop.run_until_complete never completed, so self.address
>   wasn't ever assigned few lines bellow and then
>     self.port = int(self.prserv.address.rsplit(':', 1)[1])
>   in lib/prserv/serv.py caused a bit ugly exception:
>
> bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native
> Traceback (most recent call last):
>   File "/OE/nodistro/honister/bitbake/bin/bitbake", line 35, in <module>
>     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>   File "/OE/nodistro/honister/bitbake/lib/bb/main.py", line 385, in bitbake_main
>     return ui_module.main(server_connection.connection, server_connection.events,
>   File "/OE/nodistro/honister/bitbake/lib/bb/ui/knotty.py", line 397, in main
>     params.updateToServer(server, os.environ.copy())
>   File "/OE/nodistro/honister/bitbake/lib/bb/cookerdata.py", line 75, in updateToServer
>     raise Exception("Unable to update the server configuration with local parameters: %s" % error)
> Exception: Unable to update the server configuration with local parameters: Traceback (most recent call last):
>   File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 90, in runCommand
>     result = command_method(self, commandline)
>   File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 286, in updateConfig
>     command.cooker.updateConfigOpts(options, environment, cmdline)
>   File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 491, in updateConfigOpts
>     self.reset()
>   File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 1717, in reset
>     self.handlePRServ()
>   File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 383, in handlePRServ
>     self.prhost = prserv.serv.auto_start(self.data)
>   File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 318, in auto_start
>     singleton.start()
>   File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 133, in start
>     self.port = int(self.prserv.address.rsplit(':', 1)[1])
> AttributeError: 'NoneType' object has no attribute 'rsplit'
>
> * the issue was caused by "localhost" being resolved as IPv6 address ::1
>   and then asyncio failing to bind it, the same is reproducible with hashserv, but
>   hashserve at least shows nice error message:
>     bitbake$ bitbake-hashserv -l DEBUG -b localhost:0
>     Traceback (most recent call last):
>       File "/OE/nodistro/honister/bitbake/bin/bitbake-hashserv", line 59, in <module>
>         ret = main()
>       File "/OE/nodistro/honister/bitbake/bin/bitbake-hashserv", line 53, in main
>         server.serve_forever()
>       File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 233, in serve_forever
>         self.start()
>       File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
>         self.server = self.loop.run_until_complete(server_coro)
>       File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
>         return future.result()
>       File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
>         return await loop.create_server(factory, host, port, **kwds)
>       File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
>         raise OSError(err.errno, 'error while attempting '
>     OSError: [Errno 99] error while attempting to bind on address ('::1', 0, 0, 0): cannot assign requested address
>
> * or by bitbake-prserv in prserv.log:
>     bitbake$ bitbake-prserv --start --host=localhost --port=42005
>     bitbake$ cat prserv.log
>     Traceback (most recent call last):
>       File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 55, in <module>
>         ret = main()
>       File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 46, in main
>         ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
>       File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 226, in start_daemon
>         run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
>       File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 202, in run_as_daemon
>         func()
>       File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 224, in daemon_main
>         server.serve_forever()
>       File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 233, in serve_forever
>         self.start()
>       File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
>         self.server = self.loop.run_until_complete(server_coro)
>       File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
>         return future.result()
>       File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
>         return await loop.create_server(factory, host, port, **kwds)
>       File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
>         raise OSError(err.errno, 'error while attempting '
>     OSError: [Errno 99] error while attempting to bind on address ('::1', 42005, 0, 0): cannot assign requested address
>
> * while 127.0.0.1 works fine:
>     bitbake$ bitbake-prserv --start --host=127.0.0.1 --port=42005
>     bitbake$ cat prserv.log
>     DEBUG: Listening on ('127.0.0.1', 42005)
>     2021-08-26 22:28:05,828 Listening on ('127.0.0.1', 42005)
>     DEBUG: Opening PRServ database 'file:/OE/nodistro/honister/prserv.sqlite3'
>     2021-08-26 22:28:05,829 Opening PRServ database 'file:/OE/nodistro/honister/prserv.sqlite3'
>     NOTE: Started PRServer with DBfile: /OE/nodistro/honister/prserv.sqlite3, Address: 127.0.0.1:42005, PID: 39
>     2021-08-26 22:28:05,831 Started PRServer with DBfile: /OE/nodistro/honister/prserv.sqlite3, Address: 127.0.0.1:42005, PID: 39
>
>   but 127.0.0.1:0 wasn't handled as "autostart" like localhost:0 is
>   update is_local_special to allow that
>
> * /etc/hosts file generated by docker contails localhost for both IPv4 and IPv6:
>   $ grep localhost /etc/hosts
>   127.0.0.1       localhost
>   ::1     localhost ip6-localhost ip6-loopback
>
>   even when ipv6 is disabled in dockerd as reported in:
>   https://github.com/docker/for-linux/issues/250
>
> * add a check for self.prserv.address to provide better error message:
>   ERROR: Unable to start PR Server, exitting
>   when something bad happens, but in this case you still need to read
>   bitbake-cookerdaemon.log to see the actuall error, in this case:
>
> 90 22:30:39.008441 --- Starting bitbake server pid 90 at 2021-08-26 22:30:39.008419 ---
> 90 22:30:39.023734 Started bitbake server pid 90
> 90 22:30:39.024286 Entering server connection loop
> 90 22:30:39.024753 Accepting [<socket.socket fd=6, family=AddressFamily.AF_UNIX, type=SocketKind.SOCK_STREAM, proto=0, laddr=bitbake.sock>] ([])
> 90 22:30:39.026314 Processing Client
> 90 22:30:39.026456 Connecting Client
> 90 22:30:39.027509 Running command ['setFeatures', [2]]
> 90 22:30:39.027757 Command Completed
> 90 22:30:39.028711 Running command ['updateConfig', {'abort': False, 'force': False, 'invalidate_stamp': None, 'dry_run': False, 'dump_signatures': [], 'extra_assume_provided': [], 'profile': False, 'prefile': [], 'postfile': [], 'server_timeout': None, 'nosetscene': False, 'setsceneonly': False, 'skipsetscene': False, 'runall': None, 'runonly': None, 'writeeventlog': None, 'build_verbose_shell': False, 'build_verbose_stdout': False, 'default_loglevel': 20, 'debug_domains': {}}, {'DISTRO': '', 'PWD': '/OE/nodistro/honister', 'HOME': '/OE', 'MACHINE': 'qemux86', 'BB_ENV_EXTRAWHITE': 'MACHINE DISTRO TCMODE TCLIBC http_proxy ftp_proxy https_proxy all_proxy ALL_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THREADS PARALLEL_MAKE GIT_PROXY_COMMAND GIT_PROXY_IGNORE SOCKS5_PASSWD SOCKS5_USER WEBOS_DISTRO_BUILD_ID PSEUDO_DISABLED PSEUDO_BUILD', 'PATH': '/OE/nodistro/honister/oe-core/scripts:/OE/nodistro/honister/bitbake/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', 'LC_ALL': 'en_US.UTF-8', 'MACHINES': 'qemux86', 'HOSTNAME': '6a439759e3c6', 'TOPDIR': '/OE/nodistro/honister', 'LANG': 'en_US.UTF-8', 'TERM': 'xterm', 'SHLVL': '1', 'BITBAKE_HOME': '/OE', 'BUILDDIR': '/OE/nodistro/honister/BUILD', 'OLDPWD': '/OE/nodistro/honister/bitbake', '_': '/OE/nodistro/honister/bitbake/bin/bitbake'}, ['/OE/nodistro/honister/bitbake/bin/bitbake', '-k', 'zlib-native']]
> Process Process-1:
> Traceback (most recent call last):
>   File "/usr/lib/python3.8/multiprocessing/process.py", line 315, in _bootstrap
>     self.run()
>   File "/usr/lib/python3.8/multiprocessing/process.py", line 108, in run
>     self._target(*self._args, **self._kwargs)
>   File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 255, in run
>     self.start()
>   File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
>     self.server = self.loop.run_until_complete(server_coro)
>   File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
>     return future.result()
>   File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
>     return await loop.create_server(factory, host, port, **kwds)
>   File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
>     raise OSError(err.errno, 'error while attempting '
> OSError: [Errno 99] error while attempting to bind on address ('::1', 0, 0, 0): cannot assign requested address
> 90 22:30:39.530037 Command Completed
> 90 22:30:39.530913 Processing Client
> 90 22:30:39.531023 Disconnecting Client
> 90 22:30:39.531638 No timeout, exiting.
> 90 22:30:39.632137 Exiting
> 90 22:30:39.637562 Original lockfile contents: ['90\n']
> 90 22:30:39.638107 Exiting as we could obtain the lock

Just one minor nice to have typo correction note below, but otherwise this
looks fine to me with the exception that the description could stand to be
shortened down from its current ~140 lines to something a bit more succinct.

> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/cooker.py   |  2 +-
>  lib/prserv/serv.py | 13 +++++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index b2d69c28..55eed092 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -382,7 +382,7 @@ class BBCooker:
>          try:
>              self.prhost = prserv.serv.auto_start(self.data)
>          except prserv.serv.PRServiceConfigError as e:
> -            bb.fatal("Unable to start PR Server, exitting")
> +            bb.fatal("Unable to start PR Server, exitting, check the bitbake-cookerdaemon.log")

If we're touching the message anyways, please correct it to "exiting"
(just one 't').

>          if self.data.getVar("BB_HASHSERVE") == "auto":
>              # Create a new hash server bound to a unix domain socket
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 17ae4096..68db3d3e 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -129,6 +129,8 @@ class PRServSingleton(object):
>          self.prserv.start_tcp_server(self.host, self.port)
>          self.process = self.prserv.serve_as_process()
>
> +        if not self.prserv.address:
> +            raise PRServiceConfigError
>          if not self.port:
>              self.port = int(self.prserv.address.rsplit(':', 1)[1])
>
> @@ -276,7 +278,7 @@ def is_running(pid):
>      return True
>
>  def is_local_special(host, port):
> -    if host.strip().lower() == 'localhost' and not port:
> +    if (host == 'localhost' or host == '127.0.0.1') and not port:
>          return True
>      else:
>          return False
> @@ -300,7 +302,9 @@ def auto_start(d):
>                  'Usage: PRSERV_HOST = "<hostname>:<port>"']))
>          raise PRServiceConfigError
>
> -    if is_local_special(host_params[0], int(host_params[1])):
> +    host = host_params[0].strip().lower()
> +    port = int(host_params[1])
> +    if is_local_special(host, port):
>          import bb.utils
>          cachedir = (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
>          if not cachedir:
> @@ -314,14 +318,11 @@ def auto_start(d):
>                 auto_shutdown()
>          if not singleton:
>              bb.utils.mkdirhier(cachedir)
> -            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), "localhost", 0)
> +            singleton = PRServSingleton(os.path.abspath(dbfile), os.path.abspath(logfile), host, port)
>              singleton.start()
>      if singleton:
>          host = singleton.host
>          port = singleton.port
> -    else:
> -        host = host_params[0]
> -        port = int(host_params[1])
>
>      try:
>          ping(host, port)
>
