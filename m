Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580E7C87FD2
	for <webhook@archiver.kernel.org>; Thu,  7 Aug 2025 07:10:48 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.45358.1754550645049374431
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Aug 2025 00:10:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=MSYCYZsF;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB99544283;
	Thu,  7 Aug 2025 07:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754550643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsieBLh2VTo3oJxWmsLodJIxqC7R2t5LaL18IZBLG1E=;
	b=MSYCYZsFsCTv2FgsaXMNSGrXWRIcoKLQ/Rt/kf467ik7wftH7VhfZHMKOEtq4LxfY/alrB
	cSJR6fTfFwQpcexBzEkyBD0fXWi2DAzUXWo1AzoQ2ljCfALGVqZwufwvX3JhXm4kYieg4s
	lVpEoqJtllMRLryCuHc8D6bcFHI6vWPW7r7oECxC11kkwD7cqC3exSNfQOm+LUj4qB/zWf
	9zpR4DhRmVwH4UfQiBHRNtRF8BgrZKyacLajA1iEryiwW17YjWyqocdLxAonD79N1dwMkT
	ng6nFDBw1C36s8eivi6v37Le/A0wr5A+akTxj0/XS0nQoeDliL3Vmbz4Y7ZUXQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Aug 2025 09:10:41 +0200
Message-Id: <DBW0AL5OM8CZ.1J05XYFYPMZ20@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] event/runqueue: remove unused 'd'
 arg from check_for_interrupts
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <chris.laplante@agilent.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250806145308.2052128-1-chris.laplante@agilent.com>
 <20250806145308.2052128-2-chris.laplante@agilent.com>
 <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
In-Reply-To: <DBW0984EY1IE.31I0NJ43GU7N7@bootlin.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtvdeuffehvdetfeelgfevgfdtieffvdekgeeukeeflefhueelkeevtdfhffffjeenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgvvhgvnhhtrdhfihhrvgdphihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthhhrihhsrdhlrghplhgrnhhtvgesrghgihhlvghnt
 hdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Aug 2025 07:10:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17844

On Thu Aug 7, 2025 at 9:08 AM CEST, Mathieu Dubois-Briand wrote:
> On Wed Aug 6, 2025 at 4:53 PM CEST, Chris Laplante via lists.openembedded=
.org wrote:
>> From: Chris Laplante <chris.laplante@agilent.com>
>>
>> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
>> ---
>
> Hi Chris,
>
> Thanks for your patches.
>
> It looks like this is breaking several builds on the autobuilder, with
> the following error:
>
> Removing 12 recipes from the aarch64 sysroot...ERROR: Execution of event =
handler 'sstate_eventhandler_reachablestamps' failed
> Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/meta/classes-=
global/sstate.bbclass", line 1301, in sstate_eventhandler_reachablestamps
>     bb.event.check_for_interrupts(d)
> TypeError: check_for_interrupts() takes 0 positional arguments but 1 was =
given
>
> ERROR: Command execution failed: Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/b=
b/command.py", line 123, in runAsyncCommand
>     self.cooker.updateCache()
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/b=
b/cooker.py", line 1653, in updateCache
>     bb.event.fire(event, self.databuilder.mcdata[mc])
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/b=
b/event.py", line 232, in fire
>     fire_class_handlers(event, d)
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/b=
b/event.py", line 131, in fire_class_handlers
>     execute_handler(name, handler, event, d)
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/bitbake/lib/b=
b/event.py", line 102, in execute_handler
>     ret =3D handler(event, d)
>   File "/srv/pokybuild/yocto-worker/qemuarm64-armhost/build/meta/classes-=
global/sstate.bbclass", line 1301, in sstate_eventhandler_reachablestamps
>     bb.event.check_for_interrupts(d)
> TypeError: check_for_interrupts() takes 0 positional arguments but 1 was =
given
>
> Can you have a look, please?
>
> Best regards,
> Mathieu

Sorry, I forgot to add some build links:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/8/builds/2200
https://autobuilder.yoctoproject.org/valkyrie/#/builders/16/builds/2201
https://autobuilder.yoctoproject.org/valkyrie/#/builders/36/builds/2171
https://autobuilder.yoctoproject.org/valkyrie/#/builders/68/builds/2238

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


