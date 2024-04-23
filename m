Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BFAC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 12:29:32 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.17239.1713875371251439139
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 05:29:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LqS5e9fw;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F10AAE000E;
	Tue, 23 Apr 2024 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713875369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I3k5EX41qacPXBkti4eGllASpcCqA3pa0nWVsJWdOQE=;
	b=LqS5e9fwDCFV5BRCQyYGRnK0/koUWfzUhtMbCUa+27pyubewtdHRjb438fm/hi1RKHfmiv
	EQ0PkX+SzEdj6/GJj9e+1cNR8jmNEon2lrBg/vdsrr8ujSoB3k2d2fbC6axjtqd2r10So9
	VWI3hu1CnQODZokjReJbs2eS2IP/mmWW+p7vz3wijSxpQQbhA4M6MoIFMGHzfZHSmLcSgD
	S0nYfK0V9P3BrroYZzOlHLCAnUW3sAhmiz9fJWhb0RLWP7hz+y86mHmBUt7YiXmtfoe2Qh
	/RDKFgdcV1WA1iGocmk1/5nPZZ/mkEf1vqgxxW08J8DC9Wcv9RAhdTt7/dwyBw==
Message-ID: <e9aad31c-27d9-49b6-8092-96a4672448af@bootlin.com>
Date: Tue, 23 Apr 2024 14:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com,
 Richard Purdie <richard.purdie@linuxfoundation.org>, JPEWhacker@gmail.com,
 jsmoeller@linuxfoundation.org
Subject: Re: [bitbake-devel] bitbake-selftest losing sqlite3 database
 contents!
To: =?UTF-8?Q?Jan-Simon_M=C3=B6ller?= <dl9pf@gmx.de>,
 bitbake-devel@lists.openembedded.org
References: <d85e68b3-18ec-428e-b17a-b012bc9e2c75@bootlin.com>
 <7ca8f12c-fd13-4e60-ab4e-7016e2f9a683@bootlin.com>
 <CAJdd5GZYDtvvhkKKD4jukbWDatiWPXxQTwsjh+6HcFji+wNCHg@mail.gmail.com>
 <10108676.tdPhlSkOF2@arbeit>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <10108676.tdPhlSkOF2@arbeit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 12:29:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16131

Hi Jan Simon,

Just replying to one part :)

On 4/22/24 at 12:00, Jan-Simon Möller wrote:
> @Michael: the 'empty file' issue rings a bell and I've seen this back when we tried this for the first time.
> Export did not work either. But I have a hard time remembering the details. Might even depend on sqlite versions back then.
> I found this in my local git:
> sed -i -e "s#EXCLUSIVE#IMMEDIATE#g" /home/yocto/poky/bitbake/lib/prserv/db.py
> It probably helped some but might cause other issues. Let's see what the experts say.


Thanks! What's strange is that I only have this issue with the first 
database I create with the PR server. Databases created from later tests 
don't have this issue. This will need more time to investigate...
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


