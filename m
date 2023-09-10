Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAC6C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:37:21 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by mx.groups.io with SMTP id smtpd.web11.43150.1694374632823534190
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:37:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=BegTJU02;
 spf=pass (domain: ti.com, ip: 198.47.23.248, mailfrom: rs@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38AJb8GO018242;
	Sun, 10 Sep 2023 14:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694374628;
	bh=mN1VaqnFnLN1OtO338jy37lrzrHGAaMhaJlcpTGOdzk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BegTJU02+GnXj17QOK0s2ZdIrEEvvRNgdRtCpqsGMyrUHua6FDix6Xf2IKHV/IDqC
	 XEr5OEtIeBGgSy0o6FUvynLffJXLvJRaDWQSW47x7CYUczXg+no48e8boLgECNBj0D
	 qydc5+UjoZrys9f3rONnX3LxC4GWjORr5BlOoJZ0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38AJb7f1050674
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Sep 2023 14:37:07 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 14:37:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 14:37:07 -0500
Received: from [128.247.81.144] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38AJb7k5039211;
	Sun, 10 Sep 2023 14:37:07 -0500
Message-ID: <3a26f3d8-b0aa-4ebd-97bb-aaa36c5eed9d@ti.com>
Date: Sun, 10 Sep 2023 14:37:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] bitbake-worker: remove the network flag
Content-Language: en-US, en-US-large
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <richard.purdie@linuxfoundation.org>,
        <bitbake-devel@lists.openembedded.org>, <denis@denix.org>,
        <reatmon@ti.com>
References: <20230910191445.564413-2-rs@ti.com>
 <CANNYZj_SNEM1yGkF28vv=oa+89DKptxTJmVAA_mb8qCwBtYUdA@mail.gmail.com>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <CANNYZj_SNEM1yGkF28vv=oa+89DKptxTJmVAA_mb8qCwBtYUdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:37:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15021

On 9/10/23 14:33, Alexander Kanavin wrote:
> On Sun, 10 Sept 2023 at 21:15, <rs@ti.com> wrote:
> 
>> --  ``[network]``: When set to "1", allows a task to access the network. By
>> -   default, only the ``do_fetch`` task is granted network access. Recipes
>> -   shouldn't access the network outside of ``do_fetch`` as it usually
>> -   undermines fetcher source mirroring, image and licence manifests, software
>> -   auditing and supply chain security.
> 
> These reasons still stand.
> 
> The only correct solution is to write a fetcher that can be used in
> SRC_URI. This was communicated to you previously. So please: lay out
> what is it exactly you're doing outside of do_fetch that needs the
> network, and we'll try to figure out how to engineer it with a
> fetcher.
> 
> Alex

I'm aware of the proper solution, but this will address the issues of 
network flag abuse that other layers are introducing.

My issue is that by exposing the network flag like this any layer can 
come along an introduce build complications. If that's the case, why 
expose this flag at all?

Randolph

