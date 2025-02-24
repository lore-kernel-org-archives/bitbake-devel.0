Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F097C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 17:10:28 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.95814.1740417025446056020
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 09:10:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=aByXkEZJ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41D384428F;
	Mon, 24 Feb 2025 17:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740417023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9PL1h7wt5SHtH+KGe0EQw9w2p+y72IQZSfJPZE8NoQ0=;
	b=aByXkEZJjgRs85ilCij8WgWJBVQcXU52iXrQ7KjbI3W4zmg5hju+7/n3WSQT1ymKlzKkLR
	cy9baSUzMpCib7sVNp4KeragktSEWaH83Fbu8nvDplFbOa8Pex/K1Vdk48bETi3NokI8Vo
	ZMzHEs6S12ecj6mpOs9hdGtDSEJ+UxNo3p/3hMLXHATakoq/kQyeLQCCO0fwfDlnZ7taTh
	TewCOHTmdRYV3j6lHZEvWvucOH4W4WX2smIhtjOwRFog9XT+3itv5Dnvl6V5d/VFw8QeNW
	AWOaGRcmSwPtaobzueWAMBm9twqhzNQIJEJ8Dj90x4p/brvnMaMg4P4b7tkaVQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 18:10:22 +0100
Message-Id: <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
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
In-Reply-To: <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudehgefgteegheegjeehhffhgeelkeehgfelfeeukeetvdekiedttdevgeefudeunecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdphihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehsthgvfhgrnhdqkhhotghhsehsi
 hgvmhgvnhhsrdgtohhmpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepshhimhhonhdrshhuughlvghrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 17:10:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17296

On Mon Feb 24, 2025 at 2:11 PM CET, Stefan Koch wrote:
> On Mon, 2025-02-24 at 13:55 +0100, Stefan Koch wrote:
> > On Mon, 2025-02-24 at 12:58 +0100, Mathieu Dubois-Briand wrote:
> > > On Thu Feb 20, 2025 at 6:27 PM CET, Stefan via
> > > lists.openembedded.org
> > > Koch wrote:
> > > > When `ud.shallow =3D=3D 1`:
> > > > - Prefer an initial shallow clone over an initial full bare
> > > > clone,
> > > >   while still utilizing any already existing full bare clones.
> > > >
> > > > This improves:
> > > > - Resolve timeout issues during initial clones on slow internet
> > > > connections
> > > >   by reducing the amount of data transferred.
> > > > - Eliminate the need to use an HTTPS tarball `SRC_URI`
> > > >   to reduce data transfer.
> > > > - Allow SSH-based authentication (e.g. cert and agent-based) when
> > > >   using non-public repos, so additional HTTPS tokens may not be
> > > > required.
> > > >
> > > > Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> > > > ---
> > >
> > > Hi Stefan,
> > >
> > > Thanks for your patch.
> > >
> > > We got a new failure on the autobuilder, specifically with the
> > > oe-selftest-ubuntu build. I'm not entirely sure this comes from
> > > this
> > > series, so I will try a build without it to confirm.
> > >
> > > Here is the error:
> > >
> > > NOTE: Running task 2 of 4 (/srv/pokybuild/yocto-worker/oe-selftest-
> > > ubuntu/build/build-st-3502943/meta-selftest/recipes-test/git-
> > > submodule-test/git-submodule-test.bb:do_fetch)
> > > NOTE: recipe git-submodule-test-1.0-r0: task do_fetch: Started
> > > WARNING: git-submodule-test-1.0-r0 do_fetch: Creating fast initial
> > > shallow clone failed, try initial regular clone now.
> > > WARNING: git-submodule-test-1.0-r0 do_fetch: Failed to fetch URL
> > > gitsm://git.openembedded.org/bitbake;protocol=3Dgit;name=3Dbitbake;su=
bp
> > > at
> > > h=3Dbitbake;nobranch=3D1;lfs=3DFalse;bareclone=3D1;nobranch=3D1, atte=
mpting
> > > MIRRORS if available
> > > ERROR: git-submodule-test-1.0-r0 do_fetch: Fetcher failure: Fetch
> > > command export PSEUDO_DISABLED=3D1; export
> > > PATH=3D"/srv/pokybuild/yocto-
> > > worker/oe-selftest-ubuntu/build/build-st-3502943/tmp/sysroots-
> > > uninative/x86_64-linux/usr/bin:/srv/pokybuild/yocto-worker/oe-
> > > selftest-ubuntu/build/scripts:/srv/pokybuild/yocto-worker/oe-
> > > selftest-ubuntu/build/build-st-3502943/tmp/work/core2-64-poky-
> > > linux/git-submodule-test/1.0/recipe-sysroot-native/usr/bin/x86_64-
> > > poky-linux:/srv/pokybuild/yocto-worker/oe-selftest-
> > > ubuntu/build/build-st-3502943/tmp/work/core2-64-poky-linux/git-
> > > submodule-test/1.0/recipe-
> > > sysroot/usr/bin/crossscripts:/srv/pokybuild/yocto-worker/oe-
> > > selftest-
> > > ubuntu/build/build-st-3502943/tmp/work/core2-64-poky-linux/git-
> > > submodule-test/1.0/recipe-sysroot-
> > > native/usr/sbin:/srv/pokybuild/yocto-worker/oe-selftest-
> > > ubuntu/build/build-st-3502943/tmp/work/core2-64-poky-linux/git-
> > > submodule-test/1.0/recipe-sysroot-
> > > native/usr/bin:/srv/pokybuild/yocto-worker/oe-selftest-
> > > ubuntu/build/build-st-3502943/tmp/work/core2-64-poky-linux/git-
> > > submodule-test/1.0/recipe-sysroot-native/sbin:/srv/pokybuild/yocto-
> > > worker/oe-selftest-ubuntu/build/build-st-3502943/tmp/work/core2-64-
> > > poky-linux/git-submodule-test/1.0/recipe-sysroot-
> > > native/bin:/srv/pokybuild/yocto-worker/oe-selftest-
> > > ubuntu/build/bitbake/bin:/srv/pokybuild/yocto-worker/oe-selftest-
> > > ubuntu/build/build-st-3502943/tmp/hosttools"; export
> > > HOME=3D"/srv/pokybuild"; git -c gc.autoDetach=3Dfalse -c core.pager=
=3Dcat
> > > -
> > > c safe.bareRepository=3Dall -c clone.defaultRemoteName=3Dorigin fetch
> > > origin 52a144a7daa94b2bd239d582cb71d1f03119918f --depth 1 failed
> > > with
> > > exit code 1, output:
> > > error: Server does not allow request for unadvertised object
> > > 52a144a7daa94b2bd239d582cb71d1f03119918f
> > >
> > > https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/10=
31/steps/14/logs/stdio
> > >
> > > Can you have a look at this issue please?
> > Do you using 1716ad67bbe9f4cecf1e3bcfc2007b150ba77741 from bitbakes
> > master-next branch? Because that is PATCH v2 with that issue
> > specially
> > on ubuntu 20.04...
> Sorry, v3 is meant.
> v4 PATCH from Friday should fix this.
> > >
> >

Sorry, I sent this in the wrong mail thread, but I confirm I was indeed
using the v4.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


