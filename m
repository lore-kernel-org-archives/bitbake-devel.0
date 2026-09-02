Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B940CC61DD6
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 15:26:30 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15820.1788362780771005872
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 08:26:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DhwxnqTA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c259e5c22ffso200171866b.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788362779; x=1788967579; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rnmPbzoNMDaESk6DCOWJbqJJvG6A7Nif+OlFwLefG4o=;
        b=DhwxnqTASPl9ypP087sEmWFxklkFmprzLmZFfNwCIx+tphuruECP1BSdKxqYFV7yQP
         qdyFab24Qpv3LrrCE09YbmeANrC4YRLW8kjBb4zPNKC1bmf/gIHR1RNEjNDqILN3wuCt
         z9IaBN299yUlVfGEAPk3NxqEy2RWowA3Y0T7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362779; x=1788967579;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rnmPbzoNMDaESk6DCOWJbqJJvG6A7Nif+OlFwLefG4o=;
        b=nMjBv15wv8uwWugY7qSiYjE/ILPolZd0m071qnBCGe0FobtR9UxNGmVl1KgC+IEmj0
         fqXGkJnA5Dz0cjLqIVskZn/WP842AU+jQfdnvwSTg/jYZX0suMOQ1oUQk7wiSwRQ7ViL
         TlhIdgKpfXlkr5mY2m2wIgEcEYAvoOwbsXZbrTk+yxegha84zISzQZXEgS3Ys5De8I77
         ORDRCBIeKViJ8R1JUGOtFrA8ieR+XVPlcqcq3U4kdfHvC593589kpF+gT+3z1HEs7qLb
         Q65AXzftUdYDViNSgr58sO8UiSIWgfTaehkXzt6rX/Vfclvp9RlSfOf0WREfsqWb8dxD
         Rbyg==
X-Forwarded-Encrypted: i=1; AKwUvBwAcdpzYfCmvnJ4uErnO9ol+Qoa9LUK17HjtODw1CsbrHDDE7uqnQVpzrg3ZxS9soTJDh3fsjsDDTy2gMG4@lists.openembedded.org
X-Gm-Message-State: AFuF++k2teDzZ5ZA5aWlpUsa8npqbB4aEtwqtiSn2SyenHr32ToNJgSJ
	MVlwMiUYCJQCqSYhUolSAp8UpXR5Bj9R68NcQXMYD5/qbwyXArQmswcvr4eIBceSohs=
X-Gm-Gg: AYBFou37r7g+p82xBOwGqtebtIpEYXuNlehLLv3Fuoa25YRUfgQIBwT6K4T9oXLxf9r
	YLCCraXGhSti4aTA3oN+xxMjfvQtV38sdZ3UdMFy/3FY1LhEjONz0FhuaXjuh2qYr+WXCSLYaYP
	5QtxU5iQ5k0Zho7vnANlazeO1MLhMGRJ5bmC6d4+i8ZnsC76ZtgWrSwWPhPd6cSDYK8IzEgVFcH
	Q3BWrBIBLxh5SemPXcT3KvK3dW3XDxRH6q3ko/DK9vfDXkYtEl4EpX9dHrz+qFotgQbNis4dmPW
	l4D8OvmJtzbR2klcytYfBXZoHZEp3trCnOk22RvRLqGzgeiwvsdHMHsrg1vGzvIsn68cL5QF3Ef
	xVxai1xk3TsZhQSDsXXnen5++oNZfizidnr0aInAarNe0ws4RpRE17ZCGZ/HZ5M5wWQ8ZVI8YrV
	yOYDJUkSkg+uKYMbderFkOvT9aIZ95o6sYMZRhaEXhsrQTdltkfkKZfsYIJhjaceHMxaYTYvw3Q
	X0JkUWIOjQjt0j2f2S3WGamqG5Y4Plu2vWpZ8aSQdKPokl4vbWs8A==
X-Received: by 2002:a17:907:3f87:b0:c24:e0dc:8b66 with SMTP id a640c23a62f3a-c25d53cbb6emr350388566b.6.1788362778826;
        Wed, 02 Sep 2026 08:26:18 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:89b1:8875:2e41:59f0? ([2001:8b0:aba:5f3c:89b1:8875:2e41:59f0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03f87a5sm158008466b.45.2026.09.02.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:26:18 -0700 (PDT)
Message-ID: <23d0c2d324bb72af498f83cd45adc141ae0fd537.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH] fetch: `touch` mirror tarball stamp
 files on download
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: philip.lorenz@bmw.de, bitbake-devel@lists.openembedded.org
Date: Wed, 02 Sep 2026 16:26:17 +0100
In-Reply-To: <2527846.1788352985580782981@lists.openembedded.org>
References: <20260902083232.825826-1-philip.lorenz@bmw.de>
	 <ad4a8405a86e9c243dd2748a82f3cb0535f02b8a.camel@linuxfoundation.org>
	 <2527846.1788352985580782981@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 15:26:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20157

On Wed, 2026-09-02 at 05:43 -0700, Philip Lorenz via lists.openembedded.org=
 wrote:
> On Wed, Sep 2, 2026 at 11:06 AM, Richard Purdie wrote:
> > On Wed, 2026-09-02 at 10:32 +0200, Philip Lorenz via lists.openembedded=
.org wrote:
> > > The mirror tarball stamp file's mtime is currently only updated on
> > > creation / initial download. This makes it difficult to detect whethe=
r a
> > > mirror tarball is still relevant in a given build.
> > >=20
> > > Improve this by also `touch`ing the mirror tarball stamp files alongs=
ide
> > > the sources primary stamp file.
> > This gets a bit tricky as we don't touch every download file at every
> > download, we only touch the end stamp file.
> >=20
> > This would mean we touch mirror files and stamp files but not main
> > download files and I think brings things into more disparity?
> This patch extends bitbake to touch the mirror tarball's `.done` file (no=
t the=C2=A0
> mirror tarball itself) to bring it inline with regular stamp file handlin=
g.
> > I can also think of cases where updating the timestamp may cause things
> > to re-download the tarballs too since you can't know the content in
> > advance with many of them. This is perhaps the stronger reason not to
> > do this.
> I'm not completely familiar with all of the fetcher details (and also cou=
ldn't=C2=A0
> find anything obvious) but in which cases would changing the mtime lead t=
o a=C2=A0
> redownload? I'm not sure if this is still an issue given that this only u=
pdates=C2=A0
> the `.done` files of the mirror tarballs though.
> =C2=A0
> The rationale behind this change is that we'd like to clean up our downlo=
ad caches=C2=A0
> and only keep the inputs relevant to the latest build configuration aroun=
d. Using=C2=A0
> `.done` files (after executing a `bitbake --runall=3Dfetch`) works for th=
is as long=C2=A0
> as the mirror tarballs are freshly created. On consecutive runs their `.d=
one` file=C2=A0
> is not touched and they are therefore deemed out of date.

I hadn't fully taken in the fact it was just the done stamps, sorry.
This does still leave me with questions though.

For example we have cases where it wouldn't try and download mirror
tarballs. If the main source repo is up to date or even just present,
it could fetch to there and the mirror tarballs wouldn't be touched.
They could even be out of date compared to the main source repo unless
the tarball generation options are set.

So in the context of having mirror tarball generation set, the patch
could make sense but probably not outside of that.

I have thoughts about changing the way mirror tarballs work in the next
release anyway so I'm still leaning towards not adding more complexity
right now...

Cheers,

Richard


