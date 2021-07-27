Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
 by mx.groups.io with SMTP id smtpd.web11.941.1627391651112100460
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 06:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=uL0Sn5Se;
 spf=pass (domain: pbarker.dev, ip: 66.111.4.28, mailfrom: paul@pbarker.dev)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 36D0D5C0032;
	Tue, 27 Jul 2021 09:14:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Jul 2021 09:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-type; s=fm1; bh=dmyQM/UKU1ldz4OJGUwRM1ZY6P
	oPLWgHaQBfYLPFosc=; b=uL0Sn5Sezy7cK7kC3aVSIljFfGj4YgPhv4boeECiut
	lmFDABis42hgSzmtaEJbeqUyg/a0ZCCqxj1RUjOdTVg6KfwqntgU+Zlx2tH78QAe
	Oh0MqYbdyIXRYds9Ld9kuUIPik6qTDOOW4q4O4JrSKAVRTV+Zi72KNBYvm4j3h7J
	pvLrjSkcke9n0jHpk9Q6Yy7qLbSWiU/54GIQfR+y0cBJYJG/SkVO2NM678by/BvY
	WA5MXkmxqdVvzRaCoQIuxdiwHXl8ychhXL1rVBck5v0gH2ZAAtTANkyWYOQPt2+b
	bm+wFUi1FBu7PpQB0i96eGN1+74XFGUE/2MqULSeY1fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dmyQM/
	UKU1ldz4OJGUwRM1ZY6PoPLWgHaQBfYLPFosc=; b=vsq4a6MrlYZGMFsY1J9zV/
	ayBi/wjw5hM9ZtlJsC1IXObG/ZoFBcRCPu4XcQy0/mFaxAsv2pNxg7yoTJPoV2kp
	UZ57IJ0F5nzTJuxzkr8FfqtyOp1NvEKaTqePYxQXZG4/h589gTX/C4MLh1jsJWG0
	fcnYKHhChZHqvO/pDYE4KiJNtoKSlk+U4DyPlg3xC9sR5UaDtaMHL9tksSCPHgLL
	MeqRf3fMXBfhj7vjW3JQg96q7lhXxqwrXeBxnNRUn7RMUQgIvZqLbu3Hmr4lmJT0
	9KDwv7RLmUk/g2+VQFl0pG2GfQi9vnRnuIJlQPhTGtvC2KCqTNhEULOm3A+ZPsew
	==
X-ME-Sender: <xms:oQYAYerGlwTIm92I3Nqvg4b9U7CfuaK1h_f-jwajkeCjhO6kC-JHZA>
    <xme:oQYAYcoJBOXYwLhmxeCNG32SvXfAQ-v8oTI5n98ufvljPbQwnseDd-8IMR7nh1lmp
    14uK8AMfeFyBzPvLEA>
X-ME-Received: <xmr:oQYAYTP_G03gQjVigSAukUNGsX30aLRs7NgD-gKjGMFzQZwCQ6tAaKYPLUbuV31us90QPxZQpjecII90NIXBafecw7RZJvklK2xZAgnWls7RFycB-nKvp2sFMG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epgeejleekheeiveeljedtteelvefgkeefgeeuhfefhfefteehteethfegvdduveeinecu
    ffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghdphihotghtohhprhhojhgvtg
    htrdhorhhgpdhpsggrrhhkvghrrdguvghvnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
X-ME-Proxy: <xmx:oQYAYd7mGr5LWJvrw0LYq7hpE1o1rBLYlTJkqTBwjXgX_bWHjuhrxg>
    <xmx:oQYAYd6Ey7HqHOMtl1B214uxqT0iMfT6Lsh53uJKHc8h30UTfm78tA>
    <xmx:oQYAYdiilQ7BqvM1EzmrSUn7-YfHDply5YjPiN2Lj_cWyH2YDeJavw>
    <xmx:ogYAYdEPoyW9YPtkIVFjSreNeQl8zzG73HSPAk9abuq4vYiW0ybtQg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jul 2021 09:14:09 -0400 (EDT)
Date: Tue, 27 Jul 2021 14:13:56 +0100
From: "Paul Barker" <paul@pbarker.dev>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: Scott Murray <scott.murray@konsulko.com>,
 bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel] [PATCH v4 0/5] Re-implement prserv on top of asyncrpc
Message-ID: <20210727141356.240bb95a.paul@pbarker.dev>
In-Reply-To: <269b9c191fdc8540eb6602409ef7a991e32a249d.camel@linuxfoundation.org>
References: <cover.1627352176.git.scott.murray@konsulko.com>
	<1695A57BEF93A6B5.3345@lists.openembedded.org>
	<269b9c191fdc8540eb6602409ef7a991e32a249d.camel@linuxfoundation.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-Groupsio-MsgNum: 12465
Content-Type: multipart/signed; boundary="Sig_/8mZIlecCetVD1tcdI+kESCj";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/8mZIlecCetVD1tcdI+kESCj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jul 2021 13:28:30 +0100
"Richard Purdie" <richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2021-07-27 at 13:26 +0100, Richard Purdie via lists.openembedded.=
org wrote:
> > On Mon, 2021-07-26 at 22:37 -0400, Scott Murray wrote: =20
> > > These changes replace the old XML-based RPC system in prserv with the
> > > new asyncrpc implementation originally used by hashserv, and add a
> > > read-only mode to match the hash equivalency server's support.
> > >=20
> > > Changes from v3:
> > > =C2=A0=C2=A0* Scott Murray taking over upstreaming effort from Paul B=
arker.
> > >=20
> > > =C2=A0=C2=A0* Dropped patches which are currently applied to master-n=
ext, this
> > > =C2=A0=C2=A0=C2=A0=C2=A0series should be applied on top of the curren=
t master-next branch.
> > >=20
> > > =C2=A0=C2=A0* Patches 2-4 updated by Scott Murray to rebase on top of=
 3983643
> > > =C2=A0=C2=A0=C2=A0=C2=A0("bitbake: asyncrpc: Catch early SIGTERM").
> > >=20
> > > =C2=A0=C2=A0* Read-only PR server support patch added to stack to get=
 it into
> > > =C2=A0=C2=A0=C2=A0=C2=A0the review process.
> > >=20
> > > Paul Barker (5):
> > > =C2=A0=C2=A0asyncrpc: Wait on writers to close with Python 3.7+
> > > =C2=A0=C2=A0asyncrpc: Ensure that asyncio shutdown is clean
> > > =C2=A0=C2=A0asyncrpc: Handle exceptions
> > > =C2=A0=C2=A0prserv: Replace XML RPC with modern asyncrpc implementati=
on
> > > =C2=A0=C2=A0prserv: Add read-only mode =20
> >=20
> > There is an odd failure on the autobuilder which seems related to this.
> >=20
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/75/builds/3746
> >=20
> > and looking at the bitbake-cookerdaemon.log:
> >=20
> > 1958 12:03:42.046562 Running command ['clientComplete']
> > 1958 12:03:42.046659 Command Completed
> > 1958 12:03:42.047003 Processing Client
> > 1958 12:03:42.047061 Disconnecting Client
> > 1958 12:03:42.047215 No timeout, exiting.
> > 1958 12:03:42.147541 Exiting
> > Caught exception: type object '_asyncio.Task' has no attribute 'all_tas=
ks'
> > Caught exception: type object '_asyncio.Task' has no attribute 'all_tas=
ks'
> > Caught exception: type object '_asyncio.Task' has no attribute 'all_tas=
ks'
> > Caught exception: type object '_asyncio.Task' has no attribute 'all_tas=
ks'
> >=20
> > with this last line repeating a 'lot' (log is over 1GB in size). =20
>=20
> I should add, this is after the bitbake-layers command used to add the la=
yer during
> the setup of that build. The later command just times out as the server p=
rocess
> remains and is locked up.

What's the Python version there? I've just re-checked the docs for
asyncio.Task.all_tasks():

    This method is deprecated and will be removed in Python 3.9. Use the
    asyncio.all_tasks() function instead.

asyncio.all_tasks() was added in Python 3.7. So we need to use
asyncio.Task.all_tasks() before 3.7, asyncio.all_tasks() after 3.7.

--=20
Paul Barker
https://pbarker.dev/

--Sig_/8mZIlecCetVD1tcdI+kESCj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCYQAGlAAKCRCrY1Tsnbr0
blx1AP9EGaP+4K+Qks1xCHYwcmtW9UZYDpAHTPO1jytdi+BlZAEAwHyuKnPJbAlU
LYsRT2u2gP2SlQHp9eA5jB2/eavBQAY=
=SLGj
-----END PGP SIGNATURE-----

--Sig_/8mZIlecCetVD1tcdI+kESCj--
