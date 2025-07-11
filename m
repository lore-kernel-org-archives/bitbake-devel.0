Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE83C83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 08:22:46 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.9013.1752222163552697710
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Jul 2025 01:22:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fnXtksbj;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4420943190;
	Fri, 11 Jul 2025 08:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752222161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtjGE4cMu3d0yqNrR51dXhPq5DsAj904RYHr2ZmZEOQ=;
	b=fnXtksbjb52oLAWU8XUgPLHSCbQOPd2rbGxv2hF3In+xrX6xa0YcFrYGNo/kHwH79fQFml
	Q3EJ/1PYMlhiX01T3BT4OzxJasRIsgjP2wx8sWYcgCkKvVevdjSsjNe/M1VKedzf/EXmmV
	4B1Xo3m0bCCCWWsv6bHgIt5KFjqFZpujDiqz73t6KgPr9+deK2q/rvASjhNV1gmELUURhL
	6FWkZfOTqKv3IbXBt3FHituipJmtkSX5kRq4L5hrce6hCBR4d4HuhILEVfB1Qd1Yelf2K/
	tm7OdJazzNwN5UHRFCHaceo/uFOV/jgXqvDgkxMaM+LajtMpIHA6H6LEBSYBDQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 10:22:40 +0200
Message-Id: <DB92X01O2IQ7.1JESQFE4X5RQO@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: clarify significance of
 "include_all" directive
Cc: "BitBake developer list" <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, "YP docs mailing list"
 <docs@lists.yoctoproject.org>
References: <f7199bf7-9b0c-9218-1a8d-15f8a83bc869@crashcourse.ca>
In-Reply-To: <f7199bf7-9b0c-9218-1a8d-15f8a83bc869@crashcourse.ca>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdekfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvfhfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffheekueetteekueefjeejveevuddutdfgueetieevkeejgeejgeetueevkeefudenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehrphhjuggrhiestghrrghshhgtohhurhhsvgdrtggrpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrk
 hgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Jul 2025 08:22:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17767

Hi,

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


