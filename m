Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F98C87FD2
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 07:09:08 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.45627.1754550538662029545
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Aug 2025 00:08:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=KFPVJ+97;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8BB7E441D5;
	Thu,  7 Aug 2025 07:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754550536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1X7XaXi5qFOiaxp2qFQPlFC3hxwUVihQc0T3Wuogq84=;
	b=KFPVJ+97mO5LyS6MqeW1T//1wGJmmBEbVp7FO9Q2YWnLVgexgbuZNk+6/+qMF3/ofSWG29
	31eYXPUOLmH8w/jnI012bLIN91p+j7un2pGYAZkctbdEeLg49l9JAlhaKIZpWxIMrr0peP
	6hpGMnE3EZ1uX9NKBvNBc/FPbJE8DLTQk7NfpJVcyHTDd6WrNJkwsHo8dC2/J91snNL22C
	X/mVDB8AIgwyyfFOQldUGUxiZJix+VLZX2NNy42cCB3/xe6Np1Mrb3YPxQY67zbm64pDGK
	JWP78GhHHyHEaVWwc9BsQlAXHGTPrcD2oAI5L75wgDb++ABpU6vuzt0fCMwxFQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Aug 2025 09:08:54 +0200
Message-Id: <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <chris.laplante@agilent.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd'
 arg from check_for_interrupts
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
 <20250806145308.2052128-2-chris.laplante@agilent.com>
In-Reply-To: <20250806145308.2052128-2-chris.laplante@agilent.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevueegvedtueelhfefvddvveeiffehtedvleehgeffffeivdduuefgtedvgfelffenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgvvhgvnhhtrdhfihhrvgdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptghhrhhishdrlhgrphhlrghnthgvsegrghhilhgvnhhtrdgtohhmpdhrtghpthhtohepsghithgsr
 ghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Aug 2025 07:09:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17843

On Wed Aug 6, 2025 at 4:53 PM CEST, Chris Laplante via lists.openembedded.o=
rg wrote:
> From: Chris Laplante <chris.laplante@agilent.com>
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---

Hi Chris,

Thanks for your patches.

It looks like this is breaking several builds on the autobuilder, with
the following error:

Removing 12 recipes from the aarch64 sysroot...ERROR: Execution of event ha=
ndler 'sstate_eventhandler_reachablestamps' failed
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/meta/classes-gl=
obal/sstate.bbclass", line 1301, in sstate_eventhandler_reachablestamps
    bb.event.check_for_interrupts(d)
TypeError: check_for_interrupts() takes 0 positional arguments but 1 was gi=
ven

ERROR: Command execution failed: Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/bb/=
command.py", line 123, in runAsyncCommand
    self.cooker.updateCache()
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/bb/=
cooker.py", line 1653, in updateCache
    bb.event.fire(event, self.databuilder.mcdata[mc])
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/bb/=
event.py", line 232, in fire
    fire_class_handlers(event, d)
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/bb/=
event.py", line 131, in fire_class_handlers
    execute_handler(name, handler, event, d)
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/bb/=
event.py", line 102, in execute_handler
    ret =3D handler(event, d)
  File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/meta/classes-gl=
obal/sstate.bbclass", line 1301, in sstate_eventhandler_reachablestamps
    bb.event.check_for_interrupts(d)
TypeError: check_for_interrupts() takes 0 positional arguments but 1 was gi=
ven

Can you have a look, please?

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


