Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83916C02181
	for <webhook@archiver.kernel.org>; Sun, 26 Jan 2025 09:24:32 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.27349.1737883467786596904
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jan 2025 01:24:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bvoEiXrZ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 139821C0003;
	Sun, 26 Jan 2025 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737883465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELBQpFac+2TEbZBd3AvEZacE/X/o58GZ7m2zwvggGQU=;
	b=bvoEiXrZiO/onBvmxnMKnZcprcFXATWGbCn0Cl9c8vmrFAlWFgiK+FHQuni0tYvSxNZOvn
	rKajvw0L2Fs7YYykkXU/5a4H4rrchw9xMrv/OaYLlTvytz71RAVVMav9mbZPmp3PuwKjwT
	JVUYIFR3Baua95NoJMdM0a0aRe0rxMHlmOlMVTQKUVko3C3Hs5gUaQIN7GLOX886GqX3Kn
	Ag4S/V5lrvzJOcmQ/huSP+GCabQPNEB7N0ipokj7LPowk/1dp5dWBPW3IhQBkTEIdLJv59
	CGeO7kP6uFUJfeK/hmQXHN3YJ8vet4aqF5sBqUWj/wFziT5nLUUjcl3Opw49iw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Jan 2025 10:24:24 +0100
Message-Id: <D7BW9U116IIF.RXB99Y9X33WV@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] runqueue: add 'default' mc
 translation to mcdepends
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Mark Hatle" <mark.hatle@kernel.crashing.org>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
In-Reply-To: <1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jan 2025 09:24:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17088

On Fri Jan 24, 2025 at 3:50 AM CET, Mark Hatle wrote:
> From: Mark Hatle <mark.hatle@amd.com>
>
> The default mc is '' (blank), however BB_CURRENT_MC returns 'default'.
> Allow a user to specify a mcdepend such as:
>
>   mc:${BB_CURRENT_MC}:m2:recipe:task
>
> Both '' (blank) and 'default' are now supported and have equivalent
> meaning.
>
> Signed-off-by: Mark Hatle <mark.hatle@amd.com>
> Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
> ---

Hi Mark,

Thanks for your patch.

I believe one of the patch from this series is responsible for some
failures we can see on the autobuilder:

FAIL: test_multiconfig_mcdepends (bb.tests.runqueue.RunQueueTests.test_mult=
iconfig_mcdepends)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb=
/tests/runqueue.py", line 41, in run_bitbakecmd
    output =3D subprocess.check_output(cmd, env=3Denv, stderr=3Dsubprocess.=
STDOUT,universal_newlines=3DTrue, cwd=3Dbuilddir)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 466, in check_output
    return run(*popenargs, stdout=3DPIPE, timeout=3Dtimeout, check=3DTrue,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 571, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['bitbake', 'g1']' returned non-zer=
o exit status 1.


https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/846/step=
s/11/logs/stdio

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


