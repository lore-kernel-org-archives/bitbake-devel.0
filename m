Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3828E77199
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 09:37:10 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.56165.1736156225041038408
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Jan 2025 01:37:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U5XwTWEC;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED2E3FF804;
	Mon,  6 Jan 2025 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736156223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FqjipYOUHL7y2KQgIoVjrEDwxm/DSfHvIhhohyPc3jA=;
	b=U5XwTWEC3zYt23fujmLgZ8Z+Ef5oRrNgHEOMLzzr5cm294NCRJh4Q7AakFzm+zvtS5VrU6
	eFxMpVP0FDBtptjsTxP7p7BdXC1u87vyP3JVJOw5j6Cwl70WFZFTYbiozQABzOxbK1kyFc
	xwWHNwA4iiGCOoqS55oIaZcMmVly6UD69X3kb5QF9NWbP1z+HBMRGwumkuWPRyTjK35uwL
	t9YPgVrdQPRkeOWU9iuHSpQvDwxKYHRMfOV3cVuXgDQ40zTnyee9ALc3MAFDzDUP4e8QVz
	uoZJcS3/ZCn/qPj23nwK71SGB9Oj/dVAmvqjkZ+h6C27xCskIZ5pKZF69HMkIQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jan 2025 10:37:02 +0100
Message-Id: <D6UW0M0VI79V.QRXZOO9V6BPW@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <joerg.sommer@navimatix.de>, <bitbake-devel@lists.openembedded.org>,
 <docs@lists.yoctoproject.org>
Subject: Re: [docs] [PATCH 2/2] doc/logging: convert warn.json to YAML
X-Mailer: aerc 0.18.2-100-gc2048ef30452-dirty
References: <2bf2a340cbf86391ae6722739f750f9d44f550b3.1735852948.git.joerg.sommer@navimatix.de> <bcd0593418a1217f73f4a6946b13a5b603a58fb5.1735852948.git.joerg.sommer@navimatix.de>
In-Reply-To: <bcd0593418a1217f73f4a6946b13a5b603a58fb5.1735852948.git.joerg.sommer@navimatix.de>
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 09:37:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16965

Hi J=C3=B6rg,

On Thu Jan 2, 2025 at 10:23 PM CET, J=C3=B6rg Sommer via lists.yoctoproject=
.org wrote:
> From: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
>
> To give an example how the YAML format can be used, the example of the
> warnings logger should be converted to YAML.

In https://docs.python.org/3/library/logging.config.html#logging.config.lis=
ten
the note says:

  If you want to send configurations to the listener which don=E2=80=99t di=
sable existing
  loggers, you will need to use a JSON format for the configuration, which =
will
  use dictConfig() for configuration. This method allows you to specify
  disable_existing_loggers as False in the configuration you send.

I believe this is the reason why JSON was used. So the disable_existing_log=
gers
usage in Yaml below is ineffective.

> Signed-off-by: J=C3=B6rg Sommer <joerg.sommer@navimatix.de>
> ---
>  .../bitbake-user-manual-execution.rst         | 42 ++++++++-----------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>
>
> Is the @ in front of disable_existing_loggers correct? In
> https://docs.python.org/3/library/logging.config.html#dictionary-schema-d=
etails
> it's not given. Or can we remove the whole line? At me it works.
>
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/=
doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> index 0e20d5933..99b91ba50 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
> @@ -728,35 +728,29 @@ bitbake, or set it in ``conf/local.conf``::
> =20
>     BB_LOGCONFIG =3D "hashequiv.json"
> =20
> -Another example is this ``warn.json`` file to log all ``WARNING`` and
> +Another example is this ``warn.yaml`` file to log all ``WARNING`` and
>  higher priority messages to a ``warn.log`` file::
> =20
> -  {
> -      "version": 1,
> -      "formatters": {
> -          "warnlogFormatter": {
> -              "()": "bb.msg.BBLogFormatter",
> -              "format": "%(levelname)s: %(message)s"
> -          }
> -      },
> +  version: 1
> =20
> -      "handlers": {
> -          "warnlog": {
> -              "class": "logging.FileHandler",
> -              "formatter": "warnlogFormatter",
> -              "level": "WARNING",
> -              "filename": "warn.log"
> -          }
> -      },
> +  '@disable_existing_loggers': false
> =20
> -      "loggers": {
> -          "BitBake": {
> -              "handlers": ["warnlog"]
> -          }
> -      },
> +  formatters:
> +    warnlogFormatter:
> +      '()': bb.msg.BBLogFormatter
> +      format: '%(levelname)s: %(message)s'
> =20
> -      "@disable_existing_loggers": false

This is strange, maybe a typo? We should probably remove the "@" here.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

