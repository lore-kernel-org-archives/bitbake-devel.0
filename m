Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A4C433EF
	for <webhook@archiver.kernel.org>; Mon, 20 Jun 2022 09:40:36 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.28049.1655718034491124530
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Jun 2022 02:40:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=V4s+mHlS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1898960013;
	Mon, 20 Jun 2022 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1655718032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhpDYtSaN2wvTCV+u5PAx03qEIt6iKWckGRScUTnkPY=;
	b=V4s+mHlSjDIowAdmtStxem0GSOAhwgmSm06D66o/M6drnj0C5N5gfOGe/LhqF/YE8Nvv/r
	IkYsjlWLVJJ25lvWK8Od7234OP32qdbo7ARiMOZ5bdgqAvekONPHDoqk0RnRRbxeepFCLg
	rIHpVsczrTEtvw+WWHbro0wHERlMmrxxlCRSqjFFHKFSv66kHkgkVJqCaaD1HfQo03sfyP
	n/TXb57lJISxszNBOnXP60LkiHgeF/B+ZcAJPbm70UvzOt0LuEoeZWOpxtx57rm8u6qgkx
	oGkj2IFWfpuF5BJesi/AWr3jhFazrWwuQD2VxITQzohXV1RH8Nwrs+YFt+XalA==
Date: Mon, 20 Jun 2022 11:40:29 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Pavel Zhukov" <pavel@zhukoff.net>
Cc: bitbake-devel@lists.openembedded.org, Pavel Zhukov
 <pavel.zhukov@huawei.com>
Subject: Re: [bitbake-devel] [PATCH] tests/fetch: Add test for broken mirror
 tarball
Message-ID: <20220620114029.46f79472@booty>
In-Reply-To: <20220616161521.20906-1-pavel@zhukoff.net>
References: <20220616161521.20906-1-pavel@zhukoff.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Jun 2022 09:40:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13774

Hi Pavel,

On Thu, 16 Jun 2022 18:15:22 +0200
"Pavel Zhukov" <pavel@zhukoff.net> wrote:

> With PREMIRROR set and BB_NETWORK = "1" bitbake should not try to

s/PREMIRROR/PREMIRRORS/
s/BB_NETWORK/BB_NO_NETWORK/

I fixed those when applying your patch for testing, thus no need to
resend just for these.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

