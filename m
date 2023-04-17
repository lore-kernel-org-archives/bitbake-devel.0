Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCFC77B70
	for <webhook@archiver.kernel.org>; Mon, 17 Apr 2023 07:53:51 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.48569.1681718026940312330
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Apr 2023 00:53:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=RvKblBMf;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 220C51BF212;
	Mon, 17 Apr 2023 07:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1681718024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LF6oarnDNdq0wU3suX58n1m6MIVBeeQ2eyrxkjMDMOA=;
	b=RvKblBMfQMgJojri6LLUR4AI5dC0LIvfPpLX3ZaUUKGtIJJybPFd//96RiATcy82ahN+sH
	+mKSwfxoU7Z/PkCP3nMYKHCwm570pkojIa3fS5FWxh1KNEFgd3D7qenbVZ3AvnyrVeJdEe
	mZ3ndIyvIg4/dxr9e8b5rt9W/Bv7eP+96RS2xqLYIsAre4AhmwSQ2Jgc5gHkJmDQdB4IjM
	+Hqix5UVnGyyIn4oooB5AZdy04/1W5WNXTyASOUjut3bGGMsopRRIzOGhNv5vtwZdufE5A
	ZDA7kr+G9JGG5SPO82n+SAxoSyRcNNFIgQ+fkrlnllrSmwV+DuF1/Hyv7apjNQ==
Date: Mon, 17 Apr 2023 09:53:42 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: public@smn.dk
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] npmsw fetcher: Avoid instantiating
 Fetch class if url list is empty
Message-ID: <20230417095342.67ee03f9@booty>
In-Reply-To: <czCu.1681675635331210887.i1y4@lists.openembedded.org>
References: <czCu.1681675635331210887.i1y4@lists.openembedded.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Apr 2023 07:53:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14708

Hello Svend,

On Sun, 16 Apr 2023 13:07:15 -0700
public@smn.dk wrote:

> Recipes containing both git and npmsw sources in the SRC_URI
> fail during fetch from the shrinkwrap. It seems that when the fetcher is
> fetching from the shrinkwrap, the SRCREV variable has been deleted but it
> still ends up fetching from the git source resulting in an error because
> SRCREV is undefined. The root cause of this is that the Fetch class defaults
> to urls from the SRC_URI when the urls parameter contains an empty list. This
> patch will ensure that Fetch is not instantiated if the urls list is empty.
> 
> Signed-off-by: Svend Meyland Nicolaisen <public@smn.dk>

Thanks for your patch. However it does not apply using 'git am',
because it is an HTML e-mail.

The simplest way to send a properly formatted patch is using 'git
send-email'.

For more info read:
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

