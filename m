Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.web12.6966.1630422084879130147
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Aug 2021 08:01:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sXChVoXh;
 spf=pass (domain: konsulko.com, ip: 209.85.219.51, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f51.google.com with SMTP id e18so10545086qvo.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 08:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=jfOGN06Hbj7EHCup2wDSH+KSwJNz/QOhJCDOMC8p4hk=;
        b=sXChVoXhG0ObtSMCgqW3GJaIo+ai6IRvpB28XELvkB6pThTFs/sDvihfuFXoSXR0C2
         5QvMBpSKdlBg/F/ZFKqcaPGbb569RdxZqsfdXAOG0JJgO3/LCyvFIxunn6Jtj+ZFWZGZ
         lMlror/jS9xP5xf5vxR351cEpQWsomvb32Tm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jfOGN06Hbj7EHCup2wDSH+KSwJNz/QOhJCDOMC8p4hk=;
        b=ZsIBBUgLIW4fHlXwUTxLyg9AHXdxKRZs0KpTZy0TY5riK2BnI8aolW25J1beRiBcol
         m2MgKGidwnpTgarEcuBUopexcM+S5CUxqibYn6f2Ny+jJ/BU7f9cvjetRdCb8EJeyqE2
         Vn9gMA0P3kCYLXYT96R1pf+yKDgO69yBDx/m56B4EDWsJyRSSNfBZksqhUJXxhdsEhmb
         gkA79h4SP6wyC/Ct1mUpCOZlUR962HEqNwvRTcHn3T8Z9dcb7XTfxza+5OrG8g82pG1k
         6gkNktZii2OFvFwr4ZP14eWBz4b9nxjiAPHzbP6mI0xOeaCoyhf5k79Ona/U+rk26Nss
         kBvA==
X-Gm-Message-State: AOAM531ZB3s4F5cEbpuPWveZUB4hBUUjx0jK8UaIYZLxeLWAstl+LwQg
	jRP+MBfznQG+MMhhuFB4MXadzgWTte8K/A==
X-Google-Smtp-Source: ABdhPJwXgIlIn0UureoNB1L+KDSNkoP/udXd6/tFTWzw0oMxE3Igqc4VkvKXPQgWKBAOO73q/0A4ow==
X-Received: by 2002:a05:6214:1366:: with SMTP id c6mr26399798qvw.30.1630422083851;
        Tue, 31 Aug 2021 08:01:23 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (192-0-174-222.cpe.teksavvy.com. [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id 75sm14094497qko.100.2021.08.31.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 08:01:22 -0700 (PDT)
Date: Tue, 31 Aug 2021 11:01:22 -0400 (EDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: mingli.yu@windriver.com
cc: bitbake-devel@lists.openembedded.org, Martin.Jansa@gmail.com
Subject: Re: [PATCH] prserv: make localhost work
In-Reply-To: <20210831074807.5972-1-mingli.yu@windriver.com>
Message-ID: <f3b29ae8-7582-4b3b-abaf-8e1eb08bf54@spiteful.org>
References: <16A04D855643B3E7.30479@lists.openembedded.org> <20210831074807.5972-1-mingli.yu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 31 Aug 2021, mingli.yu@windriver.com wrote:

> From: Mingli Yu <mingli.yu@windriver.com>
>
> After [1] introduced, the PR server doesn't work in docker when use
> below setting like before.
> PRSERV_HOST = "localhost:0"
>
> And it's because the localhost is resolved to an ipv6 address ::1 as
> the below bitbake-prserv shows.
>  bitbake$ bitbake-prserv --start --host=localhost --port=42005
>  bitbake$ cat prserv.log
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
> So add the extra logic to make the localhost resolved as expected to
> make the PR service work especially in docker.
>
> [1] 6a2b23e2 prserv: Replace XML RPC with modern asyncrpc implementation
>
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  lib/prserv/serv.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 68db3d3e..0a20b927 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -126,7 +126,7 @@ class PRServSingleton(object):
>
>      def start(self):
>          self.prserv = PRServer(self.dbfile)
> -        self.prserv.start_tcp_server(self.host, self.port)
> +        self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
>          self.process = self.prserv.serve_as_process()
>
>          if not self.prserv.address:
> @@ -221,7 +221,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
>      dbfile = os.path.abspath(dbfile)
>      def daemon_main():
>          server = PRServer(dbfile, read_only=read_only)
> -        server.start_tcp_server(host, port)
> +        server.start_tcp_server(ip, port)
>          server.serve_forever()
>
>      run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
>

Richard has picked up Martin's patch in master-next, I think that would
remove the need for this one?

Scott

