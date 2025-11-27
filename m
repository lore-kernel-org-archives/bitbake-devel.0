Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29806D11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 07:56:25 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13777.1764230177743179025
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Nov 2025 23:56:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=uGB8G3jx;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 85BC6C16A14
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 07:55:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48CFB6068C;
	Thu, 27 Nov 2025 07:56:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0127102F2585;
	Thu, 27 Nov 2025 08:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764230174; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mTLIq9ZJC5kri6l0FPIep915y/N2GAPYwt57Jw8ch68=;
	b=uGB8G3jxjHMZxYac1R5HO8Y/uIVHMLDjsjDslcrl/2SN3wQ/ZmaC+U2A6tyZ89F0a+mpQR
	3RJSmHTG0AobfBDvy1EtCFSNWOvZpF7hdGEM4LczzwI7HUGRa0FABpgdLQFFxsr/wOODKz
	yGOIhczF8MdH8T5VjSbZ2VorBTbR9okH3LILQVNuMFulpsJkjT37ix2/tap3ZH/HNyz9qe
	pT9AzRRppu1oXoOxDvZ1XTiQiN+TNsNxej7KQaBS85UA+WweFOOvW/cQe3E5kEPazOKDc/
	V56114SBpeOkbkXER56KKGV8w3Bn/GA8j+Ov6ultkyDztpNuFgOd2mhlhi3azQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Nov 2025 08:56:09 +0100
Message-Id: <DEJBEF60AW06.39XZQAP8JIJV3@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: add whinlatter configs
 for poky and oe-nodistro
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20251126085726.2502674-1-alex.kanavin@gmail.com>
In-Reply-To: <20251126085726.2502674-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 07:56:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18496

On Wed Nov 26, 2025 at 9:57 AM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> Compared to master, these:
> - adjust the branch names (particularly bitbake is at 2.16, making a refe=
rence
> for matching it with whinlatter branches in layers and docs)
> - adjust the description to add "release 5.3 'whinlatter'
> - add an 'expires' field so that bitbake-setup can print the date until
> the release is supported (and exclude it from 'list' and interactive 'ini=
t'
> thereafter, unless whinaltter is explicitly asked for).
>
> Bitbake-setup output:
>
> Available configurations:
> 1. poky-master	Poky - The Yocto Project testing distribution configuratio=
ns and hardware test platforms
> 2. oe-nodistro-master	OpenEmbedded - 'nodistro' basic configuration
> 3. poky-whinlatter	Poky - The Yocto Project testing distribution configur=
ations and hardware test platforms, release 5.3 'whinlatter' (supported unt=
il 2026-05-31)
> 4. oe-nodistro-whinlatter	OpenEmbedded - 'nodistro' basic configuration, =
release 5.3 'whinlatter' (supported until 2026-05-31)
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---

Hi Alexander,

Thanks for your patch.

It looks like this is breaking some test on the oe-core side:

2025-11-26 18:03:29,827 - oe-selftest - INFO - bblayers.BitbakeLayers.test_=
validate_bitbake_setup_default_registry (subunit.RemotedTestCase)
2025-11-26 18:03:29,828 - oe-selftest - INFO -  ... FAIL
...
{'description': "Poky - The Yocto Project testing distribution configuratio=
ns and hardware test platforms, release 5.3 'whinlatter'", 'expires': '2026=
-05-31', 'sources': {'bitbake': {'git-remote': {'remotes': {'origin': {'uri=
': 'https://git.openembedded.org/bitbake'}}, 'branch': '2.16', 'rev': '2.16=
'}}, 'openembedded-core': {'git-remote': {'remotes': {'origin': {'uri': 'ht=
tps://git.openembedded.org/openembedded-core'}}, 'branch': 'whinlatter', 'r=
ev': 'whinlatter'}}, 'meta-yocto': {'git-remote': {'remotes': {'origin': {'=
uri': 'https://git.yoctoproject.org/meta-yocto'}}, 'branch': 'whinlatter', =
'rev': 'whinlatter'}}, 'yocto-docs': {'git-remote': {'remotes': {'origin': =
{'uri': 'https://git.yoctoproject.org/yocto-docs'}}, 'branch': 'whinlatter'=
, 'rev': 'whinlatter'}}}, 'bitbake-setup': {'configurations': [{'bb-layers'=
: ['openembedded-core/meta', 'meta-yocto/meta-yocto-bsp', 'meta-yocto/meta-=
poky'], 'setup-dir-name': '$distro-whinlatter', 'oe-fragments-one-of': {'ma=
chine': {'description': 'Target machines', 'options': ['machine/qemux86-64'=
, 'machine/qemuarm64', 'machine/qemuriscv64', 'machine/genericarm64', 'mach=
ine/genericx86-64']}, 'distro': {'description': 'Distribution configuration=
 variants', 'options': ['distro/poky', 'distro/poky-altcfg', 'distro/poky-t=
iny']}}, 'configurations': [{'name': 'poky', 'description': 'Poky - The Yoc=
to Project testing distribution'}, {'name': 'poky-with-sstate', 'descriptio=
n': 'Poky - The Yocto Project testing distribution with internet sstate acc=
eleration. Use with caution as it requires a completely robust local networ=
k with sufficient bandwidth.', 'oe-fragments': ['core/yocto/sstate-mirror-c=
dn']}]}]}, 'version': '1.0'}: Additional properties are not allowed ('expir=
es' was unexpected)

https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/2897
https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2759
https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/2655

Can you have a look at this?

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


