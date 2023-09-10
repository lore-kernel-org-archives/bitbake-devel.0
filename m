Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5127EE49A4
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 21:16:52 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.45083.1694380602871784291
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 14:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=cTyPrbM+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EE8E1BF203;
	Sun, 10 Sep 2023 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694380601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oaWDizE3xcstqWTKBkFAbMHgXC9i9/7ayQ2CpBoojz4=;
	b=cTyPrbM+oAAMBnH3FNd5jmk1ylFK62xY16bftY2DDfPltH8e7fSo+ix25roDqYsf3IWGk0
	T1ZlCPoJrpFNfSQKtvyFpyohfiSF0YHb4ag5H1S8erdRVIDaBtELTah91wRcgOD16uuI4X
	TUZOJXhRA99G4GqvYP39LI7F2L7/dCPqZp7PrTDkd8qkHUBIO7ISjlFslTIkPf7v9c1Mjd
	lWqubKqpDfObV3DsUXp5gVlOgISg8Em6F+fIdUONe56zbdbNE+QhUlt/RaDT80MAuQZ+bO
	u07VJBiUVVg/J1pRJFDGFFZLZ6SVnWNyqQNFBX02l6wgCDPnbWrttQGhXaCFBQ==
Date: Sun, 10 Sep 2023 23:16:39 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: rs@ti.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org,
	denis@denix.org, reatmon@ti.com
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-worker: remove the network
 flag
Message-ID: <20230910211639f1b8e744@mail.local>
References: <20230910194648.942409-2-rs@ti.com>
 <72eaf44b3c86582c73a9cf76ccba2378a0e83c6c.camel@linuxfoundation.org>
 <ede700bf-05f0-4e23-b173-ba2df6de2603@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede700bf-05f0-4e23-b173-ba2df6de2603@ti.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 21:16:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15030

On 10/09/2023 15:50:22-0500, Randolph Sapp via lists.openembedded.org wrote:
> Thanks for the background. I won't push this issue anymore. The current
> method does seem to be pretty good at passively catching offending tasks.
> 

This is certainly way more important for your customers than you
realize. The proxy issue is not actually an issue because it is very
likely that anyway they would have to set up a local mirror to ensure
they are able to rebuild without relying on a third party. You should
rather teach them to do that instead of working around the networking
issues they are creating for themselves.

This is even more important as the companies having those network issue
are probably the one that care the most about the correctness of spdx.

Really, the proper fix is in the fetcher.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

