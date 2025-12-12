Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E38D49202
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 11:36:04 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10749.1765539360219063264
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 03:36:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=wndzUL2p;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=bF7O/NBt;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 82B32EC07AD;
	Fri, 12 Dec 2025 06:35:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 12 Dec 2025 06:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765539359; x=1765625759; bh=ohvr+PFeeQ
	aiWadrbQ1N2gJvSGdclb9Mvm6KNYuUj8Q=; b=wndzUL2pBUal2RKdLZe7WyHeSs
	C0NCszkyNa9r6naC8R+YdMiCe+U65N9KwaNdXxK75iBrMj61RxKUMGfTo+06f7Gl
	UIkUQ4feHLRMTRP/je1kvAiU9AYoczNX2e4GpK8erC4lgK4X6g72S3OnmgLb7kVM
	f4+pujOsgbs5Qe1YvAa79Dr5K3zr1qO/QK54Ck8A4zUd8IYjl+JVVn67VGFhtf1T
	Iaqv+dBeIA8XxKIDdeVAp9a1mD+P6fbdefkelrnn70xn2dPANVHYVn6o68WCqGza
	JUoDGxAF5imo/iSvWj/7u53PoqPrQs/ggu0ltX4L2jggJwRxgeZQsP0ZTEsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765539359; x=1765625759; bh=ohvr+PFeeQaiWadrbQ1N2gJvSGdclb9Mvm6
	KNYuUj8Q=; b=bF7O/NBtM8zibXOPDYA79Zpy8GjwgP0/TLCV60DlkRRvHD32J72
	xP4PCYp5dGA51GhWF+PZIo2mcVBwjMdOHccHZVd2vjWZFQ1qmIC5G7TQJKfhNcoM
	jksETI789GwJvfMD0ab9I13Un/aFK5fyPxmrLLGcck8RlBZx6fhLZcyTcYJPGCzg
	LllgO9zIvPZuNbVUeS2cLmejq37ncXh+befxnoUMa6nWecr20WpW/iFpxhMb+8Qb
	XyP9SUdPo8QlwKwPbzpcSIFurfQ2MgSjtwVrlPiZ/n2O+kXhduu8b214sqsShFDE
	bGBRTjeNCN9v4aWjmMffD71np09OPnO/K1Q==
X-ME-Sender: <xms:H_47aaooKFXCJAYeH5ajBRgm68ZZMSZUudiB4nVxD1rVG0z3vQmD7Q>
    <xme:H_47aQEELPHd8vWYdL8tA2VrZ3jghPMtrRf6wvpBPbIUFZvon-ApLwXpYaZx23whT
    V8m0hgEtbFfTaiI6eepvZtNB1uHNHO1SEYcpPfK0sz4GQz7NjjPZw>
X-ME-Received: <xmr:H_47acmiwP6g6cWJSCO8nYybZdiUxD9yTCniFqfdCUBj3PYZRA5BlNTXxSZrgD_-yOfpbCQm4J-wIh39q0ijiNvRQPszsgRJARDIQ2yEV7AP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    efffdvfeegveekudfhteeuhefhieekvdeiueefveeiffeukedtledutdfggeevheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesph
    gsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggu
    rdhorhhgpdhrtghpthhtoheprghlvgigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:H_47aTlpXNKPC9qT3OmmOX9yaU64l7JYJKFkTVs-WuZkmZac7l-cSg>
    <xmx:H_47adt-z3DIDFfe6-rSlPqMAkiNR5ruCp4GkaNlPEs3qtW1IZT98A>
    <xmx:H_47aWlGx1oyBLugLmvOBioGlxq1cMAIuzBK290b3JIr1DD6pjQ5GA>
    <xmx:H_47aYtauhQISEo_yFg9HKh02vleOsf8hl2Cqi2FHHd039xz8wSaHg>
    <xmx:H_47aSZFyO96YeerND7xDYpTJiLMP4XNe5oLBnLlT6_NDcCu-P7I61WD>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 06:35:58 -0500 (EST)
Message-ID: <a3b033459a62ffffbdf78553909621f28192ef01.camel@pbarker.dev>
Subject: Re: [PATCH 3/4] bitbake-setup: use separate functions for
 git-specific operations
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 12 Dec 2025 11:35:56 +0000
In-Reply-To: <20251211142532.983960-3-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
	 <20251211142532.983960-3-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FuonhUXespZ+x6a1R7pQ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:36:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18576


--=-FuonhUXespZ+x6a1R7pQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-11 at 15:25 +0100, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> This prepares the code for adding different type of sources than git remo=
tes:
>=20
> - put git-specific operations into their own functions (no behavior chang=
es)
>=20
> - call them only if a git-remote entry actually exists in the configurati=
on;
> do not assume it is always there.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 8d4e9769a..1f83b1b2a 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -90,16 +90,7 @@ def _write_layer_list(dest, repodirs):
>          json.dump({"version":"1.0","layers":layers}, f, sort_keys=3DTrue=
, indent=3D4)
> =20
>  def checkout_layers(layers, layerdir, d):
> -    layers_fixed_revisions =3D copy.deepcopy(layers)
> -    repodirs =3D []
> -    oesetupbuild =3D None
> -    print("Fetching layer/tool repositories into {}".format(layerdir))
> -    for r_name in layers:
> -        r_data =3D layers[r_name]
> -        repodir =3D r_data.get("path", r_name)
> -        repodirs.append(repodir)
> -
> -        r_remote =3D r_data['git-remote']
> +    def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
>          rev =3D r_remote['rev']
>          branch =3D r_remote.get('branch', None)
>          remotes =3D r_remote['remotes']
> @@ -118,6 +109,19 @@ def checkout_layers(layers, layerdir, d):
>              revision =3D urldata.revision
>              layers_fixed_revisions[r_name]['git-remote']['rev'] =3D revi=
sion
> =20
> +    layers_fixed_revisions =3D copy.deepcopy(layers)
> +    repodirs =3D []
> +    oesetupbuild =3D None
> +    print("Fetching layer/tool repositories into {}".format(layerdir))
> +    for r_name in layers:
> +        r_data =3D layers[r_name]
> +        repodir =3D r_data.get("path", r_name)
> +        repodirs.append(repodir)
> +
> +        r_remote =3D r_data.get('git-remote')
> +        if r_remote:
> +            _checkout_git_remote(r_remote, repodir, layers_fixed_revisio=
ns)
> +
>          if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-se=
tup-build')):
>              oesetupbuild =3D os.path.join(layerdir, repodir, 'scripts/oe=
-setup-build')
>              oeinitbuildenvdir =3D os.path.join(layerdir, repodir)
> @@ -563,12 +567,8 @@ def get_diff(file1, file2):
>      return None
> =20
>  def are_layers_changed(layers, layerdir, d):
> -    changed =3D False
> -    for r_name in layers:
> -        r_data =3D layers[r_name]
> -        repodir =3D r_data.get("path", r_name)
> -
> -        r_remote =3D r_data['git-remote']
> +    def _is_git_remote_changed(r_remote, repodir):
> +        changed =3D False
>          rev =3D r_remote['rev']
>          branch =3D r_remote.get('branch', None)
>          remotes =3D r_remote['remotes']
> @@ -586,6 +586,16 @@ def are_layers_changed(layers, layerdir, d):
>              if upstream_revision !=3D local_revision:
>                  changed =3D True
>                  print('Layer repository {} checked out into {} updated r=
evision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layer=
dir, repodir), rev, local_revision, upstream_revision))
> +        return changed
> +
> +    changed =3D False
> +    for r_name in layers:
> +        r_data =3D layers[r_name]
> +        repodir =3D r_data.get("path", r_name)
> +
> +        git_remote =3D r_data.get('git-remote', repodir)
> +        if git_remote:
> +            changed =3D changed | _is_git_remote_changed(git_remote, rep=
odir)
> =20
>      return changed
> =20

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-FuonhUXespZ+x6a1R7pQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTv+HBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bsx/AQC0MSKBl0Nt9DY9vKTPPPhww0R/T0brO831
FogPpWRmTQD+KF1XU6gFWNnGGWrTo8tgyJc6YMtto2pDMUO/hH9srQw=
=pCUS
-----END PGP SIGNATURE-----

--=-FuonhUXespZ+x6a1R7pQ--

