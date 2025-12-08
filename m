Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EA9D3B7DE
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 11:44:21 +0000 (UTC)
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6339.1765194252352722183
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Dec 2025 03:44:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=JFvMsLCN;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Y9DOQB0A;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 68273EC0567;
	Mon,  8 Dec 2025 06:44:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 08 Dec 2025 06:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1765194251; x=1765280651; bh=nDhbPpbNhJ
	42FENFBAd1UMJOFH7ZgTXTvtepPx3ycZs=; b=JFvMsLCNWnvXD5Cumpup2nML2W
	omsCL7O9HxbjIN3VNooOcivYjlbu0k4cicA7eAdc3mzl+A177yxm6rqkXqnVYKDR
	GhaHA6j2IsG08/bIa+kAOYwOVq8io1XkjMNkW903DPgyROIHC5R9yn/gSJ6iFQ8A
	zo72SCNmt5RgcWsM0YRdQLwFA5bVit/GOQnlDnjlE7cbj30Y/gd9WsivfkTpBVUf
	Svh18SZG6KqK0BHryqeamJWAR1i1aDEQY/JcJSrMbGbHQtqcaq9R+6UZXfL0fM+G
	m/lEgxZCdqSldrew7ydTVB0WpoGKboEwNvi82cVSkFgvX+dbNAZtcHO9GXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765194251; x=1765280651; bh=nDhbPpbNhJ42FENFBAd1UMJOFH7ZgTXTvte
	pPx3ycZs=; b=Y9DOQB0AjUEeNlLc5ViFoA+opVXlesdabmGdKxaFw4d5gzc8rca
	NZkmh+u93xFX1NlsOvYafJfyOP7mZOK6fMYa+rB43JbKGWFv1BnAVPuwafGmWIKI
	COdenjCdNSWVrxCNmzcYpzvYlUzFvGfxlKQU54alV3W1WQI+T0j58XBdgS9ZOdDD
	gmDfSLT38HGHeXMYFeRQQ9sb8hSUmAkzW4aTpMdcDw+fj7wY/QgyYvWbCGRRM7v/
	4bMWbudabZ4P66VB1hwkpKaejJAJZNgHxZ4/dB6Zr2C0ETGjdZKz8jGmXB2lVOme
	t0wLTNin172W1tHO3kzX80HP1eBGNQukQjA==
X-ME-Sender: <xms:C7o2afA3E9FT6MPvSn-vF7Bzqh04Mbg_GzeycXlaFETdWXHY8AP4fg>
    <xme:C7o2aQ-_RkkHMqV_e0Y8t23GAF4y0WjGLrI7JTxLP8nPYxcz9ecGr7jCntjJGO5yD
    eSUkF_AwRHpBeHsixE_izwDzUDU45Dh3AeUuCgrBbax8scahWsF5g>
X-ME-Received: <xmr:C7o2aeHmhW45bDnLFrl6cPFpvfFRSFOefhZL6LMqI6VFI0uEjUGqdio-hOV8eJaeuLhNg-TTJLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfgggsehgtderredtre
    ejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghrrdgu
    vghvqeenucggtffrrghtthgvrhhnpeegfefhudethfffveehveekjefhgeffgeeikedtfe
    ektdethfduvdffueeiieetffenucffohhmrghinhepohhpvghnvghmsggvugguvggurdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    gruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrihgthhgrrhgurdhpuhhrughivgeslhhinhhugihfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopehophgvnhgvmhgsvgguuggvugdqrghr
    tghhihhtvggtthhurhgvsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprh
    gtphhtthhopehophgvnhgvmhgsvgguuggvugdqtghorhgvsehlihhsthhsrdhophgvnhgv
    mhgsvgguuggvugdrohhrghdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlih
    hsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:C7o2aWNaCm3Bdo4gcbyxhYnZ2bGJOp3QyhdpEsvORxpYQYe1MvEAww>
    <xmx:C7o2aQcB9IoMi6G3TprokR4F8-Tz8YeYzwXopmg8HoQErYx0LXYndA>
    <xmx:C7o2aTvk5ezLx1_PGIiAkHse1uK9UbBH1xQKH1zQcMM_CdMkRrhlcQ>
    <xmx:C7o2aRnsaC6O0FVADfEtdCV1jDcoSv_YWAWfXMLZ0C-VO-8kLOy0GQ>
    <xmx:C7o2aW-RkZ4ro95YSKriyR_ISkoBm6H7C_ci4yb8e2UFREPtSzScYNf9>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 06:44:10 -0500 (EST)
Message-ID: <6aeaf3108704ff338ccde0649a2aa8a70c96daa2.camel@pbarker.dev>
Subject: Re: [Openembedded-architecture] Project role announcements
From: Paul Barker <paul@pbarker.dev>
To: richard.purdie@linuxfoundation.org, openembedded-architecture
	 <openembedded-architecture@lists.openembedded.org>, openembedded-core
	 <openembedded-core@lists.openembedded.org>, bitbake-devel
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Dec 2025 11:44:05 +0000
In-Reply-To: <e48f35c8b286c03c0e423ffd5feccfccc995c282.camel@linuxfoundation.org>
References: 
	<e48f35c8b286c03c0e423ffd5feccfccc995c282.camel@linuxfoundation.org>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-u80qNprTtqkAaxPO4Cks"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 11:44:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18551


--=-u80qNprTtqkAaxPO4Cks
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-12-02 at 12:01 +0000, Richard Purdie via
lists.openembedded.org wrote:
> It gives me great pleasure to be able to announce that we have filled
> the two recently advertised positions.
>=20
> I'd like to welcome Paul Barker as our Ecosystem Engineering and
> Operations Lead. Paul has been around both the Yocto Project and
> OpenEmbedded for a long time and is a name many will recognise. You
> will start to see Paul helping out with the day to day running in
> various areas of the project, giving the project some redundancy and
> enabling me to take a break too.
>=20
> I'd also like to announce Yoann Congal with backup from others at Smile
> as our new LTS maintainer as Steve Sakoman takes a well deserved
> retirement. Yoann/Smile have been doing great work on meta-openembedded
> with our various metrics and tracking tools as well as being active in
> various project meetings including bug fixing so many of you know him
> already. There will be an transition period as we transfer the role.
>=20
> I want to take the opportunity to say a huge thanks to Steve Sakoman
> for looking after multiple LTS releases in a careful, considered and
> smooth way. I no longer had to worry about them, I could just trust
> everything was being handled which is probably the best way I can
> illustrate the job Steve has been doing. So a huge thanks to Steve, I
> (and the project) really do appreciate what you've achieved there and
> you set a high standard to follow!
>=20
> I also want to thank all who applied for these roles, there were many
> good candidates and the final decision was a tough one so thanks to
> everyone who applied.

Hi folks,

Today is my first day in my new role so I wanted to send an email to say
hello!

Many of you already know me, but here's a little background for those
who don't: I started using and contributing to OpenEmbedded & Yocto
Project back in 2013 and since then it's been a key part of my career.
I've seen the project from many points of view over the last
decade-and-a-bit: first as a hobbyist, then working with board vendors,
silicon vendors, system integrators and end users.

I'm excited to be working for the project full-time now. I'll be helping
to coordinate our activities, take pressure off our Software Architect
and scale up what we can deliver. I expect to be spending a lot of time
thinking about the challenges and opportunities presented by the EU
Cyber Resilience Act (CRA). And I'll still be getting my hands dirty on
some actual code as needed to help the project move forward.

I also want to congratulate and welcome Yoann and others at Smile. And give
many thanks to Steve for his work on the LTS over recent years!

I'm looking forward to working with you all over the coming months :)

Thanks,

--=20
Paul Barker


--=-u80qNprTtqkAaxPO4Cks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaTa6BREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bi8+AP4iS3pIBDZfbCHSQVOImpkItcQ5TynHnRuk
X2nIRFO6+AD/XD8QbQ3oQf+UP+/oaVZuue4HcxNCYbugp6dJu06cvQU=
=jKyb
-----END PGP SIGNATURE-----

--=-u80qNprTtqkAaxPO4Cks--

