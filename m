Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DDBC369B4
	for <webhook@archiver.kernel.org>; Tue, 15 Apr 2025 11:52:13 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.17966.1744717927882159732
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Apr 2025 04:52:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Cd+WF10t;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94BBC1FCEE;
	Tue, 15 Apr 2025 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744717926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VWDK/h88AkJcHZ2UBcC818TChhRonkUN9njRisjfs8=;
	b=Cd+WF10tJzOS7ULkqHSQGwMuJIrC/iG6U3c4uJEa2Ftw5TYKmXdiBWJ2CRuv4mFa5EwEue
	wdL1Y6Cmefs93tv3X0fIun6T0SgceVXFBGv5kltOL0rhSxxNa2Gm3gXBvXIwF7BWiB8ZOI
	aozeM+vor0zkPke6ysDIT2WbFvIwiXaf6vavkKyeRtrbXBCNkqWNj7VdbzGhv3/w/NoDiX
	DE4RqVrlXDG1n7I2YakGcXtDaqvYVgwSJB0qbLKPLZj13z/U3d3PR5r2ZtTLbqwtCa/y1u
	kXvj63OKtSwwLP9POR1y52/TPRg2No11KP3noCgFMnZTm9MWTXpazy/8VKuLTw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Apr 2025 13:52:05 +0200
Message-Id: <D976VXV65RT6.1ZHT2MCAP4QL1@bootlin.com>
Subject: Re: [docs] [PATCH 1/2] runqueue: decrease the verbosity of pressure
 messages
Cc: <bitbake-devel@lists.openembedded.org>, <docs@lists.yoctoproject.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Martin Jansa" <martin.jansa@gmail.com>
X-Mailer: aerc 0.20.1-57-gc9a57f76bf52-dirty
References: <20250411-bb-pressure-improvements-v1-0-7d9e3593167f@bootlin.com> <20250411-bb-pressure-improvements-v1-1-7d9e3593167f@bootlin.com> <CA+chaQeXK2pbaNWaYvDVzMhu=eZLpFLB9zeeaGDA7oLDJnaG3A@mail.gmail.com>
In-Reply-To: <CA+chaQeXK2pbaNWaYvDVzMhu=eZLpFLB9zeeaGDA7oLDJnaG3A@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefgeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehvdeuteegkeetgfejtdfhfffhjeduhfetudegffdvteejheffieetudfhheffkeenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemiegsleelmegvfhehgeemvddtrgefmeeifhegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemiegsleelmegvfhehgeemvddtrgefmeeifhegvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepmhgrrhhtihhnrdhjrghnshgrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdro
 hhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Apr 2025 11:52:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17530

Hi Martin,

On Fri Apr 11, 2025 at 9:09 PM CEST, Martin Jansa wrote:
> On Fri, Apr 11, 2025 at 4:46=E2=80=AFPM Antonin Godard via
> lists.yoctoproject.org
> <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
>>
>> By default all the pressure changes are printed on the console and
>> generate a lot of spam to users using the BB_PRESSURE_* variables.
>> Decrease the default verbosity to bb.debug (level 1, so can be seen with
>> -D).
>
> Isn't "a lot of these messages" a proof that the BB_PRESSURE_*
> variables aren't set correctly?
>
> I find them quite useful and using -D by default in my builds would
> bring even "more spam". But in worse case I'll just revert this for my
> builds.

I see how these messages can be useful.

To my understanding, having a low value for BB_PRESSURE_* variables will
generate a lot of these messages. To me, it does not necessarily mean that =
the
value isn't properly set, it just means that you want to limit the pressure=
 a
lot.

Maybe the default behavior of printing everything is good for adjustments, =
I
just think it'd be convenient for user to have a way to disable those once =
they
are happy with their pressure configuration.

I thought first of a BB_PRESSURE_VERBOSE or BB_PRESSURE_QUIET variable. It
would just allow enabling/disabling these messages. But on second thought, =
I'm
not sure an extra variable is necessary when we could just move these messa=
ges
to debug messages. Other variables that limit the load do not generate such
"spam" (take BB_LOADFACTOR_MAX for example).

What do you think?

Antonin

--
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

