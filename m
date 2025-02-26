Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE14C021BC
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 08:39:19 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.1749.1740559154402689764
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 00:39:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Rrf/EQjc;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D47044445;
	Wed, 26 Feb 2025 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740559152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1KdDMnKJQZffa/ld79G8xRGJJslBfuOgpfWCMH8mIM=;
	b=Rrf/EQjcbkaDUk6yUd2M//aiqcixe0b/uV3v1KmLgWnfOC60+xFjiGruroacrIwH/FIIgj
	UAnPkmIH7jaa7ZUvEyi+Sx1rg9t1bgWtLLtDYUPWOhB+/frdXcc4FUfX9nUwV8PGVjQZo/
	Zkp1t2t1Jkf3LdKF3VdbJWLZ56fkIpzt9PPrtHQe3wCEyyoUkoPkSCo8voHePWLMDxNc8k
	ULRum1tfDWgt5b7qw5O8BfJG8xjch4HgKhMWKOkTzusvjZfwfZ5qIqFAJ45pUN17tFK0X7
	jFLliFZt3Ar8mAAtIbVXiAipdAEb4AkMeL/pkhVLKFGKJtl1kHRKyklDQ9jPUA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Feb 2025 09:39:10 +0100
Message-Id: <D828Q3C1GEJQ.22EIS7ZR8OKI3@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Cc: "Sudler, Simon" <simon.sudler@siemens.com>,
 "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com"
 <alex.kanavin@gmail.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Koch, Stefan" <stefan-koch@siemens.com>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
 <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
 <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
 <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
 <06ab9baa1ee1d5e22403f63b6074789412f7d501.camel@siemens.com>
In-Reply-To: <06ab9baa1ee1d5e22403f63b6074789412f7d501.camel@siemens.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfffghfejvdehkeetjeejjeeuvdelveeffedvkedtvedthfefueeiiefguedtgfejnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdpshhivghmvghnshdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepshhtvghfrghnqdhkohgthhesshhivghmvghns
 hdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehsihhmohhnrdhsuhgulhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopegrlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 08:39:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17324

On Tue Feb 25, 2025 at 6:04 PM CET, Stefan Koch wrote:
> So far, I can't reproduce the issue using a ubuntu 20.04 container.
> git clone git://git.yoctoproject.org/poky
> Patching subdir bitbake/
> oe-selftest -r devtool.DevtoolUpdateTests.test_devtool_git_submodules
> bitbake git-submodule-test
>
> The current master-next branch from bitbake contains the v4 patches,
> now. Do you still have the issue?
> >
>
> --
> Stefan Koch
> Siemens AG
> http://www.siemens.com/


Hi Stefan,

Yes, it does look like Richard had the same issue on his branch:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1045/ste=
ps/14/logs/stdio

I will try to provide you with an easy way to reproduce this failure.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


