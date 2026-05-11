Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915AACD4842
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 12:39:40 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48769.1778503175872849232
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 May 2026 05:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BKWnGgae;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1DABEC5E154;
	Mon, 11 May 2026 12:40:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A60E60646;
	Mon, 11 May 2026 12:39:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C205911AF9CDD;
	Mon, 11 May 2026 14:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778503172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5ZC2Jyn+Adobs6o4husyF0zPfDeNeYOdZWQQlQMolT8=;
	b=BKWnGgaeeCCIgRukFf/y0paXLkuCCA4sOHMKCjHSYtSodEXhAw2QxFgqROCLRxut56tLxS
	BPMwHVQocacnzFJzK1dJS0H9jhhbk9Hxq3zJZOpvqrMtviEqPv0QV1ctJq2WNX6b4rTRTC
	qBWMFRXhMxZJf8PxM1WuBw1NsVJj9IaAUWwFxLJOlmFlpjYXX4TbDMqKNY2jeZn+66tRQy
	y13euJFXUS0aUd/QKA9shqo4Bu+4glX8Pl6IJY0vaAin/zk0AOV/nY3IJP/yLwA9dyIveR
	i0m8OasbErYxcAsEvZx/BY4r1PGuYpn0b+8jgcfLfp7Rv+YxQyLSe5rFcwtvlA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 14:39:30 +0200
Message-Id: <DIFUR95B2LWG.3GMMOVGQ5SIVT@bootlin.com>
To: <bijak.dawid@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v3 0/3] doc: bitbake-user-manual-metadata:
 clarify inherit_defer documentation
Cc: <docs@lists.yoctoproject.org>, <quentin.schulz@cherry.de>,
 <richard.purdie@linuxfoundation.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260509104307.26698-1-bijak.dawid@gmail.com>
In-Reply-To: <20260509104307.26698-1-bijak.dawid@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 May 2026 12:39:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19489

On Sat May 9, 2026 at 12:43 PM CEST, Dawid Bijak via lists.yoctoproject.org=
 wrote:
> v3 of a series addressing a few inaccuracies I came across while reading =
the inherit_defer documentation.
>

Hi Dawid,

Thanks for the new version.

I believe most of the v2 was merged. Can you rebase on top of master?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


