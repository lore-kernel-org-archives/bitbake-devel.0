Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.2029.1630459917883917495
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Aug 2021 18:31:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DvIxpL6i;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id u16so1961592wrn.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Aug 2021 18:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLRHDFpGJmY8w2IG1TVds9bmNzjgHT1r/RYiSyvcmXo=;
        b=DvIxpL6ipQhT5YAsmqTcmmeje05wLWi2a0hP60ucGr7z1iAmbd+TF09JYvZ6LNC7I0
         OR4N9eKM4zWI/u0kFMqT8RdIgAY7gDViWNsNe/zFx73NjKXbCYPqYWYequsb6oNv3MnD
         1F0WBeDL00xg+jGhoJIhZDzxn4utpJ9N1lKII0/2n0iYlj7mA1QsdxTn/YSbpoOs9dnz
         46dQGmzv7+eSpDdpmfXqoEP+k+a/AfSVUBDqzejFBg7UEFBRHXcqP9b6sEXLG5wI3luI
         CRXl1PzwhRew6o2j8oonlEe9PwJZzo3XEARjIgXlNm8kWIuhojdiu5oZz+wS37a8L7oW
         m24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLRHDFpGJmY8w2IG1TVds9bmNzjgHT1r/RYiSyvcmXo=;
        b=fJ2w6ljxucsrWvZvbntUMtCUuuRY101p+GAvmOAi4+CJAO5dEl0Tk36x8Yp1pEOfux
         iafN5zM1XLLULO4jiOqGne34YvtpIst5zbyr2/FCAYMn771xF+p4EEUbFEoAmM8EY0d8
         FTiKiSJtK24LLZWgqQyDNt5LVn0dWNgesK3mfRF24Fcfvmfg/pAAtK1ohJRYJTLgy7gB
         nO0GxgxSWvcRtrtckqXXzDmZPGMGjkbXDhd+6YgflHCkroB2VKXpV5h8Ih2djwjmM6RR
         OQE2Mw73j7ssKXU4u0Cw5qJUxHIt9SR3ywQrZPOlkWJrAO4+gOpTp6/GhqVhiizOuOGz
         OKuQ==
X-Gm-Message-State: AOAM532EM3B8nU0NI6D9hKSGu/e71Tc4AAf+L6MZxP/ecZR2yCoYBlCq
	OetX+LwEWWqSO7zZcma3G2A7QYE7W8kKTd/blnk=
X-Google-Smtp-Source: ABdhPJwHHZUFVKb84OZxeuE4gpE1XOredUVlCveewhyPA9W5ms2DY5h3bYcURTuGW0EzO2ZwLl36SVQPIGVjSwJp8Gs=
X-Received: by 2002:a05:6000:374:: with SMTP id f20mr5727478wrf.129.1630459916340;
 Tue, 31 Aug 2021 18:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <16A04D855643B3E7.30479@lists.openembedded.org>
 <20210831074807.5972-1-mingli.yu@windriver.com> <f3b29ae8-7582-4b3b-abaf-8e1eb08bf54@spiteful.org>
 <d3e95bfb-593d-0fd8-bcb8-65af9537f5ea@windriver.com>
In-Reply-To: <d3e95bfb-593d-0fd8-bcb8-65af9537f5ea@windriver.com>
From: "Joshua Watt" <JPEWhacker@gmail.com>
Date: Tue, 31 Aug 2021 20:31:45 -0500
Message-ID: <CAJdd5GaViYYCa6XovSO7n6ceSjBemn28bhN7TjSaCQgXkYpmuw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] prserv: make localhost work
To: "Yu, Mingli" <mingli.yu@windriver.com>
Cc: Scott Murray <scott.murray@konsulko.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Martin Jansa <Martin.Jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 31, 2021 at 8:14 PM Yu, Mingli <mingli.yu@windriver.com> wrote:
>
>
>
> On 8/31/21 11:01 PM, Scott Murray wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> >
> > On Tue, 31 Aug 2021, mingli.yu@windriver.com wrote:
> >
> >> From: Mingli Yu <mingli.yu@windriver.com>
> >>
> >> After [1] introduced, the PR server doesn't work in docker when use
> >> below setting like before.
> >> PRSERV_HOST = "localhost:0"
> >>
> >> And it's because the localhost is resolved to an ipv6 address ::1 as
> >> the below bitbake-prserv shows.
> >>   bitbake$ bitbake-prserv --start --host=localhost --port=42005
> >>   bitbake$ cat prserv.log
> >>      Traceback (most recent call last):
> >>        File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 55, in <module>
> >>          ret = main()
> >>        File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 46, in main
> >>          ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
> >>        File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 226, in start_daemon
> >>          run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
> >>        File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 202, in run_as_daemon
> >>          func()
> >>        File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 224, in daemon_main
> >>          server.serve_forever()
> >>        File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 233, in serve_forever
> >>          self.start()
> >>        File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
> >>          self.server = self.loop.run_until_complete(server_coro)
> >>        File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
> >>          return future.result()
> >>        File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
> >>          return await loop.create_server(factory, host, port, **kwds)
> >>        File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
> >>          raise OSError(err.errno, 'error while attempting '
> >>      OSError: [Errno 99] error while attempting to bind on address ('::1', 42005, 0, 0): cannot assign requested address
> >>
> >> So add the extra logic to make the localhost resolved as expected to
> >> make the PR service work especially in docker.
> >>
> >> [1] 6a2b23e2 prserv: Replace XML RPC with modern asyncrpc implementation
> >>
> >> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> >> ---
> >>   lib/prserv/serv.py | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> >> index 68db3d3e..0a20b927 100644
> >> --- a/lib/prserv/serv.py
> >> +++ b/lib/prserv/serv.py
> >> @@ -126,7 +126,7 @@ class PRServSingleton(object):
> >>
> >>       def start(self):
> >>           self.prserv = PRServer(self.dbfile)
> >> -        self.prserv.start_tcp_server(self.host, self.port)
> >> +        self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
> >>           self.process = self.prserv.serve_as_process()
> >>
> >>           if not self.prserv.address:
> >> @@ -221,7 +221,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
> >>       dbfile = os.path.abspath(dbfile)
> >>       def daemon_main():
> >>           server = PRServer(dbfile, read_only=read_only)
> >> -        server.start_tcp_server(host, port)
> >> +        server.start_tcp_server(ip, port)
> >>           server.serve_forever()
> >>
> >>       run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
> >>
> >
> > Richard has picked up Martin's patch in master-next, I think that would
> > remove the need for this one?
>
> The patch from Martin is just make the error message specific, but
> localhost still does't work in docker with Martin's patch and this patch
> is used to make it work in docker.

I think that was because IPv6 support had been incorrectly configured
for Docker, perhaps that is the same thing happening in your setup?

>
> Thanks,
>
> >
> > Scott
> >
>
> 
>
