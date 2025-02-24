Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A1BC021A6
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 11:58:16 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.87531.1740398294006400650
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Feb 2025 03:58:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=IQZha8WT;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D379B44262;
	Mon, 24 Feb 2025 11:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740398292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KwCPxBSqg6TbQXRTCrizKLQOaWZkpiuopYpW0WSV7M=;
	b=IQZha8WTfr0fK3oCd336eokyPMYXUXHU7mQEI4F0mrsIk6vwoBvzvYvozTKacXUPJqNoke
	EP8F+Q8medP0HwNeV8I4Vr2c/cEuM+QAC+iVTKEBPwJYHkROtsD8VPSUSX1p7JXplwFTxx
	3ABLSeMTyh9Aucfh7EFc/nluG5JFRIA/iljFy+Gkq9YFQiG8wv/IEcNbf0W8DJv3HngfBj
	IKwmwpYOMM0CZ5Ix1xv+fEZNlsC6dUHc0LRTbK0DWzimZnVAjlN9VgZM1lY5XZJjwFQdDs
	a48Z7tgjiLi/0No5ton3ShYKxu6typdn7xfaMBBWwb/ozEwueX0t5rsVMtOUvg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 12:58:11 +0100
Message-Id: <D80NPDG5BAOJ.21VFGTXZZIRP5@bootlin.com>
To: <stefan-koch@siemens.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/4] fetch2/git: Add support for fast
 initial shallow fetch
Cc: <simon.sudler@siemens.com>, <jan.kiszka@siemens.com>,
 <alex.kanavin@gmail.com>, <richard.purdie@linuxfoundation.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
In-Reply-To: <20250220172706.3850722-1-stefan-koch@siemens.com>
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpegggfgtfffkvffuvefhofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgueeltefhudegffekvdevtdfgveffjeegjeduhfduvefgveeuhfeiteejgffftdenucffohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdihohgtthhophhrohhjvggtthdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtohepshhtvghfrghnqdhkohgthhesshhivghmvghnshdrtghomhdprhgtphhtthhopegsi
 hhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehsihhmohhnrdhsuhgulhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomhdprhgtphhtthhopegrlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomhdprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Feb 2025 11:58:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17292

On Thu Feb 20, 2025 at 6:27 PM CET, Stefan via lists.openembedded.org Koch =
wrote:
> When `ud.shallow =3D=3D 1`:
> - Prefer an initial shallow clone over an initial full bare clone,
>   while still utilizing any already existing full bare clones.
>
> This improves:
> - Resolve timeout issues during initial clones on slow internet connectio=
ns
>   by reducing the amount of data transferred.
> - Eliminate the need to use an HTTPS tarball `SRC_URI`
>   to reduce data transfer.
> - Allow SSH-based authentication (e.g. cert and agent-based) when
>   using non-public repos, so additional HTTPS tokens may not be required.
>
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---

Hi Stefan,

Thanks for your patch.

We got a new failure on the autobuilder, specifically with the
oe-selftest-ubuntu build. I'm not entirely sure this comes from this
series, so I will try a build without it to confirm.

Here is the error:

NOTE: Running task 2 of 4 (/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/b=
uild/build-st-3502943/meta-selftest/recipes-test/git-submodule-test/git-sub=
module-test.bb:do_fetch)
NOTE: recipe git-submodule-test-1.0-r0: task do_fetch: Started
WARNING: git-submodule-test-1.0-r0 do_fetch: Creating fast initial shallow =
clone failed, try initial regular clone now.
WARNING: git-submodule-test-1.0-r0 do_fetch: Failed to fetch URL gitsm://gi=
t.openembedded.org/bitbake;protocol=3Dgit;name=3Dbitbake;subpath=3Dbitbake;=
nobranch=3D1;lfs=3DFalse;bareclone=3D1;nobranch=3D1, attempting MIRRORS if =
available
ERROR: git-submodule-test-1.0-r0 do_fetch: Fetcher failure: Fetch command e=
xport PSEUDO_DISABLED=3D1; export PATH=3D"/srv/pokybuild/yocto-worker/oe-se=
lftest-ubuntu/build/build-st-3502943/tmp/sysroots-uninative/x86_64-linux/us=
r/bin:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build/scripts:/srv/pok=
ybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3502943/tmp/work/core=
2-64-poky-linux/git-submodule-test/1.0/recipe-sysroot-native/usr/bin/x86_64=
-poky-linux:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3=
502943/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/recipe-sysroot/u=
sr/bin/crossscripts:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build/bu=
ild-st-3502943/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/recipe-s=
ysroot-native/usr/sbin:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build=
/build-st-3502943/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/recip=
e-sysroot-native/usr/bin:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/bui=
ld/build-st-3502943/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/rec=
ipe-sysroot-native/sbin:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/buil=
d/build-st-3502943/tmp/work/core2-64-poky-linux/git-submodule-test/1.0/reci=
pe-sysroot-native/bin:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build/=
bitbake/bin:/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build/build-st-3=
502943/tmp/hosttools"; export HOME=3D"/srv/pokybuild"; git -c gc.autoDetach=
=3Dfalse -c core.pager=3Dcat -c safe.bareRepository=3Dall -c clone.defaultR=
emoteName=3Dorigin fetch origin 52a144a7daa94b2bd239d582cb71d1f03119918f --=
depth 1 failed with exit code 1, output:
error: Server does not allow request for unadvertised object 52a144a7daa94b=
2bd239d582cb71d1f03119918f

https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1031/ste=
ps/14/logs/stdio

Can you have a look at this issue please?

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


