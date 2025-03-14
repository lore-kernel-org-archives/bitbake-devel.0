Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939E1C282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 08:11:53 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.9032.1741939909169902167
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Mar 2025 01:11:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DB2hTWPf;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DBBE54438B;
	Fri, 14 Mar 2025 08:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741939907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qXkdWpCvJ1CnZw9GDmKEmA+C0HcASUjNqtmS7LglpMY=;
	b=DB2hTWPfPiobH16w6hd/heryTjTcKOgKG05yMV6RuPlOmk2atL61tZGDcIPMzp4vJ9Ddpf
	9eJLMGUOzG7gWseqk+lbGxjDQyeg8ysjAVB4Pthz11S9coRe/OfpU/Naw69w1zx3o670Zc
	fme9CqQn9mQkRX5/9denyyJkvBUO9lqf2gYw15Me22B5UxLd2dkGjWALdBJl7l4dUTqfSh
	sJdJm6akEtJj/LmoZlxczB8g9IYrjiSV8MDAHbu6iIHy+r4o1RywlBzQ27mu//yWAq3buf
	poWCwaEEk6qnoML+PUgNUSoYMUSRGG3+vCFZXozEoxTybBilHIRkgX2bctQfZg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Mar 2025 09:11:45 +0100
Message-Id: <D8FU5TE71SRK.1T7P9QSP59DZG@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ast: Add support for
 BB_RECIPE_VIRTUAL_PROVIDERS
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250121152836.1829193-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250121152836.1829193-1-richard.purdie@linuxfoundation.org>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtteehueeffefhieduudefhfehhefhgeelkeeiheduudeuhedvheejueevgfejvdenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvu
 gguvggurdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Mar 2025 08:11:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17443

Hi,

On Tue Jan 21, 2025 at 4:28 PM CET, Richard Purdie via lists.openembedded.o=
rg wrote:
> Currently, providers are set on a global config basis. This change allows
> for a select set of providers configured in BB_RECIPE_VIRTUAL_PROVIDERS t=
o
> be selected on a per recipe basis. This would allow for the selection of
> virtual/cross-cc as gcc or clang for example in OE-Core.
>
> DEPENDS and task flag [depends] values are processed.

I need to know if I understand this variable correctly (to document it).

I understand this as a list of virtual providers that are _allowed_ be
overridden from a recipe. So the default definition would only allow overri=
ding
the cross compiler / binutils. Correct?

It only makes sense to set this variable globally, right?

Does it make sense to override this variable, or should the default definit=
ion
cover most use cases? I'm trying to think of other use-cases than overridin=
g the
cross compiler / binutils, but don't see any... Not feeling very creative
though. I'm trying to get a sense of the original intent for this variable.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

