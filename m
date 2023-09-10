Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFCC71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 20:50:32 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 by mx.groups.io with SMTP id smtpd.web10.44579.1694379030262207574
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 13:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=KTJ1nFMc;
 spf=pass (domain: ti.com, ip: 198.47.19.142, mailfrom: rs@ti.com)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38AKoNKB030587;
	Sun, 10 Sep 2023 15:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694379023;
	bh=1QWbZSqnTP7hRmUmusLiQwHlIOWKoxaYwG/E/LMgIuk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KTJ1nFMctoL4GEPvrnO5y1ONXznS3HxVdRvkVZ44JaPM3JlycCDG9P3EaB5B5g1+Q
	 6qp53CNtDtNsISIUcuOhqiO+l7F7ZTGv9BlHef8pwLrS3UcwIHxwx3u2PnQ1h4n1iw
	 AqmxgHQM0bIubl19qfu4eZsQqu3eKwl5rtflt4q8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38AKoN9w084768
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Sep 2023 15:50:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 15:50:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 15:50:23 -0500
Received: from [128.247.81.144] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38AKoM7F073086;
	Sun, 10 Sep 2023 15:50:22 -0500
Message-ID: <ede700bf-05f0-4e23-b173-ba2df6de2603@ti.com>
Date: Sun, 10 Sep 2023 15:50:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2] bitbake-worker: remove the network flag
Content-Language: en-US, en-US-large
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>, <denis@denix.org>,
        <reatmon@ti.com>
References: <20230910194648.942409-2-rs@ti.com>
 <72eaf44b3c86582c73a9cf76ccba2378a0e83c6c.camel@linuxfoundation.org>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <72eaf44b3c86582c73a9cf76ccba2378a0e83c6c.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 20:50:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15029

On 9/10/23 15:17, Richard Purdie wrote:
> On Sun, 2023-09-10 at 14:46 -0500, rs@ti.com wrote:
>> What I feel would be the proper solution to the aforementioned issues.
>>
>> Examples of layers that currently use the network flag outside of the do_fetch
>> stage:
>>
>> 	oe-core (icecc.bbclass)
>> 	meta-openembedded (go recipes)
>> 	meta-flutter (all flutter recipes and classes)
>>
>> This is not an attempt to shame maintainers. I'm just curious why the network
>> task expects every maintainer to handle proxy variables (something pretty much
>> required if you are actually using the network in that task) independently. It
>> just results in needless debugging and a bunch of patches attempting to export
>> variables in their own way. Sorry if this comes off as antagonistic in any way.
> 
> You are doing yourself no favours at all by posting this patch again.
> My instinctive reaction would be to filter all your mails to /dev/null
> from now on.
> 
> You have to keep in mind that bitbake/OE allow you to do pretty much
> anything from metadata so it is hard to put boundaries and any that we
> do put in place can and will get bypassed. We've gone backwards and
> forwards on these issues for a long time.
> 
> The "Yocto Project Compatible" status was born out of a desire to at
> least make it possible to highlight layers doing things which could be
> considered anti-social. We haven't quite caught up with network
> enable/disable there yet but we should and likely will (please file a
> bug for that). Sadly the work in maintaining that standard is more
> complex than people realise, e.g. a new revision of the criteria has
> been held up by a YP website refresh for over a year <snip long painful
> story> :(.
> 
> We added the network flag since before that, code was doing pretty much
> what it wanted anywhere. We now at least can tell exactly where the
> accesses are being enabled, which is a start to fixing some of these
> issues.
> 
> icecc in OE-Core enables it since by its very nature, distributed
> compiling needs the network. It is unlikely to need/want proxy info
> though as it will likely be local network only.
> 
> go needs someone to work on the fetcher side of things for it. We've
> solutions with rust/crates which might help provide a model for how
> that could work in the future. For better or worse, someone does need
> to spend time on it.
> 
> I've no experience with flutter to comment there. I will note that most
> of these "new" things start with basics and things like proxy support
> have to follow later as they're not top of people's minds when they're
> trying to get anything working.
> 
> I am frustrated in general about a great many areas of the project
> where things don't get "completed" to the level everyone would like.
> Over time we do have a good track record of sorting them out though, I
> just wish people could work on them proactively rather than reactively.
> We do have some proactive work happening at least for the first time in
> a while with the RFQs.
> 
> I do understand your frustration but I think you need to work out a
> more productive way to move forward. The network flag did at least let
> us mark up and know where the issues are so in that sense we did
> improve on what went before.
> 
> Cheers,
> 
> Richard

Hey Richard,

Thanks for the background. I won't push this issue anymore. The current 
method does seem to be pretty good at passively catching offending tasks.

Distributed compiling itself is an interesting cornercase to both this 
patch and my previous proxy related one that shows that the current 
approach is reasonable and doesn't necessarily warrant either of these 
changes.

Sorry to bother you all on a Sunday.

Regards,
Randolph

