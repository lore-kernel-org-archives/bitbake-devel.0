Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA396C71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 07:07:31 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.43232.1693811241851422438
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Sep 2023 00:07:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YZ6e3diO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401f503b529so10889535e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693811240; x=1694416040; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/NYdz/lhUstlVhX8x47Zba9xea86vDiI3p2YMWDgWg=;
        b=YZ6e3diOeoXMaO9/V2r+MiABab0LoZKUdKW7GlaN2C7oGRig2q8CuvhrpTVVmNhQZS
         kNwzfGJpFe2iTK7aR2lHk5DdbN4ZkY+c/XAPmSSQBUw3+gihZ9mtFmPf3aVXKfQPRNz0
         UZ+aet/srfC6fFdKMxbOg9MmkkFLImQATw7Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811240; x=1694416040;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/NYdz/lhUstlVhX8x47Zba9xea86vDiI3p2YMWDgWg=;
        b=TL+gUAY7b8HVspr7C6KvCRMWx1WGLWOuJZyV8HZc/+Z72ZXBsDdE/erJ2gLm0F4EhB
         CetLYiTUvLdcPvep7Nk0K0eBRFw3EBBrq3+UrTKzZI0CCgaemLwi1xUc0Lq8YMW8P8iV
         P+bM6WC4vhEuENCnK84QIJrYq2CykUJql9OivcIJODeDHh8ys5i9ElKo+ybmbJ/FOfZi
         ngG2ATcr9whyujFfNBKPI/+U9pN1mgLpi5KePgNhejnsRgwdXW1FkzWDIKXmbIpJdNkI
         bLEB+3FmPOsDmS2pqHuyLCYI6VvMMRFQvxfIPNXxlC5MKUQht8ZoTKUw5s5uj8DDHL6I
         Sy1w==
X-Gm-Message-State: AOJu0YyU6b7rQwcAEbHGbpHy9J0v+HWtpOoEKhwC5bruWmVgeGNsxX4K
	ngiALuVK24l0s1XMVg+kBajspg==
X-Google-Smtp-Source: AGHT+IGKYbaGiDTYqekVt29IE+zrD2whQsNbSwdWmGYBdyCAnb2ZOBwimHSTVeQYlpNZEJPsqT702w==
X-Received: by 2002:a5d:4ccf:0:b0:319:7471:2965 with SMTP id c15-20020a5d4ccf000000b0031974712965mr7003342wrt.21.1693811239977;
        Mon, 04 Sep 2023 00:07:19 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:29e1:34bc:352d:65c? ([2001:8b0:aba:5f3c:29e1:34bc:352d:65c])
        by smtp.gmail.com with ESMTPSA id bp5-20020a5d5a85000000b0031f07d1edbcsm10899135wrb.77.2023.09.04.00.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:07:19 -0700 (PDT)
Message-ID: <f2989fafee47e8f5b714d976c3f7923978e1f66a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] command: Avoid time intensive
 distractions for ping
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 04 Sep 2023 08:07:18 +0100
In-Reply-To: <ZPV9aKltBIlkR3U/@nuoska>
References: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
	 <ZPBUpN6GaATE+zbz@nuoska>
	 <90096957449e6a35b3f2b349cb07132e0ef6a951.camel@linuxfoundation.org>
	 <ZPB5zs4on6u4mOgd@nuoska>
	 <6ea4d70d5bf116b389b7acbbe8825c55762d931d.camel@linuxfoundation.org>
	 <ZPV9aKltBIlkR3U/@nuoska>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 07:07:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15007

On Mon, 2023-09-04 at 09:47 +0300, Mikko Rapeli wrote:
> Hi,
>=20
> On Thu, Aug 31, 2023 at 01:01:30PM +0100, Richard Purdie wrote:
> > On Thu, 2023-08-31 at 14:30 +0300, Mikko Rapeli wrote:
> > > Hi,
> > >=20
> > > On Thu, Aug 31, 2023 at 09:56:33AM +0100, Richard Purdie wrote:
> > > > On Thu, 2023-08-31 at 11:51 +0300, Mikko Rapeli wrote:
> > > > > Hi,
> > > > >=20
> > > > > On Wed, Aug 30, 2023 at 10:33:03PM +0100, Richard Purdie wrote:
> > > > > > We noticed some users were seeing very slow ping response times=
 which
> > > > > > caused 'server timeout' issues. There were some function calls =
in runCommand
> > > > > > which could be slow such as the inotify callback processing.
> > > > >=20
> > > > > I guess the error looks like:
> > > > >=20
> > > > > Timeout while waiting for a reply from the bitbake server (60s)
> > > > >=20
> > > > > and happens right after a succesful build to me when I try to run=
 any bitbake
> > > > > command.
> > > > >=20
> > > > > Hope this fixes it. Thanks!
> > > >=20
> > > > That is the message however the cause may be different in your case=
. It
> > > > sounds like the server may be taking a long time to shut down for y=
ou
> > > > and it can't connect or start a new one whilst that is happening.
> > > >=20
> > > > If you have the bitbake-cookerdaemon log for your case I can see if
> > > > that sheds any light if this doesn't work for you.
> > >=20
> > > (Traceback (most recent call last):
> > >   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py"=
, line 292, in main
> > >     self.command_channel_reply.send(self.cooker.command.runCommand(co=
mmand, self))
> > >   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py"=
, line 868, in send
> > >     self._send(obj)
> > >   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py"=
, line 847, in _send
> > >     self.writer.send_bytes(obj)
> > >   File "/usr/lib/python3.10/multiprocessing/connection.py", line 200,=
 in send_bytes
> > >     self._send_bytes(m[offset:offset + size])
> > >   File "/usr/lib/python3.10/multiprocessing/connection.py", line 411,=
 in _send_bytes
> > >     self._send(header + buf)
> > >   File "/usr/lib/python3.10/multiprocessing/connection.py", line 368,=
 in _send
> > >     n =3D write(self._handle, buf)
> > > BrokenPipeError: [Errno 32] Broken pipe
> > > )
> > > 4131625 12:21:32.806544 Processing Client
> > > 4131625 12:21:32.806635 Disconnecting Client (socket: True)
> > > 4131625 12:21:32.807999 No timeout, exiting.
> > > 4131625 12:21:32.908254 Exiting (socket: True)
> > > 4131625 12:21:32.982669 More than one thread left?: [<_MainThread(Mai=
nThread, started 140013699211712)>, <Thread(asyncio_0, started 140012031006=
272)>]
> > > 4131625 12:21:34.433909 Exiting as we could obtain the lock
> > > sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name=3D'/hom=
e/builder/src/base/build/bitbake-cookerdaemon.log' mode=3D'a+' encoding=3D'=
UTF-8'>
> > >=20
> > > I don't know what else to look for in the log.
> >=20
> > What happened before that?
> >=20
> > The pipe error was the server trying to reply to the client but the
> > client was gone. We should be able to see the command running before
> > that and if it was a ping or not and the timestamps?
>=20
> bitbake is quite sensitive to IO on my Ubuntu 22.04 build machine
> with zfs. This is how I trigger this reliably:
>=20
> $ mv tmp foo ; rm -rf foo & bitbake image
> [1] 2709733
> Timeout while waiting for a reply from the bitbake server (60s)
>=20
> I have rm_work enabled so tmp is not that big except for the deployed fil=
es.

That is quite a different usecase to the one being fixed by the patch.

When bitbake starts up there are a few heavy IO things it needs to do
such as loading a hash equivalence database which may be large, loading
the parse cache and iterating through all the metadata to check it's
validity.

If your system has IO challenges, doing that in parallell with a large
deletion may be challenging. If the server doesn't start quickly
enough, you'll see the timeout.

Note that it isn't a ping which is timing out but an actual command.

Later when builds are running, ping is used as a lightweight way to
check the server is still there if there has been no communication for
a while. This patch fixes the ping command to really be lightweight so
that builds don't fail on a loaded system during the build.

It would be nice to find a way to improve the startup so that the
timeouts are avoided too but I'm less sure how to do that. Even if the
ping did work, if the commands themselves are slow/stalling, that is a
different set of challenges...

Cheers,

Richard





