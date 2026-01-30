Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3312E6BF25
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 16:18:50 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14367.1769789927107003936
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jan 2026 08:18:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=v0ykuTO9;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7E87CC22F5F;
	Fri, 30 Jan 2026 16:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 075AE6075A;
	Fri, 30 Jan 2026 16:18:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C889B119A885C;
	Fri, 30 Jan 2026 17:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769789924; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kQEke1XNpUzgwDzk+qy+rTnXwpV0ipBP2HyFsiSx9hE=;
	b=v0ykuTO9uzuY4iNp+G6hbxI/bT9TPo+BzBqXmku8V8y5Igrb94X0KUtsYqcXPMohAc3dbu
	XlQMeszkQ459hRUSIODG0+FpRsPTtJPRBjOTpKI1TMAmieCS0RGwlddj02VmGgel+n09Ta
	evdOxTCJZFPlKxfvZDemWjGCg9EjpwVI21sIeadG/SULPr5q8Jaj5J1mUPwS6xI8rKi6Fl
	JRW/jja02B7deeB+2orRMCIIh5B7HbO3xWBJY/hMEP/c8HqTiy4ZCFVh1RA1S1e6E+rQXU
	P3Y7kqvrBQrs7+tk/nn8esBEVOn+EbwYLC4p7fSEI2wz+jPP1CtyLamMnmOLqA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Jan 2026 17:18:42 +0100
Message-Id: <DG2262AXH01N.323RJGRGSITBG@bootlin.com>
Cc: <docs@lists.yoctoproject.org>, "Robert P. J. Day"
 <rpjday@crashcourse.ca>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, "Quentin Schulz"
 <foss@0leil.net>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v2] doc: bitbake-user-manual-intro: improve
 bbappend file matching doc
References: <20260129-bbappend-matching-v2-1-4041afca3c82@cherry.de>
 <DG1ZCGR9A4OJ.3918WSIWBKUDI@bootlin.com>
 <6e5ce5e9-d2b3-45df-bc0e-834b4035efac@cherry.de>
In-Reply-To: <6e5ce5e9-d2b3-45df-bc0e-834b4035efac@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jan 2026 16:18:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18940

On Fri Jan 30, 2026 at 3:54 PM CET, Quentin Schulz wrote:
[...]
> Do you want two separate notes for busybox_1.%.11 and linux-yocto%=20
> examples? They both are related to % being a marker so I guess they can=
=20
> be added in the same note, but while the former example is definitely=20
> wrong, the latter may sometimes be found (but is mostly wrong as well,=20
> but in more insidious ways).

I think a unique note for both is fine

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


