Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9DC433EF
	for <webhook@archiver.kernel.org>; Tue,  4 Jan 2022 03:31:39 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web08.2032.1641267098156744628
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 19:31:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=GF0r43bR;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: kergoth@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id
 b1-20020a17090a990100b001b14bd47532so1738643pjp.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 19:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version;
        bh=EfyF30KcCo8FEo2HqKuF1ndjOpIF/Ax/1KRj3XRR14s=;
        b=GF0r43bRmfkhk7Rapo1erKNvitU9KiTnSL1pEx+jc384LmNu+L9mtXM0NZSXtaFJ/5
         WsZkyJxEMkxABRayWWw8m/dQyjjm/i1R/Loo2AEB8UX+f8kPsKcYur4hMvGp0Ten9FpZ
         PRys64SeMJ66xKGU1lugIvBHjRNICl0+ww92GF31jrOdEKBWmN/sKZ1lVbNnD/e1ZX8v
         fdwQ2pMT9LI33jCSptD+00+aXMc2vet/VBs0lHOws3A/TSTMXetAEnjcVv1ZQz+ms62H
         khNTccViJt1GBjS6ZLzEe9W9ylluZP3hYNjA8kUJ1T5nkh+HINx2YyDepm41lj7CmMxW
         gWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version;
        bh=EfyF30KcCo8FEo2HqKuF1ndjOpIF/Ax/1KRj3XRR14s=;
        b=gIismfCtYy4QJNxzqmudaeFkWJn0ZgJDQf4dDJjitXIL3/X8gF44wGuWIDSRF9UUCt
         wU/dWXphc3bFrF/obMnKgMav8RHXnMOMTh6R4Uw6Bootu2sULokCXCiLy0asmYdGKuaa
         ybQhFgiTb2cGt6mPFC9FglRUqQNLty2IDh3F+1xYy29y/BKA0MySQ39IsHHGgu0pmWL+
         bIwztsOpudf/+i1n2/hq4w7jwA2jMbPdf7V51hEj5BjNqNCtYPszic/8fzjxTDrNkKuu
         LcKFIQYrzdIxukkOZocifQwKTjtID5xDP/g+eps+/gF9a9Huw8yM7lWTXc+Gf2tfhWEe
         4TXQ==
X-Gm-Message-State: AOAM530+QQada8vDwnGtU0QzUxjFcF6T5eTQU5iKh7HTzZ+csbJuTtAE
	Q+/gDGgUallZfd/x/1Z8DrQ=
X-Google-Smtp-Source: 
 ABdhPJyhM/q9E0x19Rs3ko+A+xKpBUzbJFl1Mf1X2MgzoL8F2O7i2X87dyR3gWp3I9jugnEPTwtrpQ==
X-Received: by 2002:a17:902:868f:b0:149:bc81:88e1 with SMTP id
 g15-20020a170902868f00b00149bc8188e1mr7073226plo.128.1641267097637;
        Mon, 03 Jan 2022 19:31:37 -0800 (PST)
Received: from [192.168.1.17] (ip70-188-217-212.ph.ph.cox.net.
 [70.188.217.212])
        by smtp.gmail.com with ESMTPSA id
 q21sm42991157pfu.176.2022.01.03.19.31.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jan 2022 19:31:37 -0800 (PST)
Date: Mon, 3 Jan 2022 20:31:27 -0700
From: Christopher Larson <kergoth@gmail.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 bitbake-devel@lists.openembedded.org, Richard Purdie
 <richard.purdie@linuxfoundation.org>
Cc: Alexander Kanavin <alex@linutronix.de>
Message-ID: <94e16972-440b-4ab1-a157-8c8d47907ed6@Spark>
In-Reply-To: 
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
References: <20220101112911.1866500-1-alex@linutronix.de>
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] providers.py: do not skip recipes
 providing 'virtual/x' in world builds
X-Readdle-Message-ID: 94e16972-440b-4ab1-a157-8c8d47907ed6@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="61d3bf97_6eb5bd4_9af9"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Jan 2022 03:31:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13213

--61d3bf97_6eb5bd4_9af9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This seems like something that could be moved to oe-core rather than bein=
g in bitbake proper, set EXCLUDE=5F=46ROM=5FWORLD=E2=80=99s default value=
 if providing virtual/, in which case this functionality could be easily =
disabled if needed as well.

--
Christopher =E2=80=9Ckergoth=E2=80=9D Larson
chris=5Flarson=40mentor.com, chris.larson=40siemens.com, kergoth=40gmail.=
com
=46ounder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics, a Siemens Business
On Jan 3, 2022, 3:38 PM -0700, Richard Purdie <richard.purdie=40linuxfoun=
dation.org>, wrote:
> On Sat, 2022-01-01 at 12:29 +0100, Alexander Kanavin wrote:
> > This is very old code pre-dating 2005, and the reasons are probably l=
ost in
> > history.
>
> They're not, I remember this.
>
> > Doing this skipping means that anything providing 'virtual/x' is excl=
uded
> > from populating packages to deploy/ in world builds, and thus, from r=
eproducubility
> > and packaging tests.
> >
> > This issue has been largely masked until 'package=5Fipk/deb/rpm: Drop=
 recursive do=5Fbuild task dependencies'
> > as previously recipes without virtual/x provides would pull in the de=
pendent rpms instead of the world target
> > doing that directly.
> >
> > I have noticed the issue by observing that go-runtime is no longer re=
ported as
> > non-reproducible when it should be.
>
> The principle is that virtual/XXX should only be built if something act=
ually
> depends upon them as they're usually used to denote things which can be=
 provided
> from multiple sources. I'd argue that the code is correct and wonder wh=
ether:
>
> a) go-runtime should be providing a virtual
> b) that OE-Core should have something depending on go-runtime for test =
purposes
>
> Cheers,
>
> Richard
>
>
> >
> > Signed-off-by: Alexander Kanavin <alex=40linutronix.de>
> > ---
> > bitbake/lib/bb/providers.py =7C 4 ----
> > 1 file changed, 4 deletions(-)
> >
> > diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.p=
y
> > index 8c1c31a5c5..3c4462fbdd 100644
> > --- a/bitbake/lib/bb/providers.py
> > +++ b/bitbake/lib/bb/providers.py
> > =40=40 -429,10 +429,6 =40=40 def buildWorldTargetList(dataCache, task=
=3DNone):
> > terminal =3D =46alse
> >
> > for p in dataCache.pn=5Fprovides=5Bpn=5D:
> > - if p.startswith('virtual/'):
> > - logger.debug2(=22World build skipping %s due to %s provider startin=
g with virtual/=22, f, p)
> > - terminal =3D =46alse
> > - break
> > for pf in dataCache.providers=5Bp=5D:
> > if dataCache.pkg=5Ffn=5Bpf=5D =21=3D pn:
> > logger.debug2(=22World build skipping %s due to both us and %s provid=
ing %s=22, f, pf, p)
> >
> >
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (=2313212): https://lists.openembedded.org/g/bitbake-=
devel/message/13212
> Mute This Topic: https://lists.openembedded.org/mt/88071309/3617123
> Group Owner: bitbake-devel+owner=40lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =5Bke=
rgoth=40gmail.com=5D
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--61d3bf97_6eb5bd4_9af9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>This seems like something that could be moved to oe=
-core rather than being in bitbake proper, set EXCLUDE=5F=46ROM=5FWORLD=E2=
=80=99s default value if providing virtual/, in which case this functiona=
lity could be easily disabled if needed as well.</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22>
<div dir=3D=22auto=22>--</div>
<div dir=3D=22auto=22>Christopher =E2=80=9Ckergoth=E2=80=9D Larson</div>
<div dir=3D=22auto=22>chris=5Flarson=40mentor.com, chris.larson=40siemens=
.com, kergoth=40gmail.com</div>
<div dir=3D=22auto=22>=46ounder - BitBake, OpenEmbedded, OpenZaurus</div>=

<div dir=3D=22auto=22>Senior Software Engineer, Mentor Graphics, a Siemen=
s Business</div>
</div>
</div>
<div name=3D=22messageReplySection=22>On Jan 3, 2022, 3:38 PM -0700, Rich=
ard Purdie &lt;richard.purdie=40linuxfoundation.org&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>On Sat, 2022-01-01 at 12:29 +0100, Alexander Kanavin wrote:<br =
/>
<blockquote type=3D=22cite=22>This is very old code pre-dating 2005, and =
the reasons are probably lost in<br />
history.<br /></blockquote>
<br />
They're not, I remember this.<br />
<br />
<blockquote type=3D=22cite=22>Doing this skipping means that anything pro=
viding 'virtual/x' is excluded<br />
from populating packages to deploy/ in world builds, and thus, from repro=
ducubility<br />
and packaging tests.<br />
<br />
This issue has been largely masked until 'package=5Fipk/deb/rpm: Drop rec=
ursive do=5Fbuild task dependencies'<br />
as previously recipes without virtual/x provides would pull in the depend=
ent rpms instead of the world target<br />
doing that directly.<br />
<br />
I have noticed the issue by observing that go-runtime is no longer report=
ed as<br />
non-reproducible when it should be.<br /></blockquote>
<br />
The principle is that virtual/XXX should only be built if something actua=
lly<br />
depends upon them as they're usually used to denote things which can be p=
rovided<br />
from multiple sources. I'd argue that the code is correct and wonder whet=
her:<br />
<br />
a) go-runtime should be providing a virtual<br />
b) that OE-Core should have something depending on go-runtime for test pu=
rposes<br />
<br />
Cheers,<br />
<br />
Richard<br />
<br />
<br />
<blockquote type=3D=22cite=22><br />
Signed-off-by: Alexander Kanavin &lt;alex=40linutronix.de&gt;<br />
---<br />
bitbake/lib/bb/providers.py =7C 4 ----<br />
1 file changed, 4 deletions(-)<br />
<br />
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py<br=
 />
index 8c1c31a5c5..3c4462fbdd 100644<br />
--- a/bitbake/lib/bb/providers.py<br />
+++ b/bitbake/lib/bb/providers.py<br />
=40=40 -429,10 +429,6 =40=40 def buildWorldTargetList(dataCache, task=3DN=
one):<br />
terminal =3D =46alse<br />
<br />
for p in dataCache.pn=5Fprovides=5Bpn=5D:<br />
- if p.startswith('virtual/'):<br />
- logger.debug2(=22World build skipping %s due to %s provider starting wi=
th virtual/=22, f, p)<br />
- terminal =3D =46alse<br />
- break<br />
for pf in dataCache.providers=5Bp=5D:<br />
if dataCache.pkg=5Ffn=5Bpf=5D =21=3D pn:<br />
logger.debug2(=22World build skipping %s due to both us and %s providing =
%s=22, f, pf, p)<br />
<br />
<br /></blockquote>
<br />
<br />
<br />
<br />
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br />
Links: You receive all messages sent to this group.<br />
View/Reply Online (=2313212): https://lists.openembedded.org/g/bitbake-de=
vel/message/13212<br />
Mute This Topic: https://lists.openembedded.org/mt/88071309/3617123<br />=

Group Owner: bitbake-devel+owner=40lists.openembedded.org<br />
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =5Bkerg=
oth=40gmail.com=5D<br />
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br />
<br /></blockquote>
</div>
</body>
</html>

--61d3bf97_6eb5bd4_9af9--


