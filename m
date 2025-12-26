Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771AEE8FDAB
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 16:33:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.155971.1766766793366117021
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Dec 2025 08:33:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=sFNlUeqW;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E853AC1D183
	for <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 16:32:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 063DE606E4;
	Fri, 26 Dec 2025 16:33:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81499103C8D10;
	Fri, 26 Dec 2025 17:33:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766766790; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H0n2/JKBMh/0XFQYLdoi2fdYmB7QCf+QIpuXpkYECd4=;
	b=sFNlUeqWsSrhmFeABX78KLCXqa9Su94pOpz9TJChsPQoJWiOMHLXrL27F6OgU4a8k4GDWw
	gVZATlGq8Ai9X6JB3yYBa9Rl6z0hce1DgrjLqCtqD5manZu5eQT0Ql3sXMbyhULAiY0Agm
	KSn55naGXOIMnnjZCJb78R7P0tSiwiMOYoiI9oH/DBVkciRQKlssYe7U152YMAgVUJgijo
	hod5XKwzmDb9dHNkW/mebxHXyUUxtecXl29c20IHpN2oWrYldSRghYP0xv+D1MahVFiNcj
	4l+k+cbLVE2L22UKwycgkvSim1O4AxFjLYGmx60YHBuNGU7C95DZYdYgfJ8phg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Dec 2025 17:33:08 +0100
Message-Id: <DF8AK1TAXAUW.30M2AJXJ9EEBE@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 0/1] bitbake-setup: Initialize build
 environment after setup/update
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <adrian.freihofer@siemens.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251224151248.3313463-1-adrian.freihofer@siemens.com>
In-Reply-To: <20251224151248.3313463-1-adrian.freihofer@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 16:33:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18650

On Wed Dec 24, 2025 at 4:12 PM CET, Adrian Freihofer via lists.openembedded=
.org wrote:
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> This is related to https://lists.openembedded.org/g/openembedded-core/mes=
sage/228541
>
> It does not have a hard dependency on the oe-core change, but this bitbak=
e change
> does not make sense without it.
>
> Adrian Freihofer (1):
>   bitbake-setup: Initialize build environment after setup/update
>
>  bin/bitbake-setup | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Hi Adrian,

Thanks for your patch.

It looks like this is breaking some bitbake selftest:

ERROR: test_setup (bb.tests.setup.BitbakeSetupTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 369, in test_setup
    out =3D self.runbbsetup("update --update-bb-conf=3D'yes'")
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 90, in runbbsetup
    return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.p=
ath.join(self.tempdir, 'global-config'), cmd))
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/process.py", line 189, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of '/srv/pokybuild/yocto-worker/oe-sel=
ftest-debian/build/layers/bitbake/bin/bitbake-setup --global-settings /tmp/=
bitbake-fetch-uqye_k49/global-config update --update-bb-conf=3D'yes'' faile=
d with exit code 1:
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/bin/bitbake-setup", line 1058, in <module>
    main()
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/bin/bitbake-setup", line 1051, in main
    args.func(top_dir, all_settings, args, d)
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/bin/bitbake-setup", line 683, in build_update
    build_status(top_dir, settings, args, d, update=3DTrue)
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/bin/bitbake-setup", line 677, in build_status
    verify_and_prepare_environment(init_script)
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/bin/bitbake-setup", line 524, in verify_and_prepare_environment
    bb.process.run(['sh', '-c', '. {}'.format(init_script)])
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/process.py", line 189, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of 'sh -c ". None"' failed with exit c=
ode 2:
sh: 1: .: None: not found

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2917
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3054
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2810

Can you have a look at this?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


