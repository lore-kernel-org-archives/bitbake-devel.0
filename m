Return-Path: <reatmon@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A458FCE7AA0
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 21:11:10 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 by mx.groups.io with SMTP id smtpd.web11.20728.1725570668362382055
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Sep 2024 14:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=e2WvUbeN;
 spf=pass (domain: ti.com, ip: 198.47.23.249, mailfrom: reatmon@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 485LAt1h125549;
	Thu, 5 Sep 2024 16:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725570655;
	bh=Q28/7OAi0dVo3I37J2b7X00VpozQwbjyispbnvcKGLI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=e2WvUbeNF3yzT13YjguA9Qb8TouzZubBIdXXBgUCcUaevgkPwIOmBQyaD0mBzdX+9
	 6vQK41RN09PMtD0yNHRc14WYWTUZumLa7wtAIVg3KGJGR30sOIh7++GPeKyjhXNRQ5
	 +0G90ftbbndf5lDDEIKyjFQPntvV31GVaKjx0avw=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 485LAt3p073311;
	Thu, 5 Sep 2024 16:10:55 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Sep 2024 16:10:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Sep 2024 16:10:55 -0500
Received: from [10.249.36.103] ([10.249.36.103])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 485LAtTk012745;
	Thu, 5 Sep 2024 16:10:55 -0500
Message-ID: <8ddf5dac-2cb8-4c6a-b4e9-b8b281058cb1@ti.com>
Date: Thu, 5 Sep 2024 16:10:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH] bitbake-setup: add the proof of
 concept implementation
To: Alexander Kanavin <alex.kanavin@gmail.com>,
        <bitbake-devel@lists.openembedded.org>, <yocto@lists.yoctoproject.org>,
        <openembedded-architecture@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
References: <20240502105745.3073153-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Ryan Eatmon <reatmon@ti.com>
In-Reply-To: <20240502105745.3073153-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Sep 2024 21:11:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16543



On 5/2/2024 5:57 AM, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
> 
> For the rationale and design guidelines please see this message:
> https://lists.openembedded.org/g/openembedded-architecture/message/1913
> 
> Left out for now but will be done later:
> - config fragment support
> - tests
> - documentation
> - official configuration repository
> 


Hello.  I'm attempting to play around with this patch and test out 
bitbake-setup and how it works.  My testing it with trying to take one 
our existing setups and try to get it to work.  Here is some initial 
feedback written as I ran into issues.

I'm running in an ubuntu-22.04 docker container based on crops.


1) In order to use list it assumes you are fetching a git repo and that 
the git repo has a specific layout.  That seems a little problematic. 
What if the repo we want to point has all kinds of configs for different 
tools in it and we just want a sub directory under the git repo?  How do 
we specify that?


2) The uri for a sources entry in the json file automatically adds in 
protocol=git even though I specified protocol=https on the line.  We 
prefer to always use the https for git repos and not the git protocol. 
I modified the code to not do this so my testing could continue.


3) If we specify a unique key for each of the sources, why do we need to 
then also specify a path to place the downloaded sources into?  Why not 
just use the same key value to reduce what all is needed to specify.  We 
can still support "path" for those that want it, but if it is left out I 
would default it to the unique key for the repo.


4) The init step cannot be run multiple times.  Initial errors are 
because the build-dir already exists, but overall it's a good idea to 
allow for rerunning the setup to allow for fixing issues without needed 
to nuke the entire build dir.  An example of why you might this is if 
you want to add a new layer to your config, or change a commit, or 
whatever...  Rerunning the init should be able to apply the incremental 
changes since the last run.

In this case I was running into an error message from a file in oe-core, 
which I sent a patch for, and was trying to simply fix that file in the 
layers dir and rerun, but kept tripping over the fact that I cannot 
rerun init.


5) What is the purpose of creating the top level config git repo?


6) The code loops through the layers looking for scripts/oe-setup-build. 
  What would happen if I shipped a rogue layer with that file in it and 
included it as the last layer in the sources?


7) I'm getting an error when running the setup-build script:

   File "/scratch/builds/bitbake-setup-test/layers/setup-build", line 
107, in setup_build_env
     subprocess.run(cmd, shell=True, executable=os.environ['SHELL'])
   File "/usr/lib/python3.10/os.py", line 679, in __getitem__
     raise KeyError(key) from None
KeyError: 'SHELL'


SHELL is set to /bin/sh so I'm at a loss to see why this would be 
failing.  But because of this I never get a build.sh script.


I'm out of time today to keep testing this, but I'll get back to it next 
week and I'll likely have some more feedback/questions.



-- 
Ryan Eatmon                reatmon@ti.com
-----------------------------------------
Texas Instruments, Inc.  -  LCPD  -  MGTS

