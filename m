Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E38C369AB
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 07:10:22 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.9598.1745478617866465199
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Apr 2025 00:10:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=NUcr8h9c;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D138D43A4F;
	Thu, 24 Apr 2025 07:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745478616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=av+f3/NRZFGMQEXh45d/oYERdQuaSj+0ULpnJd2EXR4=;
	b=NUcr8h9c0Wf53IyA5h9KM909cBUvKZ9v8vb/5yh2zhbT9vcu7j3F9NUXHe1b1Nf2X8qVuK
	Q54yd7Cq+cB9UnwwgK+Wrq3uOYfb94a7FOEznOuBvoNLIAaSzUrcViW8/GQoSf8aIX8yGW
	lDUvnWlvmqgeCsAfKW7dClC2MvVkjOhKZ6J6hvlirxZi/Nj4I7jZGFS8xz2DErwiLEV8QH
	3bHeA5StPVNB8S44Mp47XGkFgTjoWCTPSunYiwgTm1p+8RHMudouP6JpGDWQsvtZhlahtW
	z612oLq0MWijc+tWRljjbbJAHIprZ5xz7jjUT0bpZmKDO0pEwkja1lb2sLAZwQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Apr 2025 09:10:15 +0200
Message-Id: <D9EOJ22QSMAC.3LNDP3MSMSGCG@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 3/8] fetch2: Check for git-lfs existence
 before using it
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <philip.lorenz@bmw.de>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250423151901.1300944-1-philip.lorenz@bmw.de>
 <20250423151901.1300944-4-philip.lorenz@bmw.de>
In-Reply-To: <20250423151901.1300944-4-philip.lorenz@bmw.de>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeekkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehffellefgveekfeegheejiedutedukeffkeduvdevvddtgefgffffveefgfdvudenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddprhgtphhtthhopehphhhilhhiphdrlhhorhgvnhiisegsmhifrdguvgdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhop
 hgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Apr 2025 07:10:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17551

On Wed Apr 23, 2025 at 5:18 PM CEST, Philip Lorenz via lists.openembedded.o=
rg wrote:
> So far, existence of `git-lfs` was only checked during unpacking. As the
> binary is also used in earlier steps also check for its existence there.
>
> Additionally, factor out the LFS existence check into a dedicated
> function and call it wherever git-lfs is used for the first time.
>
> Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
> ---

Hi Philip,

Thanks for your patch.

I was not able to test this series on the autobuilder so far, as I
believe git-lfs is not installed in there. Now maybe this has to be a
new requirement on the host and maybe this is fine. Just two points:
- Is that really a new requirement and is it needed?
- We probably need to update a bit of documentation about that.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


