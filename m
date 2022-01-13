Return-Path: <jatedev@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8881FC433EF
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 18:04:52 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.653.1642097063475586133
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 10:04:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VOxV7AEE;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: jatedev@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id p14so10950891plf.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 10:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOxKBA8ZtU0UMUACRr0EDXdxzDxKSOcLowgj8PM2jl0=;
        b=VOxV7AEE1mkD+az/BxZBfbeJBiJS3E9xhw4gXOKtltoUTfXjNguizrMpupQfoiLPMC
         XXYB2G2GzdCVnAk7/elc/jg0HWZXJAFtO/BmmvLfnxlDi0vrX00uApV5991kjc9fYVzZ
         qP9qYYkF2rfVqYNLQsGqMspgi0rEm7mLIci7N9YORYYkvOI2kxf9zqcfosNRopSuYDbz
         BFxlR86ovLbNviJBcyyziNDh/qUMP7tlG9JanqLqrqNu8Nk/uyfv/7C58bu/cN4bfR+g
         0Ou1qIbh6END5lq7g3c6OcTX1lOS0awaaS1kAwBufUbzrExLKB4VLXMyJbvaNPGXVvTB
         MqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOxKBA8ZtU0UMUACRr0EDXdxzDxKSOcLowgj8PM2jl0=;
        b=3fisWDdEV4iYMRKGcNsQoIQoO5dLWO+RzX4xWC08NxMCUz8Ycr6mzZdBWhWPmAt2VS
         /JosGA9z8fhpn0wf7tHPSYKyGonZNrwUE5keTX87vgDNKJuxFt7LfIkt1+B8qosgqJ0r
         NMwV1W25LtDo7JifSP+unaxawAXlsICeX04LAqn80xCCA5Q10ugZWhYMDVzeZSTQKpbn
         tujxAw+x/rnGp7pL4IPr774HS92r5Q4+N1GPdGeWT+KnZkJVhh2beIqy/0bOmoDaxQ7d
         KnCt9xmewrlrC/wDhlneASHWeMFdN0/ZSD6AvXE8Awt6FM9gUUfTqzrHGwa9FdPCEpjM
         P3UA==
X-Gm-Message-State: AOAM530E9euqGcs7RP40cbF9qcdN0Z5HDjHvPFsNw0+q50aVSME8ny34
	PXJDgC2+Wus+EutV+ZICNmz/Tq0cLQ3tv3Ke6IrdKwfjRJk=
X-Google-Smtp-Source: 
 ABdhPJxTPF1vu7C8X1984b5wteJJyXSNK5qTuf2MjxaMKxPeH+e3RnopBD3/6MVk2l7kQbfW7JMSft/RcpTmmwAnFoE=
X-Received: by 2002:a17:902:e54f:b0:14a:1bbf:9cf0 with SMTP id
 n15-20020a170902e54f00b0014a1bbf9cf0mr5713634plf.158.1642097063001; Thu, 13
 Jan 2022 10:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20220113010527.181-1-jatedev@gmail.com>
 <78ac1aea-db40-2a99-1668-dc3bfcb3a074@bootlin.com>
In-Reply-To: <78ac1aea-db40-2a99-1668-dc3bfcb3a074@bootlin.com>
From: Jate Sujjavanich <jatedev@gmail.com>
Date: Thu, 13 Jan 2022 13:04:11 -0500
Message-ID: 
 <CAPphmgaM5ABM=omAhgizE+ay+S65hELq_rgQio9ed4aVdSTRNQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [1.46][PATCH] hashserv: specify loop for asyncio
 in python < 3.7
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, ashishm@mvista.com
Content-Type: multipart/alternative; boundary="00000000000020813405d57a8403"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jan 2022 18:04:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13234

--00000000000020813405d57a8403
Content-Type: text/plain; charset="UTF-8"

Hello Michael,

I tested on an Ubuntu 20.04 docker container, and the code worked in that
environment. It has kernel 5.10.25-linuxkit which is different from the
default kernel in Ubuntu 20.04 which is 5.4.

I chose to keep the loop argument for versions 3.6 and below because python
first deprecated the loop argument in 3.7. Perhaps it's safer to keep
specifying loop for 3.9 and below. There is one other report of the bug but
it seems to be the result of the fix for 3.10 in October. So it was
probably working for python 3.9 and below.

Could you try the fix with the minor number changed to 10?

if sys.version_info[0] == 3 and sys.version_info[1] < 10:

If that works, I will update the patch. I am not familiar with the asyncio
library and its system calls, so I'm hoping this works.

Ashish: You reported behavior like this bug. Do you have more information
on your Python and build environment?


Thanks,
- Jate S.

On Thu, Jan 13, 2022 at 11:53 AM Michael Opdenacker <
michael.opdenacker@bootlin.com> wrote:

> Hi Jate
>
> On 1/13/22 2:05 AM, Jate Sujjavanich wrote:
> > Detect python version 3.6 and below restoring loop argument where
> > it is still required. In 3.7 auto loop detection is available.
> >
> > Bitbake 1.46 is used in dunfell which requires a minimum python version
> > of 3.5. Omitting this argument leads to a regression and hang during
> > "Initialising tasks" at 44%.
>
>
> Thanks for the patch!
> Weirdly, though, my host (Ubuntu 20.04) has Python 3.8 and still
> regularly has the "Initializing task" step stuck at 44% for a several
> minutes.
>
> Here's what strace says while this happens:
> futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
> {tv_sec=1642092729, tv_nsec=110486000}, FUTEX_BITSET_MATCH_ANY) = -1
> ETIMEDOUT (Connection timed out)
> futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
> {tv_sec=1642092729, tv_nsec=360665000}, FUTEX_BITSET_MATCH_ANY) = -1
> ETIMEDOUT (Connection timed out)
> futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
> {tv_sec=1642092729, tv_nsec=610862000}, FUTEX_BITSET_MATCH_ANY) = -1
> ETIMEDOUT (Connection timed out)
> futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
> {tv_sec=1642092729, tv_nsec=861086000}, FUTEX_BITSET_MATCH_ANY) = -1
> ETIMEDOUT (Connection timed out)
> futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,
> {tv_sec=1642092730, tv_nsec=111295000}, FUTEX_BITSET_MATCH_ANY) = -1
> ETIMEDOUT (Connection timed out)
> ...
>
> Any clue why this can happen?
>
> Thanks
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--00000000000020813405d57a8403
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-family:monospace"><span style=3D"=
font-family:arial,sans-serif">Hello Michael,<br></span></span></div><div><s=
pan style=3D"font-family:monospace"><span style=3D"font-family:arial,sans-s=
erif"><br></span></span></div><div>I tested on an Ubuntu 20.04 docker conta=
iner, and the code worked in that environment. It has kernel 5.10.25-linuxk=
it which is different from the default kernel in Ubuntu 20.04 which is 5.4.=
</div><div><br></div><div>I chose to keep the loop argument for versions 3.=
6 and below because python first deprecated the loop argument in 3.7. Perha=
ps it&#39;s safer to keep specifying loop for 3.9 and below. There is one o=
ther report of the bug but it seems to be the result of the fix for 3.10 in=
 October. So it was probably working for python 3.9 and below.<br></div><di=
v><br></div><div>Could you try the fix with the minor number changed to 10?=
</div><div><br></div><div><span style=3D"font-family:monospace">if sys.vers=
ion_info[0] =3D=3D 3 and sys.version_info[1] &lt; 10:</span></div><div><spa=
n style=3D"font-family:monospace"><br></span></div><div><span style=3D"font=
-family:monospace"><font face=3D"arial,sans-serif">If that works, I will up=
date the patch. I am not familiar with the asyncio library and its system c=
alls, so I&#39;m hoping this works.<br></font></span></div><div><span style=
=3D"font-family:monospace"><br></span></div><div><div><span style=3D"font-f=
amily:monospace"><span style=3D"font-family:arial,sans-serif">Ashish: You r=
eported behavior like this bug. Do you have more information on your Python=
 and build environment?</span></span></div><div><br><br></div><span style=
=3D"font-family:monospace"></span></div><div><span style=3D"font-family:mon=
ospace"></span></div><div><span style=3D"font-family:arial,sans-serif"></sp=
an></div><div><span style=3D"font-family:arial,sans-serif">Thanks,<br></spa=
n></div><div><span style=3D"font-family:monospace"><span style=3D"font-fami=
ly:arial,sans-serif">- Jate S.</span><br></span></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 13, 2022=
 at 11:53 AM Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@bo=
otlin.com" target=3D"_blank">michael.opdenacker@bootlin.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Jate<br>
<br>
On 1/13/22 2:05 AM, Jate Sujjavanich wrote:<br>
&gt; Detect python version 3.6 and below restoring loop argument where<br>
&gt; it is still required. In 3.7 auto loop detection is available.<br>
&gt;<br>
&gt; Bitbake 1.46 is used in dunfell which requires a minimum python versio=
n<br>
&gt; of 3.5. Omitting this argument leads to a regression and hang during<b=
r>
&gt; &quot;Initialising tasks&quot; at 44%.<br>
<br>
<br>
Thanks for the patch!<br>
Weirdly, though, my host (Ubuntu 20.04) has Python 3.8 and still<br>
regularly has the &quot;Initializing task&quot; step stuck at 44% for a sev=
eral<br>
minutes.<br>
<br>
Here&#39;s what strace says while this happens:<br>
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,<br>
{tv_sec=3D1642092729, tv_nsec=3D110486000}, FUTEX_BITSET_MATCH_ANY) =3D -1<=
br>
ETIMEDOUT (Connection timed out)<br>
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,<br>
{tv_sec=3D1642092729, tv_nsec=3D360665000}, FUTEX_BITSET_MATCH_ANY) =3D -1<=
br>
ETIMEDOUT (Connection timed out)<br>
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,<br>
{tv_sec=3D1642092729, tv_nsec=3D610862000}, FUTEX_BITSET_MATCH_ANY) =3D -1<=
br>
ETIMEDOUT (Connection timed out)<br>
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,<br>
{tv_sec=3D1642092729, tv_nsec=3D861086000}, FUTEX_BITSET_MATCH_ANY) =3D -1<=
br>
ETIMEDOUT (Connection timed out)<br>
futex(0x277c200, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 0,<br>
{tv_sec=3D1642092730, tv_nsec=3D111295000}, FUTEX_BITSET_MATCH_ANY) =3D -1<=
br>
ETIMEDOUT (Connection timed out)<br>
...<br>
<br>
Any clue why this can happen?<br>
<br>
Thanks<br>
Michael.<br>
<br>
-- <br>
Michael Opdenacker, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div>

--00000000000020813405d57a8403--

