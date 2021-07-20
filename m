Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
 by mx.groups.io with SMTP id smtpd.web12.217.1626801737148209632
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 10:22:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=TIxfagqX;
 spf=pass (domain: pbarker.dev, ip: 64.147.123.24, mailfrom: paul@pbarker.dev)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 36E573200915
	for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jul 2021 13:22:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Jul 2021 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	date:from:to:subject:message-id:in-reply-to:references
	:mime-version:content-type; s=fm1; bh=DY6HgdkCWHFX9UeIVwKvNGWU7X
	cT9fN2sQ8hfN1Ix/c=; b=TIxfagqX2LDCWCBoSEgKm4Y2fFegni9e3DsXZeHU88
	Own5y/FQi5EfCZiD4i2Npm+dS8AubrU5D2zlPUNLWh/aKwFyP5JzQLXn2SrMBB2y
	IN7Saw2dl0E5jIhHvj/4BVusDKJWkchsK4PNe3sCxistgLlcHdveMVe35lzmrArn
	IO4n8bst0DWL02su/fAn/dpQ8Kor7EUHtAXrWZVyQWusKOO8ndBp+YkD695Ihl++
	fIqCLVBiLh4ovbKxgluNqwm4uGKUSKjIviNtV4JjShiEQcIoKKyTr6zsX2da6bOv
	sQqYR0+G+cOiNB2OKqkPwbOVkqLtz6Tsbuwp5ngy66NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DY6Hgd
	kCWHFX9UeIVwKvNGWU7XcT9fN2sQ8hfN1Ix/c=; b=K5i1HIqDXTV9sf5CAb6syp
	+2hBJd8Zy2ITZNvxALq9zCv4Hnl0+TD0/IgGm1dWOHxrhThWPYlQtI/QD5jmlXk7
	6B7fJyhExe4XFFFW736KXAFwYNzeDHWz6TuAtw7xSPsunr2jphaPI5uH7KIaiLkX
	qbFTyxx/ZxYltKg7IychGGr5DluMqR4qPGOYvsKXlz15isBcpitMW1rqpR+0AWJc
	8QjKGU4Qe0pV3yZJrwXuN6K9kMwhmpqHMHydqZ/boyM3FRqjzNce9DPUJu7G5q65
	06cdeIGwNN4XuunFpNv3MqLegGMHahi5zE2Ew3GyJv8eRgrq8h8IPCEGdaxZ0jpA
	==
X-ME-Sender: <xms:Rwb3YO6VFaOpFT9wvvFtJl6jDeJzNZL88URZ_Wsp2tr0FvmmbEev5w>
    <xme:Rwb3YH7GQri4sNpOUsfUbugoMlIC6CpqX6wtqtvwNRriYcwhK1N9PzPKV7__cdKCk
    xwYe0aiYjl5mOGVNig>
X-ME-Received: <xmr:Rwb3YNcPTKpJaX8jQ7uU6ik9sifzRv8OAXWmf0w89U6I_lPIKbUYypj6YKNTucjMTMzQibcMzATmhY7HttnG1q62jQdyWnLqJdLLvxdzTEJA1vtvfgL8LsXbZ8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfedvgddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkjghfofggtgesghdtre
    erredtvdenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgv
    rhdruggvvheqnecuggftrfgrthhtvghrnhepteeuhfffgfehveelffelueegffeutdekje
    evffehgfefveefleeujeevvdeigedunecuffhomhgrihhnpehophgvnhgvmhgsvgguuggv
    ugdrohhrghdpphgsrghrkhgvrhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvh
X-ME-Proxy: <xmx:Rwb3YLJUtSkaSLU0rKjHwQGy4YSYg3FtBNW8rkeqinQN1CHDafJcvQ>
    <xmx:Rwb3YCLAqFgU_bjAtX71Nf3NLVbPtzrOgf8mRxsOAryaaNkIB-Lgbg>
    <xmx:Rwb3YMz2tnjieCPFF5ocSK14j8s55F5GbB3TPdXCGm1a05LKswWtuQ>
    <xmx:Rwb3YBkL3ptMO3pVJyfq3lTTefbM9xQPKEBK_3lQzCdnIhGGqzc1Tg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <bitbake-devel@lists.openembedded.org>; Tue,
 20 Jul 2021 13:22:15 -0400 (EDT)
Date: Tue, 20 Jul 2021 18:22:01 +0100
From: "Paul Barker" <paul@pbarker.dev>
To: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 0/1] Substitute '~' when naming anonymous functions
Message-ID: <20210720182201.040efd99.paul@pbarker.dev>
In-Reply-To: <20210720171628.23394-1-paul@pbarker.dev>
References: <20210720171628.23394-1-paul@pbarker.dev>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-Groupsio-MsgNum: 12434
Content-Type: multipart/signed; boundary="Sig_/ctfGc6NdcyrczXwjAoLu=UP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ctfGc6NdcyrczXwjAoLu=UP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jul 2021 18:16:27 +0100
"Paul Barker" <paul@pbarker.dev> wrote:

> When looking at meta-linux-mainline in the layer index I realised that the
> recipe version shown were out-of-date. The most recent update log [1] sho=
wed
> that the layer had failed to parse. Looking at the log it was obvious tha=
t this
> was due to the path in which the layer had been cloned, not due to any is=
sue in
> the layer itself. As git repositories on sourcehut use '~' as a prefix to=
 the
> username in the URL, this character ended up in the local path to the lay=
er.
> When bitbake parsed the recipes in this layer, the '~' character ended up=
 in the
> function name generated for an anonymous Python function. Since '~' isn't=
 a
> valid character in a Python function name we got a pile of errors.
>=20
> We already have a translation table to handle characters which aren't val=
id in
> Python function names, we just need to add '~' to the table.
>=20
> Paul Barker (1):
>   parse/ast: Substitute '~' when naming anonymous functions
>=20
>  lib/bb/parse/ast.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

It helps if I include the URL rather than just leaving a dead
reference...

[1]: https://layers.openembedded.org/layerindex/layerupdate/9144821/

Thanks,

--=20
Paul Barker
https://pbarker.dev/

--Sig_/ctfGc6NdcyrczXwjAoLu=UP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCYPcGOQAKCRCrY1Tsnbr0
bjrcAQChY/GB6EaPSsFlSacOyDfcCQK1hqWc4S1LXlFArFShhgD+ObBen1AT6wus
4ZOY2yRFvmzJGol9S6LMz0yB5LwsvQ8=
=f1wd
-----END PGP SIGNATURE-----

--Sig_/ctfGc6NdcyrczXwjAoLu=UP--
