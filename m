Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7617C0218A
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 17:37:38 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.3112.1738085848711077320
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Jan 2025 09:37:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LKvvnId8;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5265C4433A;
	Tue, 28 Jan 2025 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738085846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3f6p6vInO6KEp7n1NOMghLTKMNsyOGmAT7TT9ZJxlS4=;
	b=LKvvnId8m2nhcQrYDHym6M8Vzv3efs4zjdM9oGJpjzRkWDcuO/hjEHOAynLi/KAqfJlT2I
	PQVOWTiO/3OaXXQ8ZG/vwHmBepvMUlrHTH5a+u7qvxIdFzX5Hxjbw7yQQPZkALVCdRn8qg
	uYEZl3eYWCawhQYCqp6pWrlWMCjmp7aFMCmjmV2QWGkVYrnbBD6qb/oRmM+DV5mZdf95gR
	wva1LfXcESzhUA8ysfMm09t3zTqYYrPoCNzOHAARxLZ0+G1zAqJ3zp6HMCK6JMMgvD6s1v
	cjf0mD9V5txiKiFNcpADjqweWGVoodiPXZNOtp74tPHncvOIRggDyL7uxhltYg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jan 2025 18:37:25 +0100
Message-Id: <D7DW0EAQZCTP.1YEKGEI110OS0@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <stefan.herbrechtsmeier-oss@weidmueller.com>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: use downloadfilename to fetch
 from mirrors
Cc: "Stefan Herbrechtsmeier" <stefan.herbrechtsmeier@weidmueller.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250127144314.27990-1-stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20250127144314.27990-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhvffuvefofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepfeeulefgffetleduhedvheetueegveduuddvjeeileeggeekgeefjedvveevtdelnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdphihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemrgeiieemfedukedtmegvkeehtgemugduugefmeehheefkeemieegiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmegrieeimeefudektdemvgekhegtmeguudgufeemheehfeekmeeigeeivddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehsthgvfhgrnhdrhhgvrhgsrhgvtghhthhsm
 hgvihgvrhdqohhsshesfigvihgumhhuvghllhgvrhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehsthgvfhgrnhdrhhgvrhgsrhgvtghhthhsmhgvihgvrhesfigvihgumhhuvghllhgvrhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Jan 2025 17:37:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17107

On Mon Jan 27, 2025 at 3:43 PM CET, Stefan Herbrechtsmeier via lists.openem=
bedded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>
> Use the downloadfilename to fetch from download mirrors. This allows
> fetchers to store downloaded files inside a subfolder.
>
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---

Hi Stefan,

Thanks for your patch.

It looks like this is causing some issues on the autobuilder, with the
oe-selftests:

2025-01-28 08:46:33,938 - oe-selftest - INFO - testtools.testresult.real._S=
tringException: Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oeqa/=
selftest/cases/sstatetests.py", line 261, in test_sstate_creation_distro_no=
nspecific_pass
    self.run_test_sstate_creation(['linux-libc-headers'], distro_specific=
=3DFalse, distro_nonspecific=3DTrue, temp_sstate_location=3DTrue)
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/meta/lib/oeqa/=
selftest/cases/sstatetests.py", line 131, in run_test_sstate_creation
    self.assertTrue(badperms , msg=3D"Found sstate directories with the wro=
ng permissions: %s (found %s)" % (', '.join(map(str, targets)), str(badperm=
s)))
  File "/usr/lib64/python3.12/unittest/case.py", line 727, in assertTrue
    raise self.failureException(msg)
AssertionError: [] is not true : Found sstate directories with the wrong pe=
rmissions: linux-libc-headers (found [])

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/815/step=
s/14/logs/stdio

Can you have a look at this issue please ?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


