Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E4EEE49A4
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 21:46:13 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by mx.groups.io with SMTP id smtpd.web11.45772.1694382363511869898
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 14:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=TAnP8KhV;
 spf=pass (domain: ti.com, ip: 198.47.19.141, mailfrom: rs@ti.com)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38ALjsOB010868;
	Sun, 10 Sep 2023 16:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694382355;
	bh=a+gH0koAostFIDWN6k5no6XK8H7nUknFeYMyhswQpmc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TAnP8KhVyzMtSlUwsM4F48yVBSEN8eTjCu/gyESk4lVNJ/nN2xpzkwKRcZYxlfPNe
	 ZubTO6PkaCmVdGaG88qocKtpUOvOCoQ/JDUL1ZIti4FiVI1K6PMxGiudWpkqE1ndyu
	 fbE5s6GGKNhWYNxccRlIhCfkIYuxDYyNgrBcuyWY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38ALjsx3093841
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Sep 2023 16:45:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 16:45:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 16:45:54 -0500
Received: from [128.247.81.144] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38ALjsLr000388;
	Sun, 10 Sep 2023 16:45:54 -0500
Message-ID: <41620028-dffd-44f7-bfc2-bb431a58e8c4@ti.com>
Date: Sun, 10 Sep 2023 16:45:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [bitbake-devel] [PATCH v2] bitbake-worker: remove
 the network flag
Content-Language: en-US, en-US-large
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
        <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>,
        <denis@denix.org>, <reatmon@ti.com>
References: <20230910194648.942409-2-rs@ti.com>
 <72eaf44b3c86582c73a9cf76ccba2378a0e83c6c.camel@linuxfoundation.org>
 <ede700bf-05f0-4e23-b173-ba2df6de2603@ti.com>
 <20230910211639f1b8e744@mail.local>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <20230910211639f1b8e744@mail.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 21:46:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15031

On 9/10/23 16:16, Alexandre Belloni wrote:
> On 10/09/2023 15:50:22-0500, Randolph Sapp via lists.openembedded.org wrote:
>> Thanks for the background. I won't push this issue anymore. The current
>> method does seem to be pretty good at passively catching offending tasks.
>>
> 
> This is certainly way more important for your customers than you
> realize. The proxy issue is not actually an issue because it is very
> likely that anyway they would have to set up a local mirror to ensure
> they are able to rebuild without relying on a third party. You should
> rather teach them to do that instead of working around the networking
> issues they are creating for themselves.
> 
> This is even more important as the companies having those network issue
> are probably the one that care the most about the correctness of spdx.
> 
> Really, the proper fix is in the fetcher.
> 

Right, I suppose I'm just pessimistic in assuming that users will tend 
to flock to the easier solution of enabling the network flag and not 
circling back to proper method of implementing the fetcher. (I know 
that's what I did for my first layer.)

Education and community involvement ideally will solve this though. I 
just have my reservations about allowing multiple methods of solving an 
issue to exist in parallel. Makes debugging things interesting.

Regardless, thanks Alexandre. :)

