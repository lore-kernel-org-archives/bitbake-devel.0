Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850EE77170
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 17:29:35 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.20491.1733333371777694921
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 09:29:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VAyeJzqD;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63BE5240002;
	Wed,  4 Dec 2024 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733333370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VRZSyUlRZLJnJ84txPWJ63lJVXppTU7t64U1OiMejU=;
	b=VAyeJzqDJiJoOyv8A4ayPrL63S6NwJwll8HqV0jwfrxfTokDsVLGakbh4Axj3SuLxYvEIC
	YG5ny4OnfXXHKk8lTCqMQoDzTAOAxfJQpKzLPvUgLRXrbF/dasENgtN25sjXToRFI6tvmj
	VZXDD+g98PiuyoJbLBS6xY5JTYrxVU5Ly4ULoSvNGcBJIRQvbJAP+GCXdeiVzHSxLi2xRn
	xzC8mf5sRDHQEH45w+63kPMa2zppIe5plq8RdTU9rwxUeq2AomOgH4w6k9z9fuQkS+lVQt
	29Bn4F01yTFQk6jvnIO3DrixYIGUVKcz3HYqiYFcoC3GWvKiOGYJkv5fQNiFAg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Dec 2024 18:29:28 +0100
Message-Id: <D633ECVEQJPV.RW45QS9AIPTJ@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/tests: use bb.build.listtasks()
 instead of __BBTASKS
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <ross.burton@arm.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241204101911.1218039-1-ross.burton@arm.com>
In-Reply-To: <20241204101911.1218039-1-ross.burton@arm.com>
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 17:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16865

On Wed Dec 4, 2024 at 11:19 AM CET, Ross Burton via lists.openembedded.org =
wrote:
> Use the new listtasks() function (introduced in 185c4b) to avoid
> accessing a private variable.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---

Hi Ross,

I believe some oe-selftest will need update after this modification. I
have the following error on the autobuilder:

FAIL: test_parse_addtask_deltask (bb.tests.parse.ParseTest.test_parse_addta=
sk_deltask)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-ubuntu/build/bitbake/lib/bb=
/tests/parse.py", line 204, in test_parse_addtask_deltask
    self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'do_mytas=
k', 'do_mytask2', 'do_mytask5'], bb.build.listtasks(d))
AssertionError: ['do_fetch2', 'do_patch2', 'do_myplaintas[39 chars]sk5'] !=
=3D ('do_fetch2', 'do_patch2', 'do_myplaintas[39 chars]sk5')

https://valkyrie.yoctoproject.org/#/builders/48/builds/502/steps/11/logs/st=
dio

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


