Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A424C4332F
	for <webhook@archiver.kernel.org>; Mon,  3 Oct 2022 21:06:43 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web08.3048.1664831198409177809
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Oct 2022 14:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=D2tDgEGr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id F3F7D40004;
	Mon,  3 Oct 2022 21:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1664831196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQOsVFf+gwk1S1qOTuC9y39/6kgn/4dDoBnTQyE1Lc8=;
	b=D2tDgEGrkbBXTGfXqQJYVHQOUIFMKMbBLsEz0arXfUVCx74qa8hB0Id6npJmiBQl5DfTTO
	vuJaz12jvwvcG7JpBtY4makOMN1asnvLZbjtMbr44nB0oWIYqAZ9hlSUGw4nTjL1ft/p0F
	QvM8Py+GLYJ9iG5Hk4EXzP6CJpwR56j/AL22pJaNbnqCLI6KO5GS57xKQzlpD7/OGXtEhZ
	vQRJkePOXQnyiVpbrc8X3s7F6DpZxK2WnX2Fej7BnFohLbYswnTbSvLg+1JUdwc/U4DKQU
	YSeXtHd5rrXNT0X7snLg31lWaobFduMrAxts1RJFy7B98aiJmxVjZCeDmvPd0Q==
Date: Mon, 3 Oct 2022 23:06:34 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Richard Greer" <rg@braneaudio.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] Change git lfs support to allow for
 destsuffix being set.
Message-ID: <20221003230634.529ca225@booty>
In-Reply-To: <00fa7401-7894-3c86-6b25-3ad62d184260@braneaudio.com>
References: <00fa7401-7894-3c86-6b25-3ad62d184260@braneaudio.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Oct 2022 21:06:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14014

Hello Richard,

On Mon, 3 Oct 2022 12:58:14 -0500
"Richard Greer" <rg@braneaudio.com> wrote:

> From: Richard Greer <rg@braneaudio.com>
>=20
> When getting large files with git lfs need to try and recreate the path=20
> where the repo
> is actually located after the unpack.
>=20
> If destsuffix or subdir (where subdir is not an absolute path) is set=20
> then it will not be in
> tmpdir/git.
>=20
> It looks like the more correct place would be in ud.destdir.
>=20
> This does not address the issue where it will fail in the unpack if=20
> subdir is an absolute path
> since it cannot possibly be in the same path as the tmpdir.=C2=A0 I have =
no=20
> idea as to how to
> deal with that.

Text wrapping seems broken in the text. Not necessarily a big problem,
but not nice to read.

> Signed-off-by: Richard Greer <rg@braneaudio.com>
> ---
>  =C2=A0bitbake/lib/bb/fetch2/git.py | 4 ++--
>  =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index f0df6fb69b..fa454a1c07 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -421,8 +421,8 @@ class Git(FetchMethod):
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # Only do this if the unpack resulted in a .git/lf=
s=20
> directory being
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # created; this only happens if at least one blob=
=20
> needed to be
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # downloaded.
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if os.path.exists(os.path.join(tmpdir, "git", ".git",=20
> "lfs")):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfetchcmd("tar -cf - lfs | tar=
 -xf - -C %s" %=20
> ud.clonedir, d, workdir=3D"%s/git/.git" % tmpdir)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if os.path.exists(os.path.join(ud.destdir, ".git", "lfs"=
)):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 runfetchcmd("tar -cf - lfs | tar=
 -xf - -C %s" %=20

Here wrapping is also wrong, but this one is definitely a problem. You
must not wrap a line in a patch, otherwise it won't apply.

I strongly suggest to use 'git format-patch' + 'git send-email' to send
a patch. Those tools will ensure the patch is not mangled, and it will
apply correctly. More info at
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded

Can you please send a v2 with that fixed?

Best regards.
--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

