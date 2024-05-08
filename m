Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA7C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 17:41:08 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.3517.1715190063812711703
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 May 2024 10:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=kTbThgKq;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 082FB20002;
	Wed,  8 May 2024 17:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715190062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmdFN4lMS76zj3TS5zzbz+K3osgrbsxNCXWJnmZ/vyk=;
	b=kTbThgKqrfUVHL+r3QPe8JQZOdFnrtiYdJ96X6E+o/kHwzSbYqeEAS/IoceQMaVE1ERU4E
	4yfhc0BhoTFC68clt4Czd+N+cZOvgnDGrQCKpMiVt0nEnmOZ2jkJRBv6bCs8E22F2UDil6
	Mf9NxqhhFBIx5Mq6eE0VB8u/PO6HnT8++7rHDkk8LjardIDG57gEiYMwI0eBa6O/3uhpF0
	znk6HX5mlyKIsYa3yH27Cs1LuDZxHPo+fS3a8NJ6JzqA//ogE/prLlEuO5OJDDcAvBRvIn
	vpW1ncKbzJhTjuiuY4wJd3GB7Pk0YjPt9gCngM0H1h5cGeGxhBED8qhTDQ7tpw==
Message-ID: <f4e7af33-b0ac-4620-9f96-f1c83460cd01@bootlin.com>
Date: Wed, 8 May 2024 23:10:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, Joshua Watt <JPEWhacker@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Orling <ticotimo@gmail.com>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v5 2/5] prserv: move code from __init__ to
 bitbake-prserv
To: Khem Raj <raj.khem@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
 <20240429201418.657042-3-michael.opdenacker@bootlin.com>
 <CAMKF1soyTt3He84XOgAv01ZdwGPZ2gxVwZaRxsL2Dufj3W_=rg@mail.gmail.com>
 <2a2f731e-7ca0-4442-a0e2-5e2b3bfde80c@bootlin.com>
 <CAMKF1soksEYiF37G=1bhDSX83iecpfVcxjiS+QLW4DciVu7LCA@mail.gmail.com>
 <bb6d8641bbc41c7ac1e32447e6b2f691127dfdca.camel@linuxfoundation.org>
 <CAMKF1srwkF=UOLvd3Een+uVLSjH6yo0XjKwG+=kDzF4g3vbjvQ@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAMKF1srwkF=UOLvd3Een+uVLSjH6yo0XjKwG+=kDzF4g3vbjvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 May 2024 17:41:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16193

Richard, Khem,

On 5/8/24 at 20:43, Khem Raj wrote:
> On Wed, May 8, 2024 at 6:35 AM Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> On Fri, 2024-05-03 at 07:14 -0700, Khem Raj via lists.openembedded.org
>> wrote:
>>>
>>> On Fri, May 3, 2024 at 1:04 AM Michael Opdenacker
>>> <michael.opdenacker@bootlin.com> wrote:
>>>> Hi Khem
>>>>
>>>> On 5/2/24 at 18:57, Khem Raj wrote:
>>>>> Hi Michael
>>>>>
>>>>> I am seeing a problem with this series, specifically following
>>>>> patchset is causing a regression
>>>>>
>>>>> * ea1d7b8a36e bitbake: prserv: add bitbake selftests
>>>>> * 5c66d345300 bitbake: prserv: import simplification
>>>>> * c23f2c1680f bitbake: prserv: store_value() improvements
>>>>> * 395b321af29 bitbake: prserv: avoid possible race condition in
>>>>> database code
>>>>> * 8022dc1029d bitbake: prserv: enable database sharing
>>>>> * b81bfdfbed8 bitbake: prserv: add "upstream" server support
>>>>> * 9539ce3b14a bitbake: prserv: move code from __init__ to
>>>>> bitbake-prserv
>>>>> * 4ec1553710b bitbake: prserv: declare "max_package_pr" client
>>>>> hook
>>>>>
>>>>>
>>>>> error seen during packagedata task of base-files
>>>>>
>>>>> WARNING: base-files-3.0.14-r0 do_packagedata: Error talking to
>>>>> server:
>>>>> Connection closed
>>>>> ERROR: Error from client ('127.0.0.1', 59846): 'PRTable' object
>>>>> has no
>>>>> attribute 'sync'
>>>>> Traceback (most recent call last):
>>>>
>>>> Thanks for the review. Actually, did you test with the V6 update I
>>>> sent?
>>>>
>>>
>>> I think it was version in master-next that Richard has staged
>>>
>> It was against v6 so I'm not able to merge these until that is fixed.
>>
> Right, I will try a  clean from scratch build and see if it was something
> intermediate to be sure.


Thanks for testing.
I confirm the issue is still there. My apologies for this overlook!
This is a busy week for me, but I will submit a fix as soon as I get the 
time, and before the end of the week anyway.

Kind regards
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


