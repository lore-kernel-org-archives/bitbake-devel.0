Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711C6CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 09:35:20 +0000 (UTC)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mx.groups.io with SMTP id smtpd.web11.13382.1757496911899086544
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 02:35:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=aOp1/4DT;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=bbE+Cx2a;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D44B57A0183;
	Wed, 10 Sep 2025 05:35:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Sep 2025 05:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757496910; x=1757583310; bh=k0om7YKVuD
	xtizapEOxVm/GIg3IpDg2xuJ6EyPdK+ZA=; b=aOp1/4DTzykGcpm8Yw7/85dfyY
	pwpFomwZPr+Rz2JdYFfnyDHxBCyZ7a2HNb5Sbrf02GwF0jFUuepy84yRWmb+gDSP
	RS/loyR+iwg1eIjVUuTldBhF9zXJEaNsCI2iRQeP+uwanBceGtQB0MglRKhFfUXD
	YL/cFYvYC3E7zcDKJcenOQB3MZEYlBzMTIb1lVd4GjpSzfiM6cv2vzi5ebQw5a7b
	kBY05BKvU8nJqy22GY0iHlZGbox3Wgcqo/pmeC4zClGx5r++oxDce3o8eFn7c9sG
	BzRCAJmFqHyACqeG+4fymokzR4ZC6XPzIItqC8zGDLfozFGbkdbDPoya7Rng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757496910; x=1757583310; bh=k0om7YKVuDxtizapEOxVm/GIg3IpDg2xuJ6
	EyPdK+ZA=; b=bbE+Cx2aOCxiUhegXqL8LhszJSEdVxjpR6+sViW8X9SoUSUVLdY
	O7ab/iHPzi9cdKRoucGkPw78hv+MFii6M+Tz/5Ts/RqN18UgBfQvKKRUPbIYHjMI
	1m37boglh2bbMBS5Rcl6ssbWOWmpWYat+A4tf7eyXUE0I8Q2HxieE5sGEAdI4Rus
	Zc8twKH/kdZ+nbmPb/y6KXp/sBbyTaZjYWDsbvyw9GdVyhgT4KsVBAP0mh6GOmul
	lC8kh49yuif2oXyMu+aMNbmZrFo1pZl0guiJlM29pwTu5fSpuEMWXLRWp8fLxniw
	jQ58QMHQI29pVJCBDEYB9rlW2AFYS9Yff/Q==
X-ME-Sender: <xms:TkbBaLuycjVhZc-gP0_Fb6unRf66gl0ZDXY2MIsCJLngckWQ9PD43g>
    <xme:TkbBaPsjTPG3ylXrrtbWcbHl2Sr25iXSfLdxwVXWrGLRXRT0bNlnjgWYtqWKwO8Up
    On-irKIg4IRkWtrY_k>
X-ME-Received: <xmr:TkbBaINX7eP9a9127EJN-8mKzFegW-kVxygADUhm3AQ10y9bAtX49GkoWnJlNhwyZ7e3hRJTwaUwKjXu0IG1M3sH66NVsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    elfeeugeeihfetueekvdeiieetieduhfelfffhhffhvddttedugffhudelteffheenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhprhhotggvshhsrdhruhhnnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhk
    vghrrdguvghvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegrlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegs
    ihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
    dprhgtphhtthhopegrlhgvgieslhhinhhuthhrohhnihigrdguvg
X-ME-Proxy: <xmx:TkbBaF1w0_koBThUi7mZgvv6FZV-ieRPsoxX2kDkd5B0W-yqAyqW6g>
    <xmx:TkbBaMPmR5zE_2Nmb0ne5JoRqAgJzD5vvbeYpgQyiaBwN96ojeECPA>
    <xmx:TkbBaN18h2cVy-phOPK_HmRdBubKI50UQxcyq6R6Cq_LPYlpmYWynQ>
    <xmx:TkbBaLF4yfN4u3HYwkVPTRL3b_-pRXEsYV96R3bwPzLgwwPIF-KQRw>
    <xmx:TkbBaEKRVXVqDxYxKZeUiMaUb1lA03m_N29bvhOAiRx07KK-KdnSKnwu>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 05:35:09 -0400 (EDT)
Message-ID: <dd91f763f6d54bf3fd48215cfad51c2d0b0cfb56.camel@pbarker.dev>
Subject: Re: [PATCH 1/3] bitbake-setup: add the initial implementation
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Wed, 10 Sep 2025 10:35:04 +0100
In-Reply-To: <20250908123437.1728264-1-alex.kanavin@gmail.com>
References: <20250908123437.1728264-1-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-h5CcUCzloDm5U3pYbMPA"
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 09:35:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17993


--=-h5CcUCzloDm5U3pYbMPA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

I've added a few thoughts after testing this out.

On Mon, 2025-09-08 at 14:34 +0200, Alexander Kanavin wrote:
> 3. To check if the build configuration needs to be updated, run:
>=20
> =3D=3D=3D
> $ bin/bitbake-setup status
> ...
> Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed.

This example doesn't work without a `--build-dir` argument.

> 4. If the configuration has changed, you can bring it in sync with:
>=20
> $ bin/bitbake-setup update

As above, the `--build-dir` argument is needed in this example.

> This commit includes fixes by
> Ryan Eatmon <reatmon@ti.com> https://github.com/kanavin/bitbake/pull/1
> Gyorgy Sarvari <skandigraun@gmail.com> https://github.com/kanavin/bitbake=
/pull/2
> Johannes Schneider <johannes.schneider@leica-geosystems.com> https://gith=
ub.com/kanavin/bitbake/pull/3

The commit message is missing a Signed-off-by line.

> +def checkout_layers(layers, layerdir, d):
> +    repodirs =3D []
> +    oesetupbuild =3D None
> +    print("Fetching layer/tool repositories into {}".format(layerdir))
> +    for r_name in layers:
> +        r_data =3D layers[r_name]
> +        repodir =3D r_data["path"]
> +        repodirs.append(repodir)
> +
> +        r_remote =3D r_data['git-remote']
> +        rev =3D r_remote['rev']
> +        remotes =3D r_remote['remotes']
> +
> +        for remote in remotes:
> +            type,host,path,user,pswd,params =3D bb.fetch.decodeurl(remot=
es[remote]["uri"])
> +            fetchuri =3D bb.fetch.encodeurl(('git',host,path,user,pswd,p=
arams))
> +            print("    {}".format(r_name))
> +            fetcher =3D bb.fetch.Fetch(["{};protocol=3D{};rev=3D{};nobra=
nch=3D1;destsuffix=3D{}".format(fetchuri,type,rev,repodir)], d)
> +            do_fetch(fetcher, layerdir)

We should support entries with 'path' set to an already checked out
layer directory and no 'git-remote' key. This would allow people to use
bitbake-setup to manage the build directories for layers which they
maintain without having to push all changes up to a remote repository in
order to test them.

We can add that in a follow-up commit though, so there's no need for
this to hold up the initial merge.

> +    init_script =3D os.path.join(bitbake_builddir, "init-build-env")
> +    shell =3D os.path.basename(os.environ.get("SHELL","bash"))
> +    fragments =3D bitbake_config.get("oe-fragments", []) + sorted(bitbak=
e_config.get("oe-fragment-choices",{}).values())
> +    if fragments:
> +        bb.process.run("{} -c '. {} && bitbake-config-build enable-fragm=
ent {}'".format(shell, init_script, " ".join(fragments)))

We can't trust that SHELL will be posix-compliant and able to run the
init-build-env script. Perhaps we should just use 'sh'?

> +def main():
> +    def add_top_dir_arg(parser):
> +        parser.add_argument('--top-dir-prefix', help=3D'Top level direct=
ory prefix. This is where all top level directories are created.')
> +        parser.add_argument('--top-dir-name', help=3D'Top level director=
y name. Together with the top directory prefix this forms a top directory w=
here builds are set up and downloaded configurations and layers are cached =
for reproducibility and offline builds.')
> +
> +    def add_build_dir_arg(parser):
> +        build_dir =3D get_build_dir_via_bbpath()
> +        if build_dir:
> +            parser.add_argument('--build-dir', default=3Dbuild_dir, help=
=3D"Path to the build, default is %(default)s via BBPATH")
> +        else:
> +            parser.add_argument('--build-dir', required=3DTrue, help=3D"=
Path to the build")

Both of the commands which use this ('status' and 'update') take no
other arguments. I would prefer to use

  ./bin/bitbake-setup status path/to/build/dir

Instead of

  ./bin/bitbake-setup status --build-dir path/to/build/dir

With those comments said, I think this is great! I'm looking forward to
trying out bitbake-setup more.

Thanks,

--=20
Paul Barker

--=-h5CcUCzloDm5U3pYbMPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaMFGSBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bkaFAQDA2LMUeNuz/VtZSeuU8K62q+bj7EoHNUiS
Ty7qH/xQNQEA+2zzdTBPuFmlBXu+qjMkYfX9xorVNCLsmWkCwifMkAo=
=Ntzu
-----END PGP SIGNATURE-----

--=-h5CcUCzloDm5U3pYbMPA--

