Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EEECCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 11:23:22 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15399.1762255395507039025
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Nov 2025 03:23:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iaOyW8be;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 57E251A1866
	for <bitbake-devel@lists.openembedded.org>; Tue,  4 Nov 2025 11:23:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29CB5606EF;
	Tue,  4 Nov 2025 11:23:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 904F710B50C71;
	Tue,  4 Nov 2025 12:23:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762255392; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ifxSgjaugHKRRLWa3T/OgcBNu8JsYjdRpfPcqLNLAeA=;
	b=iaOyW8beW8qBDkBM11nQZY+wio+EW8kOovxlt+BxGf8cbS827BesU1T2Vc8MmYNiZoagSM
	SD7Tqjl7aL2hnThtBxnbEWnTl3iOzMhmz4avw5LK6lyOvIazZcCZ7pQKQUdNgJLbjt0Xt6
	pmkVxZKSg9rNJJKj7X0IeVrn4pXWxp8L8VRGtwk47eOwpuFs+C26cy3qyZjIjmTKBBnOvB
	DxMe+Z3LHAKiXvVXN6Z5cXSometQDJyit3vucoGSI/C/i64uELW5QXd80puKEoe/kZ+ErU
	jjQ0rDf31tvgpO4rEs647syI3NhQ5CnvTXcJWsPnFupR/Sp2nUP16aaRusgDqA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 12:23:10 +0100
Message-Id: <DDZVEE4GD73D.1NPPO1ZUVS0CC@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: make "path" optional
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yoann.congal@smile.fr>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251103214804.2004903-1-yoann.congal@smile.fr>
In-Reply-To: <20251103214804.2004903-1-yoann.congal@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Nov 2025 11:23:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18250

On Mon Nov 3, 2025 at 10:48 PM CET, Yoann Congal via lists.openembedded.org=
 wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>
> Layer names and path are often redundant. Allow users to omit the path
> key when it is equal to the layer name by using the layer name as a
> default value for its path.
>
> For example, from poky-master.conf.json:
>   "bitbake": {
>     ...
>     "path": "bitbake"
>   },
>   "openembedded-core": {
>     ...
>     "path": "openembedded-core"
>   },
>   "meta-yocto": {
>     ...
>     "path": "meta-yocto"
>   },
>   "yocto-docs": {
>     ...
>     "path": "yocto-docs"
>   }
>
> Remove redundant "path" keys from default-registry and tests.
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> Note: Now that all "path" keys are removed (because they were all redunda=
nt),
> we need to ensure the "path" code path is tested by adding a test for
> it.
> ---

Hi Yoann,

Thanks for your patch.

It looks like this is breaking a selftest:

ERROR: test_setup (bb.tests.setup.BitbakeSetupTest.test_setup)
...
bb.process.ExecutionError: Execution of '/srv/pokybuild/yocto-worker/oe-sel=
ftest-armhost/build/layers/bitbake/bin/bitbake-setup --global-settings /tmp=
/bitbake-fetch-l9mrbqbo/global-config status' failed with exit code 1:
Traceback (most recent call last):
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 860, in <module>
    main()
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 854, in main
    args.func(top_dir, all_settings, args, d)
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 541, in build_status
    if are_layers_changed(current_upstream_config["data"]["sources"], layer=
dir, d):
       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^
  File "/srv/pokybuild/yocto-worker/oe-selftest-armhost/build/layers/bitbak=
e/bin/bitbake-setup", line 492, in are_layers_changed
    repodir =3D r_data["path"]
              ~~~~~~^^^^^^^^
KeyError: 'path'

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2787
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2652
https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2787

Can you have a look?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


