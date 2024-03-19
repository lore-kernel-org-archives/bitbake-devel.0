Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C7C54E60
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 10:11:39 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.11586.1710843094872524159
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Mar 2024 03:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MtlQcyN8;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 554AB2000D;
	Tue, 19 Mar 2024 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710843093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2q8f4xtCj1qsgUSDmkVaGMUbqTtk1aXmGVjwWQ6gYi8=;
	b=MtlQcyN8fHVKN8skIeFw3ZR/IkIwaSD5nZ5KMCOuRJaE7fVwj5xNNX898ZQ+S+GiZTvT8e
	YnhE7QnelZ3aUF5CSIwqCwijIzqOPs/cw1xnu6ddwjgTZwFyD5eaAWyYUMWKoQ2Xu3V+vA
	QIzr9kqQaIE0J8rqrhzynH1A+NXEHbCfIL2CK17+R1Z+giyR/g0oAkZbpbOyb7j+HEn8oB
	opFKw2TYrHh7gYGPoXsRmcSoEcLt//6N7s/Epuoq9uGhFqmnPNOmlWHUviiu8yJalAQXPO
	TAbyfSbb1rPtYc4B54sur6ymGXaXOn+LusxYlAq10qVxL2GiS/gKFaQuK8VB2g==
Message-ID: <f96aae1f-9708-4e7f-bd8a-3b7c110a7f21@bootlin.com>
Date: Tue, 19 Mar 2024 11:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] How to turn a poky patch into a bitbake one?
Content-Language: en-US
To: Alexander Kanavin <alex.kanavin@gmail.com>
References: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
 <CANNYZj9tBJL2T_G9t9ruZkOw0P3kt7mMq4XB-h=nTyGtaZAgHA@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CANNYZj9tBJL2T_G9t9ruZkOw0P3kt7mMq4XB-h=nTyGtaZAgHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Mar 2024 10:11:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16009

Alex, all,

Many thanks for sharing your tips!

On 3/18/24 at 16:47, Alexander Kanavin wrote:
> Okay, I found the correct thing to do:
>
> git format-patch --relative=bitbake
> git send-email --relative=bitbake
>
> This will strip the bitbake prefix from the chunks that have it, and
> omit the chunks that don't have the prefix altogether.

Brilliant! That's even better than I expected. Nice to know that commits 
(or even chunks if you're right?) not impacting the specified 
subdirectory are ignored.
Thanks again
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


