Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C4ECD1288
	for <webhook@archiver.kernel.org>; Wed,  3 Apr 2024 16:19:08 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.15755.1712161144271425809
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Apr 2024 09:19:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=JK5bBrVr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B62FFF803;
	Wed,  3 Apr 2024 16:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712161142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGqRSDlZugadMGuuA2JIvMZQkoPbI5LbmUjNVd4t1Ss=;
	b=JK5bBrVrSk+f/AzAjCkBUkDO/ZPIxDNCTTiIyInuUxVy2219cv6jaGf8oGtnn+O8ChA1Ha
	+ws8ub2VmbZchNtZgYcKFBkhYKgWiIwhvuSJliqAcW07fJrMSQqvJN6VLX3UisG0BnwfsG
	C1tMrOp/fa2YF7sU1wMF4t4PBNgD/XfqpX/cGMkN74pGHqQR2tYplDDERctYPdia+vJ0XH
	nHosBebEQM/MUys4L6ZkzgksMBgoi3nE44bInAMqPA8B4f0mf66pVkTmlH4jWasRI0qxow
	K7Q+kB8BlB1MOzfxPERyNFdBTncPj01oVzzekBibpFqZ8cR9ij1xHDkSl76GLw==
Message-ID: <85d282ee-b587-44f5-9324-287518acafe5@bootlin.com>
Date: Wed, 3 Apr 2024 18:19:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Joshua Watt <JPEWhacker@gmail.com>, Tim Orling <ticotimo@gmail.com>,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 07/12] prserv: fix read_only test
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
 <20240329143956.1602707-8-michael.opdenacker@bootlin.com>
 <f3c847d76b25cb880b4564c7a1000d3073b7c76f.camel@linuxfoundation.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <f3c847d76b25cb880b4564c7a1000d3073b7c76f.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Apr 2024 16:19:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16046

Hi Richard,

On 4/3/24 at 17:42, Richard Purdie wrote:
> On Fri, 2024-03-29 at 15:39 +0100, Michael Opdenacker via
> lists.openembedded.org wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> read_only is an attribute of the parent server object, not of the
>> client.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>> Cc: Joshua Watt <JPEWhacker@gmail.com>
>> Cc: Tim Orling <ticotimo@gmail.com>
>> ---
>>   lib/prserv/serv.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
>> index 242cd11a5a..efb2e0cf93 100644
>> --- a/lib/prserv/serv.py
>> +++ b/lib/prserv/serv.py
>> @@ -61,7 +61,7 @@ class
>> PRServerClient(bb.asyncrpc.AsyncServerConnection):
>>   
>>       async def handle_import_one(self, request):
>>           response = None
>> -        if not self.read_only:
>> +        if not self.server.read_only:
>>               version = request["version"]
>>               pkgarch = request["pkgarch"]
>>               checksum = request["checksum"]
>>
> Isn't this a missing piece of "prserv: simplify the PRServerClient()
> interface" and should be squashed there?

Oops, indeed, very good catch!
Fixed in my branch.
Many thanks!
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


