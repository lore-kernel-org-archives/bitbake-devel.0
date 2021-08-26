Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web12.35844.1630005457216378920
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Aug 2021 12:17:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PtppKgp3;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id j9so2679958qvt.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 26 Aug 2021 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+6GuJbNXK9VSrNtRBobxTEfNoVlLuXYsJZjx5aT7MX4=;
        b=PtppKgp3/GwICo75Qdx81Y8dzUNez8fPpWPM+wscNKOEdCcatojIYSctpqqW0xHtl8
         rTB4ycVBhc2rOXubCVyQatDX79tv6YSn+K8uHycJSLNfb4BteSAfzR+SuIPPyGDo9ef7
         KPDIJZ7pDIhgD6zhwZ2+9HSveJ3KteZRMSm2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+6GuJbNXK9VSrNtRBobxTEfNoVlLuXYsJZjx5aT7MX4=;
        b=uHYcCWSfPJ6Gl97x8JRKzNZEfksIKcL/BNDNe3cCebGP7XL8oyUnMsPtVWz3UXweHT
         VWBEFnSvysVsEdYQnwHtTWgHa0zLqbpCvsw90nG0xwYoThBqXZMT1vDltl3130JCFe1a
         0yt7X3sOPsOwXieMwTjqbvqmSXrmdpkBgbY8KJ7u+IsHyoAuvsVZwjIxfPbFkCEx7gFk
         HlOtW6iaY7QXBhs9up42ATsX9WH8NTPGaj3TGI/T9LVUrJxNDNJo4IMq//bAeUje/WJQ
         kcx7QfTDreYUqBigK7MpnVF3YgnxrfUDjMD3AI9NtFgyTRVoxJ6wDypU6DcEu7AE5Wjw
         XvOg==
X-Gm-Message-State: AOAM533WucK7ZnnXu2hi4K05cRX/CdQLbNl3e2qmRRziDuyM8WGpp7I5
	yl7e5hEEEXMwSkeioqAIxuB3UQ==
X-Google-Smtp-Source: ABdhPJxnjvyFylmA4ykYmTEGz29LuDVmgoPg7foCezK0XvI8JGRrGCtFRnuD0Q4EeDH4BZ/9p/7iKA==
X-Received: by 2002:a0c:e744:: with SMTP id g4mr5947065qvn.20.1630005456350;
        Thu, 26 Aug 2021 12:17:36 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (192-0-174-222.cpe.teksavvy.com. [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id j23sm3199859qkl.65.2021.08.26.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:17:35 -0700 (PDT)
Date: Thu, 26 Aug 2021 15:17:34 -0400 (EDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: Martin Jansa <martin.jansa@gmail.com>
cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
    Richard Purdie <richard.purdie@linuxfoundation.org>, 
    Joshua Watt <JPEWhacker@gmail.com>, Paul Barker <paul@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH v6 3/4] prserv: Replace XML RPC with modern asyncrpc implementation
In-Reply-To: <CA+chaQcuZp=-o8m96OnZ7KzRmFzUeuiQCS4b1zCKcuM4-SzbBw@mail.gmail.com>
Message-ID: <7ea3f614-246f-38fc-2bd5-c22a9b1093f0@spiteful.org>
References: <cover.1629388054.git.scott.murray@konsulko.com> <9a32587b89bb715e3614e15ab2695c0449d7ba26.1629388054.git.scott.murray@konsulko.com> <CA+chaQcuZp=-o8m96OnZ7KzRmFzUeuiQCS4b1zCKcuM4-SzbBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 26 Aug 2021, Martin Jansa wrote:

> On Thu, Aug 19, 2021 at 6:47 PM Scott Murray <scott.murray@konsulko.com>
> wrote:
>
> > From: Paul Barker <pbarker@konsulko.com>
> >
> > Update the prserv client and server classes to use the modern json and
> > asyncio based RPC system implemented by the asyncrpc module.
> >
> > Signed-off-by: Paul Barker <pbarker@konsulko.com>
> > [updated for asyncrpc changes, client split to separate file]
> > Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> >
> > ....
>
> > -    def export(self,version=None, pkgarch=None, checksum=None,
> > colinfo=True):
> > -        return self.connection.export(version, pkgarch, checksum, colinfo)
> > +class PRServSingleton(object):
> > +    def __init__(self, dbfile, logfile, host, port):
> > +        self.dbfile = dbfile
> > +        self.logfile = logfile
> > +        self.host = host
> > +        self.port = port
> >
> > -    def importone(self, version, pkgarch, checksum, value):
> > -        return self.connection.importone(version, pkgarch, checksum,
> > value)
> > +    def start(self):
> > +        self.prserv = PRServer(self.dbfile)
> > +        self.prserv.start_tcp_server(self.host, self.port)
> > +        self.process = self.prserv.serve_as_process()
> >
> > -    def getinfo(self):
> > -        return self.host, self.port
> > +        if not self.port:
> > +            self.port = int(self.prserv.address.rsplit(':', 1)[1])
>
> Hi,
>
> I've tried this when running inside docker container and it failed with a
> bit ugly exception:
>
> bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native
> Traceback (most recent call last):
>   File "/OE/nodistro/honister/bitbake/bin/bitbake", line 35, in <module>
>     sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
>   File "/OE/nodistro/honister/bitbake/lib/bb/main.py", line 385, in
> bitbake_main
>     return ui_module.main(server_connection.connection,
> server_connection.events,
>   File "/OE/nodistro/honister/bitbake/lib/bb/ui/knotty.py", line 397, in
> main
>     params.updateToServer(server, os.environ.copy())
>   File "/OE/nodistro/honister/bitbake/lib/bb/cookerdata.py", line 75, in
> updateToServer
>     raise Exception("Unable to update the server configuration with local
> parameters: %s" % error)
> Exception: Unable to update the server configuration with local parameters:
> Traceback (most recent call last):
>   File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 90, in
> runCommand
>     result = command_method(self, commandline)
>   File "/OE/nodistro/honister/bitbake/lib/bb/command.py", line 286, in
> updateConfig
>     command.cooker.updateConfigOpts(options, environment, cmdline)
>   File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 491, in
> updateConfigOpts
>     self.reset()
>   File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 1717, in reset
>     self.handlePRServ()
>   File "/OE/nodistro/honister/bitbake/lib/bb/cooker.py", line 383, in
> handlePRServ
>     self.prhost = prserv.serv.auto_start(self.data)
>   File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 318, in
> auto_start
>     singleton.start()
>   File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 133, in
> start
>     self.port = int(self.prserv.address.rsplit(':', 1)[1])
> AttributeError: 'NoneType' object has no attribute 'rsplit'
>
> after removing the rsplit it shows better error message:
>
> bitbake@599696cd20aa:~/nodistro/honister$ bitbake -k pkgconfig-native
> WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
> call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
> WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
> call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
> WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
> call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
> WARNING: Error talking to server: Multiple exceptions: [Errno 111] Connect
> call failed ('127.0.0.1', 0), [Errno 99] Cannot assign requested address
> ERROR: PRservice localhost:0 not available
> ERROR: Unable to start PR Server, exitting
>
> It would be nice to improve the error handling a bit.

Could you elaborate a bit on your configuration?  Is it just trying to
build plain oe-core / poky in Docker?  I don't really see right off from
the code in bitbake's lib/bb/asyncrpc/serv.py how the port from the
asyncio server instance could end up unset.

Thanks,

Scott

