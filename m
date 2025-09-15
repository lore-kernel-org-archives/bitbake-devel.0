Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E24CAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 11:50:17 +0000 (UTC)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 by mx.groups.io with SMTP id smtpd.web10.30774.1757937009605131623
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 04:50:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=SDed/Hg2;
 spf=pass (domain: ti.com, ip: 198.47.23.234, mailfrom: reatmon@ti.com)
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58FBo83W1127465;
	Mon, 15 Sep 2025 06:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757937008;
	bh=6BK2GxLcUbGQwsu9l1LSljN+4/INT4N4JMfHO3Q+9Vw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SDed/Hg2a5/QtBIEJ/WCOeY0Phb5AQscZpBvARrplR4qYIUhOOA4KhreMhvzE+qzy
	 LenHFfqzCetxfIrP4VJ1HVI76aRiy6pK4SKrkzuafv3i+owWVESLXYv8z+jnOcYQja
	 dfhTuz1xaeaBSz9hETS/L46pwwzc0bLNQWo2neNM=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58FBo8c84094063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 06:50:08 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 06:50:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 06:50:08 -0500
Received: from [10.249.37.202] ([10.249.37.202])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58FBo7Ef4001361;
	Mon, 15 Sep 2025 06:50:07 -0500
Message-ID: <f9acde26-b675-40d4-b2c6-bbd8b07d2778@ti.com>
Date: Mon, 15 Sep 2025 06:50:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [bitbake][PATCH 2/3] bitbake-setup: Fix
 extracting config name
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>
References: <20250912204559.10360-1-reatmon@ti.com>
 <20250912204559.10360-2-reatmon@ti.com>
 <CANNYZj-f5oM19NRJebFgkZvFR1_EdUa1jyB915o_Ux3TqHM7XQ@mail.gmail.com>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <CANNYZj-f5oM19NRJebFgkZvFR1_EdUa1jyB915o_Ux3TqHM7XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 11:50:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18022



On 9/15/2025 4:51 AM, Alexander Kanavin wrote:
> On Fri, 12 Sept 2025 at 22:46, Ryan Eatmon via lists.openembedded.org
> <reatmon=ti.com@lists.openembedded.org> wrote:
>>
>> When extracting the config name from from the filename, just splitting
>> on . does not allow for . in the config name.  For example:
>>
>> coresdk-11.01.08-config.json -> coresdk-11
>>
>> when it should be:
>>
>> coresdk-11.01.08-config.json -> coresdk-11.01.08-config
>>
>> os.path.splitext() already does this logic correctly, so use that
>> instead.
> 
> The files are explicitly expected to end with .conf.json. Otherwise
> the tool could potentially pick up unrelated json files in registries.
> There's probably a missing check for that condition somewhere?

I'll update my code then to remove the .conf.json only then and send a v2.


> Alex

-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

