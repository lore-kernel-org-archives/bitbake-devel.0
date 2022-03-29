Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5388BC433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 16:33:57 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.9102.1648571635655926969
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 09:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=BWZ/vIxf;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 7ED14E000B;
	Tue, 29 Mar 2022 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648571633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BRj6exUvF9d/scDMrlcKlV79sftYzVNIcKqatf1Gm1Q=;
	b=BWZ/vIxfntiLTueuUiXCH20yNKxcw34VornAvId2Y30O0QnVzmHsTOAjeH+kpM7BQnIfg2
	Ia/G9R6QUNPV/+NpJ8Idaj4GXbaOUar6s1QoEAdlxJ8aFphwHvLmQuJd0Ifiw+Nefb9Fyo
	T5/JA7TtePYSfyd+Q292mhIlAF0txlH9G+IR5bjidqNXIAUArtBar9Mxr+tn1CFkrox2V3
	AoMN9sqgl2S6Y4IJe/CsyNF3NTmKG9VzNPXqjqhvvb72Ntszjt3k/sBVBCYG4Azwjcjc3c
	1Nv7VNJjVZ/idUjsZhYXUvV13W3VTC9Tn2tisrC+B1g9WwFeeecduQAZkZbifQ==
Message-ID: <119c048f-010d-f9d2-2e74-da470b1d043d@bootlin.com>
Date: Tue, 29 Mar 2022 18:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] bitbake-user-manual: punctuation fixes
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 bitbake-devel@lists.openembedded.org
References: <20220329130747.364485-1-michael.opdenacker@bootlin.com>
 <5205d592-db48-f554-5c64-221dbcb7b774@theobroma-systems.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <5205d592-db48-f554-5c64-221dbcb7b774@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 16:33:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13549

Hi Quentin,

Thanks for the review!

On 3/29/22 15:13, Quentin Schulz wrote:
> Hi Michael,
>
> On 3/29/22 14:07, Michael Opdenacker via lists.yoctoproject.org wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> - Replace hyphens by em dashes when necessary
>
> I seem to recall we ultimately decided to not go for em dashes because
> it wouldn't be matched by a search in the browser or in the sources?


Ouch, this is frustrating. I'd rather not deviate from English writing
rules, so that we don't have to keep a list of exceptions to them, or
worse keep them in the back of our heads.

And why would one need to look for an em dash in the browser or in the
sources? As a reader, I'd avoid special characters in my searches, and
as a developer, I would do the same, but if I really want to look for a
specific em dash, I'll quickly find what the corresponding characters
are in the sources, thanks to the surrounding context.

Would it be possible to vote again on this?
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


