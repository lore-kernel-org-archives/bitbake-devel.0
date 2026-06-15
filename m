Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FA2CD98DE
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 08:30:17 +0000 (UTC)
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.125258.1781512207991193265
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 01:30:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=ObwASrJt;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=RtaoASG1;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.150, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B3111D00128;
	Mon, 15 Jun 2026 04:30:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 04:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781512207; x=1781598607; bh=WgS74LMFk2
	ojXrmXp0wV0UJlaqRYIcCO3PhbAFag520=; b=ObwASrJtg05VLcyN6ZT/OIQYsq
	mEGC4tcmJo8kqcwNA3tjPUKZk2HwasWy/VjKYX8SFANgdZAvhub/ff3k7RdF3Co+
	/HgYaZyAb66bq35uuHNnlKWnX1o+Bg9WjK/JdA89u0WD2zh8znYx4BkeOWfEog0x
	rjr1srXa715vY07Mr4B5ppjhshyw83qZI0Hv0pCwNPtrH4w0afVGzOh8I8hkJyrw
	tLqbJmRJzTK7ndSubz8vdS+XrpA6Cl4x2qOTj8ujLzG/YU7/14dVWDD+YUXrIJJa
	aDfIxJNuU8CT3xo8YZ2vjj1SE/sbyK9c9wd1fdwDvd/A3BasudwAp6yLsXsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512207; x=1781598607; bh=WgS74LMFk2ojXrmXp0wV0UJlaqRYIcCO3Ph
	bAFag520=; b=RtaoASG1RGVshi5z25Jhn7LMZEP5UUDOUlOncucUU5iL7pATLpD
	5PlfTdikw/fuaotn2OkSlG5UDJwzn9JoHZmQgRHZDz2iLAPblEZ5fmOhpitkldJ4
	7YiZjpWHMrQgGjO317QcJ04tzu+Frnc2hUZfAyVfmZ7fEv/gWdQmqCp3xMTE2uww
	o+XzhiT5qzQR4DzgdbQg0BJD1R58DMLaHWLqPxgx1sm1GYjqmKZcYalXJKu6vyOf
	gAP2SI6OlowOrjnd53cCa66GSZJ9ov4FqCYNjZu7TcVsCo0AP2OW+HY5XTXs2JMO
	kzqM7Pl0GqPD7Jv4EVghvDJ2ZJslRPvViRQ==
X-ME-Sender: <xms:D7gvarm0NFPjVljgw3KJyUU_LbTA0wRc1IiqVjlixRq4r123XPVLJA>
    <xme:D7gvak3I7qgARkX-b8LMj18GmqfQ99guniiPOM-Qe0JiJ-HuMo1xWKIygJ2McR2Yh
    Fhnk9WdDcPvqzR6zgjANTYP6j_E8H1T_wLWdpqrfQkIxE9-83N9fA>
X-ME-Received: <xmr:D7gvavRs5RbIZpNqtTDiwsSD1NbMM3wxxo_aSmyRo3zF1XOIko9g4BF2Tg5rNcyW_L_Pb0Uk9J0cIOM1RSXX5z8uKpzbAc2ofDY5jHdmjxU0>
X-ME-Proxy-Cause: dmFkZTF0Ot2lTMY/QFsGxbMCAM14Krj9z3CjpeeqxwR2a6glJrKu2/v/632jA0/P/B5mLI
    1kwFOd4fqVevHcLKYikgm498DmRIH06jJH9UjymjOf1nIPxGf8Dl8t5hMTEn97PbQRHqm3
    RTCwui1MwJwDRAG7t4tm6QG5VThiqMyveriRNEVN+RH46d6NL/qhYNJcteMxoAdp1iBlrs
    YniyG/h5R4JZP8XGnUbgc/mum2tpwLVqbZCE9mz9U6e1pu0sNaV1TER+ueW/kmu6496Bx2
    rqQvoKhmg0biMpH38np7cbJKhi2M5aPwKlcHjwf/6dwEyFB/AejMfOqWUsv6X2Jn7VwzQL
    NTVrfpL8CNbYJduVu/yxELHsKYCEWqjKfL85T56pWUBTKTIb8F2q5+bBYlurSMVPu0wXdT
    279jwfq379pi/p+6513v9gnwizGV2mzFZlJpzpcztE0+BC9CC/zSikkD3tZNYSRT01hE2W
    NG25DcrTcidoCef/Ee2leNgR/nsFbSps66ISyk3fL3A9jf+IlRbvdRGQan/qwMfQGQxZny
    3BD4haMt9SZ/dEJWW90kXWcBt4cyukRY5s29gFJ75YdhlslsY5GwuhmuurodZs3P/9sr3X
    GQzitvmEpRoZgpuq+pvH5QaKr8ZI75PYPgDaXrBAxYgAQWXR5wvhBIEYRqaA
X-ME-Proxy: <xmx:D7gvauvkXBDk4paXSrgLnp2c2k0eD7T6lRW_PpTn47419K3DQPceYQ>
    <xmx:D7gvasYXoykkfAoptrXtct_BGLjx8KdysjH1xlJ3-L-i4McjVdLTaw>
    <xmx:D7gvarvu7H2120q0ClKsOhrzlHIBsO_Fb0RfWkezOr8tdn2-oC9RJQ>
    <xmx:D7gvamFaVpZwRUw2xHn4QxGTcU42M9U_S-3-bQXlm7_JLIVOFV6mdg>
    <xmx:D7gvaqNgKqjUlXrco9b7qnn3QS6O551UQftUXeKZC6gPczv0hh9MFYd6>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:30:06 -0400 (EDT)
Message-ID: <d0e431f8bab663642342ad0bbb732b7c99cd09eb.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH [RFC] 2/2] bitbake-worker: Call
 landlock_restrict_network for tasks without network
From: Paul Barker <paul@pbarker.dev>
To: David =?ISO-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 15 Jun 2026 09:30:00 +0100
In-Reply-To: <20260612-landlock-v1-2-77891f63ed7f@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
	 <20260612-landlock-v1-2-77891f63ed7f@est.tech>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-7jVdNx33hXKDTPCaUWIG"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 08:30:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19684


--=-7jVdNx33hXKDTPCaUWIG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m wrote:
> Call bb.utils.landlock_restrict_network() for tasks without the 'network'
> varflag. This to support basic network restrictions in unprivileged
> docker containers.
>=20
> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
> ---
>  bin/bitbake-worker | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index aa14ef191..5f3fd9933 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -287,6 +287,8 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
>                          bb.utils.disable_network(uid, gid)
>                      else:
>                          logger.debug("Skipping disable network for %s si=
nce %s is not a local uid." % (taskname, uid))
> +                    if not bb.utils.landlock_restrict_network():
> +                        logger.debug("Skipping Landlock network restrict=
ion for %s since kernel lacks ABI v4+ support." % taskname)

In disable_network, the logger.debug() calls for failure are handled
within the function instead of by the caller. We should do the same for
landlock_restrict_network() as suggested in my reply to patch 1/2 and
drop the debug print from here.

> =20
>                  # exported_vars() returns a generator which *cannot* be =
passed to os.environ.update()=20
>                  # successfully. We also need to unset anything from the =
environment which shouldn't be there=20

Best regards,

--=20
Paul Barker


--=-7jVdNx33hXKDTPCaUWIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCai+4CBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bp0EAQCRxMbcrPFxVfm8gi/THejsaZyO3kJTKKb0
0Pdio4QCkAEAs30A5if+HUPWp5kufrdbuMyeWbIz8Dg+EMAqZCZ+sQM=
=8wH9
-----END PGP SIGNATURE-----

--=-7jVdNx33hXKDTPCaUWIG--

