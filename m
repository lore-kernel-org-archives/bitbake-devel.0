Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F3CAC587
	for <webhook@archiver.kernel.org>; Sun, 14 Sep 2025 18:51:11 +0000 (UTC)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 by mx.groups.io with SMTP id smtpd.web11.15468.1757875861175126742
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Sep 2025 11:51:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=hkib7Ty9;
 spf=pass (domain: ti.com, ip: 198.47.19.246, mailfrom: reatmon@ti.com)
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58EIoovs1339922;
	Sun, 14 Sep 2025 13:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757875850;
	bh=MOhLp8FEwcEqKirEBJ1+yf/rfoTrp2WZ0oTmaE4W2QQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=hkib7Ty9BfazibbGo/Z1Of1f3SwwLP5fv2z/Cr0BnP5jTa1Ajr7ngvJBmRL31SomZ
	 BeYVbfCvAXjYapoR6W5aHvlfz26iAP1jaZzSgSXtUlptbgjcJbMuidsYpXenETY1el
	 LGq2Uoh1L3IW3vbiS257zHvG5bmyqFXISAN6p228=
Received: from DLEE205.ent.ti.com (dlee205.ent.ti.com [157.170.170.85])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58EIootp3395216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 14 Sep 2025 13:50:50 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Sep
 2025 13:50:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 14 Sep 2025 13:50:50 -0500
Received: from [10.249.37.202] ([10.249.37.202])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58EIoo4C2527209;
	Sun, 14 Sep 2025 13:50:50 -0500
Message-ID: <f9839824-4874-4117-b5a2-ef6026ed6518@ti.com>
Date: Sun, 14 Sep 2025 13:50:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [bitbake][PATCH 1/3] bitbake-setup: Tweak user
 inputs
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        <bitbake-devel@lists.openembedded.org>
References: <20250912204559.10360-1-reatmon@ti.com>
 <DCSF7UFWPY45.1A12IA8MQQ968@bootlin.com>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <DCSF7UFWPY45.1A12IA8MQQ968@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Sep 2025 18:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18018



On 9/14/2025 4:37 AM, Mathieu Dubois-Briand wrote:
> On Fri Sep 12, 2025 at 10:45 PM CEST, Ryan Eatmon via lists.openembedded.org wrote:
>> Create a common function to get the user input when choosing an item
>> from a list.  Add support for not returning from the function until the
>> user has selected a number.
>>
>> When choosing items from the option list, if there is only one item,
>> then auto select it.  This is similar to code when picking the
>> configuration.
>>
>> Signed-off-by: Ryan Eatmon <reatmon@ti.com>
>> ---
> 
> Hi Ryan,
> 
> Thanks for your patches.
> 
> I suspect one of them is responsible of this error we got on the
> autobuilder:

Likely it is patch 2/3 bitbake-setup: Fix extracting config name.

It looks like the test is adding configs named:

test-config-1.conf.json
test-config-2.conf.json

And with my patch instead of the config name being the part before the 
first '.', now it strips just the extension '.json'.

I guess my change needs a little discussion on how we want this part of 
bitbake-setup to operate.  What do we consider the name of a config when 
extracting it from the file name.

I can update the tests to match my change and submit a v2 if we want to 
go with my change.

Thoughts?


> FAIL: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/bitbake/lib/bb/tests/setup.py", line 222, in test_setup
>      self.assertIn("test-config-1", json_configs)
> AssertionError: 'test-config-1' not found in {'test-config-1.conf': {'description': 'Test configuration'}, 'test-config-2.conf': {'description': 'Test configuration'}}
> 
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2252
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2324
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2469
> 
> Can you have a look at this, please?
> 
> Thanks,
> Mathieu
> 

-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

