Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2566D4417F
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 11:28:04 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10664.1765538877125416277
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Dec 2025 03:27:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=z1YtRwU7;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=j/GUeSLj;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3313EEC05F2;
	Fri, 12 Dec 2025 06:27:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 12 Dec 2025 06:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765538876; x=1765625276; bh=tIomm+e7Wu
	O4JlsbXQfpWabmmKfXwlkI2MrAdP6Kbdo=; b=z1YtRwU7x4veKH/5RVnDfNTGkz
	uJQNwH9IlMfeSoGwnxI7J110VEtaPPmRZSydZxtqiNnGMoZUnuE+mjHFN5MTr2iM
	gUj87FZrHaqbBOY96XHfvUd15kIsQOoJ6wb0jN0M7TsoVKxZqPERnn5D9OLBHc1D
	XGLJhlI0FF6ZpvoRjDcAssidcYvyIYTPsuAlyXYTNFId0zg+z9sVWeKEEO5e55OF
	R0E/5IuUAzOkan4muWqpm+0mBP/gOlYC1pmLLulgX0Xw8/M3EfjocRJl41b8H9Fr
	Vp3p8YCFddGtTOFDqiRnlStKoM/F5bJX0CZVRbrM1Tys57RFJ/X3wsBd6rnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765538876; x=1765625276; bh=tIomm+e7WuO4JlsbXQfpWabmmKfXwlkI2Mr
	AdP6Kbdo=; b=j/GUeSLjpNG8pVmHHbHzqM0X4X3BdQxerB2MAF5TCdIynJVpZ2o
	tKN7B7HiYR+X+7OnD8vbup/4NWe3HZDjz/7T65tmXn0AXJV9cV+tFsCO+Z5ppVBg
	CrXVF0Mi2eFw+Z71ZZCmWXYQgL2VKdj50HGMz4YEsP97aO4RllQd6T5u5XwmDDm3
	AKad5y8LoDpVICXw9BmT8vJHOIg97blDqYaS6p9u4V7u/VADZ6oBfCfCTM7YK+Dv
	Oli+XSFmyHJXHrvXoqEBVgUuSAtLjgO61XU5xsIi4hdwMn2p2hD9fqRjSyCJ8oUH
	0yHeIwxSGFqJOq5a0P6X1LJbSBWz8faZmwA==
X-ME-Sender: <xms:O_w7aYQuQR-pzq9cZ6TRvagAhnTCeJo3GTNX5KmH93RUKsFoKjIBEw>
    <xme:O_w7adNdDepB8z1r32Blpo9IZoS7gcm5PFBor03gbRIhw1hwFFupl0ZNbcZhhv9uS
    XSBzAdaXUYmUwB2yViLrJY8Z4kS1kiiPYdQuDD_TJH0K6XRmJa-oK6->
X-ME-Received: <xmr:O_w7aTON_lZL4OzTRHSHNCUKn59ImuRB1ZvbvK-ybr8ylpmDcVImuMwlMoZWSbTG7eKdrYzUBeU77VLjMMciMR0HZ0IiItR__wt_-XGUzxDH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    fhkefhuefgleefleduleelhfektedvffeitddtueeukefhieduiedvfeeuhedutdenucff
    ohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlh
    gvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegsihhtsggrkhgv
    qdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtth
    hopegrlhgvgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:O_w7aVt0DAtmwfvSllw-40hPN6W0Jt4sErYSpb-GE4H5bLD27HTCPA>
    <xmx:O_w7aVXIHH1BAhSqsTaX081sHaIR9vqUTEvIP-opzVuiAVXmfGArjw>
    <xmx:O_w7aVsrK5DoxhvF4NJlaW2e19hUAiQNf--OSrwd2HNrjjpZ3Xj3jQ>
    <xmx:O_w7aZVBDHvgRQfJUxg6k_uEk9XJROG38IjG1BO2rfSr_t6LNgfWHw>
    <xmx:PPw7aahYUMxZ6gH24rVNF6V9uMnbSqYLHAar9FdQkXxcbxqLbp-oqcV4>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 06:27:55 -0500 (EST)
Message-ID: <9df2121472cb0296ca4c1ded0edeb1059e55a130.camel@pbarker.dev>
Subject: Re: [PATCH 4/4] bitbake-setup: implement symlinking local sources
 into builds
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Fri, 12 Dec 2025 11:27:52 +0000
In-Reply-To: <20251211142532.983960-4-alex.kanavin@gmail.com>
References: <20251211142532.983960-1-alex.kanavin@gmail.com>
	 <20251211142532.983960-4-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-imcoZNW4Lyhblt50bjT3"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Dec 2025 11:28:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18573


--=-imcoZNW4Lyhblt50bjT3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-11 at 15:25 +0100, Alexander Kanavin wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> The feature and the use case were proposed here:
> https://lists.openembedded.org/g/bitbake-devel/message/18373
>=20
> The implementation extends the schema with a 'local' source type,
> and simply symlinks them into the setup directory during 'init'.
> 'status' or 'update' do not consider or modify the symlinks.
>=20
> The overrides support is extended to add a command line 'shortcut'
> for overriding sources with a local path, and massaging relative or
> ~-containing paths as appropriate.
>=20
> Documentation is extended to describe the local sources and show
> examples. The json properties for sources are also grouped correctly to s=
how
> what is git-specific, what is local-specific and what is common.
>=20
> Tests are extended to cover a few things that weren't previously tested:
> source overrides, custom setup directory names, and tests for local
> sources are added as well.
>=20
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup                             | 29 ++++++++++-
>  .../bitbake-user-manual-environment-setup.rst | 50 +++++++++++++++++--
>  lib/bb/tests/setup.py                         | 28 +++++++++++
>  setup-schema/layers.schema.json               | 14 ++++++
>  4 files changed, 115 insertions(+), 6 deletions(-)
>=20
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 1f83b1b2a..30c5c44f7 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -109,6 +109,10 @@ def checkout_layers(layers, layerdir, d):
>              revision =3D urldata.revision
>              layers_fixed_revisions[r_name]['git-remote']['rev'] =3D revi=
sion
> =20
> +    def _symlink_local(src, dst):
> +        print("Making a symbolic link {} pointing to {}".format(dst, src=
))
> +        os.symlink(src, dst)
> +
>      layers_fixed_revisions =3D copy.deepcopy(layers)
>      repodirs =3D []
>      oesetupbuild =3D None
> @@ -121,6 +125,9 @@ def checkout_layers(layers, layerdir, d):
>          r_remote =3D r_data.get('git-remote')
>          if r_remote:
>              _checkout_git_remote(r_remote, repodir, layers_fixed_revisio=
ns)
> +        local =3D r_data.get('local')
> +        if local:
> +            _symlink_local(os.path.expanduser(local["path"]), os.path.jo=
in(layerdir,repodir))

Applying overrides shouldn't result in both 'git-remote' and 'local'
keys being present for the same source, but a badly written .conf.json
file could contain both. We should probably error out if both keys are
provided.

We call os.path.expanduser() in obtain_overrides, so I don't think we
need to call it again here.

And, I'd prefer the variable name r_local to match r_remote.

The rest of this looks great and works well in my local testing. Thanks
for implementing this!

--=20
Paul Barker



--=-imcoZNW4Lyhblt50bjT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTv8OBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bkwgAQClNdcaG132fhcTbl00OL37YOWeXsHUT4Cy
j8XviustlgD/eCHS8xjbtc2XUD23BrHsHy/Em3dDVklyvy5W+yu7Gwg=
=fbY5
-----END PGP SIGNATURE-----

--=-imcoZNW4Lyhblt50bjT3--

