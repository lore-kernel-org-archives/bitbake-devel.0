Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648EBFDEE24
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 16:17:14 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1543.1776961026673665213
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Apr 2026 09:17:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=lZPA3J/5;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 788C84E42ACC;
	Thu, 23 Apr 2026 16:17:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FC65600DD;
	Thu, 23 Apr 2026 16:17:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48F0B10720586;
	Thu, 23 Apr 2026 18:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776961023; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=enmpGtnNKnhqoHxw1nY+zJmHLfaZL/TgYeTCl4EPdJI=;
	b=lZPA3J/5JiyY+qxzeFBJzKSkMqfL/MakJ6BpRKyjzhJ5miIyk838yzVvgrZ1bLWIYaQL3k
	H89G3gBYIUdXb2LyQ4YDZEelqu6VPwlJpo/Sw3GbA61Iy8dqjX0QtaQDCGGzQXBni3FqF5
	9q/775jDxoghsbrkBysnNlFNF94vjCF5OF8f0EtANWm6QuJHtil3lSfNMd7fV39lm1mhjr
	DuuJsgx0ygTFwJ+tpjpj3MdMFf8r0OIBt4usJPnjCDkg7zVnI2iAybfDX2eonm2DVMNmcS
	Cl4RHZJB67AJ7IqBBjDEYiw3M9iA4boQsQMH/Q24D9O02hsZhTGqq9E4LwFf3g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 18:17:01 +0200
Message-Id: <DI0O3ZT5821X.2HP9QRRUPBBB1@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] contrib/vim: highlight inherit_defer
 and include_all
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <twoerner@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20260423151340.2082495-1-twoerner@gmail.com>
In-Reply-To: <20260423151340.2082495-1-twoerner@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Apr 2026 16:17:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19383

Hi,

On Thu Apr 23, 2026 at 5:13 PM CEST, Trevor Woerner via lists.openembedded.=
org wrote:
> The vim syntax file's "Includes and requires" rule only matched
> inherit, include and require. BitBake also accepts the inherit_defer
> and include_all directives, so they should be highlighted the same
> way.
>
> Add both keywords to bbInclude and to the bbIncludeLine match
> pattern. Longer keywords are listed first in the alternation so the
> regex does not match the shorter prefix (e.g. inherit_defer must win
> over inherit).

Why do we maintain a syntax file here since it's already part of upstream v=
im [1]?

[1]: https://github.com/vim/vim/blob/master/runtime/syntax/bitbake.vim

Antonin

