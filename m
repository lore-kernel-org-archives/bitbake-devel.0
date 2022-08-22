Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA959C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 16:06:05 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.19925.1661184363142176736
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 09:06:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=U+dzCsZw;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661184363;
  x=1692720363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X5pFq2/RXAuLK/J1c8e8vVxlRtYm3BUsfcoMhZAES1M=;
  b=U+dzCsZwfKm/17kL21eTQVhCrY+zKA+6JKEv9eJd+J7JQTQi1YtkKgQd
   7DsRuFtPy1va/Gh89J3HXtj7vdC6Y0QA0tzR9vW/WudAD6w2aVQshCY4g
   Du6ethxrK7ePaDip2rqgFbZlBQoz6aVQEA+dyB7TaMYxGjN4w2zK9X408
   IDmM649zvcBqvYY/pSXVMCLvACjDWTBX2t+MrMDYKy5LGBdEPGyBKqx+1
   8Lhbvk8meCeGjJhxfusWfFeCiHG5F1HyjuJRhdcq1NiMGniVC/VeD/9Lt
   iO8DuemUKMmjSz7P1wkX4XX8qnp8VPBtzEW9Ry3ihMaQBUeQEw/m0bnbM
   w==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Martin Jansa
	<Martin.Jansa@gmail.com>, Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: RE: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Topic: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Index: AQHYs+xv6Ur3otLigUKfkUpnMtN9z62699eAgAAiBnA=
Date: Mon, 22 Aug 2022 16:06:00 +0000
Message-ID: <e2392e6ef91442d58b8ec1a104f88c5f@axis.com>
References: <20220819165455.270130-1-marex@denx.de>
 <20220822180241.5f625ed3@booty>
In-Reply-To: <20220822180241.5f625ed3@booty>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 16:06:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13925

> -----Original Message-----
> From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Sent: den 22 augusti 2022 18:03
> To: Marek Vasut <marex@denx.de>
> Cc: bitbake-devel@lists.openembedded.org; Martin Jansa
> <Martin.Jansa@gmail.com>; Peter Kjellerstedt
> <peter.kjellerstedt@axis.com>; Richard Purdie
> <richard.purdie@linuxfoundation.org>
> Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetche=
r
> from fetching gitlab repository metadata
>=20
> Hi Marek,
>=20
> On Fri, 19 Aug 2022 18:54:55 +0200
> "Marek Vasut" <marex@denx.de> wrote:
>=20
> > The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> > single object in the remote repository. This works poorly with gitlab
> > and github, which use the remote git repository to track its metadata
> > like merge requests, CI pipelines and such.
> >
> > Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> > and refs/keep-around/* and they all contain massive amount of data that
> > are useless for the bitbake build purposes. The amount of useless data
> > can in fact be so massive (e.g. with FDO mesa.git repository) that some
> > proxies may outright terminate the 'git fetch' connection, and make it
> > appear as if bitbake got stuck on 'git fetch' with no output.
> >
> > To avoid fetching all these useless metadata, tweak the git fetcher suc=
h
> > that it only fetches refs/heads/* and refs/tags/* . Avoid using negativ=
e
> > refspecs as those are only available in new git versions.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
>=20
> Of course this might become irrelevant with whatever implementation
> will be in v2, however when testing with this patch applied I got the
> following warning and wonder whether they are related:
>=20
> WARNING: mesa-2_22.1.6-r0 do_package_qa: QA Issue: File /usr/lib/dri/nouv=
eau_dri.so in package mesa-megadriver contains reference to TMPDIR

I cannot see any reason how they can be related.

>=20
> Full log:
> https://autobuilder.yoctoproject.org/typhoon/#/builders/72/builds/5753/st=
e ps/32/logs/stdio
>=20
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

//Peter


