Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7DEC83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 06:22:02 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.17241.1751437316942983509
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jul 2025 23:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jtMzDkNw;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74F55443D0;
	Wed,  2 Jul 2025 06:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751437314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FHqX3oGRwQ5/f9YD1hZXYu/I0wQurdRVw0dMyxcHA8=;
	b=jtMzDkNwa5PKcfeEg+zaMkiwjtElc+fODhUwhG2pzUOowKO7mI8Vy7ao9tw355Gzkzdlfp
	gVWUBjPcayU4qos6usBk7wW/C+uFiQgXqQZ5H1xc7bzG7O7BwXCiqxDaryflaKme5iw61t
	kgOD3Mkh/LCo/3jj/C2WkykTdSazIr9AcO4q80xPXIRcNj73HCsbG+5Vt9yllI/Z4eGGDW
	9EyI54VXF9MgM2NGz5NXiecSeW195gJATKZmcE4YycPuGXxAksXC2p0MGoE5SL6LHSrBCW
	SUVJ0IeGidq43OQ+Q/LQpYd2gVGNySQOrNn92wPw+FIDfPaiZ8b8mLeFXyDMXw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Jul 2025 08:21:54 +0200
Message-Id: <DB1CPMFTBKOK.1B0C9LPTCQK1B@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] runqueue: show the current pressure as
 debug messages
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20250701-pressure-messages-v1-1-bebffe123676@bootlin.com>
 <e0ec39370f30659958447e6a5def8d88d3dc4649.camel@linuxfoundation.org>
In-Reply-To: <e0ec39370f30659958447e6a5def8d88d3dc4649.camel@linuxfoundation.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffvufevhfhfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevhffgjeejleetfeehgefhvddvfedvuddtjeegudeuhfdtvdffleejvdfhtdehieenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemkeegvdelmeekudejrgemgedttddumegttdgsvgemugehkegrmeegvdeltdemlegvrgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvleemkedujegrmeegtddtudemtgdtsggvmeguheekrgemgedvledtmeelvggrjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdqu
 ggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 06:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17735

On Tue Jul 1, 2025 at 11:23 PM CEST, Richard Purdie wrote:
> On Tue, 2025-07-01 at 11:53 +0200, Antonin Godard via lists.openembedded.=
org wrote:
>> The current pressure logic only prints pressure information when the
>> limits set by BB_PRESSURE_* variables are exceeded. But in order to
>> determine the best pressure limits for a given host, it can be useful to
>> monitor pressure information after setting BB_PRESSURE_* to the maximum
>> (1000000) and get a sense of how high the pressure can be.
>>=20
>> Add three bb.debug() calls showing that information.
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>> =C2=A0lib/bb/runqueue.py | 3 +++
>> =C2=A01 file changed, 3 insertions(+)
>>=20
>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>> index 80f3d3282f..cae4bfa3e5 100644
>> --- a/lib/bb/runqueue.py
>> +++ b/lib/bb/runqueue.py
>> @@ -206,6 +206,9 @@ class RunQueueScheduler(object):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 cpu_pressure =3D (float(curr_cpu_pressure) - float=
(self.prev_cpu_pressure)) / tdiff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 io_pressure =3D (float(curr_io_pressure) - float(s=
elf.prev_io_pressure)) / tdiff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 memory_pressure =3D (float(curr_memory_pressure) -=
 float(self.prev_memory_pressure)) / tdiff
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current CPU pressure: {cpu_pressure}")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current IO pressure: {io_pressure}")
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.debug(3, f"Current Memory pressure: {memory_pressu=
re}")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_cpu_pressure =3D=C2=A0 self.rq.max_cpu_pre=
ssure and cpu_pressure > self.rq.max_cpu_pressure
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_io_pressure =3D=C2=A0 self.rq.max_io_press=
ure and io_pressure > self.rq.max_io_pressure
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 exceeds_memory_pressure =3D=C2=A0 self.rq.max_memo=
ry_pressure and memory_pressure > self.rq.max_memory_pressure
>>=20
>
> I'm torn on this, debug messages aren't without their overhead even if
> not printed. How often do these end up outputted? If nothing else there
> should be one bb.debug call and not 3...

Actually, quite a lot, so I should reduce this to one call, or find out a w=
ay to
reduce the amount of messages printed.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


