Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2B9C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:35:45 +0000 (UTC)
Received: from esa7.hc324-48.eu.iphmx.com (esa7.hc324-48.eu.iphmx.com [207.54.71.126])
 by mx.groups.io with SMTP id smtpd.web11.13471.1745915735803375230
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Apr 2025 01:35:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=a2mbgAb+;
 spf=pass (domain: bmw.de, ip: 207.54.71.126, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745915735; x=1777451735;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQvz7LDjNvZk2tkkL9KVWtQDuYWE61hHUo8U0gUD5uY=;
  b=a2mbgAb+c6LBARaPahBqz2hwAmxtBzQhsZQYmZKAPRnciEq4MK5KIrZz
   rfG0x7ABgJaG8TjHAsYHz155E1Os5n+Eut+WfPvLoV4maAkQdAgQFDCJr
   GpnY7U/l2giYIg+Oi49m2zPqOQQqLOLSGaWs/2K75snk9500531JgEtAB
   4=;
X-CSE-ConnectionGUID: tBAS5+sfSuGFnHwQkf7+Ow==
X-CSE-MsgGUID: g8Tj7q1fTiGRddIMPlWIgw==
Received: from 160.46.252.39.spf.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 10:35:34 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw4.muc with ESMTP/TLS;
 29 Apr 2025 10:35:34 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 29 Apr 2025 10:35:34 +0200
Received: from [10.242.8.29] (10.30.85.202) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 10:35:33 +0200
X-CSE-ConnectionGUID: vtIM+czoS7COA/VzLUBqsg==
X-CSE-MsgGUID: vMLAvofsRuG76I2494ZgJQ==
X-CSE-ConnectionGUID: m3IX/485Sf6qaITz5Impvg==
X-CSE-MsgGUID: pXxyloCHRf6v/b84eUCBZQ==
Message-ID: <e344292c-b500-4fcb-8e98-e7cd455c1bf1@bmw.de>
Date: Tue, 29 Apr 2025 10:35:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
To: "Marko, Peter" <Peter.Marko@siemens.com>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <20250425101155.2905972-1-philip.lorenz@bmw.de>
 <522a15ccc1ed1597a5a6b92803536484a3f008a4.camel@linuxfoundation.org>
 <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <AS1PR10MB569750ACF9183A75F2389811FD842@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: smucmp18e.europe.bmw.corp (2a03:1e80:a15:58f::1:75) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 08:35:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17591

Hi Peter, hi Richard,

On 25.04.25 14:45, Marko, Peter wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-
>> devel@lists.openembedded.org> On Behalf Of Richard Purdie via
>> lists.openembedded.org
>> Sent: Friday, April 25, 2025 14:36
>> To: philip.lorenz@bmw.de; bitbake-devel@lists.openembedded.org
>> Cc: mathieu.dubois-briand@bootlin.com
>> Subject: Re: [bitbake-devel] [PATCH v2 0/8] Fix gitsm LFS support
>>
>> On Fri, 2025-04-25 at 12:11 +0200, Philip Lorenz via lists.openembedded.org
>> wrote:
>>> This patch series fixes a number of issues we observed when using the
>>> gitsm fetcher in conjunction with git-lfs.
>>>
>>> I'd like to highlight two patches in this series:
>>> * 0004-fetch2-Simplify-git-LFS-detection: I could not come up with a
>>>    good reason on why the code so far preferred the content of
>>>   `.gitattributes` on the repository's branch instead of always
>>>    considering the state of the target revision. Please let me know
>>>    if there's something I didn't take into account.
>>> * 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I could not
>>>    replicate the `git-lfs fetch` behaviour in versions going back to
>>>    2.13.2 released in 2021. This leads me to believe that the issue
>>>    leading to this workaround is no longer in place. However, if anyone
>>>    remembers the actual issue / versions involved I can also retest to
>>>    confirm that there are no regression.
>>>
>>> ---
>>> V1 -> V2:
>>> * The correct parameter is now passed for each submodule URL when LFS is
>>>    explicitly disabled
>>> * Smudging for submodules is now skipped when LFS is explcitly disabled.
>>>    This ensures consistent behaviour in setups where git-lfs is installed
>>>    but should not be used.
>>> * Test cases are extended to test the LFS disabled state.
>>> * Explicitly install git lfs into submodule in the test cases to make
>>>    sure that git-lfs is actually used for storing the files.
>>>
>>> Philip Lorenz (8):
>>>    fetch2: Clean up no longer used name parameter
>>>    tests/fetch: Move commonly used imports to top
>>>    fetch2: Check for git-lfs existence before using it
>>>    fetch2: Simplify git LFS detection
>>>    fetch2: Use git-lfs fetch to download objects
>>>    fetch2: Fix incorrect lfs parametrization for submodules
>>>    fetch2: Fix LFS object checkout in submodules
>>>    tests/fetch: Test gitsm with LFS
>>>
>>>   lib/bb/fetch2/git.py   |  69 ++++++----------
>>>   lib/bb/fetch2/gitsm.py |  13 ++-
>>>   lib/bb/tests/fetch.py  | 183 ++++++++++++++++++++++++++++++-----------
>>>   3 files changed, 163 insertions(+), 102 deletions(-)
>> With this series applied, OE-Core throws a lot of errors, see below.
>> I'm not convinced we have that much LFS use so something seems wrong...
>>
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1465/steps/13/log
>> s/stdio
> I think what is wrong is the default for lfs (enabled).
> It badly chosen default if lfs is not a requirement and whole core builds without it.
>
> Adding additional commit to switch lfs default to disabled should solve it.
> I think it will not break the core itself as until now it built successfully without git-lfs installed, but migration note will be needed for the custom layers.

I'd actually like to come back to this suggestion as I noticed some 
conceptual issues with the existing implementation of LFS support. As of 
now, the implementation assumes that the presence of a lfs filter in 
.gitattributes means that the repository uses LFS. However, this 
assumption does not necessarily hold as the filters are *not* required 
for a repository to contain LFS objects (it is merely a convenience 
method to ensure that files matching a certain pattern automatically get 
handled by LFS).

One example of this is the Vulkan-Samples-Assets repository [1] (fetched 
via vulkan-samples.bb) which does not have a .gitattributes file but 
does contain files (e.g. [2]) managed by LFS. This is not an issue as 
the vulkan-samples recipe explicitly disables LFS but may affect other 
recipes referencing repositories with a similar setup.

As such I actually believe that changing the lfs parameter default value 
to off would be the sensible thing to do. Recipes dealing with LFS 
content can  then explicitly opt in and opting in implies that git-lfs 
must be available and the .gitattributes check is no longer needed and 
can be dropped.

Does that sound sensible? If so I can fix things up in a future patch 
series (together with a migration note).

Philip

[1] 
https://github.com/KhronosGroup/Vulkan-Samples-Assets/tree/8db8ce9c528330f0b1261b07531b009732b08731
[2] 
https://github.com/KhronosGroup/Vulkan-Samples-Assets/blob/8db8ce9c528330f0b1261b07531b009732b08731/scenes/morpheus_team/lego_ball_phone/shape0.obj

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Michael Böttrich ,Chris Brandt, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


