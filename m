Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B85CD4F21
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 11:42:27 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73204.1778586137043956220
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 04:42:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=sDN8xIP7;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DD6414E42C07;
	Tue, 12 May 2026 11:42:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B243560646;
	Tue, 12 May 2026 11:42:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20A8911AF849B;
	Tue, 12 May 2026 13:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778586134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H+fmE3Hx6FE6Aw9ExtiMaTdxldDISIolrTBnj6wt2No=;
	b=sDN8xIP7O7xK8pb2FK+CPZo57qSELWEsUilPBnm1hjlVgaQu0joohxQwzGGHER917cXoNA
	pIt8+aWwFlfYtBUOGHAqJU/mvj136d7aiKeVau5i43ww8DxIAWgz2u+K5teEz6ofSqac+D
	kHZnSlAzeTyh01Jcsk/kJA+aPEQXv5t0LzVebkN+hUfZL1ztCQ9yqaco+yWGeZJak51gMj
	d6DZyz9bt4M0qJwdEm3bdOHKItmJ28D4Hl1UBRNj1KILdNMEI5JKexd7/BMZpF/sjXfZJg
	ikkzaQN09H7BlBZvd9MKZwNnHVn1nRu4kf2KXjZhrXDW3tdAmfLOGjFZ0GoP8A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 13:42:10 +0200
Message-Id: <DIGO5WR624MA.H8CQYE00ZS00@bootlin.com>
To: <Qi.Chen@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH V3 1/5] fetch2/git.py: add filter_regex
 parameter to latest_versionstring
Cc: <alex.kanavin@gmail.com>, <randy.macleod@windriver.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260509052950.1565384-1-Qi.Chen@windriver.com>
In-Reply-To: <20260509052950.1565384-1-Qi.Chen@windriver.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 11:42:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19499

On Sat May 9, 2026 at 7:29 AM CEST, Chen Qi via lists.openembedded.org wrot=
e:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> We want to be able to do stable version upgrade for recipes. For
> example, 1.0.0 -> 1.0.1 instead of 1.0.0 -> 1.1.0.
>
> To to this, we need an extra paramter to latest_versionstring
> so that we are able to filter out the versions we need. Using regex
> has the advantage of adapting to different version schemes.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---

Hi Chen,

Thanks for your patch.

This is conflicting with some patches that were merged yesterday. I
tried to solve these conflicts, but I get some bitbake-selftest error:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3936

Either I didn't fix the conflicts correctly or your patch has issues.

Can you rebase on top of master and make sure bitbake-selftest runs
successfully?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


