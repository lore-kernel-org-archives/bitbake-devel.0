Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D3C35FFB
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 12:48:51 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.7062.1742388524483675718
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 05:48:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=dTXlT1PX;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 06B05441AA;
	Wed, 19 Mar 2025 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742388522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGnIMEBiDq4osRQc+HeE5AiuYcsJ9BGgRsN6fm+TVHM=;
	b=dTXlT1PX+mA59pXEj2D1FwQRy9+Kk6f/jdXDAJfxVhlv/gYkbY/Qz+47rMUEFJr0YsptNZ
	tumlvBbXKSOPnENFBP83kTzxoSC0Y7GUmeoMmi2B08nN3n0nOuGO9jCRa1SWggTDDb/Vbc
	8SWoOLKluf/1vtBwsDbKkLiE2IE1+zVtUeJ2qE4ruHbM1q0Sxg8GoLw+gD99rWQR+6Gqvf
	A9vZ51AdjSkjYmkuIhxKh8NH2PZ0DHOc8UPenhhD2lZysewX9RFbBTsxzKEFfE4/239H81
	0Ea6cI3v5f6kK8UEQtDgXul7A40OA2CctAvCsLHIJYDQN2eQLYJTsuPfC3fbYw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 13:48:41 +0100
Message-Id: <D8K96KOWTA7O.1V6GVNJ037FGZ@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] tests/fetch: Add missing branch
 parameter to tests
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250318233546.574124-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250318233546.574124-1-richard.purdie@linuxfoundation.org>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfeuvdfghfegtdehvdegvefhkeegheeikeelfeefffetheeitdduudeludduleenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdihohgtthhophhrohhjvggtthdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhor
 hhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 12:48:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17466

On Wed Mar 19, 2025 at 12:35 AM CET, Richard Purdie via lists.openembedded.=
org wrote:
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---

Hi Richard,

We have some selftest failures on the AB, might it come from these
patches?

FAIL: test_gitfetch_tagandrev (bb.tests.fetch.FetcherNetworkTest.test_gitfe=
tch_tagandrev)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb=
/tests/fetch.py", line 1093, in test_gitfetch_tagandrev
    self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
AssertionError: FetchError not raised by gitfetcher

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/1130
https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1216
https://autobuilder.yoctoproject.org/valkyrie/#/builders/76/builds/1170

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


