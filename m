Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C440EE020B
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 15:14:13 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65955.1767107645063119509
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Dec 2025 07:14:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=NdWPpH3D;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1074A4E41E85
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 15:14:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C104C6072C;
	Tue, 30 Dec 2025 15:14:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C4A5113B0392;
	Tue, 30 Dec 2025 16:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767107642; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cDxb47WGLHHTj3acbX9SKlJGJqKDhvNXobnF9OigPS8=;
	b=NdWPpH3DdtbeP7YPrDnaq1RTa3hRdQIuY1wIXegNqwTHXBSdKChcSBdUGNxlzjpa+2+zQb
	sS1rVqn7k0Oaj0Cjf8LdCHtk9YW7Q0CRptU08RwEDnfedjjhy7uRmUzBpR9b5TPmSRgKf2
	IrqraNQ1AAFoiUruDzOO77ihh55s2eF0N48Lyz67FwtfOGBPmPeqB9x+kQb17IC7e3XxBW
	btVtIJhdfMO5EmWvCcYpSXbou9uXGoYIZVXGyPNmG+cHs4e4SY7lRWm3+vz2QxWc0QNfID
	janJM5o3M1qQzdkglKB5BxwftcAwFvonEXA2cHr5fhe8iDOImfIzYldMxaDvmg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Dec 2025 16:14:00 +0100
Message-Id: <DFBNDN2ZOJC6.3V3I5GLBKAT8Q@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 0/1] bitbake --skip-deps feature
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <adrian.freihofer@siemens.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251230091530.2373504-1-adrian.freihofer@siemens.com>
In-Reply-To: <20251230091530.2373504-1-adrian.freihofer@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Dec 2025 15:14:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18659

On Tue Dec 30, 2025 at 10:15 AM CET, Adrian Freihofer via lists.openembedde=
d.org wrote:
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Adds a "skip-deps" feature to run/build specific tasks without scheduling=
 their
> full dependency tree.
>
> This is useful for devtool ide-sdk, which works like this:
> - The IDE's native build system is used to build the code.
> - bitbake my-recipe:do_install --skip-deps --force is run to install the =
built
>   artifacts.
> - A script based on devtool deploy-target is used to deploy the installed
>   artifacts to the target device.
> - The IDE's debugging features are used to debug the code on the target d=
evice.
>
> One more commit to openembedded-core is needed to fully support this feat=
ure.
> This is already prepared and tested. Branch is here:
> https://git.openembedded.org/openembedded-core-contrib/log/?h=3Dadrianf/i=
de-sdk-improvements
>
> Adrian Freihofer (1):
>   tests/runqueue: cover --skip-deps
>
>  lib/bb/tests/runqueue.py | 9 +++++++++
>  1 file changed, 9 insertions(+)

Hi Adrian,

Thanks for your patch. Is the bitbake series complete? I can see a patch
adding tests, but none adding the feature. Am I missing something?

So far, the test is failing on the autobuilder:

FAIL: test_skip_deps (bb.tests.runqueue.RunQueueTests.test_skip_deps)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/layers/bitbake=
/lib/bb/tests/runqueue.py", line 41, in run_bitbakecmd
    output =3D subprocess.check_output(cmd, env=3Denv, stderr=3Dsubprocess.=
STDOUT,universal_newlines=3DTrue, cwd=3Dbuilddir)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
    return run(*popenargs, stdout=3DPIPE, timeout=3Dtimeout, check=3DTrue,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib64/python3.12/subprocess.py", line 571, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['bitbake', 'a1', '-c', 'install', =
'--skip-deps']' returned non-zero exit status 2.

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/layers/bitbake=
/lib/bb/tests/runqueue.py", line 409, in test_skip_deps
    tasks =3D self.run_bitbakecmd(cmd, tempdir)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-fedora/build/layers/bitbake=
/lib/bb/tests/runqueue.py", line 46, in run_bitbakecmd
    self.fail("Command %s failed with %s" % (cmd, e.output))
AssertionError: Command ['bitbake', 'a1', '-c', 'install', '--skip-deps'] f=
ailed with usage: bitbake [-s] [-e] [-g] [-u UI] [--version] [-h] [-f] [-c =
CMD]
               [-C INVALIDATE_STAMP] [--runall RUNALL] [--runonly RUNONLY]
               [--no-setscene] [--skip-setscene] [--setscene-only] [-n] [-p=
]
               [-k] [-P PROFILE] [-S SIGNATURE_HANDLER] [--revisions-change=
d]
               [-b BUILDFILE] [-D] [-l DEBUG_DOMAINS] [-v] [-q]
               [-w WRITEEVENTLOG] [-B BIND] [-T SERVER_TIMEOUT]
               [--remote-server REMOTE_SERVER] [-m] [--token XMLRPCTOKEN]
               [--observe-only] [--status-only] [--server-only] [-r PREFILE=
]
               [-R POSTFILE] [-I EXTRA_ASSUME_PROVIDED]
               [recipename/target ...]
bitbake: error: unrecognized arguments: --skip-deps

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2823
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3068
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2930

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


