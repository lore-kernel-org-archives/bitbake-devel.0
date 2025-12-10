Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181C1D3B9A9
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 10:21:02 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12368.1765362053583509793
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Dec 2025 02:20:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=lMHJcmQZ;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=SwKPbI/B;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.155, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF9337A019F;
	Wed, 10 Dec 2025 05:20:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 10 Dec 2025 05:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1765362052; x=1765448452; bh=wJ9lhaFI+y
	N72/baLI9r6is0bj1qdAedjpBWf/RJxiY=; b=lMHJcmQZ0Bg1yeEqROTJhojOPo
	+Xe3KZwWRLORcfsQLWGigUnzOpd/xw7oXg86xGUUiEs0rwIvg2RzY4yCHhf7JXGH
	m/UPNslQELXQE0Z0gVaEvAyMZMXUl/i4GGZaZG3r0YngGFpRXOWyhKespDnVgeZd
	evVXdrQ2xJqfN8hA0vW5ZG8mi4qjM/GCn/nTB2Ik+BN8WhfHisMaDsTAvmLiBpJr
	03X2W50VjKDobHjtk3tzbI725nqGVAZXG6QvmV88yaAYd3qSU/yPE3Q8tw5mYpcc
	Z/VI8b64nlTTrFH0vaAu9OomcXb55eTIB/ZEqREy/zpvP3Zrys0zosrMqJrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765362052; x=1765448452; bh=wJ9lhaFI+yN72/baLI9r6is0bj1qdAedjpB
	Wf/RJxiY=; b=SwKPbI/BgFw8xTQ2Nw6S0UxH42C/gNl7IH7IruY1LDGxyE7iTBa
	su1m5EOPXg71VkUprFj5O3uue+nb6AuciDmRQWrFA9RyuX9xuGX0+je0ryVxhGBt
	hAPcjYntSnDpxd/GsiFzvSFuwBUzVOO869U/J6VsdVmhgN0Z67t6n8N8cX3F0f90
	78PRqemqB5KNHdNM7kFy0nVQujVVxsE1y7dGKGCXtSBnmguFUQlwtIDcatXKm1dL
	FUWrX8yCH8pGebX2pxzuMwaw63hvxUd7U+KAZBLehDBQ+XDPbJSBOeJg/aET41R7
	mOUMB+as3GT+5JXszQKsdIn9G/DpKsJ26Bw==
X-ME-Sender: <xms:hEk5abxOID__EgT7JVMtK_EOEUm_eGBbocsgLl6rkQwtcIRSHNprKg>
    <xme:hEk5aZQNYl1OFtCtSuSv5kLKapsYPQVbYMtb-nLBuFZQ3XQ3vPLsPIchKW1zlOSHs
    pPDvn8KbMGk8zjI4z_YR0JdKz60zU6AH9nMJClTcGG1sj5i3xljZcQ>
X-ME-Received: <xmr:hEk5aS-2q-uKslHxOEF1t9GANeshudN9hlxC8vGYB2b31zTlNHdNcK5CLa9reQE2XBFTiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkffuhffvveffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepueekueejhfdtheejvdeutdfguddvieejveeije
    euffduvddttdeuffeggeehheefnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdr
    ohhrghdpuggvvhhtohholhhuphhgrhgruggvthgvshhtshdrihhtpdihohgtthhophhroh
    hjvggtthdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghorhgvnhhtihhnrdhguhhilhhlvghv
    ihgtsehsmhhilhgvrdhfrhdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlih
    hsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:hEk5aQoV-XoMAXjn4DCaeaEvtu5y2QSKnPCsIlzZJBqj7TOK2Gia9g>
    <xmx:hEk5aflu8x--1eU-bPOH6v0o0Oy-0v9PZV6JUJMOgB-s7CFwjTZz8w>
    <xmx:hEk5aXLhfSnZgNn7B8EUDx_jnBoS9kr4ziYDvT6_e-NEXgZpBTeT5Q>
    <xmx:hEk5aUwc0k8rd2OXd_UIJ-QKRB2ep2SotOYOUCm11JrlsLzhcWKjfA>
    <xmx:hEk5aYXQBJ7QaRB-L480bljVwv9LvvpIFFAV1S0jFl3ZrNcuf1h-dG86>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 05:20:51 -0500 (EST)
Message-ID: <6a06addf2f5746511f152cce0bfa7c662b6469a1.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Skip AUTOREV management if no
 SCM URI
From: Paul Barker <paul@pbarker.dev>
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2025 10:20:35 +0000
In-Reply-To: <CAMFqQmq0ZjzyPceUGhH25gVpP8295UBtrHBqKs7rttpCt-ijhg@mail.gmail.com>
References: <20251208161219.41335-1-corentin.guillevic@smile.fr>
	 <7501fc9f5b22984c6279f56b04f3888b34913d1a.camel@pbarker.dev>
	 <CAMFqQmq0ZjzyPceUGhH25gVpP8295UBtrHBqKs7rttpCt-ijhg@mail.gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1oYcrTfh1HXsTCIx1uKd"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Dec 2025 10:21:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18558


--=-1oYcrTfh1HXsTCIx1uKd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-12-09 at 11:43 +0100, Corentin Guillevic via
lists.openembedded.org wrote:
> > Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI is
> given?
>=20
> No, however this case occurs indirectly with the recipetool command (from
> the self-test devtool.DevtoolUpgradeTests). It generates a recipe in whic=
h
> SRCREV is equal to "${AUTOREV}", even though the URI is not a SCM one. Th=
e
> issue arose because I used SRCREV in a new "insane" test, see:
> https://lists.openembedded.org/g/openembedded-core/topic/116341789
>=20
> The issue can be reproduced by applying my patches and running the
> following command:
>=20
> $ recipetool --color=3Dauto create --devtool -o /tmp/devtool4819z5wk '
> http://downloads.yoctoproject.org/mirror/sources/i2c-tools-3.1.2.tar.bz2'
> -x ${BUILDDIR}/workspace/sources/devtoolsrcdcviuvn9

Which patches are you referring to here? And, does the issue occur on the
current master branch without applying any additional patches?

>=20
> Le lun. 8 d=C3=A9c. 2025 =C3=A0 17:59, Paul Barker <paul@pbarker.dev> a =
=C3=A9crit :
>=20
> > On Mon, 2025-12-08 at 17:12 +0100, Corentin Guillevic via
> > lists.openembedded.org wrote:
> > > AUTOREV allows to fetch the latest revision. If no SCM URI is used (e=
.g.
> > git://, ...),
> > > AUTOREV has no effect. However there is one case in which a recipe wi=
th
> > AUTOREV
> > > but no SCM URI will lead to a parsing error:
> > >=20
> > > ERROR:
> > /path/to/yocto/builds/build-qemux86-64/workspace/recipes/i2c-tools/
> > i2c-tools_3.1.2.bb: AUTOREV/SRCPV set too late for the fetcher to work
> > properly, please set the variables earlier in parsing. Erroring instead=
 of
> > later obtuse build failures.
> > >=20
> > > This error is raised when AUTOREV occurs (__BBAUTOREV_SEEN) but is no=
t
> > acted
> > > upon (__BBAUTOREV_ACTED_UPON). A recipe with one SCM URI causes the
> > > srcrev_internal_helper() function to run, and read the value of SRCRE=
V.
> > If
> > > SRCREV =3D "${AUTOREV}", then AUTOREV will be acted upon.
> > >=20
> > > If the recipe does not have an SCM URI, SRCREV is not parsed and AUTO=
REV
> > remains
> > > unchanged. However, if SRCREV is expanded during the parsing time in
> > Python code
> > > (either pure or evaluated from BitBake code), then AUTOREV will be
> > expanded too
> > > and resulting in the setting of __BBAUTOREV_SEEN. However, as there i=
s
> > no SCM
> > > URI, the code flow that would act upon AUTOREV is never run.
> > >=20
> > > The fix slightly changes the way AUTOREV is handled: if no SCM URI is
> > provided,
> > > AUTOREV will be considered to have never occurred (__BBAUTOREV_SEEN w=
ill
> > not be
> > > defined).
> >=20
> > It makes more sense to me to throw an error if AUTOREV is seen but no
> > SCM URI is provided, rather than silently ignoring AUTOREV. Perhaps we
> > just need to improve the error that is raised.
> >=20
> > Is there any valid case for `SRCREV =3D "${AUTOREV}` when no SCM URI is
> > given?

Thanks,

--=20
Paul Barker



--=-1oYcrTfh1HXsTCIx1uKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTlJcxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bvROAPwMN4KI4xUhhbVV+P0hkQ3jyg/WBooWO+W6
CK+F22b5hAD/cSzzJ3e7RN+yt0Ipopy2Ln8a272gpDRv5+Aaj4w/iQ0=
=URRy
-----END PGP SIGNATURE-----

--=-1oYcrTfh1HXsTCIx1uKd--

