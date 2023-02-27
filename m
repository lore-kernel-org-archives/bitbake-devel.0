Return-Path: <u.oelmann@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9601C64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 12:03:12 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
 by mx.groups.io with SMTP id smtpd.web10.88405.1677499390570091818
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Feb 2023 04:03:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: pengutronix.de, ip: 85.220.165.71, mailfrom: u.oelmann@pengutronix.de)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1pWcDk-0006kQ-6G; Mon, 27 Feb 2023 13:03:08 +0100
Received: from uol by pty.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1pWcDi-005NMT-LG; Mon, 27 Feb 2023 13:03:06 +0100
References: <20230227112447.26871-1-fawzi.khaber@smile.fr>
User-agent: mu4e 1.6.9; emacs 29.0.50
From: Ulrich =?utf-8?Q?=C3=96lmann?= <u.oelmann@pengutronix.de>
To: Fawzi KHABER <fawzi.khaber@smile.fr>
Cc: Ever ATILANO <ever.atilano@smile.fr>, Yoann CONGAL
 <yoann.congal@smile.fr>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/2] doc: ref-variables: add
 LAYERSERIES_COMPAT to term glossary
Date: Mon, 27 Feb 2023 13:00:40 +0100
In-reply-to: <20230227112447.26871-1-fawzi.khaber@smile.fr>
Message-ID: <6r7cw3joxx.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: u.oelmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Feb 2023 12:03:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14497

Hi Fawzi,

On Mon, Feb 27 2023 at 12:24 +0100, "Fawzi KHABER" <fawzi.khaber@smile.fr> =
wrote:
> Bitbake throws a warning if the layer compatibility is not defined since
> cca81e33b58c390dcf5cc3a31555a43b79177166. This variable did not figure in
> the documentation.
>
> Reviewed-by: Ever ATILANO <ever.atilano@smile.fr>
> Reviewed-by: Yoann CONGAL <yoann.congal@smile.fr>
> Signed-off-by: Fawzi KHABER <fawzi.khaber@smile.fr>
> ---
>  .../bitbake-user-manual-ref-variables.rst     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 09d09a8d..3611ee78 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1096,6 +1096,29 @@ overview of their function and contents.
>        variable is not available outside of ``layer.conf`` and references
>        are expanded immediately when parsing of the file completes.
>=20=20
> +   :term:`LAYERSERIES_COMPAT`
> +      Lists the versions of the OpenEmbedded-Core (OE-Core) for which
> +      a layer is compatible. Using the :term:`LAYERSERIES_COMPAT` variab=
le
> +      allows the layer maintainer to indicate which combinations of the
> +      layer and OE-Core can be expected to work. The variable gives the
> +      system a way to detect when a layer has not been tested with new
> +      releases of OE-Core (e.g. the layer is not maintained).
> +
> +      To specify the OE-Core versions for which a layer is compatible, u=
se
> +      this variable in your layer's ``conf/layer.conf`` configuration fi=
le.
> +      For the list, use the Yocto Project release name (e.g. "kirkstone",
> +      "micklemore"). To specify multiple OE-Core versions for the layer,=
 use
          ^---

just a small typo here

  s/micklemore/mickledore/

> +      a space-separated list::
> +
> +         LAYERSERIES_COMPAT_layer_root_name =3D "kirkstone micklemore"
                                                            ^---
and here.

Best regards
Ulrich


> +      .. note::
> +
> +         Setting :term:`LAYERSERIES_COMPAT` is required by the Yocto Pro=
ject
> +         Compatible version 2 standard.
> +         The OpenEmbedded build system produces a warning if the variable
> +         is not set for any given layer.
> +
>     :term:`LAYERVERSION`
>        Optionally specifies the version of a layer as a single number. You
>        can use this variable within
--=20
Pengutronix e.K.                           | Ulrich =C3=96lmann            =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

