Return-Path: <u.oelmann@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44061C43334
	for <webhook@archiver.kernel.org>; Wed, 22 Jun 2022 05:54:20 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by mx.groups.io with SMTP id smtpd.web09.4240.1655877252531169838
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 22:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: pengutronix.de, ip: 85.220.165.71, mailfrom: u.oelmann@pengutronix.de)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1o3tJY-0003Ow-Pr; Wed, 22 Jun 2022 07:54:08 +0200
Received: from uol by dude.hi.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <u.oelmann@pengutronix.de>)
	id 1o3tJX-0050UI-7M; Wed, 22 Jun 2022 07:54:07 +0200
References: <16FAADC4DA16D2D7.32537@lists.openembedded.org>
 <20220621175455.2655775-1-michael.opdenacker@bootlin.com>
User-agent: mu4e 1.6.9; emacs 29.0.50
From: Ulrich =?utf-8?Q?=C3=96lmann?= <u.oelmann@pengutronix.de>
To: michael.opdenacker@bootlin.com
Cc: docs@lists.yoctoproject.org, "Michael Opdenacker via
 lists.openembedded.org"
 <michael.opdenacker=bootlin.com@lists.openembedded.org>,
 bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2] doc: bitbake-user-manual: document
 npm and npmsw fetchers
Date: Wed, 22 Jun 2022 07:32:55 +0200
In-reply-to: <20220621175455.2655775-1-michael.opdenacker@bootlin.com>
Message-ID: <6rwnd9mef4.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: u.oelmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jun 2022 05:54:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13784

Hi Michael,

just some typo fixes I stumbled across.

On Tue, Jun 21 2022 at 19:54 +0200, "Michael Opdenacker via lists.openembed=
ded.org" <michael.opdenacker=3Dbootlin.com@lists.openembedded.org> wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> This addresses bug [YOCTO #10098]
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> ---
>
> * Changes in V2:
>
>   - Fix typos in the names of explicit targets ("nmp" instead of "npm")
>   - Simplify the reference to the "nmpsw" section:
>     no need to use a complex reference when you can directly use
>     a target ("`target`_" as defined in ".. _target:")
> ---
>  .../bitbake-user-manual-fetching.rst          | 76 ++++++++++++++++++-
>  1 file changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index f9d9e617..bb521f63 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -704,6 +704,80 @@ Here is an example URL::
>=20=20
>     SRC_URI =3D "crate://crates.io/glob/0.2.11"
>=20=20
> +.. _npm-fetcher:
> +
> +NPM Fetcher (``npm://``)
> +------------------------
> +
> +This submodule fetches source code from an
> +`NPM <https://en.wikipedia.org/wiki/Npm_(software)>`__
> +Javascript package registry.
> +
> +The format for the :term:`SRC_URI` setting must be::
> +
> +   SRC_URI =3D "npm://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..."
> +
> +This fetcher supports the following parameters:
> +
> +-  *"package":* The NPM package name. This is a mandatory parameter.
> +
> +-  *"version":* The NPM package version. This is a mandatory parameter.
> +
> +-  *"downloadfilename":* Specifies the filename used when storing the do=
wnloaded file.
> +
> +-  *"destsuffix":* Specifies the directory to use to unpack the package =
(default: ``npm``).
> +
> +Note that NPM fetcher only fetches the package source itself. The depend=
encies
> +can be fetched through the `npmsw-fetcher`_.
> +
> +Here is an example URL with both fetchers::
> +
> +   SRC_URI =3D " \
> +       npm://registry.npmjs.org/;package=3Dcute-files;version=3D${PV} \
> +       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
> +       "
> +
> +See :yocto_docs:`Creating Node Package Manager (NPM) Packages
> +</dev-manual/common-tasks.html#creating-node-package-manager-npm-package=
s>`
> +in the Yocto Project manual for details about using
> +:yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-r=
eference.html>`
> +to automatically create a recipe from an NPM URL.
> +
> +.. _npmsw-fetcher:
> +
> +NPM shrinkwrap Fetcher (``npmsw://``)
> +-------------------------------------
> +
> +This modules fetches source code from an

s/This modules fetches/This module fetches/

> +`NPM shrinkwrap <https://docs.npmjs.com/cli/v8/commands/npm-shrinkwrap>`=
__
> +description file, which lists the dependencies
> +of an NPM package while locking their versions.
> +
> +The format for the :term:`SRC_URI` setting must be::
> +
> +   SRC_URI =3D "npmsw://some.registry.url;OptionA=3Dxxx;OptionB=3Dxxx;..=
."
> +
> +This fetcher supports the following parameters:
> +
> +-  *"dev":* Set this parameter to ``1`` to install "devDependencies".
> +
> +-  *"destsuffix":* Specifies the directory to use to unpack the dependen=
cies
> +   (``${S}`` by default).
> +
> +Note that the shrinkwrap file can also be provided by the recipe for
> +the package which has such dependencies, for example::
> +
> +   SRC_URI =3D " \
> +       npm://registry.npmjs.org/;package=3Dcute-files;version=3D${PV} \
> +       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
> +       "
> +
> +Such a file can be automatically be generated using

s/can be automatically/can automatically/

Best regards
Ulrich


> +:yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-r=
eference.html>`
> +as described in the :yocto_docs:`Creating Node Package Manager (NPM) Pac=
kages
> +</dev-manual/common-tasks.html#creating-node-package-manager-npm-package=
s>`
> +section of the Yocto Project.
> +
>  Other Fetchers
>  --------------
>=20=20
> @@ -713,8 +787,6 @@ Fetch submodules also exist for the following:
>=20=20
>  -  Mercurial (``hg://``)
>=20=20
> --  npm (``npm://``)
> -
>  -  OSC (``osc://``)
>=20=20
>  -  Secure FTP (``sftp://``)
--=20
Pengutronix e.K.                           | Ulrich =C3=96lmann            =
   |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

