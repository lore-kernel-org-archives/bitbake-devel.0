Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1648CAC582
	for <webhook@archiver.kernel.org>; Sun, 14 Sep 2025 09:37:57 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.6299.1757842673260869288
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Sep 2025 02:37:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DlW04rVn;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 67F244E40BE3
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Sep 2025 09:37:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D0EC6063F;
	Sun, 14 Sep 2025 09:37:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EB7F102F2925;
	Sun, 14 Sep 2025 11:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757842670; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aGySmb3kaI73tKDVmq+Vkw9bty9Ecw6mSKStpkkLNKI=;
	b=DlW04rVnvyt1GAyca/z0pqIQZWyPpkmGdQd/Fa97zUbqIKqhReTQnJKtv8WwowqWFPl3/S
	CyCKFNK9zJRFycdmt+16sgYTBxkmN45FeLLkoUQFMW+0f+e6YkOc0YvPYmPqSV9IrjxOlN
	S3sxrAx9tn6Pobn+jSlaecGwjG8rFQ6S+2oOzv/QZ2n8v0tApRpUtzCi7PRuDmHH73P79d
	B50bKcTP+8rDszBcN3lNBoL8SUcSFyhdBnBoiNbq1gGM+cJV4WbDkeqQ0kS6xXkkk9tFEt
	T1AEsXnMQL8IIuxqB5hyg4/JB42GncIuzj8hLdBtfpQGoK2V+YZV1/eaWpkc+A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 11:37:41 +0200
Message-Id: <DCSF7UFWPY45.1A12IA8MQQ968@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <reatmon@ti.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [bitbake][PATCH 1/3] bitbake-setup: Tweak user
 inputs
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250912204559.10360-1-reatmon@ti.com>
In-Reply-To: <20250912204559.10360-1-reatmon@ti.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Sep 2025 09:37:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18017

On Fri Sep 12, 2025 at 10:45 PM CEST, Ryan Eatmon via lists.openembedded.or=
g wrote:
> Create a common function to get the user input when choosing an item
> from a list.  Add support for not returning from the function until the
> user has selected a number.
>
> When choosing items from the option list, if there is only one item,
> then auto select it.  This is similar to code when picking the
> configuration.
>
> Signed-off-by: Ryan Eatmon <reatmon@ti.com>
> ---

Hi Ryan,

Thanks for your patches.

I suspect one of them is responsible of this error we got on the
autobuilder:

FAIL: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/bitbake/lib/b=
b/tests/setup.py", line 222, in test_setup
    self.assertIn("test-config-1", json_configs)
AssertionError: 'test-config-1' not found in {'test-config-1.conf': {'descr=
iption': 'Test configuration'}, 'test-config-2.conf': {'description': 'Test=
 configuration'}}

https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2252
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2324
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2469

Can you have a look at this, please?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


