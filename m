Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22309CDC18E
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:17:40 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88677.1767701854512335998
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:17:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Dws8kGRT;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7AEF41A2696;
	Tue,  6 Jan 2026 12:17:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 420A260739;
	Tue,  6 Jan 2026 12:17:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBCFE103C85FD;
	Tue,  6 Jan 2026 13:17:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767701851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8icHQpQPka7w3sKTbQa3wmFDH/+IV1gMCeixfFMl6es=;
	b=Dws8kGRTEGqtEOvuPCCZBmRKV7l7InC2MDizb2IVcPtIQYpVgwui2cPd0JyFBmUzYg4OhF
	cgkHvjI3wfKAnG82F5c2gAd0R/YBcwCoGc/wdmkWtIHThnANsADYOpUQvDoxGtVnOcPf6F
	zV41iscx0pxKC77XbSUbry3JN1TsCTaHDFWjaiK6suIs6KFiEjzFTu/h+jmjj77LoMqqc9
	143x8uhB2fk8J9DC6APpyZtwUG3c/hcFKzpeG4lqxCr50TIHC9dCBS6IcQLume+zRGva2Q
	mTwJdZzbybqSrVKer39WP/ODg199X1AFG/w7/0iaD/KQLmWDMoVrdHky7E4qcw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 13:17:30 +0100
Message-Id: <DFHI0B8PG76H.BITRWRMUWDQG@bootlin.com>
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 09/10] doc: document fixed revisions
 override in bitbake-setup manual
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
 <20260106121033.3892596-9-alex.kanavin@gmail.com>
In-Reply-To: <20260106121033.3892596-9-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:17:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18702

Hi,

On Tue Jan 6, 2026 at 1:10 PM CET, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
> v2: address feedback by Antonin
> ---
>  .../bitbake-user-manual-environment-setup.rst | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index ec1bdeecd..fcffab812 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -938,3 +938,51 @@ Here is an example file that overrides the branch of=
 the BitBake repository to
>  -  The ``sources`` section contains the same options as the ``sources`` =
option
>     of a :term:`Generic Configuration` file. See the
>     :ref:`ref-bbsetup-section-config-reference` section for more informat=
ion.
> +
> +.. _ref-bbsetup-fixed-revisions:
> +
> +Fixed source revisions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:term:`Generic Configuration` can set source revisions in ``rev`` to a t=
ag or a branch.
> +Bitbake-setup will make sure the actual revision will match the tag or b=
ranch when performing
> +initializations or updates, and will capture the revisions in a :ref:`_r=
ef-bbsetup-source-overrides`
> +file.
> +
> +This file is named ``sources-fixed-revisions.json`` and is available in =
``layers/``
> +under the :term:`Setup` directory (as well as under ``config/`` for back=
wards compatibility).
> +It can be used to keep record of what was checked out when using configu=
rations that do not
> +specify exact revisions.
> +
> +Also, as it is an override file, it can be combined with the original co=
nfigurations
> +to initialize a setup in a reproducible way that guarantees an exact, ne=
ver-changing
> +set of revisions, by using the ``--source-overrides`` option of the
> +:ref:`ref-bbsetup-command-init` command.
> +
> +For example if the original configuration had specified only a master br=
anch
> +for a source::
> +
> +     "bitbake": {
> +         "git-remote": {
> +             "remotes": {
> +                 "origin": {
> +                     "uri": "https://git.openembedded.org/bitbake"
> +                 }
> +             },
> +             "branch": "master",
> +             "rev": "master"
> +     }
> +
> +
> +the override will contain the exact revisions::
> +
> +     "bitbake": {
> +         "git-remote": {
> +             "remotes": {
> +                 "origin": {
> +                     "uri": "https://git.openembedded.org/bitbake"
> +                 }
> +             },
> +             "branch": "master",
> +             "rev": "720df1a53452983c1c832f624490e255cf389204"
> +     }

Looking good, thanks!

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


