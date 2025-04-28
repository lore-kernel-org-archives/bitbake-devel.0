Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC39C369DC
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 16:26:00 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.52842.1745857550459037233
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Apr 2025 09:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gQynnOk9;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D361439E2;
	Mon, 28 Apr 2025 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745857548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blkLLqnQWxnk7XVbgQmvNkPJtYlKqBs9d3Moq/oGhfc=;
	b=gQynnOk9uKsEssLyux/fOkjILMUFsvYESClypRy/M3vco21GteFzEzfuhjXywoM8t0xSel
	tK8ZNHHThbMRhn/cE1KBlNxFT9bnxuKyMEF6fm4FglLMhUxonndTlAy6ABU35+DYZ6NqE1
	qy9RfUT81Ev7XyQXFS8Np+/PYFYdJCXnxBvYZx4GkMAMy/RsmlCo2liOlgcg0cC2/wwXju
	z5sZ/fsuKZQcmL51fmuLtLppSAMnys/T88JpfEuDyU6s9QB3MEEVVpuzobk5TpQ0ddF84R
	Q5NXExYK64jDg7wXZLADZ1ob2UpI62sWlo8aFM1RibJbx3lUhh3iHFlPJ8Sb0Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 18:25:47 +0200
Message-Id: <D9IEUL8C31XI.2888IIXIFIPAW@bootlin.com>
Cc: <richard.purdie@linuxfoundation.org>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Philip Lorenz" <philip.lorenz@bmw.de>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v3 0/8] Fix gitsm LFS support
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
In-Reply-To: <20250425144138.4089681-1-philip.lorenz@bmw.de>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedugedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkvefhvffuofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegleeiheegieevheetieeigfehtedtheegvdehvdettefgfeeihfetleefteeuhfenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehphhhilhhiphdrlhhorhgvnhiisegsmhifrdguvgdprhgtphhtthhopegsi
 hhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Apr 2025 16:26:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17579

On Fri Apr 25, 2025 at 4:41 PM CEST, Philip Lorenz wrote:
> This patch series fixes a number of issues we observed when using the
> gitsm fetcher in conjunction with git-lfs.
>
> I'd like to highlight two patches in this series:
> * 0004-fetch2-Simplify-git-LFS-detection: I could not come up with a
>   good reason on why the code so far preferred the content of
>  `.gitattributes` on the repository's branch instead of always
>   considering the state of the target revision. Please let me know
>   if there's something I didn't take into account.
> * 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I could not
>   replicate the `git-lfs fetch` behaviour in versions going back to
>   2.13.2 released in 2021. This leads me to believe that the issue
>   leading to this workaround is no longer in place. However, if anyone
>   remembers the actual issue / versions involved I can also retest to
>   confirm that there are no regression.
>
> ---

Hi Philip,

Thanks for the new version.

It works much better than previously. I still have some issues with
bitbake selftests on my branch:

ERROR: test_lfs_enabled_not_installed (bb.tests.fetch.GitLfsTest.test_lfs_e=
nabled_not_installed)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb=
/tests/fetch.py", line 2528, in test_lfs_enabled_not_installed
    fetcher.download()
    ~~~~~~~~~~~~~~~~^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb=
/fetch2/__init__.py", line 1929, in download
    raise FetchError("Unable to fetch URL from any source.", u)
bb.fetch2.FetchError: Fetcher failure for URL: 'git:///tmp/bitbake-fetch-m3=
0azy7_/gitsource;protocol=3Dfile;lfs=3D1;branch=3Dmaster'. Unable to fetch =
URL from any source.

Stdout:
Cloning into bare repository '/tmp/bitbake-fetch-m30azy7_/download/git2/tmp=
.bitbake-fetch-m30azy7_.gitsource'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects:  33% (1/3)
Receiving objects: 100% (3/3), done.
Failed to fetch URL git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=3D=
file;lfs=3D1;branch=3Dmaster, attempting MIRRORS if available
Fetcher failure: Repository file:///tmp/bitbake-fetch-m30azy7_/gitsource ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)
Failed to fetch URL git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=3D=
file;lfs=3D1;branch=3Dmaster, attempting MIRRORS if available
Fetcher failure: Repository file:///tmp/bitbake-fetch-m30azy7_/gitsource ha=
s LFS content, install git-lfs on host to download (or set lfs=3D0 to ignor=
e it)

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/1440/ste=
ps/12/logs/stdio

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


