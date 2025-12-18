Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60925D711A1
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 19:49:33 +0000 (UTC)
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1147.1766087363478482885
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Dec 2025 11:49:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=hhavOx/V;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=GjS+VRwb;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.150, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A3E35EC0011;
	Thu, 18 Dec 2025 14:49:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 14:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766087362; x=1766173762; bh=HYNCgpsPQw
	W5YzfneYsJuCPs4XvAnvOxiO5ayS/rngU=; b=hhavOx/Vn4IQ2NvLfZZKudnpWO
	CO0CPBJL5JhUdEELet8GIxe3MAtN8SZBmOKtVS8ftuJLFrz81hDkTfT5oIf0v8sC
	pIYfyzCQ+ODiSUNectrjYi/eOzxVPDVpkhCvg3fK/jCnV9FySWohAvAl3BkoXu67
	tGwiJSMxYoiZOO7bs60+fJdyYyUM5bS5EbqKHfSSXgIW6YAy0STJxIewNwZ8aW7q
	bttDcTJeAXqgRE++47gtPlwb3MdzBraKgDO0cYB3Te4pT551XPI7IgmtwuCYEmoK
	L9PbDzWZ/9qVBaHSAIyLZnSu7RV8KL4N/nrCkALYkznHYusORlhk03xV1S8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766087362; x=1766173762; bh=HYNCgpsPQwW5YzfneYsJuCPs4XvAnvOxiO5
	ayS/rngU=; b=GjS+VRwb0t9XFCBUwEKBSCFkOhoTKwz9CrcQud1E4m6tfV9ohO6
	W7ZNrSnONPpH0wdjFsC4wzR9BkbHr5RAzKpH+Y6c7DK/DKAk9coqbJ/D1q6HvW7J
	EWIbmvYVY0iwR2PtWTisw86t51k+RGKYNZpUTY7KbqGvElbeQp7TyBO8yz45w+pn
	fcjwG6owzYOkNx4y1f8oAGWGhvW+CbeNdCS4OfEUh527NK4NoLdIq252SsDvbvf1
	xEI+aIgorg/nsoiI2RU/X6CztzNgC0i8ESVpD20sINxj5cTtlMTXiN5JEXDBdrlq
	4kd7aLWYoOKH5ZO2N4hHkmR8alo37BPUByg==
X-ME-Sender: <xms:wlpEaSoxRdrXfvr1-PrgMzFmPt4uEs2peOFFOHKPJlPGnJ1oegvX6Q>
    <xme:wlpEaYGiK4oh7__8u0VM70ckQIz5PDZKY4lGutRvZJU3EyYhENORnBt6hC5sDFFXU
    vl8j6P8UD3VW02UrYT9Qy88gIoC7alVzBR9wC-veGcl1k3CerGjWNY>
X-ME-Received: <xmr:wlpEaUkf_umt9lr_FDotsKop72E4Hgyb66ot3iDeAlhxDIw1jIEY2R9Cu36BXxyXJ6bdASKlz6iy4qhc-HsWcme7TpacDAGkhErlYGwvihgj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkuffhvfevffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    eugeeiudeifeekgffhveeggffffedtkeegudeujefhhfeigfetvedtuedutdehfeenucff
    ohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgpdhsqhhlihhtvgdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhes
    phgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghlvgigrdhkrghnrghvihhnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvg
    gurdhorhhgpdhrtghpthhtoheprghlvgigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:wlpEablrZf8lej_uUGWUcwdoPwEMIPSoAzIqWMDdCcfe-EP5oaJL-A>
    <xmx:wlpEaVuP5AP7ci9mz9WtTKED2dq_0YJkLwsv4qOlLbBsJ71a3LoA9A>
    <xmx:wlpEaelMkh3E4fP-KnPEvLz8w6wiix4Fb5yN7AQ2s9drLjf4m0zjeg>
    <xmx:wlpEaQsfA2vUcZ5o2p84WnodbKpXGwZuVHcMNnT0ycFmg9jqjIPK7Q>
    <xmx:wlpEaaY_yBJ6U0NaIErIZ1McaF3s4I-8nUObmDA58q2X5X9V-m9REuRb>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 14:49:21 -0500 (EST)
Message-ID: <62e07a47b15a48f0e7d80f2dcb88fd37a52bd4c4.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [RFC PATCH 2/2] bitbake-setup: share sstate by
 default between builds
From: Paul Barker <paul@pbarker.dev>
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Thu, 18 Dec 2025 19:49:19 +0000
In-Reply-To: <20251215145418.2680311-2-alex.kanavin@gmail.com>
References: <20251215145418.2680311-1-alex.kanavin@gmail.com>
	 <20251215145418.2680311-2-alex.kanavin@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RC+vztnLMsNZbn/lCdQO"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Dec 2025 19:49:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18610


--=-RC+vztnLMsNZbn/lCdQO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-12-15 at 15:54 +0100, Alexander Kanavin via
lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>=20
> Nowadays sharing sstate must also include sharing the hash equivalency
> information and thus, managing a hash equivalency server. There are
> two ways to do it:
>=20
> - starting/stopping the server outside the bitbake invocations, and
> guaranteeing that it's available when bitbake is invoked.
>=20
> - using bitbake's built-in start/stop code which launches a server
> before a build starts and stops it when a build is finished; essentially
> this is a private server, using a database private to a build directory
> (by default).
>=20
> I couldn't come up with a good way to do the first option in bitbake-setu=
p:
> it needs to be invisible to users, they should not have to run special co=
mmands
> and they should not wonder why there is a mysterious background process.
> It's not impossible to auto-start a shared server, but that will quickly
> run into synchronization issues: if one server is being started, another
> should not be started at the same time. If one server is shutting down
> (e.g. after an inactivity timeout), another starting server should wait
> until it frees the socket, and block all bitbake invocations on that.
> Memory resident bitbake does this in lib/bb/server/process.py with a lot =
of
> complexity, and I don't think it should be added to the hash server as we=
ll.
>=20
> On the other hand, hash equivalency database is sqlite-driven, and sqlite
> documentation reassures that sharing it between different simultaneous
> processes is okay: nothing will get lost or corrupted: https://sqlite.org=
/faq.html#q5
>=20
> I've confirmed this by running simultaneous builds that way: nothing
> unusual happened, and sstate was shared as it's supposed to.
>=20
> There's a new setting that turns off this behavior for situations
> where the server and sstate are managed externally.

To capture the concerns discussed on the patch review call this morning,
since Christmas & New Year are about to happen and we may all forget
things otherwise...

The sqlite faq you linked (https://sqlite.org/faq.html#q5) says:

  But use caution: this locking mechanism might not work correctly if
  the database file is kept on an NFS filesystem. This is because
  fcntl() file locking is broken on many NFS implementations. You should
  avoid putting SQLite database files on NFS if multiple processes might
  try to access the file at the same time.

We do promote the sharing of the sstate directory over NFS as safe, so
we should be very careful about placing the hashequiv db file in the
sstate directory in light of the above.

Thanks,

--=20
Paul Barker


--=-RC+vztnLMsNZbn/lCdQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaURavxEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpViAQDfI6GVBEIocbSYLJfg0i07TbAclx2F/uoD
T0ThS0BRyQD/Wuck/Xq829LR0K/2ot/DRWeljYgPZmqgAWmNbfGtow4=
=tDEY
-----END PGP SIGNATURE-----

--=-RC+vztnLMsNZbn/lCdQO--

