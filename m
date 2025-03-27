Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81910C36010
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:17:29 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.49580.1743081440013333337
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Mar 2025 06:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=EyFGlO11;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE7F844208;
	Thu, 27 Mar 2025 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743081438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVbAFXW8s33yrj6v6GZKIaJzQf/kQKNWbhN3VdhKHtg=;
	b=EyFGlO1136+gn98bRW6K4pniM9RernfkMHqQy0g4Ml9jKz75lDfpsipyKn1WPZUm4YNGjy
	7asXiKrmT4Gd3bf0Eu71IZZNZ3CopsOrHNx0Dq79xaEp0yGyh1DIxymM7UHgxebDCtIQOX
	9SQMtCVWRPbCywh3fC3OMPdC6kUxwdcDYVBqTEL6ifzPzLs8qJVl2LyZ9YOE7X+mHxb0Vw
	xIGmrIv4tqIhdKbvzZvLcblcpNiU1Nujm2oVNLScndNxDNZxDVx5H2h8+84Z+G1/zqBlab
	yT0aa5Ls9tt5vCXnIwb4dyULNhzF2Y538ZZn9rIq+89F9Zc0YdN00dymLYLkZA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 14:17:17 +0100
Message-Id: <D8R2STOUQTXK.5NH29V054MLY@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/7] fetch2/wget: consider
 downloadfilename when checking for upstream
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <ross.burton@arm.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250326122523.293551-1-ross.burton@arm.com>
In-Reply-To: <20250326122523.293551-1-ross.burton@arm.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiuddvkeevvdejgefgieetfffhtefggeeuleeufedvheefgfeviefhkeekleekgeenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdhtuhigfhgrmhhilhihrdhorhhgpdihohgtthhophhrohhjvggtthdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdeifedrvddtvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvddtvddrgedtpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhhoshhsrdgsuhhrthhonhesrghrmhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Mar 2025 13:17:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17502

On Wed Mar 26, 2025 at 1:25 PM CET, Ross Burton via lists.openembedded.org =
wrote:
> latest_versionstring() currently looks at just the end of the URI when
> guessing what the filename to look for is, but this doesn't work if the
> URL filename is not simple.
>
> For example, miniupnpd has a SRC_URI of:
>
>   http://miniupnp.tuxfamily.org/files/download.php?file=3D${BP}.tar.gz;do=
wnloadfilename=3D${BP}.tar.gz
>
> The filename component of this is "download.php", which causes the
> heuristics in latest_versionstring() to exit early.
>
> Instead, if the downloadfilename is set then use that, as it's often the
> actual filename that we're after.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---

Hi Ross,

I've been trying to apply this series on my branch, but I get some error
on the autobuilder:

FAIL: test_wget_latest_versionstring (bb.tests.fetch.FetchLatestVersionTest=
.test_wget_latest_versionstring) (pn=3D'miniupnpd')
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb=
/tests/fetch.py", line 1578, in test_wget_latest_versionstring
    self.assertTrue(verstring, msg=3D"Could not find upstream version for %=
s" % data.pn)
    ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^
AssertionError: '' is not true : Could not find upstream version for miniup=
npd

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/1193


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


