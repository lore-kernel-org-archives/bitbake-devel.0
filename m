Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B6BC71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 20:11:22 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web11.43790.1694376681650260667
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 13:11:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=jCFWjYNS;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: rs@ti.com)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38AKBHgB126200;
	Sun, 10 Sep 2023 15:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694376677;
	bh=oVrjMF2NP8ONp7rZ6VAyvd7qoqvsPwrKevCo2V5h3AM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jCFWjYNS7WPlGKaLpNvJ68z99ZP9LrNseN74dQMv+LWJu0xbljo+BfR+XGVFVOnE0
	 LuUfniemvVRdQhLbrTmWJn5gquKUpUc+89sm8tWuTgfPFdNYAHWurHHGWvpGQxupJ8
	 1ajKe711sAifenQ0VTH2zo7DkiG6Xq290/0mVqQ4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38AKBH8U012954
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Sep 2023 15:11:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 15:11:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 15:11:17 -0500
Received: from [128.247.81.144] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38AKBHVD041030;
	Sun, 10 Sep 2023 15:11:17 -0500
Message-ID: <208a2844-9ee3-4e51-afb1-5de1255bfac4@ti.com>
Date: Sun, 10 Sep 2023 15:11:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2] bitbake-worker: remove the network flag
Content-Language: en-US, en-US-large
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <richard.purdie@linuxfoundation.org>,
        <bitbake-devel@lists.openembedded.org>, <denis@denix.org>,
        <reatmon@ti.com>
References: <20230910194648.942409-2-rs@ti.com>
 <CANNYZj9innMGasLvCuZBEvB8Cr65AwRW+wyRK_mUaU8MOmJjQA@mail.gmail.com>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <CANNYZj9innMGasLvCuZBEvB8Cr65AwRW+wyRK_mUaU8MOmJjQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 20:11:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15026

On 9/10/23 14:57, Alexander Kanavin wrote:
> Please stop sending the patch. You are just winding everyone up. If
> you want to have a discussion, open a thread with the comment about
> icecc and friends, and we'll take it from there, otherwise any further
> submission from you will be treated with suspicion and mistrust, which
> is not the outcome you want.
> 
> Alex
> [snip]
Fair enough. It was my intent to actually submit a usable patch with 
this discussion but the first revision was a bit too hastily sent. Rest 
assured, this will be the last revision.

I'm not here to push the matter. I just figured this was the next step 
if the network flag didn't behave the same for all users.

Seems like people like the current behavior though. That's fine. I just 
think this should be documented somewhere if that's the case. I can 
submit a patch for that documentation update instead, if that's preferred.

