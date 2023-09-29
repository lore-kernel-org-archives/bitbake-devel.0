Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE78E743EE
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 06:33:44 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.11982.1695969219356008927
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Sep 2023 23:33:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bRDZ/Lbi;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C2855240006;
	Fri, 29 Sep 2023 06:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695969217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xo3ynS8Kt2qWY1KhpnHOVbE6EsZNK9ZDdrgkR0JfdGA=;
	b=bRDZ/Lbick23KPZIukiPDXd/bn66qdIgWlwGOReMLX+zG20QZNXNP9i+StqTSujFO7lENA
	VhOJ5VPCGmxIXtkEmy7VdGYKGmDAnYyrbDZ0lB5IiN0ZA28uMwplbbKeDroXU+dS6rUwSS
	OJOAYz5agpki36C7yNP45nertgsorKbIH84hxArdFBrDvPvTwJqxGUw8xGSUmZHG9Ib2lK
	1nZ7y5YWAENyTkBq0335k6cyXFJmO84zkpw0W727qGAJQqjHU1BuOS8SAvAxts+W9Qj7QW
	T5hS0ONX+WvaDnFWjnRJEztd2Mbuw1x0VQgdKYGHn3bKUgJPdZ73wEuBoBKfLw==
Date: Fri, 29 Sep 2023 08:33:36 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][RFC 0/5] Bitbake Hash Server WebSockets
 Implementation
Message-ID: <20230929063336632d758d@mail.local>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928170551.4193224-1-JPEWhacker@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Sep 2023 06:33:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15148

Hi Joshua,

I was curious and gave it a shot, this seems to break prserv:

https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/5820/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/2170/steps/15/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/5828/steps/15/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5845/steps/14/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5779/steps/14/logs/stdio

On 28/09/2023 11:05:46-0600, Joshua Watt wrote:
> This patch series implements a websockets transport protocol for the
> bitbake hash equivalence client. Note that while this uses the
> websockets 3rd party python module, its use should only be actually
> required if the user wants to use the websocket transport mechanism.
> 
> A websocket implementation is not added on the server side, as it is not
> desired to add the websocket dependency there. In addition, there are
> other server improvements that are desired, such as the ability to use
> different database backends which also require other python modules. As
> such, the websockets client can be test with the websocket hash
> equivalence server implemented here:
> https://github.com/JoshuaWatt/bb-hashserver
> 
> Joshua Watt (5):
>   asyncrpc: Abstract client socket
>   hashserv: Add remove API
>   bitbake-hashclient: Add remove subcommand
>   hashserv: tests: Add external database tests
>   hashserv: Add websocket connection implementation
> 
>  bitbake/bin/bitbake-hashclient    |  13 +++
>  bitbake/lib/bb/asyncrpc/client.py | 173 ++++++++++++++++++++----------
>  bitbake/lib/hashserv/__init__.py  |   9 ++
>  bitbake/lib/hashserv/client.py    |  30 +++---
>  bitbake/lib/hashserv/server.py    |  29 +++++
>  bitbake/lib/hashserv/tests.py     |  82 ++++++++++++--
>  bitbake/lib/prserv/client.py      |   8 +-
>  7 files changed, 262 insertions(+), 82 deletions(-)
> 
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15142): https://lists.openembedded.org/g/bitbake-devel/message/15142
> Mute This Topic: https://lists.openembedded.org/mt/101641857/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

