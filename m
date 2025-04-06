Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B0FC36002
	for <webhook@archiver.kernel.org>; Sun,  6 Apr 2025 14:43:02 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.26101.1743950572175806677
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Apr 2025 07:42:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iEYby9Ic;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAC86444DA;
	Sun,  6 Apr 2025 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743950570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKggy97NyJcZuQYtlPsped/drwSPmF1yA870iJlZ38E=;
	b=iEYby9Ic3uvkLVjj6Z9to5tA8FUmWmT6yMhxdjd5rJ3PNrX/dm2wsVOcfZigLM0mgz+iJu
	IXcpoIA0hzJuFQ5V61H6NOiN+327Xkwa5Q9jlbT0NuJviW8fDqN3gtnY280JBbtrDFyYiD
	rG02JZbZP8IJDy2z0pZQVZ4OebSx8RMGlRBug1CgzE+NeNfm5IfQ5b8LqIqW6OVyxZhaRG
	xvAPOP5rd/QefpWwnKrHIalTVJu8ZE61o7SewT8S2NGLyqmaH6OpUMdhlHCEf/X3Z1X915
	hfQPwSOB6WZE4q2udmmZWvl4T5XIOmNl8LbWqv/H6qWiXOk8HvTm3thsoJyEzg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Apr 2025 16:42:50 +0200
Message-Id: <D8ZMVRQ93Y3I.3NO1L0B4OG69A@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: always fetch lfs when
 creating shallow tarball
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <peter.marko@siemens.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250404185911.137153-1-peter.marko@siemens.com>
In-Reply-To: <20250404185911.137153-1-peter.marko@siemens.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleejheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehheegjeelueetteeghfeiudeiheekgedtfeeuudejgedukeeigfdtgeeiuedtjeenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdduledvrdduieekrdejrdefpdihohgtthhophhrohhjvggtthdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegrieeimeefudektdemjehfvdgrmeehudgrugemhehfrgdvmeejfegtkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemrgeiieemfedukedtmeejfhdvrgemhedurggumeehfhgrvdemjeeftgekpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepphgvthgvrhdrmhgrrhhkohesshhivghmvghnshdrtghom
 hdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Apr 2025 14:43:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17520

On Fri Apr 4, 2025 at 8:59 PM CEST, Peter Marko via lists.openembedded.org =
wrote:
> From: Peter Marko <peter.marko@siemens.com>
>
> Before fast shallow tarballs the shallow tarball with lfs worked only
> if the original .../downloads/git2/... directory existed. Once it was
> not there, do_unpack on shallow tarball without lfs files failed due to
> disabled network.
> It was fixed for fast shallow tarballs and this commit fixes the other
> scenarios, too.
>
> This can happen when such shallow tarball is put to mirror or if
> someone does cleanup to reclaim disk space.
>
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---

Hi,

Thanks for your patch.

I have a failure on the autobuilder, it might come from this series but
I'm not fully confident so far. I will try to drop it and see if this
error remains:

2025-04-05 18:34:18,526 - oe-selftest - INFO - Starting client DEBUGINFOD_U=
RLS=3Dhttp://192.168.7.3:36583/ debuginfod-find debuginfo /usr/bin/xz
[Sat Apr  5 18:34:18 2025] (1095188/1095201): 192.168.7.4:60184 UA:elfutils=
/0.192,Linux/aarch64,/ XFF: GET /buildid/d844ffb4600923775c544fbf26e06b4298=
6c9e9f/debuginfo 200 299136 0+7ms
ERROR: When reparsing /tmp/selftest-fetchd_wtdpmg/test.bb:do_checkuri, the =
basehash value changed from 84b9e23a83a764e7a5d8a96ee523199e2b1c604f4280a45=
030e248de0ff52962 to 4123da244f465feffecb2b4fd2b132b64851981ec2fb70bf9445df=
8b0ea6a69e. The metadata is not deterministic and this needs to be fixed.
ERROR: The following commands may help:
ERROR: $ bitbake test -cdo_checkuri -Snone
ERROR: Then:
ERROR: $ bitbake test -cdo_checkuri -Sprintdiff

ERROR: When reparsing /tmp/selftest-fetchd_wtdpmg/test.bb:do_fetch, the bas=
ehash value changed from 6d55d6743729b615749dc016857d7e5f9c884a8b92f0d57f68=
e743f4910333d3 to fa7d6ea0563b60362418d2a6c5e41a6684183d01ec578b65abd0c64a9=
cfba7cf. The metadata is not deterministic and this needs to be fixed.
ERROR: The following commands may help:
ERROR: $ bitbake test -cdo_fetch -Snone
ERROR: Then:
ERROR: $ bitbake test -cdo_fetch -Sprintdiff

ERROR: When reparsing /tmp/selftest-fetchd_wtdpmg/test.bb:do_unpack, the ba=
sehash value changed from ae9d94aafc721d891f8754df82ed90da8191357178f3db642=
21a49d5c1de3bcd to 1ac8f87a71db151b8eb2ae8d13f9a6ea1a0c884ef98555d61d2c2fe0=
7a476a8a. The metadata is not deterministic and this needs to be fixed.
ERROR: The following commands may help:
ERROR: $ bitbake test -cdo_unpack -Snone
ERROR: Then:
ERROR: $ bitbake test -cdo_unpack -Sprintdiff

ERROR: When reparsing /tmp/selftest-fetchd_wtdpmg/test.bb:do_cleanall, the =
basehash value changed from dada587ade4d28783151e52fcc21d922f3bdad57064c057=
c23796f4743430427 to cf9daca04d1ff9b60f84b2bed99c89ddb03a867efaf079e92b5532=
f86c2a0ef5. The metadata is not deterministic and this needs to be fixed.
ERROR: The following commands may help:
ERROR: $ bitbake test -cdo_cleanall -Snone
ERROR: Then:
ERROR: $ bitbake test -cdo_cleanall -Sprintdiff

...

Similar error on oe-selftests on all machines:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/1389
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/1304
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/1253

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


