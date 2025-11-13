Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB934CD8C94
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 15:30:39 +0000 (UTC)
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26573.1763047835695294892
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 07:30:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=BSNHJ2EV;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=VoLiDf9Q;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.155, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A28FE14001DC;
	Thu, 13 Nov 2025 10:30:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 13 Nov 2025 10:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763047834; x=1763134234; bh=Q7kleZ5a8G
	qtF4VLw+ETWDEHyYZHqRaGGvZ3GDEVQl4=; b=BSNHJ2EVc0BqwzxwUtG3zi5gpn
	YX4D0w0r61T7bGP/zVwoeZ3ahPA8XhLg9QTwveVXqMk9Zn+dDZMuJxE5fbXjpYq5
	8mIZNh/+xAVjSt618FSHIo4FdmIncDvI/q1exiy+sDMsdZW5FzeILf4FmDWdGxfV
	XAcvoRongGpLCsF7/wHWXJ38juBKAymvp9RstlaUqsNOFLrV/pnpZ75bdFsTtSKl
	ecm0G4gQAzBYfiiGOjsL6XwUUwJ+A4S7cQCd1o7e8Ut700RM9E4A76slTqv5q8vP
	Cs3HlwYY5XtaUJvoiwatQeYl+hfRni+C2naUdbbcEvwKru0TRvIQhIsWsBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763047834; x=1763134234; bh=Q7kleZ5a8GqtF4VLw+ETWDEHyYZHqRaGGvZ
	3GDEVQl4=; b=VoLiDf9QBsFYlXwAYNsrl78Q3+bNL4C53dDrGB1zzplnuAX14af
	NA0SkuHBOdZRZ/OO89oko+pWOLw3oRh4+5zk1htlLpITuhgtrVovAvCF23bLbzio
	rAbP57xPxFNX/QoBeaMTklzc7HvKyDjaTzPCbrZBZLveQVVo/wqcSRkMB+PFHDoQ
	4gFOy3NeJg55Q1oj+d/lqSFyFEFo5jgCz/ilOwCV/m+fRGfY0R1SbsGsTKZyumvr
	pc7nFR4L8tdALG7SabmXe6yBMl8v8tJQLYTgll6IVzdWUZtRkH1AJRbEaAaAVlP3
	FGEr4JsdPeKpW0y03FvrXytOGVixE4Ga0UA==
X-ME-Sender: <xms:mvkVafhKM0on1KqQw6lwMBsTCq2U878mKp7F7RdR1xdAnxFkXEayWQ>
    <xme:mvkVaYminVGi4ukFikkea-wYgfxHmHw2URJ0vpkVtfDglVXNEN2BIRIWBDVGPFDQO
    _EBfyJ6Ne9LwkTNf0wA6kxk65qqkunvDPIG4-QnNO_nxCxKqbHT>
X-ME-Received: <xmr:mvkVaTiDF3jtiQkAmX9cO3wPGSd7CUOid60RxFIept4xGdw0vKhj8Fy77N5hKsGWb0cl3OdbEV_i5TVQx7KF4IQ3q_b-MA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    ephfekhfeugfelfeeludellefhkeetvdffiedttdeuueekhfeiudeivdefueehuddtnecu
    ffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggv
    vhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    grlhgvgidrkhgrnhgrvhhinhesghhmrghilhdrtghomhdprhgtphhtthhopehrihgthhgr
    rhgurdhpuhhrughivgeslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdr
    ohhrghdprhgtphhtthhopehrohhsshdrsghurhhtohhnsegrrhhmrdgtohhmpdhrtghpth
    htoheprhgvrghtmhhonhesthhirdgtohhmpdhrtghpthhtoheplhhivgiihhhirdihrghn
    ghesfihinhgurhhivhgvrhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurg
    hrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhi
    shdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepjhhpvgifhhgrtg
    hkvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mvkVaTEw_PluqobvMJyc48IbK9Fchv3lEjM7_BkX1bQpKamTckaJWA>
    <xmx:mvkVadti9kqY4DKYq--LTeL-xCpYELYAcWk3HIFzI2DMLp3XoveEEQ>
    <xmx:mvkVacdQnyxH3ZnDg2W9DN8qHLicWHGu6S3C4-8pm02UzDz260P7cw>
    <xmx:mvkVabmXnL8M9hwouqN_6wF-DFskA6FshqsP1fa8enXhSNleXPTx_Q>
    <xmx:mvkVaaPRa_STSd0d_wiMo11X9lRH2R2q6u2eLJ2481MNcwqJpPtdMrup>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 10:30:32 -0500 (EST)
Message-ID: <d6865d19f95b3e7a3addfc14f08ce042a82aa43c.camel@pbarker.dev>
Subject: Re: [bitbake-devel] bitbake-setup steps for release
From: Paul Barker <paul@pbarker.dev>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, bitbake-devel	
 <bitbake-devel@lists.openembedded.org>, Ross Burton <ross.burton@arm.com>, 
 reatmon <reatmon@ti.com>, Robert Yang <liezhi.yang@windriver.com>,
 "antonin.godard"	 <antonin.godard@bootlin.com>, Mathieu Dubois-Briand	
 <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>
Date: Thu, 13 Nov 2025 15:30:28 +0000
In-Reply-To: <CANNYZj_p_FX1sb6UduS-5H=jsmBrZA5crpJFPi3juRXjRtarXQ@mail.gmail.com>
References: 
	<2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
	 <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
	 <18779541E6AD04B6.981615@lists.openembedded.org>
	 <CANNYZj_p_FX1sb6UduS-5H=jsmBrZA5crpJFPi3juRXjRtarXQ@mail.gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-oirpeoUbLAEsCWB96DSc"
User-Agent: Evolution 3.56.1-1+deb13u1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 15:30:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18378


--=-oirpeoUbLAEsCWB96DSc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-13 at 15:06 +0100, Alexander Kanavin wrote:
> On Thu, 13 Nov 2025 at 14:51, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
>=20
> > I'd probably extend the schema to have 'local'-type entry in addition
> > to 'git-remote'-type, and then you can override one with the other
> > from the override file.
>=20
> Then the implementation would symlink the original local path into
> layers/. That way things like bb-layers entries, and various other
> places that expect sources to be in layers/ will work as before and do
> not need special casing.

I think this may be enough of a solution. I also like the idea of
bitbake-setup symlinking things into the layers directory so that we
don't need to handle these paths as special cases.

So, are we thinking of an override file like this?

    {
        "description": "Local overrides for development",
        "sources": {
            "bitbake": {
                "local": {
                    "path": "~/src/bitbake"
                }
            },
            "openembedded-core": {
                "local": {
                    "path": "~/src/openembedded-core"
                }
            }
        }
    }

I think it's important to support '~' in the path, we can easily call
os.path.expanduser() to handle this. We should also support relative
paths, which are interpreted as relative to directory containing the
override json file.

Thanks,

--=20
Paul Barker

--=-oirpeoUbLAEsCWB96DSc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaRX5lBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bmzvAPkBFovKZAfUZA5kGF/9ygT0TN4Zmisct3TL
XdE9UXCz7wD+IC70HgWI/Bu7qBHrvRxpmCrG8sF77ocFaWu0dgSDowQ=
=6Ora
-----END PGP SIGNATURE-----

--=-oirpeoUbLAEsCWB96DSc--

