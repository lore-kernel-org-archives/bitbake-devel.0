Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28013CDB470
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 08:08:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16199.1782202081943693022
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jun 2026 01:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Y50g6iuT;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A01D71A0843
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2026 08:07:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 74EF1601C2;
	Tue, 23 Jun 2026 08:07:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3AFD6106C89DD;
	Tue, 23 Jun 2026 10:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782202079; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nuALitEP6n1Ct2At2PN4vMVLVSTbc27FZS13Az8LlCA=;
	b=Y50g6iuTTc3atkCdBCtEqfJBN5xSgCaf3C6H+y1GrfBmo+ANhMt2/vOMNUKU4eaksE4lEr
	m6y4Gnt8KqhZ6vRd3xNDw38TSTyIawuiUU79eCS3vak8PraxrLFdeEYsxVZ3YryzfOiG/J
	X8rlBERex19N5Fq6jeenSjsJdnOewwnjRbM2dTqk6vcxor4m9P+Najhr+2IsrNP6AflJjE
	zwwF59Ryhz8JVITthbSRB6fC9KoavuqPL1OiGgqD8QLZ3mbN4E3EdoAVWQfNxckJ665loi
	H0rCx32Blx47ZOXW7WRSAYXlzuuxVdEeoB1oENuRXrmxU+yd4/UQ23IaOxrogQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 10:07:56 +0200
Message-Id: <DJG9WRF0A154.2SEDAR8FEZSMW@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Only fetch extra shallow
 refs that exist
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <peter.kjellerstedt@axis.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260620174416.1489364-1-pkj@axis.com>
In-Reply-To: <20260620174416.1489364-1-pkj@axis.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Jun 2026 08:08:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19764

On Sat Jun 20, 2026 at 7:44 PM CEST, Peter Kjellerstedt via lists.openembed=
ded.org wrote:
> When using BB_GIT_SHALLOW_EXTRA_REFS in combination with a recipe that
> fetches multiple URLs, make sure to only fetch the references that exist
> in the respective remote repositories.
>
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---

Hi Peter,

I suspect this is breaking the GitShallowTest bitbake selftest:

ERROR: test_shallow_extra_refs (bb.tests.fetch.GitShallowTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/tests/fetch.py", line 2250, in test_shallow_extra_refs
    self.assertRefs(['master', 'origin/master', 'origin/a_branch'])
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/tests/fetch.py", line 1866, in assertRefs
    full_expected =3D self.git(['rev-parse', '--symbolic-full-name'] + expe=
cted_refs, cwd=3Dcwd).splitlines()
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/tests/fetch.py", line 438, in git
    return bb.process.run(cmd, cwd=3Dcwd)[0]
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/process.py", line 189, in run
    raise ExecutionError(cmd, pipe.returncode, stdout, stderr)
bb.process.ExecutionError: Execution of 'git -c safe.bareRepository=3Dall r=
ev-parse --symbolic-full-name master origin/master origin/a_branch' failed =
with exit code 128:
fatal: ambiguous argument 'origin/a_branch': unknown revision or path not i=
n the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
refs/heads/master
refs/remotes/origin/master
origin/a_branch

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4178
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/4119
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3949

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


