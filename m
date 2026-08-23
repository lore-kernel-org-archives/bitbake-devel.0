Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7207BC5DF81
	for <webhook@archiver.kernel.org>; Sun, 23 Aug 2026 08:14:20 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10811.1787472854738214625
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 23 Aug 2026 01:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=jUff6Jdl;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6145F4E41360;
	Sun, 23 Aug 2026 08:14:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C9C460378;
	Sun, 23 Aug 2026 08:14:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97F5511C77E0E;
	Sun, 23 Aug 2026 10:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787472847; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TCs3sIln9DcWhn6Fyy8h8mODk+tGM9ii6h1A5OXsaSQ=;
	b=jUff6Jdl6m23s22RKAVVJ2hW8kV9OiB5GRWOEb94nwDQ2ylkxYGtQ8Lj9Y4DDEwEMwHFxY
	WCSDkXc+wiRlgQSA0WPD5nCws83Qoan5k/Y/24aQSNfbKC4khZ9ajKIQpwj39TDQyY5BaA
	R2qMxnW4OCatz62uSfwnAJmZxIetCfEkg3TcBAZsAJ8Tn2sI7NXy95dTqLIVOL0mA1KAyG
	Wiohq46rGGq8CkiaFkH/ENbW10YU++LOgWNcYN0M8O7OuPud3nOK88WWsTWMLg4LEghlE4
	xceST7j+So8FU66cr+fepp6zIDklXGsGgey2vVWrxiXTRjDYoN+fmmfmvQBtvA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Aug 2026 10:14:03 +0200
Message-Id: <DKW68O7ETQ3B.PGWHY4WGZ75T@bootlin.com>
To: "Jaipaul Cheernam" <jaipaul.cheernam@est.tech>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2] parse: warn on trailing whitespace
 in parsed lines
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
 <20260806112435.25128-1-jaipaul.cheernam@est.tech>
 <DKNWRTWPZT8T.1ZLGV8S99L5N9@bootlin.com>
 <DU7PPF66507B2D7DF3AD4504715A950243CF3DB2@DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM> <1880129.1787221871218113438@lists.openembedded.org>
In-Reply-To: <1880129.1787221871218113438@lists.openembedded.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 23 Aug 2026 08:14:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20019

On Thu Aug 20, 2026 at 12:31 PM CEST, Jaipaul Cheernam wrote:
> Hi Mathieu,
>
> Both oe-core and metaopenembedded serires are accepted.
>
> https://patchwork.yoctoproject.org/project/oe-core/list/?series=3D49858&a=
rchive=3Dboth&state=3D*
> https://patchwork.yoctoproject.org/project/oe/list/?series=3D49954&archiv=
e=3Dboth&state=3D*
>
> Can you check on bitbake patch.
>
> Regards,
> Jaipaul

Hi Jaipaul,

I sent a patch to fix the last few things, but we should be good.

I note we have warnings on a few other layers tested on the autobuilder.
I can ask the maintainers to fix them once the patch is merged, but I'm
sure they would appreciate a patch to fix these.

https://autobuilder.yoctoproject.org/valkyrie/#/builders/75/builds/4317/ste=
ps/16/logs/warnings
https://autobuilder.yoctoproject.org/valkyrie/#/builders/89/builds/4284/ste=
ps/15/logs/warnings
https://autobuilder.yoctoproject.org/valkyrie/#/builders/14/builds/4270/ste=
ps/13/logs/warnings

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


