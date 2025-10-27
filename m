Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF571CCF9EA
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 14:23:15 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.34339.1761574988353362484
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 07:23:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=z/9FgeRX;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 234C8C0BE83;
	Mon, 27 Oct 2025 14:22:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 400BA6062C;
	Mon, 27 Oct 2025 14:23:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29890102F24D3;
	Mon, 27 Oct 2025 15:23:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761574985; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VO6aCNX+7iVnup/9y8FwDba0q7FFcBloRWZF9fQz9As=;
	b=z/9FgeRXXCkLqIAv8IbMpA8LouogpcPPkqCmQLWRd4uWpuSQ8zp+mRCAvhi3ODJagtEx53
	gFduFF28fHSwJb1CIs6WfihHlEScvVeMCk6Vd6WARDx8F3/d7oKgomxxF2baoPFotzcOiY
	af6lD57bmxPUDnWV7JOXxjDW1ZTEEVeDzmcBD/OoYyXKTeoS5f4gpfWzV/6GIoYfWV00H6
	BrsITm5qguGQzOuvsPGF2UzVm7Srou/zWPFc5wyjj+270JRlZz9wak+VoVnHuo+3mpcrnt
	k+En56/HSyNAwrf3mRpwZOdsMdnOUkJYMCJL5CVal4X2KGiAkAWnYT7+4KKPNg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 15:23:03 +0100
Message-Id: <DDT67RIKW1Y2.2XKQFEINFUVLK@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: correctly define
 --global argument for settings management
Cc: "Alexander Kanavin" <alex@linutronix.de>
References: <20251027141627.3724031-1-alex.kanavin@gmail.com>
In-Reply-To: <20251027141627.3724031-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 14:23:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18222

On Mon Oct 27, 2025 at 3:16 PM CET, Alexander Kanavin via lists.openembedde=
d.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> --global was defined twice (for settings command as a whole, and specific=
ally
> for set/unset sub-commands), which caused 'settings --global set ...' to
> be allowed, and at the same time not have any effect. 'settings set --glo=
bal'
> is the only valid form after this change.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 38bb8099f..a0426005f 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -785,7 +785,7 @@ def main():
>      parser_settings_arg_global =3D argparse.ArgumentParser(add_help=3DFa=
lse)
>      parser_settings_arg_global.add_argument('--global', action=3D'store_=
true', help=3D"Modify the setting in a global settings file, rather than on=
e specific to a top directory")
> =20
> -    parser_settings =3D subparsers.add_parser('settings', parents=3D[par=
ser_settings_arg_global],
> +    parser_settings =3D subparsers.add_parser('settings',
>                                              help=3D'List current setting=
s, or set or unset a setting in a settings file (e.g. the default prefix an=
d name of the top directory, the location of build configuration registry, =
downloads directory and other settings specific to a top directory)')
>      parser_settings.set_defaults(func=3Dsettings_func)
> =20

Thanks, this fixes the issue reported on IRC. I was able to set settings ei=
ther
with `bitbake-setup settings set --global`, or `bitbake-setup settings set`=
, and
global and build-dir settings were modified respectively. E.g.:

$ cat /home/builder/.config/bitbake-setup/settings.conf /home/builder/yp2/b=
itbake-builds/settings.conf
[default]
top-dir-prefix =3D /home/builder/yp2

[default]
top-dir-name =3D builds

$ bitbake-setup settings list
Loading settings from
    /home/builder/.config/bitbake-setup/settings.conf

Loading settings from
    /home/builder/yp2/bitbake-builds/settings.conf

default top-dir-prefix /home/builder/yp2
default top-dir-name builds
default registry /bitbake/default-registry
default dl-dir /home/builder/yp2/bitbake-builds/.bitbake-setup-downloads

Tested-by: Antonin Godard <antonin.godard@bootlin.com>

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


