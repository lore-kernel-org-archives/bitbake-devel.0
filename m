Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B66EEF315
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 07:39:40 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39379.1772696378398436611
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Mar 2026 23:39:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=MNhU0Z7E;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6EADCC40404
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Mar 2026 07:39:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E06885FDEB;
	Thu,  5 Mar 2026 07:39:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6303E10369827;
	Thu,  5 Mar 2026 08:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772696375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MpLwAh+2mbH0Y/6E+eBonStcBWhKtLzT2ElcyM0CS0o=;
	b=MNhU0Z7EAUkyHhokMpLSrIduuP8+G7JuM1mO96zxRtGou42fi9ZaIoEpGpmTNmZztU0BRe
	I0mWFGy5cxqX8F+eqagLMhmKMgrOCtCGtirecAHv5Oh1nqcMNRP6cnTVAKVUKwNSQ2Lx2x
	LAYbPnXKC07D4TeExWlwbtyYA87RAtxEekngJkW8aOO1R2VGwfnbm6+opb939DClA+zX25
	dTjCaOXVA5nxTohyZtrgPr+XSteaGf64Kzqny5IvXD6v613ZZJUaqxjafkrIxYL+FKBp94
	ILq/cPe6PKN0zEKLoq2BfjuXkR2FzZCGhSUdESnu+HEyPlWp64xXDROwC6w9cA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 08:39:25 +0100
Message-Id: <DGUOEZNW5M9V.3MTEVU4DE42P4@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: avoid reuse download filenames
Cc: "Pedro Ferreira" <Pedro.MS.Ferreira@ctw.mbwgroup.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <pmi183@gmail.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com>
In-Reply-To: <20260302151443.256386-1-pedro.ms.ferreira@ctw.bmwgroup.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 07:39:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19107

On Mon Mar 2, 2026 at 4:14 PM CET, Pedro Ferreira via lists.openembedded.or=
g wrote:
> When fetch task runs and while running checksum validation
> detects that for a source file the checksum mismatches,
> instead of aborting, its allowing to move aside and download again.
> This might allow users to taint the source files instead of acting
> as a safe mechanism to fix some issue occurred on the download stage.
>
> Signed-off-by: Pedro Ferreira <Pedro.MS.Ferreira@ctw.mbwgroup.com>
> ---

Hi Pedro,

Thanks for your patch.

I suspect this is making the bitbake-selftest fail:

ERROR: test_invalid_missing_donestamp (bb.tests.fetch.FetcherNoNetworkTest.=
test_invalid_missing_donestamp)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/fetch2/__init__.py", line 710, in verify_donestamp
    checksums =3D verify_checksum(ud, d, precomputed_checksums)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/fetch2/__init__.py", line 660, in verify_checksum
    raise ChecksumError("\n".join(messages), ud.url, bad_checksum)
bb.fetch2.ChecksumError: Fetcher failure for URL: 'http://invalid.yoctoproj=
ect.org/test-file.tar.gz'. Checksum mismatch!
File: '/tmp/bitbake-fetch-gc0zy9ws/download/test-file.tar.gz' has md5 check=
sum 'd41d8cd98f00b204e9800998ecf8427e' when '4221d002ceb5d3c9e9137e495ceaa6=
47' was expected
File: '/tmp/bitbake-fetch-gc0zy9ws/download/test-file.tar.gz' has sha256 ch=
ecksum 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855' w=
hen

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/3454
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3224

Can you have a look at these errors?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


