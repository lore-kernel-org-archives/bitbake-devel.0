Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA69C2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 22:13:35 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.10648.1719872010398811655
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jul 2024 15:13:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gUl+0etM;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D40EC0002;
	Mon,  1 Jul 2024 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719872008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5e1Q41cX+/JyDUwF0cZSmBF1TAJwo1l7/YBhWRZUME=;
	b=gUl+0etMfG3eiLPXGYyOkcM6MvJz4mClgWSeb/qSAY0OAhwuK8y8Esjhcy6OW8eUI+0Ito
	mGgv1R171i9LBN/zp0QZU7wJAYgWAQekrsFRu1w5b1WlMZd67zuV1B16BSk8It9b7Wxrt+
	am7WGDj4lfYGPZ0V7zUP9iIPmpreYfInNgIfUkxdlgSOzMVaD8vhcR1xaJfn1gTO8scZT2
	GKXXVh1DTfNbnwaHxs+ILgzEfAm9RFMATBHQ/0zoulQhGxw4M1mlXPacSQ8WybLsopSoXK
	CEZdmQor/TKK6Gq22aHnRcocYtABcKSDADbZ2KVJ+DhkwUrs8RSxaS3NKy41kg==
Date: Tue, 2 Jul 2024 00:13:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: liezhi.yang@windriver.com
Cc: bitbake-devel@lists.openembedded.org, andre.draszik@linaro.org,
	kergoth@gmail.com
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch2/git: Use git shallow fetch to
 implement clone_shallow_local()
Message-ID: <2024070122132747f143a4@mail.local>
References: <cover.1718886475.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718886475.git.liezhi.yang@windriver.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jul 2024 22:13:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16383

Hello,

This fails on our ubuntu 20.04 workers:

https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/6923/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/3542/steps/11/logs/stdio

On 20/06/2024 05:44:39-0700, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> * Test info
>   bitbake-selftest works well
>   bitbake world works well with the shallow tarballs
> 
> // Robert
> 
> The following changes since commit 5d88faa0f35f0205c1475893d8589d1e6533dcc0:
> 
>   bitbake: siggen: catch FileNotFoundError everywhere and ConnectionError also in get_unihashes (2024-06-18 08:45:22 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/robertlinux/yocto rbt/shallow
>   https://github.com/robertlinux/yocto/tree/rbt/shallow
> 
> Robert Yang (2):
>   fetch2/git: Use git shallow fetch to implement clone_shallow_local()
>   bitbake: tests/fetch: Update GitShallowTest for clone_shallow_local()
> 
>  bitbake/lib/bb/fetch2/git.py  | 71 ++++++++++++++++++++++-------------
>  bitbake/lib/bb/tests/fetch.py | 13 ++++---
>  2 files changed, 53 insertions(+), 31 deletions(-)
> 
> -- 
> 2.45.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16368): https://lists.openembedded.org/g/bitbake-devel/message/16368
> Mute This Topic: https://lists.openembedded.org/mt/106779045/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

