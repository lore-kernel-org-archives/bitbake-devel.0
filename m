Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F1C47BC9
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 08:52:07 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.86149.1767689523198671367
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 00:52:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=f5STu+3a;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 11AB21A2691;
	Tue,  6 Jan 2026 08:52:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB3C960739;
	Tue,  6 Jan 2026 08:52:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52FA3103C85DD;
	Tue,  6 Jan 2026 09:51:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767689520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MxcYKwrjR4UicAH8UootFLXfc1+Qmwqbpt6YAln/YM4=;
	b=f5STu+3aLgYOzXIot3PiNkdqdhS+fjTi4+NlSDQFGNi9fzw0RARl9i19CiSSDh5F2+SfJH
	j6igoqviC2+PZ7Tv8tqsuZcguVxSuupFbpa8LGAWsXb/LwCudlmfJkj4Hz4WWSokoQ7mQN
	jyV/BvihwvaNu4UvBMJF2KLhE6xJ3Y7/nxK8/rDM/+arJ3nrjRcHJMzf3G3Q64I7vkkZVL
	Y//gqt28iFQ3U+nLNWpj7b+N5C8934e5fobskJfzyqPD2dBmB9KROgy5h0ZdpOJH/wmphp
	wdwUhunUdKMTKxkBKFkYn25uc0xqbwwWG2M41Z1C8BmOpH2wiW+BGlUZwn4IgQ==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Jan 2026 09:51:58 +0100
Message-Id: <DFHDMY9WEY3D.RDQ8ZANAMU5L@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 09/10] doc: document fixed revisions
 override in bitbake-setup manual
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
 <20260102193438.2960561-9-alex.kanavin@gmail.com>
In-Reply-To: <20260102193438.2960561-9-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 08:52:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18690

Hi,

On Fri Jan 2, 2026 at 8:34 PM CET, Alexander Kanavin via lists.openembedded=
.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  .../bitbake-user-manual-environment-setup.rst | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index ec1bdeecd..68b2ad31d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -938,3 +938,49 @@ Here is an example file that overrides the branch of=
 the BitBake repository to
>  -  The ``sources`` section contains the same options as the ``sources`` =
option
>     of a :term:`Generic Configuration` file. See the
>     :ref:`ref-bbsetup-section-config-reference` section for more informat=
ion.
> +
> +.. _ref-bbsetup-fixed-revisions

Missing colon at the end:

.. _ref-bbsetup-fixed-revisions:

otherwise this is treated as a comment.

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
> +The file is named ``sources-fixed-revisions.json`` and is available in `=
`layers/``

s/The/This/ ?

if this is a continuation to your previous sentence

> +or ``config/`` under :term:`Setup` directory. It can be used to keep rec=
ord of

s/under :term:`Setup` directory/under the :term:`Setup` directory/

Why layers/ _or_ config/? It's ambiguous for users reading here what the
difference between the two might be. If this is a compatibility thing (beca=
use
bitbake-setup used to do it one way, then it was changed to another locatio=
n), I
would just keep the final one documented here (or explain that it's for
compatibility).

> +what was checked out when using configurations that do not specify exact=
 revisions.
> +
> +Also, as it is an override file, it can be combined with the original co=
nfigurations
> +to initialize a setup in a reproducible way that guarantees an exact, ne=
ver-changing
> +set of revisions.
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

"""
This file can later be used with the ``--source-overrides`` option of the
:ref:`ref-bbsetup-command-init` command.
"""

?

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


