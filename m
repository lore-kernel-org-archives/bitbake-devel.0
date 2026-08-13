Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81254C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 15:07:43 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21458.1786633658904314263
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 08:07:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=F57ueFh8;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A20424E41204
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 15:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FEB2602B8;
	Thu, 13 Aug 2026 15:07:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1CA411C4E047;
	Thu, 13 Aug 2026 17:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786633655; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/WPOhMLq6JOo6z12ImT/qCie3ramBBQ7efikjlJRKTk=;
	b=F57ueFh8dxZzpt00J/J79GgR0wECF+fhdahZzG8a7Eh0JcvZbQLW0kn+xqy1ClmGgdAVOo
	hCfRqypBoIJ8YsAQr3gYqsXXF6T9NCp4CZi1C1ZC440l/z8wE3AQ9CdnBpjIhLQdLdfLqA
	fYRDgv0km9Eq0FP9dwxwGdl29sZZ4nmxmax0srw6fTDhnHCo8G+MhBQee337B8UDRPvZcC
	GTfs7FNpdWtrYnofqj37FQ+BF2upSdNJrR4OnfM4xDT8tYUoQ1dxY8cKcHXJtB1uAJNqcQ
	txdDlRmYAyCCmxcf9NZVInyo1IfcaP1hTVndVx6lA6pAS9DAJTYFnms1Rr+7Cw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 17:07:34 +0200
Message-Id: <DKNWRTWPZT8T.1ZLGV8S99L5N9@bootlin.com>
To: "Jaipaul Cheernam" <jaipaul.cheernam@est.tech>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace
 in parsed lines
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
 <20260806112435.25128-1-jaipaul.cheernam@est.tech>
In-Reply-To: <20260806112435.25128-1-jaipaul.cheernam@est.tech>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 15:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19929

On Thu Aug 6, 2026 at 1:24 PM CEST, Jaipaul Cheernam wrote:
> rstrip() silently strips trailing whitespace before processing. This
> hides invisible spaces or tabs that end up in patch context and cause
> patches to fail to apply across branches.
>
> Warn on any line with trailing whitespace so developers can fix it early.
>
> Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
> ---

Hi Jaipaul,

Thanks for the v2. I forgot to ask: do you plan to provide an oe-core
patch fixing all whitespace issues? As so far, this is adding a lot of
warnings during the build:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/4/builds/4405

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


