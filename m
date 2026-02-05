Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7202EC1E9B
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 11:08:10 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18233.1770289685878388164
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 03:08:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GPq3Z6wY;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C6E2B1A2C16
	for <bitbake-devel@lists.openembedded.org>; Thu,  5 Feb 2026 11:08:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9DBC8606FD;
	Thu,  5 Feb 2026 11:08:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 51EAD119A8891;
	Thu,  5 Feb 2026 12:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770289683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bf87w8zON6GA/XbmF4FCAMLERBc69Dc/IbPKEy0QjTA=;
	b=GPq3Z6wYkCNMrP1x8B2dHTGpU0gR1wq5w/GbzlThzgN1qnTIFgfkGPcUByQ28in6Zb206o
	Iwdjd04Vp/RHthHow2PLTRMNDWWXXIeBKBxQ9bOdE2Mz58fRWdoC9E4KJBxiPL/Dv3mfv3
	c7BccZFxtzDiuyBiebvY/9LfaAyJ1zqtljxGmNki5YWMGIQ9LPHt4CjhLfsdCUXoXoEkcd
	6YxSTPciAhy74yLuzFE8yvZczJmA7TtdS/C/ZrLTiFS/z/OO5yab1hAWJvuvk95e/GII7R
	KS84ZWtB0wRqNnXsERBKEecpCZFafTvEYHrYxZ5t1sM+uBagXLqfkq6bUfpgCA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 12:08:01 +0100
Message-Id: <DG6ZBGNEUSSR.E95H6B6IK8MM@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 2/2] bitbake-setup: share sstate by
 default between builds
Cc: "Alexander Kanavin" <alex@linutronix.de>
References: <20260129120421.4413-1-alex.kanavin@gmail.com>
 <20260129120421.4413-2-alex.kanavin@gmail.com>
In-Reply-To: <20260129120421.4413-2-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 11:08:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18962

On Thu Jan 29, 2026 at 1:04 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
[...]
> +            sstate_settings =3D textwrap.dedent(
> +                """
> +                #
> +                # Where to place shared-state files
> +                #
> +                # BitBake has the capability to accelerate builds based =
on previously built output.
> +                # This is done using "shared state" files which can be t=
hought of as cache objects
> +                # and this option determines where those files are place=
d.
> +                #
> +                # You can wipe out TMPDIR leaving this directory intact =
and the build would regenerate
> +                # from these files if no changes were made to the config=
uration. If changes were made
> +                # to the configuration, only shared state files where th=
e state was still valid would
> +                # be used (done using checksums).
> +                SSTATE_DIR ?=3D "{sstate_dir}"

Nitpicky I know , but we should add a line return here, as DL_DIR above is
already separated from SSTATE_DIR by a line return.

> +                #
> +                # Hash Equivalence database location
> +                #
> +                # Hash equivalence improves reuse of sstate by detecting=
 when a given sstate
> +                # artifact can be reused as equivalent, even if the curr=
ent task hash doesn't
> +                # match the one that generated the artifact. This variab=
le controls where the
> +                # Hash Equivalence database ("hashserv.db") is stored an=
d can be shared between
> +                # concurrent builds.
> +                BB_HASHSERVE_DB_DIR ?=3D "${{SSTATE_DIR}}"
> +                """.format(sstate_dir=3Dos.path.join(top_dir, ".sstate-c=
ache"))
> +            )

Antonin

