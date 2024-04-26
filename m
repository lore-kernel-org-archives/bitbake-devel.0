Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EBFC4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 13:50:45 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.14783.1714139438876029149
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Apr 2024 06:50:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fvAdui1x;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1048E0006;
	Fri, 26 Apr 2024 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714139437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vE+HjOKygFs8xffsWRbcEEF+uzpVMOiQ8FYiEQJWaHY=;
	b=fvAdui1xAWd2udcCpdkg0hryMdrJCrMKP0/MSodo1HPOm1REnZMyrnSFu666Zz46ip0M9N
	TEy8N5a5NpoqUfFsZiFwN1OxcYYhndeWpNy1hY/hpLYgvNbDHDYquNCkPG/Y12+nKmvmHS
	mMKgv48KNnokReS16twXE6ewtQySdGYPCa0wnJoqtLlwNNqy7EllsIGEMMt1tkVAU9rQr4
	qYvG8Zjx7UPGSymBMd/CKqXZdPmGKK6ci97GFdQDUhXx/hHWGij8NjVdHjPuSwqgNRBHX6
	kBPIN9R3I8+5Mx+qgZCn6usn41WxZsMaNhbkI1jLa6QcRf6VyR/YKQwECBDMcA==
Message-ID: <a165f4b7-1317-4163-98a7-7ccfaf055485@bootlin.com>
Date: Fri, 26 Apr 2024 15:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240423182543.226113-1-JPEWhacker@gmail.com>
 <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org>
 <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
 <17C9D59E2FED0839.6322@lists.openembedded.org>
 <17C9D5CD5F9CF1DF.16940@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C9D5CD5F9CF1DF.16940@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Apr 2024 13:50:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16144


On 4/26/24 at 14:56, Michael Opdenacker via lists.openembedded.org wrote:
>
> On 4/26/24 at 14:53, Michael Opdenacker via lists.openembedded.org wrote:
>> By the way, I still had empty databases after leaving the tests, but 
>> adding:
>> self.conn.commit()
>> after a group or INSERT or UPDATE commands did the trick.
>
>
> For the record, my database was created with the below settings:
>
> self.connection.execute("PRAGMA synchronous = NORMAL;")
> self.connection.execute("PRAGMA journal_mode = WAL;")

Oh, forget it, it's gone again (databases being empty again). Maybe, I 
looked too quickly.
I'll keep investigating and will keep you posted.
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


