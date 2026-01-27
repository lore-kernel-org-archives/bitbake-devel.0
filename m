Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D8D2D8F1
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:29:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7750.1769509754307431581
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=1moVNk2x;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5DFDEC211D2
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:29:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5BF6F606F5;
	Tue, 27 Jan 2026 10:29:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91C2E119A8687;
	Tue, 27 Jan 2026 11:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769509752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=USBzX3GJBwwbwBR5Gur/5RirA8Ii+M16x/kS2UWKWwM=;
	b=1moVNk2xVe0uuEpnWB/RQV3Ws7Fgfy8flpwldrfGhOdIv1sYM3LzXVwHW+YD7b4ffYNqvt
	I4KdebBcmWmUddS2lYpMDBxJwi63TJ3XJ7UaIJ6KQPevSIDJlOdFhEEKLIYXzcurNtzYhV
	6ZJI1KhDp6vEHbkvmXdiKl87pXfM9NnntPmlS8x+dqXiJ1e1TpPChFP5LxtKV2nLhjGf2n
	7JKr3GMwTVaSQBqZHVlYPqWt5G393C0biAe5A5VjoLHhgRHfG8MllRnyYMfmwLepQIpvPy
	MpgBT9eGsy3bWBiW54D3HHSqZa4cccDUqEWvx3hZiQrOwgoJp+cUQQGHbyZAOw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:29:11 +0100
Message-Id: <DFZAUTK11Y5A.1PPDDZRLH02PU@bootlin.com>
Subject: Re: [docs][PATCH 2/5] bitbake-setup: Change the output to match the
 terminology in the docs
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <daiane.angolini@foundries.io>, <bitbake-devel@lists.openembedded.org>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-2-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-2-daiane.angolini@foundries.io>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:29:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18881

Hi,

On Mon Jan 26, 2026 at 11:27 PM CET, Daiane Angolini via lists.yoctoproject=
.org wrote:
> The original output in the script does not use the original terminology
> from the document. This patch changes the script output to match the
> terminoly, this way user can search the documentation for help.
>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  bin/bitbake-setup                                         | 8 ++++----
>  default-registry/configurations/poky-master.conf.json     | 2 +-
>  default-registry/configurations/poky-whinlatter.conf.json | 2 +-
>  .../bitbake-user-manual-environment-setup.rst             | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index abe7614c8..65f0c5eb3 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -457,11 +457,11 @@ def choose_bitbake_config(configs, parameters, non_=
interactive):
>      if non_interactive:
>          raise Exception("Unable to choose from bitbake configurations in=
 non-interactive mode: {}".format(configs_dict))
> =20
> -    logger.plain("\nAvailable bitbake configurations:")
> +    logger.plain("\nAvailable Variants:")
>      for n, config_data in enumerated_configs:
>          logger.plain("{}. {}\t{}".format(n, config_data["name"], config_=
data["description"]))
>      config_n =3D int_input([i[0] for i in enumerated_configs],
> -                         "\nPlease select one of the above bitbake confi=
gurations by its number: ") - 1
> +                         "\nPlease select one of the above Variants by i=
ts number: ") - 1
>      return flattened_configs[config_n]
> =20
>  def choose_config(configs, non_interactive):
> @@ -475,7 +475,7 @@ def choose_config(configs, non_interactive):
>      if non_interactive:
>          raise Exception("Unable to choose from configurations in non-int=
eractive mode: {}".format(not_expired_configs))
> =20
> -    logger.plain("\nAvailable configurations:")
> +    logger.plain("\nAvailable BitBake Setup Template:")

s/Template/Templates/

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


