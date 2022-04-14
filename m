Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672FBC6370A
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:57 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.12861.1649948930645174833
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 08:08:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=E1FD8W+s;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: luca.ceresoli@bootlin.com)
Received: (Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8C8F1E000B;
	Thu, 14 Apr 2022 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1649948928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7AeKZg1dVzqH5haYSZX3vjUic44GxIPFVYtMZh59Tg=;
	b=E1FD8W+sevMKKG7hj7+Zb4WjIvGfQXsgvZBnkCQ748HtrgTwQl4TK2LH86ocUni7n9fD7e
	QISF73oJthnQaPNnTrAcUMOVy/YXp4la885ywdHUqbDv8JeDzW6Ni7fUMl8HiIHgkcJVhQ
	CyEFkwKz+Bgu1GnYKLtDfTLX4zAQAkNfGpJ8jFfbiX3dVdYG90svKtP5q0/3fFn65YOmS7
	zd+mpJ/KmNwXT2F7mWpyunlSqNwNzfSbV8HufHIGP8ekfoIVMknCMUkLI54GLOup+HgJIX
	nVxax2ZD105BVHo41YpD2G8agQPkqccHndc23sjW8CNsn8LQOnjre4A5At528w==
Date: Thu, 14 Apr 2022 17:08:46 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Marius Kriegerowski" <marius.kriegerowski@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Message-ID: <20220414170846.55417ac0@melee>
In-Reply-To: <20220414114009.56067-1-marius.kriegerowski@gmail.com>
References: <20220414114009.56067-1-marius.kriegerowski@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 16:03:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13620

Hi Marius,

Il giorno Thu, 14 Apr 2022 13:40:09 +0200
"Marius Kriegerowski" <marius.kriegerowski@gmail.com> ha scritto:

> Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
> ---
>  scripts/lib/scriptutils.py | 23 +++++++++++++++--------

This file does not exist in bitbake. This is why it does not apply.

I think this patch is against oe-core, so you should send it to
openembedded-core@lists.openembedded.org instead.

Best regards
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

