Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2036FCD11DD
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:48:19 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.257.1711723692089035044
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=hHYiLQ6F;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A98A3C0009
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/p1ElKmG5jjbKWtEnAWjfsX77jhDljOARi5R1izfuI=;
	b=hHYiLQ6FJCouHzJyt2lF67YfgUdMaM6gFmh0auMZmYDCtKZd2ihgL99NqMNocrPZKB3Vot
	RrtOL6j3oudSoOhEeuwEaF2oxN51Nhr8Xr0q/tO1A6CrRa+nZmgf3hS1RBxsn5eP0uEl/5
	xjAbaHRhSh2VrUsyFQ9H7k8HwEYUN7hrJjuNx6q9W7+7bl4Yt7XlobRz1ttpCUqezJxPWH
	Si36UabhdQd5NfER6dRshXmRrPtrfAi69mqCDBWiTiA9NDADlUzoqHpVekV/iLOlCUsTTb
	+uVEIZtweinm2qon95dDVN39v9/SvzQ8IoCj9e365ZaljN4wnQPW0leb9JfnFQ==
Message-ID: <d9f7b03e-ed50-4796-8605-d6c1c253f4c7@bootlin.com>
Date: Fri, 29 Mar 2024 15:48:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 00/12] prserv: add support for an
 "upstream" server
To: bitbake-devel@lists.openembedded.org
References: <17C14331A9F4EAD6.31455@lists.openembedded.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <17C14331A9F4EAD6.31455@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16035


On 3/29/24 at 15:39, Michael Opdenacker via lists.openembedded.org wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This makes it possible to customize an "upstream" distribution
> by modifying local packages. If the "upstream" package bears
> revision "x", the local one will have revision "x.y", this
> having priority over the upstream one.
>
> Take advantage of this work to clean-up and update the prserv code too.
>
> Michael Opdenacker (12):
>    prserv: simplify the PRServerClient() interface
>    prserv: use double quotes by default
>    bitbake-prserv: replace deprecated optparse by argparse
>    prserv: use self.logger instead of logger directly
>    asyncrpc: include parse_address from hashserv
>    prserv: capitalization and spacing improvements
>    prserv: fix read_only test
>    prserv: add extra requests
>    prserv: remove redundant exception handler
>    prserv: correct error message
>    prserv: remove unnecessary code
>    prserv: add "upstream" server support
>
>   bin/bitbake-prserv        |  99 ++++++++++++-----
>   lib/bb/asyncrpc/client.py |  23 ++++
>   lib/hashserv/__init__.py  |  27 +----
>   lib/prserv/__init__.py    |  21 +++-
>   lib/prserv/client.py      |  42 +++++--
>   lib/prserv/db.py          | 176 ++++++++++++++++++++---------
>   lib/prserv/serv.py        | 228 ++++++++++++++++++++++++++++----------
>   7 files changed, 434 insertions(+), 182 deletions(-)


Note that this code has a remaining issue that appears sometimes.

Even though the revision stored in the database was indeed "0.3", I 
eventually got this package name:
tmp/deploy/ipk/core2-64/hello-dev_1.0-r0.0.30000000000000004_core2-64.ipk

This may be an issue in OE-core, in the way the "0.3" value can be 
treated by default as a float by Python3, and then converted into an 
incorrect string when creating the output package name. Investigating, 
but if you already know where this happens, I'm interested!

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


