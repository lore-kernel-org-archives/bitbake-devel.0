Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE711EF36F9
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 07:40:30 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9011.1773042021512142718
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 00:40:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GiymmZr5;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4AA8E4E425D9;
	Mon,  9 Mar 2026 07:40:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1A0D85FFB8;
	Mon,  9 Mar 2026 07:40:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AC651036969E;
	Mon,  9 Mar 2026 08:40:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773042018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AwB1Gl3Mlp7W0yPTrO6cArV9f5oKbsA/LgNAFIdj11Q=;
	b=GiymmZr5RqV8JQ6FN17B5Oqbn9wPM38sYfWe42rgieVqlYwvGym3nadSySpzxkPRjm1SQH
	f9rzXaw9snKOcCRW1xq8tyUWxOwuQ2WY9p47hAavjhYZlW5TINVLhMm0ZvgtlBS5JebwPS
	KTIGwZostcktC5jt1F1tN1YFo50TvLsSJAJG0pNKKxnqVasIrhTubXf3MsjinnYIh7fVFG
	9585JcMmS0zLemxn5Sz0OrArv7bcG27fAXLW0GWzMd1/fz3YIvzbi6ndq2pmqBt/KcUECL
	PufOmMUv2W8hV6BYlFeK8SgbZ4yyXOM/izDK7jQeA49NyMwlwl5eXAxqNO1jIQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 08:40:15 +0100
Message-Id: <DGY2XTFF7EIK.365FMBM43AWTO@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] fetch2: add curl method to fetch
 web content
Cc: "Pascal Eberhard" <pascal.eberhard@se.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <pascal.eberhard@gmail.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
 <20260305-add_alt_fetch_method_curl-v1-1-0d0220e5fa59@se.com>
In-Reply-To: <20260305-add_alt_fetch_method_curl-v1-1-0d0220e5fa59@se.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 07:40:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19123

On Thu Mar 5, 2026 at 4:32 PM CET, Pascal Eberhard via B4 Relay via lists.o=
penembedded.org wrote:
> From: Pascal Eberhard <pascal.eberhard@se.com>
>
> curl fetch method is an alternative fetch method for web downloads. It
> is based on curl cmdline tool and provides the same http, https, ftp
> and ftps protocols as wget. It supports some new features as well such
> as hostname resolution by the proxy when using SOCKS5 proxy.
>
> Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>
> ---

Hi Pascal,

Thanks for your patches.

> +
> +    def _runcurl(self, ud: FetchData, d: DataSmart, command: str, quiet:=
 bool, workdir: str | None =3D None):

Writing type hint unions with a pipe was added recently to Python, 3.10
if I'm correct [1]. This is above the minimal 3.9 [2] version mandated
for bitbake.

And this is indeed failing on some supported distributions, at least on
Debian 11 and Rocky 9:

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/genericarm64/build/repos/bitbake/bin/bi=
tbake-setup", line 27, in <module>
    import bb.msg
  File "/srv/pokybuild/yocto-worker/genericarm64/build/repos/bitbake/lib/bb=
/__init__.py", line 155, in <module>
    from bb import fetch2 as fetch
  File "/srv/pokybuild/yocto-worker/genericarm64/build/repos/bitbake/lib/bb=
/fetch2/__init__.py", line 2107, in <module>
    from . import curl
  File "/srv/pokybuild/yocto-worker/genericarm64/build/repos/bitbake/lib/bb=
/fetch2/curl.py", line 53, in <module>
    class Curl(Wget):
  File "/srv/pokybuild/yocto-worker/genericarm64/build/repos/bitbake/lib/bb=
/fetch2/curl.py", line 104, in Curl
    def _runcurl(self, ud: FetchData, d: DataSmart, command: str, quiet: bo=
ol, workdir: str | None =3D None):
TypeError: unsupported operand type(s) for |: 'type' and 'NoneType'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/60/builds/3308
https://autobuilder.yoctoproject.org/valkyrie/#/builders/93/builds/3302

[1]: https://peps.python.org/pep-0604/
[2]: https://git.openembedded.org/bitbake/tree/lib/bb/__init__.py

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


