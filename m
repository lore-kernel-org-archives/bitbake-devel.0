Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA8AEDE999
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 15:03:15 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web11.25663.1725980587875911613
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Sep 2024 08:03:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=acylexm4;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: reatmon@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48AF2tnn025333;
	Tue, 10 Sep 2024 10:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725980575;
	bh=t3MtPzFKYmYMPcPFbccbBD244DiE7l/NNLxFbQNdogo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=acylexm4ZqlUaWm2OmXK50uhQYL+sLb4aAW2zkkE0DEeEzjogIgM/uDjG2PLwEGeA
	 vKfLQIhNNa1E7QZVKfp5PCH4X6enBBolroSxYLsTey7cg12G4KM647FEpN4grb/WHg
	 TGrDitaA73bViEdV4CLeYeh6ejQ3Ig57+SyyXi3M=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AF2tVN016222;
	Tue, 10 Sep 2024 10:02:55 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Sep 2024 10:02:54 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Sep 2024 10:02:54 -0500
Received: from [10.249.34.164] ([10.249.34.164])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48AF2spV101279;
	Tue, 10 Sep 2024 10:02:54 -0500
Message-ID: <fa52a7f7-d025-418a-b022-9d3e813ad2de@ti.com>
Date: Tue, 10 Sep 2024 10:02:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>, <yocto@lists.yoctoproject.org>,
        <openembedded-architecture@lists.openembedded.org>,
        Alexander Kanavin
	<alex@linutronix.de>
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
 <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com>
 <CANNYZj8THxZ6y8sv3Y7A9br3zfh4GMpec4g4Y-+gMzGMJf5CAA@mail.gmail.com>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <CANNYZj8THxZ6y8sv3Y7A9br3zfh4GMpec4g4Y-+gMzGMJf5CAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Sep 2024 15:03:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16550



On 9/9/2024 4:33 AM, Alexander Kanavin wrote:
> On Thu, 5 Sept 2024 at 23:10, Ryan Eatmon <reatmon@ti.com> wrote:

>> 2) The uri for a sources entry in the json file automatically adds in
>> protocol=git even though I specified protocol=https on the line.  We
>> prefer to always use the https for git repos and not the git protocol.
>> I modified the code to not do this so my testing could continue.
> 
> This is not the case. If the entry in the json starts with https://
> then the tool will use protocol=https. Basically it needs to convert
> URI that can be given to git on the command line into an SRC_URI type
> string that can be given to bitbake's git fetcher.

You are correct.  I assumed that the string was the same format as the 
SRC_URI.  This might be a little confusing for users as that means we 
have two different interpretations for repo strings.


>> 3) If we specify a unique key for each of the sources, why do we need to
>> then also specify a path to place the downloaded sources into?  Why not
>> just use the same key value to reduce what all is needed to specify.  We
>> can still support "path" for those that want it, but if it is left out I
>> would default it to the unique key for the repo.
> 
> Here I had simply followed the layer configuration schema that makes
> path mandatory. Requiring a parameter has its advantages, you don't
> have to ensure that the default is documented, standardized and all
> tools follow the standard. You also don't lock yourself into the
> default value that must be followed until the end of time.

Then what good is the key value for?  The current patch does not use 
r_name except to look up the value under layers.  Should we just make 
the JSON have this as an array of repos instead of a named hash?

Or is there some planned thing coming later that might make use of this key?



>> 6) The code loops through the layers looking for scripts/oe-setup-build.
>>    What would happen if I shipped a rogue layer with that file in it and
>> included it as the last layer in the sources?
> 
> I guess it would run that instead? If you include a rogue layer into
> the config, there's lots of other rogue things it can do when bitbake
> starts, but maybe you have a suggestion?

Ideally this would be locked to oe-core as that is what is intended. 
But I'm not sure how best to do that.


Side topic, would it make sense to allow for the existence of a config 
file in the repos that would allow them to "register" features that can 
processed by bitbake-setup to configure various things that the layer 
requires/offers?  Right now we do this kind of thing for the 
oe-setup-build script.  But I could see the framework being useful for 
this kind of thing.


>> 7) I'm getting an error when running the setup-build script:
>>
>>     File "/scratch/builds/bitbake-setup-test/layers/setup-build", line
>> 107, in setup_build_env
>>       subprocess.run(cmd, shell=True, executable=os.environ['SHELL'])
>>     File "/usr/lib/python3.10/os.py", line 679, in __getitem__
>>       raise KeyError(key) from None
>> KeyError: 'SHELL'
>>
>>
>> SHELL is set to /bin/sh so I'm at a loss to see why this would be
>> failing.  But because of this I never get a build.sh script.
> 
> For this I would really appreciate if you can get to the bottom of.

I'll take a look today and try to track it down.


> Thanks,
> Alex

-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

