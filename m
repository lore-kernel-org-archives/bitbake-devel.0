Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEF5C10F15
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 08:15:13 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.11444.1713946507485223551
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Apr 2024 01:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iweiPe3M;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA711C000C;
	Wed, 24 Apr 2024 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713946505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wke4tx3MAm3AAEdZ9alX+qzs12DsmagUuHZxV2AINXc=;
	b=iweiPe3Mz+4sm2996qbWeSO+4OqB1m9HOsYmLToGnp2VFtmb0p1oOZcJmN6a3LOF2SM7jz
	X3pSzBHVRo+caP8ObnajwXrtZIn/XakBuRwtYJaWOO1EoYdhXTGKZUCk6dmNl0dws+k0PR
	M2Avi5+zHXFgS96ErmHZALvtfO9ubK6sX2V4L8n9wfnvOGRQY8XFV9CseoizLuJFgkthHW
	WwHAwFSjfef4Zb9JDTbdbbT7OB7YcPBTJQT2mZKYapEd+5BcmobkCoeLmxVmZrqPg6qkWC
	1EafEb+2lYU66exPuyZLfwz4216fP7hFxMvQc0WCQG2um7NKyGFa7v344Pee+A==
Message-ID: <9e555c2c-37b2-4bb1-a4c2-4b1532e22a2c@bootlin.com>
Date: Wed, 24 Apr 2024 10:15:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240423182543.226113-1-JPEWhacker@gmail.com>
 <20240423182729.226345-1-JPEWhacker@gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20240423182729.226345-1-JPEWhacker@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Apr 2024 08:15:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16137

Hi Joshua

On 4/23/24 at 20:27, Joshua Watt wrote:
> sqlite3 can allow multiple processes to access the database
> simultaneously, but it must be opened correctly. The key change is that
> the database is no longer opened in "exclusive" mode (defaulting to
> shared mode). In addition, the journal is set to "WAL" mode, as this is
> the most efficient for dealing with simultaneous access between
> different processes. In order to keep the database performance,
> synchronous mode is set to "off". The WAL journal will protect against
> incomplete transactions in any given client, however the database will
> not be protected against unexpected power loss from the OS (which is a
> fine trade off for performance, and also the same as the previous
> implementation).

Thanks, I also made experiments with the "WAL" journal mode, but didn't 
go on as it didn't solve my empty database issues. However, I agree it 
seems like the way to go!

>
> Finally, the _execute() API now uses a database cursor. The cursor
> automatically makes sure that the query happens in an atomic transaction
> and commits when finished.
>
> NOTE: THIS MAY BE INCOMPLETE; All APIs need to be evaluated to see if
> the transaction (cursor) needs to cover mode than one "execute"
> statement.
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>   bitbake/lib/prserv/db.py | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)

Which branch did you use to generate your patch? I can't manage to apply 
it to either "master", "master-next" or the branch I shared recently...

Ah, just found it. You used "nanbield".

I'll test it in my branch and "torture" it with regular tests and my new 
bitbake selftests.
Thanks,
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


