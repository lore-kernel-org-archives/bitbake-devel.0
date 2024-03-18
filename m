Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B32BC54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 14:41:15 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.46206.1710772874409636374
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Mar 2024 07:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lBcYm3al;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77297C0008
	for <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710772872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k9+TDeIBAoJhICOvxBw4K/u1JhL9Va58fPkNi6kqI2M=;
	b=lBcYm3altvw4ob7m4pusvXAqiBf+CEmPmLWdfc2Rty5fPYo9C4BhPfCARknZAuAGI/OGNj
	iSYsqbOesANmIN8bar3Hp6HbHxltULsJwjwuvwT3ViA9fijTtCpV3p89kr7qIJQbdjnAo+
	LaGRYYJV47NRVmSuav9p5CPsJWmpwhjRzL3BRqmRCTAn4kJTON1FfQ0vENKhAULIMa+6za
	I7QLdcde6WhUoBMZMv4Im5ywkCgVz3nWQFSJgutcu1IYkdOxhXPxGYALbHJmLZMspIxkM0
	k+LXH2hqtNIrdxEWJn352kM9lHqvxM6TV6kzQQ4O6Vza47sh0ABtOsh+D8Rb/A==
Message-ID: <99f6d56b-8013-4255-bd96-5a66bb9130f4@bootlin.com>
Date: Mon, 18 Mar 2024 15:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: How to turn a poky patch into a bitbake one?
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Mar 2024 14:41:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16001

Greetings,

For testing convenience, I made BitBake changes directly in the Poky tree.

Before I re-apply my changes to a BitBake tree before submitting them, 
in a very manual way (like removing "bitbake/"  in the paths in my 
generated patches), would you have a nicer way to turn my changes under 
Poky's "bitbake/" subdirectory into a proper pathset for BitBake?

Git tips appreciated. I guess I'm not the first one to do this :-}
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


