Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F3C5475B
	for <webhook@archiver.kernel.org>; Fri,  8 Mar 2024 15:31:17 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.24785.1709911868983780110
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Mar 2024 07:31:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ljab5FU5;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 941EE20007;
	Fri,  8 Mar 2024 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709911866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEemjvatO4F/9qDhot2+sEkQwUi950sfVQrMlJX996A=;
	b=ljab5FU5lEcmhcIVo9O8pIAxPVxlffmFMaVu0yqubQehQ17MFPiMwPbBMEpcuW8aCBDHJd
	XhicfXfyJh5jD7svHGGCcph7x3jEdA/Ai0oEiO/9+ErMr08x7Tt6Hhgjz2/4LKjgFWVqLT
	jzgS7XEttzjXqPT7v3V+2dHLcbgE5+pa6/i0CkWEdqm5Gs7buXIwfLl91gwNWaveZ12cr3
	rloaI1fGNF8EiH4BxOvRIkmn6U5wNKY53/L18qdPK+0rvLL35hbPnjK/vClebi+/DgiMYj
	dG8iegNzw5P1Uk1/QBCDe1lmAcE8F4koguEM2puKRrx0A3KVNjzaRbNaTVLjPg==
Message-ID: <f7290592-375e-448d-a33d-6c806c6fc36b@bootlin.com>
Date: Fri, 8 Mar 2024 16:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] prserv: remove dead code in exception
 handling
Content-Language: en-US
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240306171144.1874798-1-michael.opdenacker@bootlin.com>
 <CAJdd5GZ1RkHzaFhSmVYZmBsK=z9Y3Sge5d5=-SdsJjneiOp1gg@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GZ1RkHzaFhSmVYZmBsK=z9Y3Sge5d5=-SdsJjneiOp1gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Mar 2024 15:31:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15995

Hi Joshua

On 3/7/24 at 00:31, Joshua Watt wrote:
> On Wed, Mar 6, 2024 at 10:12 AM Michael Opdenacker via
> lists.openembedded.org
> <michael.opdenacker=bootlin.com@lists.openembedded.org> wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> As explained in https://docs.python.org/3/reference/compound_stmts.html#else-clause,
>> the code after the "else" statement won't be run as there is a "return"
>> in the "try" block.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> ---
>>
>> See the whole code on
>> https://git.openembedded.org/bitbake/tree/lib/prserv/serv.py#n38
>> ---
>>   lib/prserv/serv.py | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
>> index 5fc8863f7..5032f7cd7 100644
>> --- a/lib/prserv/serv.py
>> +++ b/lib/prserv/serv.py
>> @@ -40,8 +40,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
>>           except:
>>               self.table.sync()
>>               raise
>> -        else:
>> -            self.table.sync_if_dirty()
> It is correct this will not run, should self.table.sync() be in a
> finally block instead to make sure the DB is always synced? (the
> except can also be removed then)

I've implemented this simplification, but it would cause to run 
"self.table.sync()" even when no exception is caught. That wasn't the 
case before. Is that what you were suggesting?

Happy to submit my change if you agree!
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


