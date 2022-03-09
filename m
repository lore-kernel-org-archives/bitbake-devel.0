Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A553CC433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 17:30:20 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web08.253.1646847018774556894
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Mar 2022 09:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MjnOxg+C;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C6A401BF206;
	Wed,  9 Mar 2022 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646847017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xV0KYzRGz0iUbu4aWYmGJIj5gsLI5rsFU1sqnfP2zSA=;
	b=MjnOxg+Cjvh+Fj8PC6ypYrRyxdoPjc9FlPTWjPEyHvqvxd/lvPlXZyotZ2rr8OCARH3p7p
	YssuWEqmYiGMzYE2z1ZEgprr9CacFw0FCAW4izzGF+WMoWGwKbwMGekuB0GrvIhYn4Mfmb
	jMfwGeuKp+F4NJ0WEY+ETVLnf7qjYbdUsp1nkkHvo/RsIAFH1sR1L3UgsE2lvQOxPSq7NK
	NGwt0nAXoFuGG+nQ7+rPSPJDbGip4wCqLMCM8LbVgT32DzMxqCPMgXMIEXf6NmG6teceZQ
	9ULlh4CNMbFL3u6nS2VGsnTC936iafdaxeuLbCJve61jozu5PqbFnE9hkcutGA==
Message-ID: <012f6398-a8dd-39fa-bb29-aeff10ab87c9@bootlin.com>
Date: Wed, 9 Mar 2022 18:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: YP docs mailing list <docs@lists.yoctoproject.org>
Content-Language: en-US
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: Time to make "branch" parameter mandatory in git SRC_URIs?
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Mar 2022 17:30:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13452

Hi Richard,

In the documentation (migration notes for 3.5), we say that the "branch"
parameter is mandatory in git SRC_URIs.

However, that's not true yet in the code, which just issues a warning:
https://git.openembedded.org/bitbake/tree/lib/bb/fetch2/git.py#n175

Given that the warning period was probably long enough, wouldn't it be
time to align the code with the documentation ;-) ?

At least, this would make it easier for me to update the BitBake manual.

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


