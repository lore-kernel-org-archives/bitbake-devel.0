Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4AE8307C
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 13:41:47 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20558.1770212502511094072
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Feb 2026 05:41:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ryltMmnP;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7C46B4E423F7
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Feb 2026 13:41:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4AB4860745;
	Wed,  4 Feb 2026 13:41:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2802119A865B;
	Wed,  4 Feb 2026 14:41:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770212499; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BlkvD2KnU2qCOJjJExoyQicP8RCO1u0TZ6+sBlO0ooc=;
	b=ryltMmnPCnAiYAr+7pHKuvrvNBKcLo7fquzwd6FKLcTAi0qvUMAYeDrzb3GNZDwCO1Cw7Y
	4O7OkCg9y46tUZcB9jpC9auT5fqZqNqH6DsbQtRJWly62BRIbJCBYKf6wSk7dy7GLDlvOK
	YUp6l3w3oxMUI0NSQDyUXNV/mUVOoFde/rNoDKYSp8Z+HlEjtj0htZDNo+4iZStAAdTRqA
	/xOH+COJnxOOh/ylFIkhxYrfNw60WLQ2OwBnodFtJ3rgR7m9SQECf2YiHGZSzjCPbxusEi
	lv2EHcRk8B4Be6aNpUr2G5/wgEtyadH89RV06M+VoB3TcyCSfnXZ/IueQq24oQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 14:41:38 +0100
Message-Id: <DG67YJ0354J5.3N96FN4DSMNML@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] doc: fix the switchers menu
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
 <ad6217119fe0e7382684ef6a41078e172a4e8498.camel@linuxfoundation.org>
In-Reply-To: <ad6217119fe0e7382684ef6a41078e172a4e8498.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Feb 2026 13:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18955

On Wed Feb 4, 2026 at 2:32 PM CET, Richard Purdie wrote:
> On Wed, 2026-02-04 at 11:03 +0100, Antonin Godard via lists.openembedded.=
org wrote:
>> Fix the switchers.js script of Bitbake to show what are the supported
>> versions and be able to switch between them.
>>=20
>> The default landing page is the stable branch and shows the BitBake
>> version along with the corresponding Yocto Project codename. This
>> hopefully makes it easier to remember the correspondance between the
>> BitBake version and the Yocto Project version.
>>=20
>> This works thanks to a set_versions.py script, which is largely inspired
>> from yocto-docs. It reads the tags from the repository and tries to
>> guess the currently checked out version of BitBake on which we are.
>>=20
>> The "obsolete" warning is now also shown when browsing outdated manuals,
>> meaning any version not part of activereleases in set_versions.py.
>>=20
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>> Note: This will be accompanied by a patch to adapt the Autobuilder to
>> generate this file for each release.
>> ---
>> Changes in v2:
>> - Remove environment information grabbing mechanism, making this fully
>> =C2=A0 standalone.
>> - Link to v1: https://lore.kernel.org/r/20250915-fix-switchers-js-v1-0-5=
23ef53fe802@bootlin.com
>> ---
>> =C2=A0doc/.gitignore=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
>> =C2=A0doc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 3 +-
>> =C2=A0doc/bitbake.yaml.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>
> I was about to merge this however is there a requirement to use yaml
> here? I ask mainly as we don't currently have yaml config files and I'd
> prefer not to start adding them and try to remain consistent with what
> we're using...

You're right, I don't see any obvious reason to use yaml either, and we cou=
ld
use JSON instead. I just aligned with what was done on yocto-docs without t=
his
afterthought. I'd be happy to make the switch (here and perhaps we could al=
so do
that on yocto-docs). I'll try it out, thanks.

Antonin

