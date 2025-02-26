Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F61AC021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 09:24:59 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.2081.1740561889565516996
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 01:24:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=XTD190m+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E68D433E9;
	Wed, 26 Feb 2025 09:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740561887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rawT/8HKT6SvbbtuEsMPUOd7MyJgo4Ob8FfhvlemUmw=;
	b=XTD190m+yZIQVpE6PN+Fg1Xpi9TvawSp3gDDf4pLbxcjrZR/LgvsEjzS5rLXRm4e4xC7zz
	tFPNvTWxZkM4ARi9N4ZdddlorOOxtdZ4G3upJULupQM1QqfsrNw8+4ttoeDPzL1qklef5h
	kalS/MgKZA5rm/Uzs+nEpgvpRAOy9SloFbAwDQn8is4wz8L8RwhBtdSktop880/cCsa1ya
	94NkJ/NgPOOLDumflbd6yHiPUspHVddOTlMxRps/BJnoKqbVzyu0jxVjaXHlZY1KtVhJCJ
	Iahekum1BuD6XEIOu45tSYmWiUcxqQd/wN0gitAFLjmr49vIVBK4gkzAurZ8gg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Feb 2025 10:24:46 +0100
Message-Id: <D829P08052QS.1AVBHIBJKXZQP@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Cc: "Sudler, Simon" <simon.sudler@siemens.com>,
 "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com"
 <alex.kanavin@gmail.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>, "Koch,
 Stefan" <stefan-koch@siemens.com>, "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
 <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
 <e041fd346c069847c11899777503721d0dfaf952.camel@siemens.com>
 <4961407c133c3579acf66ca5deefa6f680c4f391.camel@siemens.com>
 <D80UCEFULALJ.1FXZODPDU20BJ@bootlin.com>
 <06ab9baa1ee1d5e22403f63b6074789412f7d501.camel@siemens.com>
 <D828Q3C1GEJQ.22EIS7ZR8OKI3@bootlin.com>
In-Reply-To: <D828Q3C1GEJQ.22EIS7ZR8OKI3@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedfofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugdfuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjedujeelkefghedtgfdthfekffeigffhkefhudekfeetfeekudfhtdegffffkefgnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdpshhivghmvghnshdrtghomhdpohhpvghnvghmsggvugguvggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehmr
 ghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshhtvghfrghnqdhkohgthhesshhivghmvghnshdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehsihhmohhnrdhsuhgulhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopegrlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 09:24:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17326

On Wed Feb 26, 2025 at 9:39 AM CET, Mathieu Dubois-Briand wrote:
> On Tue Feb 25, 2025 at 6:04 PM CET, Stefan Koch wrote:
> > So far, I can't reproduce the issue using a ubuntu 20.04 container.
> > git clone git://git.yoctoproject.org/poky
> > Patching subdir bitbake/
> > oe-selftest -r devtool.DevtoolUpdateTests.test_devtool_git_submodules
> > bitbake git-submodule-test
> >
> > The current master-next branch from bitbake contains the v4 patches,
> > now. Do you still have the issue?
> > >
> >
> > --
> > Stefan Koch
> > Siemens AG
> > http://www.siemens.com/
>
>
> Hi Stefan,
>
> Yes, it does look like Richard had the same issue on his branch:
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1045/s=
teps/14/logs/stdio
>
> I will try to provide you with an easy way to reproduce this failure.

I successfully reproduced this on uubuntu 20.04 with the following
commands:

git clone git://git.yoctoproject.org/poky-ci-archive -b autobuilder.yoctopr=
oject.org/valkyrie/a-full-1069
. poky-ci-archive/oe-init-build-env
echo "SANITY_TESTED_DISTROS =3D ''" >> conf/local.conf
oe-selftest -r archiver.Archiver.test_archiver_mode_mirror_gitsm_shallow

WARNING: git-submodule-test-1.0-r0 do_fetch: Creating fast initial shallow =
clone failed, try initial regular clone now.
WARNING: git-submodule-test-1.0-r0 do_fetch: Failed to fetch URL gitsm://gi=
t.openembedded.org/bitbake;protocol=3Dgit;name=3Dbitbake;subpath=3Dbitbake;=
nobranch=3D1;lfs=3DFalse;bareclone=3D1;nobranch=3D1, attempting MIRRORS if =
available
ERROR: git-submodule-test-1.0-r0 do_fetch: Fetcher failure: Fetch command e=
xport PSEUDO_DISABLED=3D1; export PATH=3D"/home/mdubois-briand/swat/fetch2-=
issue/build-st/tmp/sysroots-uninative/x86_64-linux/usr/bin:/home/mdubois-br=
iand/swat/fetch2-issue/poky-ci-archive/scripts:/home/mdubois-briand/swat/fe=
tch2-issue/build-st/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/rec=
ipe-sysroot-native/usr/bin/x86_64-poky-linux:/home/mdubois-briand/swat/fetc=
h2-issue/build-st/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/recip=
e-sysroot/usr/bin/crossscripts:/home/mdubois-briand/swat/fetch2-issue/build=
-st/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/recipe-sysroot-nati=
ve/usr/sbin:/home/mdubois-briand/swat/fetch2-issue/build-st/tmp/work/core2-=
64-poky-linux/git-submodule-test/1.0/recipe-sysroot-native/usr/bin:/home/md=
ubois-briand/swat/fetch2-issue/build-st/tmp/work/core2-64-poky-linux/git-su=
bmodule-test/1.0/recipe-sysroot-native/sbin:/home/mdubois-briand/swat/fetch=
2-issue/build-st/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/recipe=
-sysroot-native/bin:/home/mdubois-briand/swat/fetch2-issue/poky-ci-archive/=
bitbake/bin:/home/mdubois-briand/swat/fetch2-issue/build-st/tmp/hosttools";=
 export HOME=3D"/home/build"; git -c gc.autoDetach=3Dfalse -c core.pager=3D=
cat -c safe.bareRepository=3Dall -c clone.defaultRemoteName=3Dorigin fetch =
origin 52a144a7daa94b2bd239d582cb71d1f03119918f --depth 1 failed with exit =
code 1, output:
error: Server does not allow request for unadvertised object 52a144a7daa94b=
2bd239d582cb71d1f03119918f

ERROR: git-submodule-test-1.0-r0 do_fetch: gitsm: submodule download failed=
: FetchError Fetcher failure for URL: 'gitsm://git.openembedded.org/bitbake=
;protocol=3Dgit;name=3Dbitbake;subpath=3Dbitbake;nobranch=3D1;lfs=3DFalse;b=
areclone=3D1;nobranch=3D1'. Unable to fetch URL from any source.
WARNING: git-submodule-test-1.0-r0 do_fetch: Failed to fetch URL gitsm://gi=
t.yoctoproject.org/bitbake-gitsm-test1;protocol=3Dgit;name=3Dbitbake-gitsm-=
test1;subpath=3Dbitbake-gitsm-test1;nobranch=3D1;lfs=3DTrue;bareclone=3D1;n=
obranch=3D1, attempting MIRRORS if available
NOTE: recipe git-submodule-test-1.0-r0: task do_fetch: Succeeded
NOTE: Running task 3 of 4 (/home/mdubois-briand/swat/fetch2-issue/build-st/=
meta-selftest/recipes-test/git-submodule-test/git-submodule-test.bb:do_ar_m=
irror)
NOTE: recipe git-submodule-test-1.0-r0: task do_ar_mirror: Started
WARNING: git-submodule-test-1.0-r0 do_ar_mirror: Mirror tarballs are listed=
 for a source but none are present. Falling back to original download.
SRC_URI =3D gitsm://git.openembedded.org/bitbake;protocol=3Dgit;name=3Dbitb=
ake;subpath=3Dbitbake;nobranch=3D1;lfs=3DFalse;bareclone=3D1;nobranch=3D1
WARNING: git-submodule-test-1.0-r0 do_ar_mirror: Mirror tarballs are listed=
 for a source but none are present. Falling back to original download.
SRC_URI =3D gitsm://git.yoctoproject.org/bitbake-gitsm-test2;protocol=3Dgit=
;name=3Dbitbake-gitsm-test2;subpath=3Dbitbake-gitsm-test2;nobranch=3D1;lfs=
=3DFalse;bareclone=3D1;nobranch=3D1
ERROR: git-submodule-test-1.0-r0 do_ar_mirror: Original download is missing=
 for a source.
SRC_URI =3D gitsm://git.yoctoproject.org/bitbake-gitsm-test2;protocol=3Dgit=
;name=3Dbitbake-gitsm-test2;subpath=3Dbitbake-gitsm-test2;nobranch=3D1;lfs=
=3DFalse;bareclone=3D1;nobranch=3D1
ERROR: Logfile of failure stored in: /home/mdubois-briand/swat/fetch2-issue=
/build-st/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/temp/log.do_a=
r_mirror.982
NOTE: recipe git-submodule-test-1.0-r0: task do_ar_mirror: Failed
ERROR: Task (/home/mdubois-briand/swat/fetch2-issue/build-st/meta-selftest/=
recipes-test/git-submodule-test/git-submodule-test.bb:do_ar_mirror) failed =
with exit code '1'
NOTE: Tasks Summary: Attempted 3 tasks of which 0 didn't need to be rerun a=
nd 1 failed.


--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


