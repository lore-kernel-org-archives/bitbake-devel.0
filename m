Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F7FCC6B0A
	for <webhook@archiver.kernel.org>; Tue, 13 Oct 2026 05:17:12 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.680.1791868625929336832
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2026 22:17:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=C0xwIbpK;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9FD811A11FE
	for <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 05:17:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 635CC60362;
	Tue, 13 Oct 2026 05:17:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8A96111D7012D;
	Tue, 13 Oct 2026 07:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791868622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gn1rljDeiPnFvSTgHCpBN5aKPPkgygvYantbjdO7IsM=;
	b=C0xwIbpKKdP/U7JuRA1bcXQIRv+z7OxGiFi8mQBnm+eBgByBYi3p6JvTP5opHjquD8l7Yo
	+Bf9o1BDK+WDiBA0iamMq2b8GYYxQ6fVNRKcW4gCl2mL7NF5mi52Z/xv0mdZPOzB/JnxI6
	f6KqOEnnkDrJyd8uY1Ya0rOH/ouutQoNqvralqfrEa84xeqqViIdkPEoyiKj2N5Uo4vtWV
	h28CIDmYxot0z+HQk9ifyRZOp477e3sFUTQTZ6jSDtbUDUokN7uvAcXzETIdzqPOCiorIX
	6ukkCw4clcxzqE8ruTTjrfHee+vO3QS2B6uiOz7Yu7xM5iGz8Z5I/qfy0RCoFA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 07:17:00 +0200
Message-Id: <DM3GEW286NB5.302OAXPFSNBM5@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/2] data_smart: restore the ability
 to use capital letters
Cc: <docs@lists.yoctoproject.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20261007125138.59937-1-yann.dirson@vates.tech>
 <20261012084202.103724-1-yann.dirson@vates.tech>
 <1791794550.8631fc262581453bbf619ec5b2062170.1a12f4716e800080d7@vates.tech>
In-Reply-To: <1791794550.8631fc262581453bbf619ec5b2062170.1a12f4716e800080d7@vates.tech>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Oct 2026 05:17:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20321

On Mon Oct 12, 2026 at 10:39 AM CEST, Yann Dirson via lists.openembedded.or=
g wrote:
> This reverts commit 6eb56624e6d8dc1944e559b4f6584bfe66f566ba.
>
> That commit was meant as an ad-hoc band-aid when "_" was used as
> override prefix, and it explicitly blocked capital letters from being
> usable in the overrides.  There is no reason to keep it now we use ":"
> as prefix.
>
> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
> ---

Hi Yann,

Thanks for the new version, but we are still seeing the same failure:

FAIL: test_append_in_expanded_override (bb.tests.data.TestOverrides.test_ap=
pend_in_expanded_override)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/lib/bb/tests/data.py", line 417, in test_append_in_expanded_override
    self.assertEqual(self.d.getVar("TEST"), "base appended")
AssertionError: 'base' !=3D 'base appended'
- base
+ base appended

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/5075
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/5043
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4856

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


