Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E7D74967
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 08:44:37 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13078.1766133872889567834
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 00:44:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oh0yHv/j;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DC27E1A22E6;
	Fri, 19 Dec 2025 08:44:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A97886071D;
	Fri, 19 Dec 2025 08:44:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3275B102F0B57;
	Fri, 19 Dec 2025 09:44:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766133868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ApOL1XPOwUIkXNxGlChZZvocSCo+/+/hdFpV5CpsK8o=;
	b=oh0yHv/jgyR9kvW2O1v9fwOsHWMIf+RSNv+TMmv1d2jpMNKG4QSdSrtHVa9Nd+4P9fZ16m
	POqgX/CEfbVZZ0fgwDK1PXoYF7FlU4fAS+aaIqfmaXYo6zNzB0ufA6OJsFjDALbYB9Skjz
	ExuvpJIL9iqjkwGliFid/pZWWQwR4oTCzrhZXXQ53hdQLBWbHWSU09kQuhgFI23MJmkOUl
	KXkDl5UeEvBFI+CYAukHycEffSXDQDtEtQiTAxvKsdyJY1/g25rs/GEz3snpDKcJ8gJF2S
	XUN7Q9MOkYLnJ9O29fe/uaBUUg/WPwxmSvmvvDz/3KIMknIvDpJJSs0YUQUGrg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Dec 2025 09:44:25 +0100
Message-Id: <DF227D3UEFF6.E74AE0VVVWS5@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [RFC PATCH 2/2] bitbake-setup: share sstate by
 default between builds
Cc: "Alexander Kanavin" <alex@linutronix.de>
References: <20251215145418.2680311-1-alex.kanavin@gmail.com>
 <20251215145418.2680311-2-alex.kanavin@gmail.com>
In-Reply-To: <20251215145418.2680311-2-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 08:44:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18613

Hi,

On Mon Dec 15, 2025 at 3:54 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> Nowadays sharing sstate must also include sharing the hash equivalency
> information and thus, managing a hash equivalency server. There are
> two ways to do it:
>
> - starting/stopping the server outside the bitbake invocations, and
> guaranteeing that it's available when bitbake is invoked.
>
> - using bitbake's built-in start/stop code which launches a server
> before a build starts and stops it when a build is finished; essentially
> this is a private server, using a database private to a build directory
> (by default).
>
> I couldn't come up with a good way to do the first option in bitbake-setu=
p:
> it needs to be invisible to users, they should not have to run special co=
mmands
> and they should not wonder why there is a mysterious background process.
> It's not impossible to auto-start a shared server, but that will quickly
> run into synchronization issues: if one server is being started, another
> should not be started at the same time. If one server is shutting down
> (e.g. after an inactivity timeout), another starting server should wait
> until it frees the socket, and block all bitbake invocations on that.
> Memory resident bitbake does this in lib/bb/server/process.py with a lot =
of
> complexity, and I don't think it should be added to the hash server as we=
ll.
>
> On the other hand, hash equivalency database is sqlite-driven, and sqlite
> documentation reassures that sharing it between different simultaneous
> processes is okay: nothing will get lost or corrupted: https://sqlite.org=
/faq.html#q5
>
> I've confirmed this by running simultaneous builds that way: nothing
> unusual happened, and sstate was shared as it's supposed to.
>
> There's a new setting that turns off this behavior for situations
> where the server and sstate are managed externally.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 6f7dba16c..f382f6eb0 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -777,6 +777,12 @@ def create_siteconf(top_dir, non_interactive, settin=
gs):
> =20
>          os.makedirs(top_dir, exist_ok=3DTrue)
>          with open(siteconfpath, 'w') as siteconffile:
> +            sstate_settings =3D textwrap.dedent(
> +                """
> +                SSTATE_DIR =3D "{sstate_dir}"
> +                BB_HASHSERVE_DB_DIR =3D "{sstate_dir}"

Like DL_DIR, it would be nice to add a comment to explain what these variab=
les
do.

Maybe needs some rework but something like this (adapted from poky's templa=
te
files):

```
# Where to place shared-state files
#
# BitBake has the capability to accelerate builds based on previously built=
 output.
# This is done using "shared state" files which can be thought of as cache =
objects
# and this option determines where those files are placed.
#
# You can wipe out TMPDIR leaving this directory intact and the build would=
 regenerate
# from these files if no changes were made to the configuration. If changes=
 were made
# to the configuration, only shared state files where the state was still v=
alid would
# be used (done using checksums).
SSTATE_DIR =3D "{sstate_dir}"

# Hash Equivalence database location
#
# Hash equivalence improves reuse of sstate by detecting when a given sstat=
e
# artifact can be reused as equivalent, even if the current task hash doesn=
't
# match the one that generated the artifact. This variable controls where t=
he
# Hash Equivalence database ("hashserv.db") is stored and can be shared bet=
ween
# concurrent builds.
BB_HASHSERVE_DB_DIR =3D "{sstate_dir}"
```

We would probably also need an sstate-dir setting, like dl-dir?

FWIW, I've tested this locally and it works as expected but I did not run
concurrent builds.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


