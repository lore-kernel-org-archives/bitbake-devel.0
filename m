Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91BCD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 17:07:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24705.1781802419323199794
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 10:07:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=cE9VPEJN;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0CF381A3A07;
	Thu, 18 Jun 2026 17:06:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD74D601AC;
	Thu, 18 Jun 2026 17:06:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02945106C8263;
	Thu, 18 Jun 2026 19:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781802416; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h/WMeetBnHikW9TjginG6EqI5vCNL+13FQw3Y36OHrg=;
	b=cE9VPEJNssqQuowmKVhUbYl+BiiUkRcxUjavpWSlLa2a7ZT+qfE6veoEfM19A6MjHGx9lX
	8Nc+ZygGcCRzmSp1KuJwESYk28KRufQochCBOiRN8Pc370cB6gsF79u9ei3qCr5LDr5Xqy
	HQonNnS9OIBxuJ5deh/j1BtRMVC+D0RQJLgORkx6fRPvEh3S7K0QlssD6eHmCp8Uex4Nyl
	he/4nBWMt8eOXVP8f83NHMecYyV4/hVlhyxFO4vzR2h3EEgCPwJ978PImEsCqo7UU6afA8
	9OVVjhsPb3/HL1bWnJ8pxNwM93jGNCjUuVmjNvSpJWkgEIkrzOptcaSqX5oz3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 19:06:52 +0200
Message-Id: <DJCC8O98GW1V.95VRNYO90WVL@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: accept sha256 revisions
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <mischief@offblast.org>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260618100903.231245-2-mischief@offblast.org>
In-Reply-To: <20260618100903.231245-2-mischief@offblast.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 17:07:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19741

On Thu Jun 18, 2026 at 12:09 PM CEST, Nick Owens via lists.openembedded.org=
 wrote:
> regexes in fetch2's git support currently don't allow for fetching git
> repos with the sha256 object format.
>
> to allow fetching sha256 git repos, adjust the regular expression and
> fix all of the references.
>
> tested on my gitea server with a sha256 repo
>
> fixes https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16322
>
> Signed-off-by: Nick Owens <mischief@offblast.org>
> ---

Hi Nick,

Thanks for your patch.

It looks like we still have some use of sha1_re in bitbake-setup, and so
have a failing bitbake selftest:

ERROR: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 389, in test_setup
    self.check_setupdir_files(setuppath, test_file_content)
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 296, in check_setupdir_files
    self.config_is_unchanged(setuppath)
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 237, in config_is_unchanged
    out =3D self.runbbsetup(["status"])
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/setup.py", line 106, in runbbsetup
    return bb.process.run([bbsetup, '--global-settings', os.path.join(self.=
tempdir, 'global-config')] + cmd, env=3Denv, cwd=3Dself.tempdir)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/process.py", line 189, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of '/srv/pokybuild/yocto-worker/oe-sel=
ftest-debian/build/layers/bitbake/bin/bitbake-setup --global-settings /tmp/=
bitbake-fetch-irglhhir/global-config status' failed with exit code 1:
NOTE: Loading settings from /tmp/bitbake-fetch-irglhhir/global-config
NOTE: Loading settings from /tmp/bitbake-fetch-irglhhir/bitbake-builds/sett=
ings.conf
NOTE: Bitbake-setup is using /tmp/bitbake-fetch-irglhhir/bitbake-builds as =
top directory.
NOTE: Looking up config test-config-1 in configuration registry
NOTE: Fetching configuration registry
    git:///tmp/bitbake-fetch-irglhhir/bitbake-setup-configurations;protocol=
=3Dfile;branch=3Dmaster;rev=3Dmaster
into
    /tmp/bitbake-fetch-irglhhir/bitbake-builds/.bitbake-setup-cache/configu=
rations
ERROR: cannot import name 'sha1_re' from 'bb.fetch2.git' (/srv/pokybuild/yo=
cto-worker/oe-selftest-debian/build/layers/bitbake/lib/bb/fetch2/git.py)

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/4067
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3917

Can you fix this?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


