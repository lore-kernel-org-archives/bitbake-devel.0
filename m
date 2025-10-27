Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D58CCF9EA
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 09:16:53 +0000 (UTC)
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mx.groups.io with SMTP id smtpd.web11.27681.1761556605961005391
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 02:16:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=rPc49DBc;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=mirBvERh;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2DCAD14001DF;
	Mon, 27 Oct 2025 05:16:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 27 Oct 2025 05:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761556605; x=1761643005; bh=reTfWHEcjp
	xSnMDPpVUYID7K/i4etAUuBfowsBisUAk=; b=rPc49DBckSfpicLO7d+ihL7MaG
	qn+iprcmCpemWct7pDU6m8XDaybpKTlfrLqjYGKvAVsjiDJ1Ucmy7qIUthKjEKbT
	vFKez1ZaPJ1f4gPLYHvdjW2DOEKXZgqx7uSOv35RdYOtsbDa31V4IccVIT0E8vMZ
	JA3Qax4RrRqKo3fdCFqgWNvxp4GWmVb3F5MMfRXT80g6LpCIR2rIadUpI4FH5oQJ
	ryttUHwM6V0sJ+OqAZ7KhxBoIoX2hvi43ZX3s9yYre3ajMFRVBkU3+ePfZAbKadW
	qpcbLBYZgxW4Dh0rOW9dYsYcwJBfkKIAOonfMts0msJUAijaBtTjU7FzC4yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761556605; x=1761643005; bh=reTfWHEcjpxSnMDPpVUYID7K/i4etAUuBfo
	wsBisUAk=; b=mirBvERhJJ7mRoEDEDMCjS5nt5EpwHf8uwjbe/PaHHTryXW/cY4
	1FLhWaZoed8kVzG7tzRUjeOVX7omd5QhniXFv2Et44klsgLlDeicol2fwa0issS+
	75shZXysYdBVlqtD4cx3brx6gYtOPAkAc+KAT25wn7gxFEiAnBq/prh6rxthNwTz
	GLPDh2lBmx6TgaEEDYSLVLzEciDL3P2Ks+TtLGfKCIdaeocE5IPS8fwVloJYED2C
	0XnKz9Lp51ybp+Vd1GgSqENW3ka1ZH7BrfASk7YTRjTopAm/PefiE2123i93Tnl0
	zHeG04i23GbqbcXuIbFw45RLC6HjOR/RQcw==
X-ME-Sender: <xms:fDj_aOUKlAJT2-xIcZH5u287P6a3l_pk0zUAKw5mRm2_7H4vJeIFnw>
    <xme:fDj_aAkBgpR0N-f4fJZeYOHIECUSNpzXmXok4XGLuWKTVlrsac_4e0DruA_spHxG4
    l4TDHTdGagiLBudJ5B3rKRnjj-GPMtGK0oAHjAqWtBE03in87JYeWI>
X-ME-Received: <xmr:fDj_aAB93f754XXZ0UxNS_q6flASn4L3Pk0UbMlhKfYKvlQxI-iYyaiQ80dSeztLJNqieJ49Hb-uQG7WDQFJrFiCHKjUng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    efieelheduffdvleejvdfgteeiuefgteetkeeftdeggefgvedtuddtvdehgeefkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesph
    gsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprhhitghhrghrugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdr
    ohhpvghnvghmsggvugguvggurdhorhhg
X-ME-Proxy: <xmx:fDj_aAeCduY-M5sECmzmNVpF3-1kvLSfLLf_d3wMQKNwhWM9yBnfFw>
    <xmx:fTj_aLIkgnMGkv8WRvNkGtYcsI2Bpc3Ou0zV_Ai-XpI1M7E2ZVyhpg>
    <xmx:fTj_aDd3EelLK7_ehg8pb1WP6Ym7-qk3IbLjuZ58PpXQ4MB0dxyn2Q>
    <xmx:fTj_aC3f02HPP06NpvyNUWOlpimPv99WoYxerKF6gvXW2h3DZi-7UQ>
    <xmx:fTj_aHwL6QIn18n7kMpdghhGmu8MPITtXh0hSr0LB3SBZOMa_i40OE7u>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 05:16:44 -0400 (EDT)
Message-ID: <c12740b7bc4ad5f7ddbb56f4ce57dc665892051e.camel@pbarker.dev>
Subject: Re: [PATCH] siggen: Fix dump of non-runtime sigdata
From: Paul Barker <paul@pbarker.dev>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 27 Oct 2025 09:16:39 +0000
In-Reply-To: <fd1e8c06aa46063af275cebef8aa42eb897c55e0.camel@linuxfoundation.org>
References: <20251027-fix-dumpsig-v1-1-465674c4fac3@pbarker.dev>
	 <fd1e8c06aa46063af275cebef8aa42eb897c55e0.camel@linuxfoundation.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-eD+1DJWDH3w7UBAOSNhf"
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 09:16:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18219


--=-eD+1DJWDH3w7UBAOSNhf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-27 at 08:58 +0000, Richard Purdie wrote:
> On Mon, 2025-10-27 at 08:25 +0000, Paul Barker wrote:
> > If the debug code is uncommented in SignatureGeneratorBasic.finalise(),
> > sigtask stamp file are created without runtime data such as
> > 'runtaskdeps' and 'file_checksum_values'. If we then try to run
> > bitbake-dumpsig on one of these files, we will see a traceback as the
> > expected keys are not present in the sigdata dictionary:
> >=20
> > =C2=A0=C2=A0=C2=A0 Traceback (most recent call last):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/bin/bitbake-dumpsig", =
line 195, in <module>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output =3D bb.siggen.dump_si=
gfile(options.sigdatafile1)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/lib/bb/siggen.py", lin=
e 1266, in dump_sigfile
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 computed_taskhash =3D calc_t=
askhash(a_data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 File ".../bitbake/lib/bb/siggen.py", lin=
e 1199, in calc_taskhash
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for dep in sigdata['runtaskd=
eps']:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~^^^^^^^^^^^^^^^
> > =C2=A0=C2=A0=C2=A0 KeyError: 'runtaskdeps'
> >=20
> > To fix this, treat these entries as empty lists if they are not present=
.
> >=20
> > Signed-off-by: Paul Barker <paul@pbarker.dev>
> > ---
> > Richard,
> >=20
> > This patch attempts to fix an issue reported on IRC last week [1]. It
> > prevents the traceback, but I'll have to defer to you on whether the
> > taskhash calculated without 'runtimedeps' and 'file_checksum_values' is
> > meaningful.
> >=20
> > I guess an alternative approach would be to call calc_taskhash in a try
> > block and not print out a task hash if the call fails.
>=20
> Rather than compute a hash which will never work, we should just skip
> calculating/printing it or print something indicating it can't be
> calculated. I've not looked into the details yet but I will at some
> point unless someone beats me to it with a different patch.

Is calc_taskhash likely to change in the forseeable future to depend on
additional keys in sigdata? If not, we could just check for 'runtimedeps' a=
nd
'file_checksum_values' in dump_sigfile before calling calc_taskhash and say
"unable to compute task hash" if they're missing.

I can send a v2 implementing that.

Thanks,

--=20
Paul Barker

--=-eD+1DJWDH3w7UBAOSNhf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaP84dxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpisAP99fgK3DOfOuFbfUUN5+l/IqjFWw3JFeRwi
BMsJa9sASQEAhdBZFN0C2wOZzEAdbGf3VVmGjOJl2ekCENesVk0Hhgk=
=RK3+
-----END PGP SIGNATURE-----

--=-eD+1DJWDH3w7UBAOSNhf--

