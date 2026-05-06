Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC520CD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 11:30:14 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16249.1778067010925728474
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2026 04:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=UFDBvYMT;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E9E89C5DC45
	for <bitbake-devel@lists.openembedded.org>; Wed,  6 May 2026 11:30:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC7266053C;
	Wed,  6 May 2026 11:30:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6090B102F2279;
	Wed,  6 May 2026 13:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778067008; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ROrwbcQeU0DaQo0fhGj0JL0nzLoRgsgP3EyoB0hJJ80=;
	b=UFDBvYMTb4nSakTfvaBO+ljEwRixwdDQrzkfnQNHFI2B146EMaa/5Ic0r2UVi0dOTMSpoQ
	xRbvGE3pcvgBgPbywUoZHFs46RvxGsqO5ZaFWTRcMdbBntSW68g+rFBmceOu4q7Ug/qYW3
	wELsAPA/o875nAsG0kPkkul58WrkecP4Q+UxNmYtNCQ3p+Vpg55MN5mj3hBEqdwyTK1am8
	S91PhN1cqgaJDAyiXVfsRfR4PAxZgoU3/P6IHr+b5itQ9qCnDD2gSpP7iBdAm7h0AI2H0B
	FUksBk3ff+vUOC5ZEV5DDhMSg4Q+Dr52ioxMzcc4k0EpXVPif2MGr0K1CsauKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 13:30:06 +0200
Message-Id: <DIBK5E9R3MCA.2M9Y3MZ27X9SM@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] cooker: limit the execution of the
 hashequiv client/server ping
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260505160556.3688048-2-corentin.guillevic@smile.fr>
In-Reply-To: <20260505160556.3688048-2-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 May 2026 11:30:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19444

On Tue May 5, 2026 at 6:05 PM CEST, Corentin Guillevic via lists.openembedd=
ed.org wrote:
> From: Corentin Guillevic <corentin.guillevic@smile.fr>
>
> The ping method is used to test the connection to the hash equivalence se=
rver.
> However, if the server is unavailable, the bitbake server has to wait sev=
eral
> minutes for the system to terminate.
>
> While waiting for a response from the hash server, the bitbake server doe=
s not
> provide any feedback to the bitbake client. The latter then closes the li=
nk and
> fails with the error:
>
> Timeout while waiting for a reply from the bitbake server (60s at 09:50:1=
5.377337)
>
> Adding a timeout to the ping step allows quicker action when a remote ser=
ver is
> unavailable, and prevents disconnection of the client due to timeout.
> The default timeout is 10 seconds, but this can be set using the
> BB_HASHSERVE_UPSTREAM_TIMEOUT variable.
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---

Hi Corentin,

Thanks for the new version.

> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -342,7 +342,7 @@ according to https://docs.yoctoproject.org/dev-manual=
/hashequivserver.html""".fo
>                  if upstream:
>                      try:
>                          with hashserv.create_client(upstream) as client:
> -                            client.ping()
> +                            client.ping(int(self.data.getVar("BB_HASHSER=
VE_UPSTREAM_TIMEOUT")) or 10)

I believe this is not sufficient when BB_HASHSERVE_UPSTREAM_TIMEOUT is
not defined:

TypeError: int() argument must be a string, a bytes-like object or a real n=
umber, not 'NoneType'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/80/builds/3542

Maybe this is just a parenthesis issue?
client.ping(int(self.data.getVar("BB_HASHSERVE_UPSTREAM_TIMEOUT") or 10))

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


