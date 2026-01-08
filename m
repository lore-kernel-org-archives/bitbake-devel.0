Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8FD1D477
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:42 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8656.1767885459624879581
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 07:17:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=LibhW0H9;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=brn4D4CJ;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CF8741D00144;
	Thu,  8 Jan 2026 10:17:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 08 Jan 2026 10:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767885458; x=1767971858; bh=2hFMxYKqgT
	z6I/1b8qgwRbLSkgPYQ1dW20upyP5a1/g=; b=LibhW0H9AXiZ8YSG4/3ONtuOw6
	N4N4BoFotJndL7/mYMETkt/tE+M+apmccYqgKO7QydO8+lZByq5fOqIsuxUWQaDx
	64eJR7nU3nUOWqXG5B5l/hEaGOQ8jCSo6wU1ORn8eLzo3MTJgBw4GBaajct5rJoU
	AhatNwtPGz/MndMKHTD4iph9k47xetvCziszAmpEFJNf0Z0TzvjUNMf3yBmdOkp/
	2zLcLRL0ZVxX2VOES/akkx6q/Trd/f2yWbKAhJTx9BchPvNmWWP8T00y1qn/uwH8
	j5QTmTGBNWaZSbcU469H2/Oizen+lIKzPM2Fm81PCHbQUoBgR+OavFbS5B9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767885458; x=1767971858; bh=2hFMxYKqgTz6I/1b8qgwRbLSkgPYQ1dW20u
	pyP5a1/g=; b=brn4D4CJ+MiTSh0meo6130aglcIBeCIg7hlbafsHeRQSpDbOowU
	qgVqzVCG6WI5d/butl5oIsQRPy9h8hYyeanylHJbS4uCiuf25+cgLPzEDpZWWS91
	A9Ts2iaNdRsjooN+8ZuDz6iY4VHn2/mmo/ljV2O3hi69UxzXv5XqWk4tVdjFaEHz
	dv5kGrbEcVGri8et041FmmgvmCvwXVdzqB217nGckLHsc09wBm/3wML1mJB2DoxG
	wTsKU35aI1qfiYemTjfFtM3S/kVwlgfsGxdJnbZLGnJMocJTGxy7xEgQ7exdlFsq
	5VObuRMk71hrYQY+czXyjVo2ZruqCc0kCBQ==
X-ME-Sender: <xms:kspfaTTw9-4pcLPxknXdYyt8ldb8TzxRF7mz4vlnEwWItCsdL0GLvA>
    <xme:kspfacP1IbtKiL45AlFZXyMBpx3T1IyHuh3AYtMIuWjH_9vHqjUI6ouLG4Kz5O7Hu
    cJsjdVCofD4sJ8M3IwULuICQyuSONjqXJJm-rh91_92MXAn-bGVwtI>
X-ME-Received: <xmr:kspfaWPehA5ciHITD9edTbujOm5tBNtrAO6fWMNYcW5B014xKRcxjVz4ZECV-9sr8C3vdOcvKCVQ63sh6kHtQuZGU_bd_9jpiTFlr_gqh84o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeivdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    ephfekhfeugfelfeeludellefhkeetvdffiedttdeuueekhfeiudeivdefueehuddtnecu
    ffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggv
    vhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghithgsrghk
    vgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpth
    htoheprghlvgigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:kspfacslblQKYx3ykwi5oJZixX_FsUakw4RvcbVjqDPIkHWWh338zA>
    <xmx:kspfaQX1XzTSmDFoOxISX5gwYfxGccc8TUKuG1BELmvCJOl0EEvhGQ>
    <xmx:kspfaUtSK8TZAeZgIt0NSlHqU39aSu1n3PhtRJFvSEtnRl2oOuDM4g>
    <xmx:kspfacV1WMfg45NaXt2tX_ZbWjZ9pWhpxvH-QKI4DW8Xcj67ryvcAQ>
    <xmx:kspfaRg_4p3mNDaoMzQorjGdWsefHuLrOtXmr-_SpIJoVzJzH0jl3U7c>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 10:17:37 -0500 (EST)
Message-ID: <2854f27b68c3e3bfaf897fdbfcc97ae715d3e96e.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH v2 01/10] bitbake-setup: move the local
 source tests to the end
From: Paul Barker <paul@pbarker.dev>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu, 08 Jan 2026 15:17:34 +0000
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jtMLQJ6bhOLNoz4Mu7Fs"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 15:17:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18712


--=-jtMLQJ6bhOLNoz4Mu7Fs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-06 at 13:10 +0100, Alexander Kanavin via
lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> They are not a part of the main testing sequence, and logically
> should not be in the middle of it.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  lib/bb/tests/setup.py | 56 +++++++++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>=20
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 933178c84..ad09913f4 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -320,34 +320,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                  out =3D self.runbbsetup("update --update-bb-conf=3D'yes'=
")
>                  self.assertIn("Configuration in {} has not changed".form=
at(setuppath), out[0])
> =20
> -        # check source overrides, local sources provided with symlinks, =
and custom setup dir name
> -        source_override_content =3D """
> -{
> -    "sources": {
> -        "test-repo": {
> -            "local": {
> -                "path": "."
> -            }
> -        }
> -    }
> -}"""
> -        override_filename =3D 'source-overrides.json'
> -        custom_setup_dir =3D 'special-setup-dir'
> -        self.add_file_to_testrepo(override_filename, source_override_con=
tent)
> -        out =3D self.runbbsetup("init --non-interactive --source-overrid=
es {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.te=
strepopath, override_filename), custom_setup_dir))
> -        custom_setup_path =3D os.path.join(self.tempdir, 'bitbake-builds=
', custom_setup_dir)
> -        custom_layer_path =3D os.path.join(custom_setup_path, 'layers', =
'test-repo')
> -        self.assertTrue(os.path.islink(custom_layer_path))
> -        self.assertEqual(self.testrepopath, os.path.realpath(custom_laye=
r_path))
> -
> -        # same but use command line options to specify local overrides
> -        custom_setup_dir =3D 'special-setup-dir-with-cmdline-overrides'
> -        out =3D self.runbbsetup("init --non-interactive -L test-repo {} =
--setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_=
setup_dir))
> -        custom_setup_path =3D os.path.join(self.tempdir, 'bitbake-builds=
', custom_setup_dir)
> -        custom_layer_path =3D os.path.join(custom_setup_path, 'layers', =
'test-repo')
> -        self.assertTrue(os.path.islink(custom_layer_path))
> -        self.assertEqual(self.testrepopath, os.path.realpath(custom_laye=
r_path))
> -
>          # install buildtools
>          out =3D self.runbbsetup("install-buildtools")
>          self.assertIn("Buildtools installed into", out[0])
> @@ -428,3 +400,31 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>              out =3D self.runbbsetup("update --update-bb-conf=3D'no'")
>              sums_after =3D _conf_chksum(f"{setuppath}/build/conf")
>              self.assertEqual(sums_before, sums_after)
> +
> +        # check source overrides, local sources provided with symlinks, =
and custom setup dir name
> +        source_override_content =3D """
> +{
> +    "sources": {
> +        "test-repo": {
> +            "local": {
> +                "path": "."
> +            }
> +        }
> +    }
> +}"""
> +        override_filename =3D 'source-overrides.json'
> +        custom_setup_dir =3D 'special-setup-dir'
> +        self.add_file_to_testrepo(override_filename, source_override_con=
tent)
> +        out =3D self.runbbsetup("init --non-interactive --source-overrid=
es {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.te=
strepopath, override_filename), custom_setup_dir))
> +        custom_setup_path =3D os.path.join(self.tempdir, 'bitbake-builds=
', custom_setup_dir)
> +        custom_layer_path =3D os.path.join(custom_setup_path, 'layers', =
'test-repo')
> +        self.assertTrue(os.path.islink(custom_layer_path))
> +        self.assertEqual(self.testrepopath, os.path.realpath(custom_laye=
r_path))
> +
> +        # same but use command line options to specify local overrides
> +        custom_setup_dir =3D 'special-setup-dir-with-cmdline-overrides'
> +        out =3D self.runbbsetup("init --non-interactive -L test-repo {} =
--setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_=
setup_dir))
> +        custom_setup_path =3D os.path.join(self.tempdir, 'bitbake-builds=
', custom_setup_dir)
> +        custom_layer_path =3D os.path.join(custom_setup_path, 'layers', =
'test-repo')
> +        self.assertTrue(os.path.islink(custom_layer_path))
> +        self.assertEqual(self.testrepopath, os.path.realpath(custom_laye=
r_path))

The ordering definitely makes more sense now so this is good.

We do have a single very long test case covering bitbake-setup here. We
should think about splitting it up into separate test cases in the
future so that pass/fail results are more specific and easier to triage.

Best regards,

--=20
Paul Barker


--=-jtMLQJ6bhOLNoz4Mu7Fs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaV/KjhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bvCxAQCC9RCI/c7FT9+pyfgEn+r6qTSI/73MlzX/
1n1VzfHefAD+Lx91eDHApA/2d4SDliJxdmTr/R2BGo+tLSs4j0fgtgY=
=7Wp5
-----END PGP SIGNATURE-----

--=-jtMLQJ6bhOLNoz4Mu7Fs--

