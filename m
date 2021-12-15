Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601CC4332F
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 14:02:54 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web12.40822.1639576972875835898
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:02:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AFBF740007;
	Wed, 15 Dec 2021 14:02:50 +0000 (UTC)
Cc: michael.opdenacker@bootlin.com,
 YP docs mailing list <docs@lists.yoctoproject.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] Question about "hash-equivalence passthrough to the
 matching server"
To: Joshua Watt <JPEWhacker@gmail.com>
References: <83a56ef9-711e-a804-ed49-f64d864252a8@bootlin.com>
 <CAJdd5GYdSL=y7iRJwyC0Cf8Cjie5r+2k4=MTZQyo0oYA_O_QOA@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <9dc18b54-19a2-1087-81ff-68f31a5ea591@bootlin.com>
Date: Wed, 15 Dec 2021 15:02:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <CAJdd5GYdSL=y7iRJwyC0Cf8Cjie5r+2k4=MTZQyo0oYA_O_QOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Dec 2021 14:02:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13165

Hi Joshua

On 12/14/21 10:53 PM, Joshua Watt wrote:
> On Tue, Dec 14, 2021 at 3:01 PM Michael Opdenacker
> <michael.opdenacker@bootlin.com> wrote:
>> Greetings,
>>
>> I'd need clarification about this section in Poky's
>> meta-poky/conf/local.conf.sample file:
>>
>> # Yocto Project SState Mirror
>> #
>> # The Yocto Project has prebuilt artefacts available for its releases,
>> you can enable
>> # use of these by uncommenting the following lines. This will mean the
>> build uses
>> # the network to check for artefacts at the start of builds, which does
>> slow it down
>> # equally, it will also speed up the builds by not having to build
>> things if they are
>> # present in the cache. It assumes you can download something faster
>> than you can build it
>> # which will depend on your network.
>> # Note: For this to work you also need hash-equivalence passthrough to
>> the matching server
>> #
>> #BB_HASHSERVE_UPSTREAM = "typhoon.yocto.io:8687"
>> #SSTATE_MIRRORS ?= "file://.*
>> http://sstate.yoctoproject.org/3.4/PATH;downloadfilename=PATH"
>>
>> How to set enable "hash-equivalence passthrough"?
>> I haven't managed to find details in the source code yet...
> You need to configure it for the hash server you are using. If you are
> running locally (e.g. BB_HASHSERV = "auto"), then
> BB_HASHSERVE_UPSTREAM will set the upstream. If you are running a
> standalone hash server, you specify the upstream as a command line
> argument when you start the server


Thanks for the details. I'll update the documentation to explain this.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


