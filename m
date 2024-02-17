Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A39EC4829E
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 07:27:21 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web11.8549.1708211774674030990
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Feb 2024 15:16:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@posteo.net header.s=2017 header.b=qNDmKSsx;
 spf=pass (domain: posteo.net, ip: 185.67.36.66, mailfrom: simone.weiss@posteo.net)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C453A240103
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 00:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1708211772; bh=XY89p/M7cKBLdvrC/CePGU3aLJHizHAndFcsyOmjxVE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=qNDmKSsxhPS5AcIFmNWuZUvmxDLpoQ+PJyl9+MN3IyLj4dI9gTYLRJJhoIdj7ncbH
	 IKORNRQt217H0avcP7cSK0Cd3ZIeMLgmUp12tt6f5Vavxwj3IzKN3nAUB+mB9/yS9+
	 ELjhQYji9djIRdzMBVtejXVcZswYiB+1UDgERyBnJnXCFLyypcfWm8NLPilPuNPj99
	 Coo8puiACJjm5YDrOo/A35xhsBZsanYWtknD6Hj5GXDQ52r4XNJewEp6/bzPVPSVJy
	 /GEIJBgZk9SnXaLC1lCCJc0mlRcbBEXjnnXU/FGsB8ZLU1TqQfq5wtoOL+g0VtsbAk
	 uhvXY7fyRWqKg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Tcl6M1WjYz9rxB;
	Sun, 18 Feb 2024 00:16:11 +0100 (CET)
Message-ID: <446975960dee95ef716c493650099c56e77582b3.camel@posteo.net>
Subject: Re: [docs] [PATCH v2] bitbake: doc: Add section for variable context
From: =?UTF-8?B?U2ltb25lIFdlacOf?= <simone.weiss@posteo.net>
To: Simone =?ISO-8859-1?Q?Wei=DF?= <simone.p.weiss@posteo.com>, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Sat, 17 Feb 2024 23:16:10 +0000
In-Reply-To: <17B4A1C770848659.28679@lists.yoctoproject.org>
References: <17B4A1C770848659.28679@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 07:27:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15911

On Sat, 2024-02-17 at 11:07 +0000, Simone Wei=C3=9F wrote:
> From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
>=20
> This is inspired by the same section in the yocto-docs. It aims to
> provide
> information in what contexts(recipes, .conf, bbclass,...) a variable is
> usually
> used. For that I tried to group similar variables, so that a short
> overview is
> given. This was inspired by [YOCTO #14072], but of course does not
> implement a
> warning if a variable is used in an unintended context.
>=20
> Signed-off-by: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
> ---
> =C2=A0...bake-user-manual-ref-variables-context.rst | 89 ++++++++++++++++=
+++
> =C2=A0doc/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A02 files changed, 90 insertions(+)
> =C2=A0create mode 100644 doc/bitbake-user-manual/bitbake-user-manual-ref-
> variables-context.rst
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-
> context.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-
> context.rst
> new file mode 100644
> index 00000000..8252889e
> --- /dev/null
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables-
> context.rst
> @@ -0,0 +1,89 @@
> +.. SPDX-License-Identifier: CC-BY-SA-2.0-UK
> +
> +****************
> +Variable Context
> +****************
> +
> +Variables might only have an impact or can be used in certain contexts.
> Some
> +should only be used in global files like ``.conf``, while others are
> intended only
> +for local files like ``.bb``. This chapter aims to describe some
> important variable
> +contexts.
> +
> +.. _ref-varcontext-configuration:
> +
> +BitBake's own configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +Variables starting with ``BB_`` usually configure the behaviour of
> BitBake itself.
> +For example, one could configure:
> +
> +- System resources, like disk space to be used
> (:term:`BB_DISKMON_DIRS`),
> +=C2=A0 or the number of tasks to be run in parallel by BitBake
> (:term:`BB_NUMBER_THREADS`).
> +
> +- How the fetchers shall behave, e.g., :term:`BB_FETCH_PREMIRRORONLY`
> is used
> +=C2=A0 by BitBake to determine if BitBake's fetcher shall search only
> +=C2=A0 :term:`PREMIRRORS` for files.
> +
> +Those variables are usually configured globally.
> +
> +BitBake configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +There are variables:
> +
> +- Like :term:`B` or :term:`T`, that are used to specify directories
> used by
> +=C2=A0 BitBake during the build of a particular recipe. Those variables =
are
> +=C2=A0 specified in ``bitbake.conf``. Some, like :term:`B`, are quite of=
ten
> +=C2=A0 overwritten in recipes.
> +
> +- Starting with ``FAKEROOT``, to configure how the ``fakeroot`` command
> is
> +=C2=A0 handled. Those are usually set by ``bitbake.conf`` and might get
> adapted in a
> +=C2=A0 ``bbclass``.
> +
> +- Detailing where BitBake will store and fetch information from, for
> +=C2=A0 data reuse between build runs like :term:`CACHE`, :term:`DL_DIR` =
or
> +=C2=A0 :term:`PERSISTENT_DIR`. Those are usually global.
> +
> +
> +Layers and files
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Variables starting with ``LAYER`` configure how BitBake handles layers.
> +Additionally, variables starting with ``BB`` configure how layers and
> files are
> +handled. For example:
> +
> +- :term:`LAYERDEPENDS` is used to configure on which layers a given
> layer
> +=C2=A0 depends.
> +
> +- The configured layers are contained in :term:`BBLAYERS` and files in
> +=C2=A0 :term:`BBFILES`.
> +
> +Those variables are often used in the files ``layer.conf`` and
> ``bblayers.conf``.
> +
> +Recipes and packages
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Variables handling recipes and packages can be split into:
> +
> +- :term:`PN`, :term:`PV` or :term:`PF` for example, contain information
> about
> +=C2=A0 the name or revision of a recipe or package. Usually, the default=
 set
> in
> +=C2=A0 ``bitbake.conf`` is used, but those are from time to time overwri=
tten
> in
> +=C2=A0 recipes.
> +
> +- :term:`SUMMARY`, :term:`DESCRIPTION`, :term:`LICENSE` or
> :term:`HOMEPAGE`
> +=C2=A0 contain the expected information and should be set specifically f=
or
> every
> +=C2=A0 recipe.
> +
> +- In recipes, variables are also used to control build and runtime
> +=C2=A0 dependencies between recipes/packages with other recipes/packages=
.
> The
> +=C2=A0 most common should be: :term:`PROVIDES`, :term:`RPROVIDES`,
> :term:`DEPENDS`,
> +=C2=A0 and :term:`RDEPENDS`.
> +
> +- There are further variables starting with ``SRC`` that specify the
> sources in
> +=C2=A0 a recipe like :term:`SRC_URI` or :term:`SRCDATE`. Those are also
> usually set
> +=C2=A0 in recipes.
> +
> +- Which version or=C2=A0provider of a recipe should be given preference =
when
> +=C2=A0 multiple recipes would provide the same item, is controlled by
> variables
> +=C2=A0 starting with ``PREFERRED_``. Those are normally set in the
> configuration
> +=C2=A0 files of a ``MACHINE`` or ``DISTRO``.
> diff --git a/doc/index.rst b/doc/index.rst
> index 3ff8b158..ee1660ac 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -13,6 +13,7 @@ BitBake User Manual
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-intro
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-execution
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-metadata
> +=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-ref-variables-conte=
xt
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-fetching
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-ref-variables
> =C2=A0=C2=A0=C2=A0 bitbake-user-manual/bitbake-user-manual-hello
>=20
>=20
>=20
I forgot to mentioned it in the commit message. Once this is good and
merged, I would reference it in the yocto-docs as well. A picture
showcasing this further as described by Quentin in [1] is also a good
idea, I just think that this might better be placed in another section,
maybe as an extension after the section 4.8 (Bitbake task map) in the
yocto-docs.
And thanks for the helpful reviews on v1!

[1]:https://lists.yoctoproject.org/g/docs/message/4837

