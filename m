Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E06C83F01
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 12:01:35 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.15066.1693483293724799607
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 05:01:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ss5e0TxC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401d2e11dacso12279365e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693483292; x=1694088092; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NRHyXE2aRtyh7jYT8u2dXI5WQKPRII/9/Pp9zg1wjWA=;
        b=Ss5e0TxCQ8bBQ1ztjlRF6ld5JmFbl6gz7iO74kZOSjbl0nShmk+apu57Ok1ZnzikNK
         j6CwOTwwiLgZb7RhIOc4n+1cinj8HFq/mb+myUXY3Od1uyrDequh4q+nNINRnaNXojHX
         DURvhuJOQgzWzp3VUKJPlekESbDvScHdxgf+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693483292; x=1694088092;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRHyXE2aRtyh7jYT8u2dXI5WQKPRII/9/Pp9zg1wjWA=;
        b=lvssCYP/bS53waYGD4X52HNiELo5HyHv3lSKxgJHlwWeJmD1Ra4qV9HEYjW/6ThjHm
         H89JM9rpOAyIA0JKJdS94+RN5SO/kgCBGbBbjwI3xjEnlwDJKw5GxlshFJkES3VjBu6K
         J8nsmxBwx2dFvlOxC2m51KQwLekyUwGVv2N0iaAfKwewkxBrCjHIYw2QStXGmILYvh/C
         SoTWhpt8WWGJZq9gD252leWu8WmtTCsiethNLV+NGvxLsrhYJPv2/9SL6lx85H3nwtDN
         GDGlRA/rAk1cRV4oBicJsCCvtK/sYsZhhPF8jkX3qlO0GMWGc0SQNMPNYUts+eoKg/by
         Pt5g==
X-Gm-Message-State: AOJu0Yy842CnGA/JP2/eQF9RYwW1nlHANk11esEfVy4W4m6EmW9+R04r
	dKc5+BRSniRymYnB9xyEXYZfTg==
X-Google-Smtp-Source: AGHT+IGRGQWwEOpXgi9mG9GIW/ajASu3VPlPIHEIeuJwvNS7LVHLMTadjuBAX0f28W9nl/RiQ7jBxg==
X-Received: by 2002:a5d:6045:0:b0:319:7537:b454 with SMTP id j5-20020a5d6045000000b003197537b454mr1733300wrt.28.1693483292014;
        Thu, 31 Aug 2023 05:01:32 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:22b:9179:6474:7878? ([2001:8b0:aba:5f3c:22b:9179:6474:7878])
        by smtp.gmail.com with ESMTPSA id j14-20020adfe50e000000b0031c52e81490sm1998832wrm.72.2023.08.31.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:01:31 -0700 (PDT)
Message-ID: <6ea4d70d5bf116b389b7acbbe8825c55762d931d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] command: Avoid time intensive
 distractions for ping
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2023 13:01:30 +0100
In-Reply-To: <ZPB5zs4on6u4mOgd@nuoska>
References: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
	 <ZPBUpN6GaATE+zbz@nuoska>
	 <90096957449e6a35b3f2b349cb07132e0ef6a951.camel@linuxfoundation.org>
	 <ZPB5zs4on6u4mOgd@nuoska>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 12:01:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14997

On Thu, 2023-08-31 at 14:30 +0300, Mikko Rapeli wrote:
> Hi,
>=20
> On Thu, Aug 31, 2023 at 09:56:33AM +0100, Richard Purdie wrote:
> > On Thu, 2023-08-31 at 11:51 +0300, Mikko Rapeli wrote:
> > > Hi,
> > >=20
> > > On Wed, Aug 30, 2023 at 10:33:03PM +0100, Richard Purdie wrote:
> > > > We noticed some users were seeing very slow ping response times whi=
ch
> > > > caused 'server timeout' issues. There were some function calls in r=
unCommand
> > > > which could be slow such as the inotify callback processing.
> > >=20
> > > I guess the error looks like:
> > >=20
> > > Timeout while waiting for a reply from the bitbake server (60s)
> > >=20
> > > and happens right after a succesful build to me when I try to run any=
 bitbake
> > > command.
> > >=20
> > > Hope this fixes it. Thanks!
> >=20
> > That is the message however the cause may be different in your case. It
> > sounds like the server may be taking a long time to shut down for you
> > and it can't connect or start a new one whilst that is happening.
> >=20
> > If you have the bitbake-cookerdaemon log for your case I can see if
> > that sheds any light if this doesn't work for you.
>=20
> (Traceback (most recent call last):
>   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", li=
ne 292, in main
>     self.command_channel_reply.send(self.cooker.command.runCommand(comman=
d, self))
>   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", li=
ne 868, in send
>     self._send(obj)
>   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", li=
ne 847, in _send
>     self.writer.send_bytes(obj)
>   File "/usr/lib/python3.10/multiprocessing/connection.py", line 200, in =
send_bytes
>     self._send_bytes(m[offset:offset + size])
>   File "/usr/lib/python3.10/multiprocessing/connection.py", line 411, in =
_send_bytes
>     self._send(header + buf)
>   File "/usr/lib/python3.10/multiprocessing/connection.py", line 368, in =
_send
>     n =3D write(self._handle, buf)
> BrokenPipeError: [Errno 32] Broken pipe
> )
> 4131625 12:21:32.806544 Processing Client
> 4131625 12:21:32.806635 Disconnecting Client (socket: True)
> 4131625 12:21:32.807999 No timeout, exiting.
> 4131625 12:21:32.908254 Exiting (socket: True)
> 4131625 12:21:32.982669 More than one thread left?: [<_MainThread(MainThr=
ead, started 140013699211712)>, <Thread(asyncio_0, started 140012031006272)=
>]
> 4131625 12:21:34.433909 Exiting as we could obtain the lock
> sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name=3D'/home/bu=
ilder/src/base/build/bitbake-cookerdaemon.log' mode=3D'a+' encoding=3D'UTF-=
8'>
>=20
> I don't know what else to look for in the log.

What happened before that?

The pipe error was the server trying to reply to the client but the
client was gone. We should be able to see the command running before
that and if it was a ping or not and the timestamps?

Cheers,

Richard

