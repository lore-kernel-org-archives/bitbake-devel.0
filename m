Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25948C433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 17:04:40 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.11868.1646931879085891536
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 09:04:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ftZ9zPiM;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 482371BF20B
	for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646931877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q4UJiR97Ux6fjXG1sJWzymqlaAOxT4snFXz2f/hZO9A=;
	b=ftZ9zPiMi+j7TV7beM9JfPv19Z17MRohrXu41t+vVzgqnkwAq1Patux7+BaeDUurnDrBvh
	KTeB72abmExZVleXzjE/M6EQJstzf+82KAfHMh4ypE8XguTXQLPR7nqok/dlSQggQ1laWV
	YFxp2amIjLG9OPnZuSr6ODQD0/o/WEdUfw0rLhSnbR/rVbqJK60y/Hl4dqaaigQKTP14Ig
	nCIqYcOVhZH/u+yRspJring+rjzmGDVXhQjVo6zI6bMLoMclX71bchMLto6aqcczPib+pd
	/RwZNmO3YrkCgxyAd2nu1/YnTOjzt/ybCtSSu/Z5kJSdYTw+LMxT9EypfaXftw==
Message-ID: <f24b08c0-d638-280f-30a9-a5483222a310@bootlin.com>
Date: Thu, 10 Mar 2022 18:04:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: lib/bb/tests/fetch.py still in use?
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 17:04:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13472

Greetings

lib/bb/tests/fetch.py still refers to cvs.handhelds.org which doesn't
exist any more, though it brings back fond memories.

Should the corresponding entries be removed or updated with working CVS
hosts?

Or can lib/bb/tests/fetch.py be removed if it's not used any more?

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


