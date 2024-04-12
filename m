Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F9C4345F
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 12:36:34 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.45282.1712925386787719467
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 05:36:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XJx1SC/v;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0B4EE0006;
	Fri, 12 Apr 2024 12:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712925385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQJziP/zFOaCOfiwdBs9xZs1amNV19tMwsDsVFW53G8=;
	b=XJx1SC/vIRBJzg3eoP23QPnyzFEM5yl8oTiWB7XqDhvBu/cS02KevHV7/cgCd9BAxLHB9X
	pyS0wOsjTPA/bjDyrCk0atWsuX7/zcEPiwxtsUAX0JD5z3liIrHd4fzoJXo9GqSR/y6x1k
	ym+kMYpEuaXATirTFg7UwQkzoO0pu1xfBIk76zqJT3061TJgkksO75W6Etm1qxfHavteCF
	loaUohcOKpm2vjSTmHBQPcxs5Vf4lDxfkMynxAnpx/A15qFUPeJmZ8V7M0SYsjw+u+lKs3
	1cpwCbKMSRHbktCQAN5kbV3dVdfb8cDetc+M0QZcQmMm3+wLmrz3BfsOA30IWw==
Message-ID: <f268475a-22d8-4346-a4be-45054c126a7a@bootlin.com>
Date: Fri, 12 Apr 2024 14:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com
Subject: Re: [bitbake-devel] [PATCH 00/12] prserv: add support for an
 "upstream" server
To: bitbake-devel@lists.openembedded.org
References: <17C57CE7C760AD01.4467@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C57CE7C760AD01.4467@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 12:36:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16088

Greetings,

On 4/12/24 at 11:02, Michael Opdenacker via lists.openembedded.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This makes it possible to customize an "upstream" distribution
> by modifying local packages. If the "upstream" package bears
> revision "x", the local one will have revision "x.y", this
> having priority over the upstream one.
>
> Multiple levels of upstream servers are supported, so "x.y.z" revisions
> are possible too.
>
> Take advantage of this work to clean-up and update the prserv code too.
>
> Manual "sanity" tests have been run so far but automated tests
> (based on Python unittest, as for the hash server tests)
> are being prepared for the next iteration. They will also to
> test also supported scenarios.
>
> Code reviews are welcome, especially for more Pythonic
> ways of implementing some details.
>
> ---
>
> Changes in V3:
>
> - Revert the commit removing the so far unused "hist" mode, which
>    we wish to keep for binary reproducibility sake.
>
> - Simplification of get_value() function to take
>    both "hist" and "nohist" modes with the same shared code.
>
> - Add "history" parameter to the "getPR" request,
>    so that the client can ask for the mode of its choice.
>    This will also make it possible to implement tests
>    for both modes.
>
>    Note that more requests ("export", "import"...)
>    will also need a "history" parameter, in a future version,
>    after the first tests are implemented.
>
> - Several fixes to bugs either present in V2 or introduced
>    by the V3 code changes.
>
> - Put all the new features at the tip of the branch,
>    to make the cleanup commits easier to merged.


This is obviously a V3, even if I forgot to add the "v3" prefix :-I

Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


