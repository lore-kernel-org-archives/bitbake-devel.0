Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23696C433FE
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 14:23:34 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web12.41094.1639578212860516416
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:23:33 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E7755C0005;
	Wed, 15 Dec 2021 14:23:30 +0000 (UTC)
Cc: YP docs mailing list <docs@lists.yoctoproject.org>,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [docs] Can BB_HASHSERVE still take a 'host:port'
 value?
To: Joshua Watt <JPEWhacker@gmail.com>
References: <9234471a-8cb1-429a-0dd9-6820cdf62616@bootlin.com>
 <CAJdd5GbRMTVhm9rZHOEmX3a-14cZsby_RuAX2SRjhv6cvvAq9w@mail.gmail.com>
 <d19f9e73-929f-d32e-ef57-6e48950c1b20@bootlin.com>
 <CAJdd5GY8fcTyseZ6KfcN+WkFG-WjfpDFEyy=F44UUFFj2C70hA@mail.gmail.com>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
Message-ID: <cd388fff-1b0c-c089-691b-31375eaa8031@bootlin.com>
Date: Wed, 15 Dec 2021 15:23:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: 
 <CAJdd5GY8fcTyseZ6KfcN+WkFG-WjfpDFEyy=F44UUFFj2C70hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Dec 2021 14:23:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13167


On 12/15/21 3:05 PM, Joshua Watt wrote:
>
> "HOST:PORT" and "unix://" are handled by `create_server` in
> bitbake/lib/hashserv/__init__.py


Thanks, that allowed me to find the "parse_address()" that reads these
settings.
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


