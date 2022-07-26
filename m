Return-Path: <patrick@stwcx.xyz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB34CC433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 04:09:10 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by mx.groups.io with SMTP id smtpd.web10.2796.1658808544657340917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Jul 2022 21:09:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@stwcx.xyz header.s=fm1
 header.b=JphaGg2F;
 spf=pass (domain: stwcx.xyz, ip: 64.147.123.24, mailfrom: patrick@stwcx.xyz)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9D8DB3200922;
	Tue, 26 Jul 2022 00:09:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 26 Jul 2022 00:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1658808543; x=1658894943; bh=4mSVvmvt0h
	G/PGZeGnURji19v93iFla02mw+KiGeND4=; b=JphaGg2FKX0EZ11zfekH8Lv/XG
	hEyJHfDI39PuakgYpJ1e3yDciIPwt8JEBnbHiN2El8YMwX2jT1txr9v1PsdeTpdX
	8vRkyfd9PA4ZxdHQflxMZEX51F3nrguCfcEQzretIEWGiswZDMU5AA6VdgSxiH2t
	xmUDDvH5Zob/YDW6rSiNuxCNrbPMx7+pc2Vx1aZzTHRXNvZEuc4ppIj2DpS9HMKQ
	ZBCyagLw/jzEI6AJjZVt9NYYu3jyXZSemqXlVCez6oYLKMmPWrrPAwdsX+p0h4VD
	X+7FHvBMzqZluoQ2dhY5+Z9CiaBw9MfT/WpLn8YTLSBsxEOCUqVB9bag4tPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1658808543; x=1658894943; bh=4mSVvmvt0hG/PGZeGnURji19v93i
	Fla02mw+KiGeND4=; b=YSxzbI2sP6wXu7teumII0noPG/3emymZuUFpmuCUCor9
	ffVUk5o3EmmFontWFLw92UF1Ll8ulocMr+JEh9bi1nZFNoj7aqhtBsfvESjFUR/z
	nH1hJF2PmO6xwDWtcbzlaXc0bF7fFRv82jjKhddAMAZzCOHHqJdAgIh7eTBnVX0u
	0ivP1nmpBFivXb//rZ051/6vydDiCE5kCxOthLv6iEP9ZkK9uOZp/qn+lGpBs9sI
	HLqlD2qjvLTF7T5dmrZXfLu9QHvoJ+zhk3+4Ww0yc4UEgsrx4lKmWBL4RpPYJNJE
	YfyOOvxZEXLxSRrvMavBwgMERN91yCZU3VXZDLVUqA==
X-ME-Sender: <xms:3mjfYiPzrI7XwE_ykg2g1l_OgF-IU0Emvo0mryS8cxWms0NOF7x8gQ>
    <xme:3mjfYg8UT-hyTVdOR94ezuGVUEGxXkmC7bx9XJCTxvua3Z3xgIUJ1KBfVZ9i8XfmG
    lAjW1zeFlsL6nDLzHY>
X-ME-Received: 
 <xmr:3mjfYpRc5WzMF7jYtcyJnWVsC0gTlD2xQcYfH54okjPR8NDDjXh0dJazHDIZ8ctRE6pvViysePZ5ZPbp9aZaX1dCxspMcmO0>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvfedrvddtledgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeejjeetleehleeijedutddufffh
    ueeufefhfeelheevgedviefgffehudelheelhfenucffohhmrghinhepghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:3mjfYivPKGTD6tjLa7GqWOyNsVHhd6DGomUtOGanOT6ngOYfyhpMBw>
    <xmx:3mjfYqebaNG9zgssNnThNHUEuiR9U2rK7yOPB9iKDNmHlimYCqg7nA>
    <xmx:3mjfYm3sPPY4d_Pu4DK63kD6pyhx8JK1nBtxwoTXcBK6UiAR1Klzew>
    <xmx:32jfYuF0fAPPaXgCkn4oYuA6ArvA9bp8Sik_W0HM4ksdgPLVpJd7_Q>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 00:09:02 -0400 (EDT)
Date: Mon, 25 Jul 2022 23:09:01 -0500
From: Patrick Williams <patrick@stwcx.xyz>
To: Paulo Neves <ptsneves@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [PATCH 2/2] fetch: bb.fatal when trying to checksum non-existing
 files.
Message-ID: <Yt9o3TefXIqpJk7q@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
 <20220708205407.1680137-2-ptsneves@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wrbg2hEYRjJmPoyu"
Content-Disposition: inline
In-Reply-To: <20220708205407.1680137-2-ptsneves@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Jul 2022 04:09:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13849


--wrbg2hEYRjJmPoyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2022 at 10:54:07PM +0200, Paulo Neves wrote:
> If the local fetcher was not able to find the file anywhere but it
> was included in the SRC_URI for checksumming just make it a fatal
> error.
> ---
>  lib/bb/fetch2/__init__.py | 2 +-
>  lib/bb/tests/fetch.py     | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5f05278a..8184b55e 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1237,7 +1237,7 @@ def get_checksum_file_list(d):
>                              " This means there is no way to get the file=
 except for an orphaned copy"
>                              " in DL_DIR.") % (d.getVar('PN'), os.path.ba=
sename(f)))
>                      else:
> -                        bb.warn("Unable to get checksum for %s SRC_URI e=
ntry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))
> +                        bb.fatal("Unable to get checksum for %s SRC_URI =
entry %s: file could not be found" % (d.getVar('PN'), os.path.basename(f)))

Now that we've picked up this change, it seems to have caused a bunch of
irritating hard failures where we use to just get irritating warnings.
Our recipes probably aren't 100% ideal, but we had a number of recipes
which are not pulled into all our machine configs, and could end up with
broken SRC_URIs on machine configs they are not intended to be used on.

There are some more complex examples, but one easy example is a recipe
which had `file://${MACHINE}/eeprom.h` in its SRC_URI[1].  Any machine
which didn't provide this file, even if it never intended to use the
recipe, now fails when we picked up this change.

I know we've been ignoring the warning(s) for a while on these kinds of
failures, so it is our own fault, but it is kind of annoying the new
behavior.  We now have to make sure every recipe not only parses validly
on all machine configs but it also has to have fully populated SRC_URIs
even when the recipe is never used on that machine config.

1. https://github.com/facebook/openbmc/blob/f0d9511ad2fbd563a6b793093cdac55=
7c5ef2a89/meta-facebook/recipes-utils/mac-util/mac-util_0.1.bb#L12
--=20
Patrick Williams

--wrbg2hEYRjJmPoyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLfaNsACgkQqwNHzC0A
wRmpyxAAgIDcAVe13c1N4wObGOqKddLH7aCPcgoIGhDcD3CbAHE9vYdfQMo93GAI
6aoLty3e44BFeoXeZL7CH7apXBEIOYKSjGYZpg667wNDaT3vLh7IA8dN8yPd69rQ
Wb/UiCWWwYhs0Sk8+Fyl6v1ma40eJlKj19hGtFG5sRPAk746Cmyq3sOGhG6rv6CY
VAhfkypZvMWAqCIBGwc/bBaad45iMW0sMLPgz8SFdAXoGTnMcIAwA2pjIXpeMFDN
J1wgG5+jq1wNlHFp0kyCDuTyX3AwPeJBlO0OX870v2GLERV3IKZ1cmts+JAC80nP
8YqLaaz3fGOHfJ9b0OYwb+akAAmZglvjt4NiargLLmsNa3RLDWq4gsnSDOq9acTU
z1Z4E5ndnMqfbsFAYBygn3+5KC1AwM1qNk12H7mbtrK8WCFmPxi3StrbINZVF2HZ
agt0jOCQJcvRgH90UqR/dsZuisopj/8TVlKDIk0M32TKKsCuniD8U9lPJXSK2T0+
WBTRJ+EnKPV5LhnZZQsGG5GExH9EkGvlhmJTatWqYniZ3MU9+z3ha8i7/9PiP7oY
AuKbYRTCrsLzZNQys8pQlKq6Btc3RA5BXe+EqbA0Uv52O6GzBMHskPzaip3mtQE9
9KJN3X9F6QY5f81rEBQ6udM1/bPr5w45NKMLWoH3GBFVlvKbHwA=
=6IfA
-----END PGP SIGNATURE-----

--wrbg2hEYRjJmPoyu--

