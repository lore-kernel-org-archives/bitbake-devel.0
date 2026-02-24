Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1322EFB815
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 08:26:38 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15927.1771921597583421961
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Feb 2026 00:26:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=B2Zk5wcE;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5EF0E4E41053;
	Tue, 24 Feb 2026 08:26:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 347EC5FD9D;
	Tue, 24 Feb 2026 08:26:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A6AEE10368B4A;
	Tue, 24 Feb 2026 09:26:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771921594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RFwI0V7M896dypEc3Y0A0vfM5RBwFQmOXgYt8ucrceY=;
	b=B2Zk5wcE9aM/y/hRb4MUAioQP7CTrkX3jIbd9YVN34IVw/LIlf50kozN2JgPmPqLLAkpDA
	C6+ozVItOp1ZUUU3ZSTGJ6yEQ0c9UCn9izkyCqp0FbcOfoyPYEfMgTiGdfgTfVF2NliTlV
	266RPanf/PWT6Z88342iNvfFXmJtdDsEbxxXYN5RMqVHeyAB2KrMp2ZE2QkKtc4Z2qXT50
	rO68aBy10Fyrh72UMEa3tGS3v7cbL8PFRK+kXPyEGN5Y+rOFIlVOXq7Y435FOeQf9bCjup
	Y1bwn8eya197juqpTH7qMXKDMk0y28Q9Em8WnbNnb9kQzKfWq9PCaGH2n1uvFw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 09:26:32 +0100
Message-Id: <DGN1S5X3G8U3.1ZM8WFKT6ZDKZ@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: warn when sstate is outside of
 build dir, but hash equiv database is inside it
Cc: "Alexander Kanavin" <alex@linutronix.de>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260223143118.1533806-1-alex.kanavin@gmail.com>
In-Reply-To: <20260223143118.1533806-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Feb 2026 08:26:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19081

On Mon Feb 23, 2026 at 3:31 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> This should help with the long-standing usability problem: when
> someone tweaks the configuration to put sstate somewhere else than
> the default (so that it can be shared between local builds, or over NFS),
> they should also share the hash equivalency database, but there would not
> be any indication to do so.
>
> This will issue a warning and recommend to start a dedicated hash equival=
ency
> server (if sstate is on NFS), or set BB_HASHSERVE_DB_DIR (if it isn't).
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---

Hi Alex,

Thanks for your patch.

It looks like this is breaking the
bb.tests.runqueue.RunQueueTests.test_hashserv_double test:

FAIL: test_hashserv_double (bb.tests.runqueue.RunQueueTests.test_hashserv_d=
ouble)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/runqueue.py", line 41, in run_bitbakecmd
    output =3D subprocess.check_output(cmd, env=3Denv, stderr=3Dsubprocess.=
STDOUT,universal_newlines=3DTrue, cwd=3Dbuilddir)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 466, in check_output
    return run(*popenargs, stdout=3DPIPE, timeout=3Dtimeout, check=3DTrue,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 571, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['bitbake', 'a1', 'b1', 'e1']' retu=
rned non-zero exit status 1.

The bb.tests.runqueue.RunQueueTests.test_hashserv_multiple_setscene test
is also failing, with a similar error.

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3266
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3144
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3385

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


