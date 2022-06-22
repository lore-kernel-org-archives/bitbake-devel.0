Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAF6C43334
	for <webhook@archiver.kernel.org>; Wed, 22 Jun 2022 14:48:33 +0000 (UTC)
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net
 [217.70.178.231])
 by mx.groups.io with SMTP id smtpd.web12.7973.1655909308934952071
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jun 2022 07:48:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=g4SxzK/7;
 spf=pass (domain: bootlin.com, ip: 217.70.178.231,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5E841100009;
	Wed, 22 Jun 2022 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1655909307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1ritxu2DPsKYQiYkzfYjGV4OGmQ8O7NvNk24Qmx/pk=;
	b=g4SxzK/7ItD+Mz0ZvMQBCRA3PFgNBtFtYUKkDilYW/udk9K+nRAbH2l237WtcPqVBBxK2B
	V2Boh3ke14p7JO5fwZ5KVFxABFoT1bK6nIPdIQEZ3qmhx5O93q9mp+CSE4pLFUD6ikPpZ+
	C+n1fBdmnUrMuP56tU3MwMUkfBCdzPzWyOg6e8qqCuldDGf5LkJMBgr0Q9Cf3LAx5NSK7U
	6JxyYJq+kM+W4/DQBICVSGb8ccQMX/2sbsz92GsWte+8GFWOilT0JtfJBFoeou3ejvH2IX
	FL1SfBPRsAd5mxvVjBZ8rUPFd/V+qCiALPud2v9zf9TwEmbpFI825nC8+dPoPw==
Message-ID: <dde23013-a205-7fa9-afb6-f48eb819d857@bootlin.com>
Date: Wed, 22 Jun 2022 16:48:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc: docs@lists.yoctoproject.org, "Robert P. J. Day" <rpjday@crashcourse.ca>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [docs] [PATCH] bitbake-user-manual: punctuation
 fixes
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
 <5205d592-db48-f554-5c64-221dbcb7b774@theobroma-systems.com>
 <119c048f-010d-f9d2-2e74-da470b1d043d@bootlin.com>
 <6a58f3eb-7140-b6aa-6b9f-a0372b7311fa@theobroma-systems.com>
 <16E1CD5D84DCAFFA.24007@lists.openembedded.org>
 <16FAF73805DB6D1B.31435@lists.yoctoproject.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <16FAF73805DB6D1B.31435@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jun 2022 14:48:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13788


On 6/22/22 16:20, Michael Opdenacker via lists.yoctoproject.org wrote:
>
>
> Since nobody except Quentin voted against this change (for practical 
> reasons to grep in the source code), I'll like to proceed with this 
> change, to be consistent with standard rules for English text.
>
> At least, this will allow us to distinguish simple dashes and em 
> dashes, which have a different meaning, and may help Sphinx to break 
> lines (or not to) in a correct way.


Actually, this patch got merged: 
https://git.openembedded.org/bitbake/commit/?id=f1c4ac816e927f490fb9852c12aa408e8c9403b1
So, I resent the corresponding patch for em dashes in yocto-docs.

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


