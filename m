Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45912C636CC
	for <webhook@archiver.kernel.org>; Wed,  8 Feb 2023 10:15:06 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web10.5344.1675851300147704241
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Feb 2023 02:15:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=RUnDteTH;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231, mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 160A1100005;
	Wed,  8 Feb 2023 10:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1675851298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JfoVIO3LZ3Z2pj+Jx7ER1yjVK6j70hfS74YAXF/RmEQ=;
	b=RUnDteTHCUV1upcDGXsZLpNiz+mcS1jCpgjs48XvxO6mJFBFY10Cjbjp1BiApHYoX+yYti
	eubXPOwp0yzc5uj6HlAjggQxMDIPuWLXZkyXuFQ+5kngtgdYLIrm5YQ0jqCi4WkQaSr2S4
	RTxKhsmI8nnmPngAF8zgsHVZaIwM1j24EdXzhVSvYJlk4QQcbjv3p5vfKAwTBUmwDVfU4f
	RhgZb3NsPqBCCOIMHgHJs1yj7sMmxxsyEbxj4o97LL9xtRoERaaFnOd5n5eO778o+mMSE2
	tnMjUarncnvGSiyT3g4jPTjX/7TwCUzDRhfHu9xoxZCev6jX0YuzQ8PhMCTvyA==
Date: Wed, 8 Feb 2023 11:14:56 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "George Kelly" <george.kelly1097@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [bitbake][PATCHv2] Add NODE_EXTRA_CA_CERTS to
 export list
Message-ID: <20230208111456.08b95a45@booty>
In-Reply-To: <20230207221022.4346-1-george.kelly1097@gmail.com>
References: <20230207221022.4346-1-george.kelly1097@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Feb 2023 10:15:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14385

Hello George,

On Tue,  7 Feb 2023 17:10:22 -0500
"George Kelly" <george.kelly1097@gmail.com> wrote:

> If you are behind a corporate proxy, the npm fetcher uses
> the proxy IP address already passed in the list of exports.
> However, it will error if the proxy injects its own root
> CA certificate. Thus, the NODE_EXTRA_CA_CERTS environment
> variable must be passed so the user can include their
> company's root CA as a trusted CA inside node's
> certificate store.
> 
> Signed-off-by: George Kelly <george.kelly1097@gmail.com>

Your subject and commit message looks definitely good now, thanks! I
added your patch to my testing branch.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

