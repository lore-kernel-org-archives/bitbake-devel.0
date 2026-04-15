Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92E1FA0C3C
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 06:58:55 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13192.1776236326906544834
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Apr 2026 23:58:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=zGYstFrF;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DB086C5AABE
	for <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 06:59:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6AF8960420;
	Wed, 15 Apr 2026 06:58:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3361A10450080;
	Wed, 15 Apr 2026 08:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776236323; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YFkISEeqhgGSMveaMlb0IDMCH82JPRnUQPlWkvW6dBY=;
	b=zGYstFrFatQgmTKd7Pkmh0/hBLHWrzK2yy7lxPMm9/QEEBxVsnxeqSLlLU9nw+SdI3irQO
	XUNV6kpCRQgM+3ais74Qq9r73VI2NTwLJ4a9q7aEdd+1AnQX314PZi99z/P257teaNACxo
	c4VlO8RxbYmx1Y9x+FBcNAeGdegFoyZsyvlI6HUtftFghxLb9jlWqScaIwgfgczEZSh0C8
	tN0ORu9BxMU+2m5+g92B82tEJ0aWSHQsYB3dIYnh9gGyeTJiG7qvBcrOe8cfJuCLphE/I+
	c/fjIIeWVBx+AFPhG4EvLWUFVEm8Dlo24hOmM7h4I/RJWQd3hThMBckFsRvTQA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 08:58:41 +0200
Message-Id: <DHTJ85579JI9.2SAQHSMRVTXSZ@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: fix HEAD and branch ref
 when subpath is used
Cc: <yj.chiang@mediatek.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <mark-pk.tsai@mediatek.com>, <bitbake-devel@lists.openembedded.org>
References: <20260415025829.2342719-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20260415025829.2342719-1-mark-pk.tsai@mediatek.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 06:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19364

Hi,

On Wed Apr 15, 2026 at 4:58 AM CEST, Mark-PK Tsai via lists.openembedded.or=
g wrote:
> From: Mark-Pk Tsai <mark-pk.tsai@mediatek.com>
>
> When subpath is set the checkout code uses read-tree + checkout-index,
> but never updates HEAD. It stays on whatever branch the clone defaulted
> to instead of pointing to the requested revision.
>
> Fix by pointing HEAD at the correct revision after checkout-index, and
> creating the branch ref when branch=3D is specified.

Can you remove this warning note with your patch?

https://git.openembedded.org/bitbake/tree/doc/bitbake-user-manual/bitbake-u=
ser-manual-fetching.rst#n428

Thanks,
Antonin

