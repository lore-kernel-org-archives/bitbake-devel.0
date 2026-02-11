Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B03ECD6C4
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 16:13:28 +0000 (UTC)
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22787.1770826405364248737
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 08:13:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=WytaPYA/;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=qK63TSs9;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 800CF140010E;
	Wed, 11 Feb 2026 11:13:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 11:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770826404; x=1770912804; bh=BQnoVchrWw
	useNWbhYHKqkHPc6yHQwyyOcFvWnQxt7k=; b=WytaPYA/wPMP2BzMd15oPZPKlw
	xWsGPN7wyE3rlsfN6zAXQlhFwFiSbpD3OG2+ASrKjK46t1cTD8PcjopBIEFIXVXU
	+tyVyqaIm9PlS3IIpD3TJb1hdF0lY7HDIdYgl2z+Gxk7UoJtBuIfe+Cx/qxE/nl+
	0KtNBaFZMXdIDR6Rd8htg3rZ3EdSBMhqdYDl9xmIpUB2AMeVGxEwQCrrIUhKpehI
	r0e7c7XJTiZV7KCpBsK2OspVDQDgrnj6M8TPyx+wh/9RulltBXcDqg0bW8hVyDdW
	7SXcdAnR/G2wpVRl0adiBvIjbnJpKITG//3qJVmjib3dMfRKfRpkEjg2FmDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770826404; x=1770912804; bh=BQnoVchrWwuseNWbhYHKqkHPc6yHQwyyOcF
	vWnQxt7k=; b=qK63TSs9Q+WoaQM/a+Cx0OVcNY93xe6e5RT7bSyh/V1XcX8Gsja
	ljHDfeRaC3aA9XZEuczdCoK5rYwKPWgxFdGBog5KnQY4ZC/lxcA6RCytsLpzkbmI
	ACy7WVf7Hewvy824M2SSJGLgrhzERciO6tistmNXTw9Tz/EGv1wVMgkxIVNdaHYt
	HmBhslt3D5TQWUJASpazBpbceTIoZvi6bYGPASIwXxaDRwjwMHVk9zIbLVf0nrz+
	z1Lyvi6f/QLOcjzmTLrv0GB4MnJQh76HOmX/s1BxlmeWXoPJARqxcLVH2/TBYhsH
	CgNZ8c47IZLzFmPAbmriUQ8mhmJiopV8lTQ==
X-ME-Sender: <xms:pKqMaZpiVINFnngskjJnvsClsor_4KOMjSCHGDUg5Rfm-GaDrJ7c1w>
    <xme:pKqMaRr3DwY2CH9b79ZZBGGlsabeI9nbAfWr7xUS4ZbEWMaGDsZr0AjtcfaG9XJOj
    9nuLFVBvutPxb3i-YbBdm4dqkZ5JRjvixuLk6eErIjHFVXtM5LFww>
X-ME-Received: <xmr:pKqMaT2IDnk78Fb0wIRAzzbIwwbhn6JiAeTI6eF7v-O35e3ekz0boeSxjui8bbyiF5xYMfTUvfiI7PtEU9iWJAYwpny2fHGdmdeCL_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepgeefhfdutefhffevheevkeejhfegffegieektd
    efkedttefhuddvffeuieeiteffnecuffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhirdgthhgvnhesfihinhgurhhivhgvrhdrtghomh
    dprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgs
    vgguuggvugdrohhrgh
X-ME-Proxy: <xmx:pKqMaQAZrT85-kDW_DKK10TjpnDSgVdBfO_LZcwzcKRmNxRo1YzB1Q>
    <xmx:pKqMabci8JY-2K_xskJ03MZa0DFZr9xMNsL-ixx8Sixz6As9THKnUw>
    <xmx:pKqMaVgdu1PziSbXravFjpWNQ1P3x_smCcQvoH6GwWiaOEjBzvpSFg>
    <xmx:pKqMaTpBvfsfyNepXVLJWNJLgPG83PZavYdAhXYQo2ey0yaGEP_WoQ>
    <xmx:pKqMaVIBBwf1JKf0l-_R0j13QiFlf0xiXn9dlxial9lVBqEpQZWlZWHn>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 11:13:23 -0500 (EST)
Message-ID: <0251564542cdad8e2c571c2c153dda82a11ee715.camel@pbarker.dev>
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix update_mirror_links
From: Paul Barker <paul@pbarker.dev>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Date: Wed, 11 Feb 2026 16:13:20 +0000
In-Reply-To: <20251230025413.1293484-1-Qi.Chen@windriver.com>
References: <20251230025413.1293484-1-Qi.Chen@windriver.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Q+Oux+mfzq49lIA9LbR7"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 16:13:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19006


--=-Q+Oux+mfzq49lIA9LbR7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-12-30 at 10:54 +0800, Chen Qi via lists.openembedded.org
wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> We cannot assume ud has the same fetcher with origud. For example,
> if we set map git:// to file:// in PREMIRRORS, ud is using local fetcher
> and origud is using git fetcher. In such case, the ud does have the
> 'shallow' attribute. And we'll see the following error:
>=20
>   Exception: AttributeError: 'FetchData' object has no attribute 'shallow=
'
>=20
> Looking at the logic of this function, I think it's the origud's shallow
> that should be checked. So the logic becomes: if origud is using shallow
> and its full shallow tarball does not exist yet, symlink to ensure it
> exists. This should make more sense.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 709c692a8..f288afb51 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -359,7 +359,7 @@ class Git(FetchMethod):
>          super().update_mirror_links(ud, origud)
>          # When using shallow mode, add a symlink to the original fullsha=
llow
>          # path to ensure a valid symlink even in the `PREMIRRORS` case
> -        if ud.shallow and not os.path.exists(origud.fullshallow):
> +        if origud.shallow and not os.path.exists(origud.fullshallow):
>              self.ensure_symlink(ud.localpath, origud.fullshallow)
> =20
>      def try_premirror(self, ud, d):

Hi Qi, thanks for your patience on this one as we work through the
backlog.

The only place update_mirror_links is currently called is from
try_mirror_url() in lib/bb/fetch2/__init__.py. This is called as
origud.method.update_mirror_links(ud, origud), so checking
origud.shallow instead of ud.shallow looks correct to me. I think your
patch is correct, we'll take another look at it in the next review call
and hopefully get it merged.

Best regards,

--=20
Paul Barker


--=-Q+Oux+mfzq49lIA9LbR7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaYyqoBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bu7kAP9usyj7Mw+GaRgi78omQ9G7wTxBAffy43Fn
tfUZolBKTgEAvonxeZf4+WpmXnxrZgft7IWqy/j9Z/9SzdrPi8wjxgE=
=yjv+
-----END PGP SIGNATURE-----

--=-Q+Oux+mfzq49lIA9LbR7--

