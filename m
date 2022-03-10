Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC6FC433FE
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 16:38:43 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web12.11741.1646930323035271486
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 08:38:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=K/jS1xML;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id DDAF71BF206;
	Thu, 10 Mar 2022 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646930320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RLjhJpg2QGSQiOD/8sqGDAzoTVVvVDXkLdkSfrFGbNA=;
	b=K/jS1xMLAqSKcKN7ZltOqcI18kd8gEPLWVmNF3oaoQFN/iKFcPBbIn8u8vRC5p6uOpj/b1
	sL/U/KDQap6kQT5yChD94ietuN4n285Miub04PDWsSwz3JyEUfPKMcDJOyG8UmJtO4ESNH
	onNORavF/Gz8KjtYpJZCOprLO4poSqwS++hNqBft2pYAVB0P2FG9JfBMKhkAnnr/Z5nV6p
	OBfB6LTXXw0q+H/brnd16MVndSW7Iw3UgAJMOw5qNmxU1baupGk/5MyNuv0+qUYABZ5p6H
	quYiTLRtpfU83uT9TcG8shDAEFGurS5Zj63A3D1VVpzqaQoIGv9TtQ1GCg6hUg==
Message-ID: <dfc5f583-2172-71b3-2d0f-d4b3a400ef69@bootlin.com>
Date: Thu, 10 Mar 2022 17:38:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
Subject: Re: [docs] [PATCH 2/2] doc: bitbake-user-manual: branch parameter now
 mandatory in git SRC_URIs
Content-Language: en-US
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20220309175319.620707-1-michael.opdenacker@bootlin.com>
 <20220309175319.620707-2-michael.opdenacker@bootlin.com>
 <a1abff5be8224e7683afab63e7f3e9fc@axis.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <a1abff5be8224e7683afab63e7f3e9fc@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 16:38:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13468

Hi Peter,

On 3/10/22 11:53, Peter Kjellerstedt wrote:
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> index ae2d3a17..d0c78062 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
>> @@ -432,8 +432,8 @@ This fetcher supports the following parameters:
>>     raw Git metadata is provided. This parameter implies the "nocheckout"
>>     parameter as well.
>>
>> --  *"branch":* The branch(es) of the Git tree to clone. If unset, this
>> -   is assumed to be "master". The number of branch parameters much match
>> +-  *"branch":* The branch(es) of the Git tree to clone. This is a
>> +   mandatory parameter. The number of branch parameters must match
>>     the number of name parameters.
> Note that it is either branch=... or nobranch=1 that is mandatory.


Oops, indeed. Thanks for the correction.
Sending a V2 right now...
Thanks again
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


