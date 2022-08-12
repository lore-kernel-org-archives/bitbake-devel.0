Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D6C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 16:47:19 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web12.1568.1660322830163311900
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Aug 2022 09:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FhQxbhDI;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 1F86060005;
	Fri, 12 Aug 2022 16:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1660322827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ppTUsTKu7CRGNlySiYAaGI76aE3vqS00SfrN7xvr/8=;
	b=FhQxbhDIV3zq98kPN8RfevzTdqq4KO/bEOYkmsqiOIbWqo/sdEqEJWnbsX76xyV8mR7t2+
	ywvY21Ixozt78z15R8R2Ed1nA+6B9v3YuUIKdVsDl8/WyAfYorOGP7iXta4p9AtSOS/XhO
	pP7sWeP66TDSx8ycaofQPw6zZr4gwy3O8MpRF0HA3W/ebv69XK+F1x8217UllyYQfL1fGP
	+7oACssb89gUy1qeJvBnHVWmHxqfQjWLJuj3Io5i60RMdZmJ5oulqRRS9uSi5hHZAl0StH
	3riCJJ3QFYLi8fmTjx2YRhiEsUk4Utq9JrPJtYFax/gncgt4L/S7kY5f0sjKVw==
Message-ID: <3d7c8979-1ea4-8ff2-1f2a-eeba95ddcd27@bootlin.com>
Date: Fri, 12 Aug 2022 18:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: docs@lists.yoctoproject.org
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: Add definition for
 BB_PRESSURE_MAX variables
Content-Language: en-US
To: Aryaman Gupta <aryaman.gupta@windriver.com>,
 bitbake-devel@lists.openembedded.org
References: <20220812151207.1616310-1-aryaman.gupta@windriver.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <20220812151207.1616310-1-aryaman.gupta@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Aug 2022 16:47:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13894

Hi Aryaman,

On 8/12/22 17:12, Aryaman Gupta wrote:
> Add the definitions for the BB_PRESSURE_MAX{CPU|IO|MEMORY} variables in the
> bitbake varibales glossary. Further information on how to determine a good
> threshold is added to the Yocto reference manual in the following
> commit:
> 	a9b58b3a6 ref-manual: add definition of BB_PRESSURE_MAX_CPU variable

Did you send an update to the Yocto manual after the first submission 
which Quentin commented?

Anyway, you should not refer to a commit that hasn't been merged yet.

Let's merge this one first, and see what remains to be added to the 
Yocto manual, avoiding duplicate information. The Yocto manual can 
always refer to the Bitbake manual.

Could you resend this patch with a corrected commit description, please, 
so that Richard can merge it?

Thanks in advance
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


