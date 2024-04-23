Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFE1C4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 12:26:52 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.17158.1713875210458394226
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 05:26:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LBchJpVW;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C6B8240014;
	Tue, 23 Apr 2024 12:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713875208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bkrc9ocP2Z6Ancp3feCNPZqk9wUw9ydw78Q/nFIlSl0=;
	b=LBchJpVWO6GtznRMokkRuXMhAdEwn6gobuIsHZcShHRUjaxI5jo7IkmMEzAKpDxqr3Ti6j
	lCXtq/SiGMZJOsApSL4d3LI+HJyaiaS76dxsRWAFlml8A98gniumTs8v46xtuKgpM9lRyZ
	WfQJnII5Fv6cr4PBUVBS2SJ4MaD9J6KslvXsYquSLvE9w9h8s7e/qu2173gNeEHOzuSYXI
	U8FJgaSREhtMaWe50yyCmEgbk30sb2UhRan8ojzXISSXlorjR3mMuVxu6nmGc+DCnAy3Xz
	vB29a01VTXI5IBRYJXGwmAKa/+VpRyAzaM5ek6cx7tdDZqRZ7j3MDajwoDrZvw==
Message-ID: <9bf63d8d-2750-4ee2-ad3d-67fbb029d61c@bootlin.com>
Date: Tue, 23 Apr 2024 14:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tim Orling <ticotimo@gmail.com>
Subject: Re: [RFC][PATCH 2/3] prserv: add "history" argument to "get-pr"
 request
To: Joshua Watt <jpewhacker@gmail.com>
References: <20240416171945.3799445-1-michael.opdenacker@bootlin.com>
 <20240416171945.3799445-3-michael.opdenacker@bootlin.com>
 <CAJdd5GaYY4+jp34H+_BJ2gACA0eg5nog34JdDfy9nnhKVJRkGg@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <CAJdd5GaYY4+jp34H+_BJ2gACA0eg5nog34JdDfy9nnhKVJRkGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 12:26:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16130

Hi Joshua

On 4/20/24 at 22:45, Joshua Watt wrote:
> On Tue, Apr 16, 2024 at 12:20 PM <michael.opdenacker@bootlin.com> wrote:
>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>
>> This makes it possible to test the "history" mode in the
>> future bitbake selftests, to make sure that both "history"
>> and "no history" modes work as expected.
> Is this useful in normal day-to-day usage? I don't generally like to
> add functionality just for testing if it can be helped, as the closer
> you can get to actual end user API calls, the better it covers the end
> user experience.
>
> It looks like PRData has an (unused) argument to enable history mode?
> If this is unused do we even actually care about it at all? Maybe it
> would be better to remove an unused feature than try to test it?

One version of my series actually removed that feature, but then Richard 
asked me to keep the code, because of the usefulness of the "history" 
mode for binary reproducibility. This way, we always generate the same 
package and revision if we have the same output hash as in a prior 
build. That's different from the default behavior that increases the 
revision every time we have a new output hash.

This being said, supporting both modes added substantial complexity to 
the code, and I wish I had more time to consolidate all this and reduce 
as much redundancy as possible between modes.

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


