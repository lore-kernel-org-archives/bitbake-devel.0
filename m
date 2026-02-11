Return-Path: <ukleinek@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC55ECD6D0
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 17:37:38 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25091.1770831450315890082
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Feb 2026 09:37:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=LgTce6jN;
 spf=pass (domain: baylibre.com, ip: 209.85.221.43, mailfrom: ukleinek@baylibre.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43767807da6so1643645f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770831448; x=1771436248; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKwXBQ3ykLEYlPeVrG4gj23aIt/9E2BIVfELccjkvRU=;
        b=LgTce6jNQsN56BhSpjlCmur3tQ0wVuNotgfdeNRESK5bqAt/Ys3C8x4z/aUH5RCOMm
         oP1UQVJ9xLexU+Xuw9Z3PKBmwbTZylvLUwj5dXugerPf0cp7jJNtTcId2pK2Z1acU6uX
         u+i5PTj0puHBQSITbPRwSBUljBzjHFHBsKT72igjfFlGU1N0t+PPVedoR6B22VVY8TKU
         30Nzoz3GWNT/Hay0ipRtvCSevBjIMxKmnLqhFfjUajRACOfsIkrdjVGrY2AggvuXxAev
         uguMQ1FGOtV2ZwR96oxfykWlAr5a7GrqtD724bg6ufFIW9BaIzhfkemMMTg6sApJW4rz
         pqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831448; x=1771436248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKwXBQ3ykLEYlPeVrG4gj23aIt/9E2BIVfELccjkvRU=;
        b=H8ogM5Zs1PQWqq+6OyVAOxc+B6aaL+voDd5wo+xNF7zINF0Q54HuUyX5VZUWWOZec5
         J31kNGqCJJMKlbcJykSceRrQ0o+KbhsKmEXoq5sue/0w9GPTZLcRt0aQJ/8zj2LbUt3P
         WcfE4pxPKtM+T2U/FVTC8crEF1mwj0OQdNLvf+SaRUF6zCvcRaFieIEmFE3lAqLaxwZg
         Abfs4b/oqL1nHvt7pm7P/1WQ8iQvIbvRZ/ZmM8MIw44JrC07M9CVY1wHkF8KcNhBcMTr
         sXgPToN99q53bGDkxz8SZqSgk/q0UzC1LOWAk6s9khweEOTfHUlSvqHC2TbohV6yOc78
         tnUw==
X-Gm-Message-State: AOJu0YwdisihoHd9rrF8DwaeHqbzw4hVvaeJx+eKRRv0onqKnPsatEyc
	N2OUZxJmQ62XzDaFjcjPi013R2Js7USCZfOdZDzeDcEAkusqwj0o8VaEFXreQztXJL4=
X-Gm-Gg: AZuq6aIDbA4rXbdb66+ByOB+aPleb+euiQzfnSzC3VaMX4EDQRiwK910UgsRvuM0lPg
	77GH16rsAnWM5/JeVtde0gFVrC5z6rVEJhdUbbsWToPDgWfoGV4QiJCP0gmWuzkHAQj3r9BJpiQ
	CrK0knJe7L7run7YEVb9D0BpZ2d/SsTdVqUqH68X0aWdEfFX8Ii4/U6M6xcuYiDaEi+T0qaC6Ok
	uHzX1PRd7NYb4Wk1kPn9INZ0cSNs+piKTKK2bZm8nmI2zDy8FoxLf5Rp8TcJG+P1Gw82R3h4nA5
	eE8vJa9h+2ooVCQL2BjSuyogZxMXMmaFPU2SlNxfKGn/fekYkVNu5aHVPKv75MEv275Y4mBBrkj
	aBfgCF0mtXdrfhgcPDJlaBbeKL6BjDMZZccJam1clyLUOBx1fC7/wqPzjPqfD9RNuxfRSu1T+XO
	c+FfWoLHsPDhy1ZfktN6s3pF+DYDx7FKag/u8YCh2/ynZaxBHayzA8YT7TNBVOncgFlkJX+jAuX
	GUy8r+xpL3SjZQ=
X-Received: by 2002:a05:6000:1786:b0:437:69c0:9619 with SMTP id ffacd0b85a97d-4378ad91896mr337667f8f.29.1770831448193;
        Wed, 11 Feb 2026 09:37:28 -0800 (PST)
Received: from localhost (p200300f65f20eb04129994ada78a8b10.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:1299:94ad:a78a:8b10])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43783e544e2sm6975091f8f.32.2026.02.11.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:37:27 -0800 (PST)
Date: Wed, 11 Feb 2026 18:37:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake/bzr: Drop check for unset .revision after
 .setup_revisions()
Message-ID: <aYy8KMgZOhqfDnph@monoceros>
References: <20251006140246.2459639-2-u.kleine-koenig@baylibre.com>
 <5bcaffcd860a42d9b0d28d6eb43b58ba8ca6c4f2.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujzybkl3ka2x3biv"
Content-Disposition: inline
In-Reply-To: <5bcaffcd860a42d9b0d28d6eb43b58ba8ca6c4f2.camel@pbarker.dev>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Feb 2026 17:37:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19007


--ujzybkl3ka2x3biv
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] bitbake/bzr: Drop check for unset .revision after
 .setup_revisions()
MIME-Version: 1.0

Hello Paul,

On Wed, Feb 11, 2026 at 11:56:29AM +0000, Paul Barker wrote:
> On Mon, 2025-10-06 at 16:02 +0200, Uwe Kleine-K=F6nig wrote:
> > FetchMethod.latest_revision() expects three parameters, so the call
> > `self.latest_revision(ud, d)` triggers an exception.
> >=20
> > Drop that error path that obviously isn't used.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> > Hello,
> >=20
> > I didn't hit this exception and only noticed that problem during
> > research for another problem. I'm unsure if deleting is really the right
> > thing to do (i.e. if .setup_revisions() always returns something that
> > evaluates to True when interpreted as Bool), but it seems nobody hit
> > that error path since commit 7b7a4517c600 ("fetch2: Allow multiple src
> > rev to be used in one src_uri").
> > (Hmm, maybe the author of commit 7c94ca56b2fd ("fetch2: Correct a few
> > calls to latest_revision()") should have noticed ....)
> >=20
> > There is a similar issue in lib/bb/fetch2/hg.py. I'll postpone sending a
> > patch for that until we agreed on what to do here.
>=20
> Apologies, this patch seems to have dropped through the cracks. Feel
> free to send us a ping after a couple of weeks in the future if you've
> had no replies.

I forgot about this, too :-) I only sent it because the status quo
looked wrong to me and after sending the patch considered my duty done.

> >  lib/bb/fetch2/bzr.py | 3 ---
> >  1 file changed, 3 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
> > index fc558f50b047..443195fa00bc 100644
> > --- a/lib/bb/fetch2/bzr.py
> > +++ b/lib/bb/fetch2/bzr.py
> > @@ -35,9 +35,6 @@ class Bzr(FetchMethod):
> > =20
> >          ud.setup_revisions(d)
> > =20
> > -        if not ud.revision:
> > -            ud.revision =3D self.latest_revision(ud, d)
> > -
>=20
> Looking at the git fetcher, this should probably be fixed to call
> self.latest_revision(ud, d, ud.name) instead.
>=20
> Are you actually using the bzr fetcher? I'd like to propose deprecating
> it then removing it after the LTS release.

No I don't. I worked on the git fetcher (resulting in commits
ddf00d6aee955878c070327ee8d751fdb6099444 and
cb36e8a62d7d31b75b3ddc6b84c1bdee09ebbc60 in oe-core) and just looked
left and right while doing that.

So I'm unsure what to do next here. Given that I'm not using the bzr
fetcher (nor the hg one), is a patch adding `ud.name` to these callers
welcome and sensible?

Best regards
Uwe

--ujzybkl3ka2x3biv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmMvlMACgkQj4D7WH0S
/k5O1gf/ROpTb6xSu2eEDitGLzP1AupoNVBtjNHPVRPkQq5RBNJKZcXQjIXvbL/U
cHMAyNNcmVWhH8IA2Cvot+SwTY05a4egll0v31gBKebThWmEguNaGVsN/UBvtqRI
BR3Cn/DZ8vAaFZRY7e+Q1SW/RR5kmT2DVdbvsRVUjK8YeHLdQYyMwcktiribZFwF
C9W+zuyyLPI1u1wVvTvEyx5qYF7r05LdZNkXyPjjNihfcRaNLSd+78pvEZgvANiF
79pLjacJiWGm48ByVP0pIEBnDGloDssWP9jw4HTS4JlNscXWWQJ/hHvcUHf5bFe2
9+I7fo8wWYHp9ckGgL/VK6RCW7hlKQ==
=FpOJ
-----END PGP SIGNATURE-----

--ujzybkl3ka2x3biv--

