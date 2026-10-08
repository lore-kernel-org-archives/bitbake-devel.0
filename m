Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E0CA6007
	for <webhook@archiver.kernel.org>; Thu,  8 Oct 2026 09:44:06 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11645.1791452638678105370
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Oct 2026 02:43:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Gv0g3rZS;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B99974E4119A
	for <bitbake-devel@lists.openembedded.org>; Thu,  8 Oct 2026 09:43:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8D32160341;
	Thu,  8 Oct 2026 09:43:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B8511033038C;
	Thu,  8 Oct 2026 11:43:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791452636; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GZWM27dPHDmgueUmkDTpkr1RiysIwGjOUkXEHt5T2us=;
	b=Gv0g3rZSCgAlUAiijZhNazhghSco1ybkqTlsuPwi0tOvmCoLlPufchm7Yav9DSp+j4MBdl
	3DEZHk+4IZLhJZ0WTSlvyQajRBr0Y5n3BBj49Yi1A+uGmTDyxjEeuFxRUMNEGTMRGzhv5O
	BZhcaO77V6FdTo758hme12frR6XMsCzSYpCMLsv+KZZ6swp9rWXMo9Wt3QDP7m0qgTsXWI
	+hBrJ9PFCv7I34ul5rImj/GCqKip0h+2wFJV7yI5mKw4ykpW3+hlzoRYmkA1AHrL48yE8J
	dL7nKBwXVueum+mTZfgXnQw6IfP5LkrK0yWJv0PZDygy0tHbfCPU7WOHWi0X3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 11:43:54 +0200
Message-Id: <DLZCYIY5W05O.1MX2P15W1LMLV@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] parse: add a (failing) test for a
 variable override with capital letters
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <1791377513.8631fc262581453bbf619ec5b2062170.1a1166b9ac40003f66@vates.tech>
In-Reply-To: <1791377513.8631fc262581453bbf619ec5b2062170.1a1166b9ac40003f66@vates.tech>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Oct 2026 09:44:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20306

On Wed Oct 7, 2026 at 2:51 PM CEST, Yann Dirson via lists.openembedded.org =
wrote:
> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
> ---

Hi Yann,

Thanks for your patch.

This appears to be failing selftests:

FAIL: test_append_in_expanded_override (bb.tests.data.TestOverrides.test_ap=
pend_in_expanded_override)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/layers/bitbake=
/lib/bb/tests/data.py", line 417, in test_append_in_expanded_override
    self.assertEqual(self.d.getVar("TEST"), "base appended")
AssertionError: 'base' !=3D 'base appended'
- base
+ base appended

https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/5024
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/5055
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/4838

Can you have a look at the issue?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


