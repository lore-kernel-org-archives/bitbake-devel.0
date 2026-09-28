Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A5CA5FA2
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 09:49:37 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.54934.1790588969491618689
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Sep 2026 02:49:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=Iv3B8QMh;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=YDhXk0Ap;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id AC0AF1D000B3;
	Mon, 28 Sep 2026 05:49:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 05:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790588968;
	 x=1790675368; bh=6K3xtjRYx0J5/5gt3It/F5LAK7xEGpcLggi3jmnlbTY=; b=
	Iv3B8QMh5AqJIHqWQlHakpDe1i0QceWb2TrRpD7PEnGUPlCwILf6LOKeWO3cRRtS
	PRfSljtSf/64GKF4CTIrOIcXrz1VcMkntoU0krUgQstEYf/n45fL7J+YQpqcl2m0
	IVETnW1dWcSsW2YMlljbhGIB51IbI/Rtl4w63VfUm4vCN5BPY+ApDjtQ30dADX2u
	iwg/OcN/Y8UXNa7XbyTT6rer1TjMUFDSsyKiPED4UbidxhU/0Oze+oxC2igk6fca
	zAK6EjE0mTy/ZdjXw09/jVTmf1BxOQ+cIfmWb+NPWX0lwumbOrxNMmMofnxf7/pN
	lQ/fxTUcNmnHEmrZmn2xXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790588968; x=1790675368; bh=6
	K3xtjRYx0J5/5gt3It/F5LAK7xEGpcLggi3jmnlbTY=; b=YDhXk0ApHjvcJqm8/
	1Rp+HCbq7SNR/2KjYJnTpKnYDrbASGjFN9pca3e2LYR7vBjBguV17dvlgCcTNrSt
	fCHR+5DLEZw+KVQ7WGhWr2S8UvQW/blJHVB8kYnq2kdtM5mqZCRTBl+kX4QgKmof
	8uXwhnvx+WOGaBUpklu6tQbTb9KyzM0gFiCNc3SkMY8nWBTL6Se3L62LRFyeychu
	ezVAkGdWwfBiYjRAIsuMP38Wmk9y4kMOMUZqhLVGzQgCrbmWx98x3rHcQbKqbK44
	MHqL9OIKhyuPSfG+qJ9qOG+DUzc+pJmGSlMGASAJw89rzWQbRFNeDiAmoOteX5LO
	wz8Dg==
X-ME-Sender: <xms:KDi6aqe_93IONEn9fSLxElU8o4NikTX50qmKL87WKnzNlqXDHqTDzw>
    <xme:KDi6aqNDNOINls_x5VWEAG3c94yx9sWdEzHFCu_Albc6otfwubS-P8rmDVYJ-HVpX
    hvVbEseQfogIQoNstMBcAABVeduGnaa_yeqNqkf1O1a6KQt4kMOhu8>
X-ME-Received: <xmr:KDi6apI0ki2BTHP_AjRu-HNE2qHixTQE2EgA631xh0NP1mt-u1cymop0lsr0SsGu8d6vyc2FKzrVqNlETPho18KKKjkEBS0LYphYT9M>
X-ME-Proxy-Cause: dmFkZTGPkbKhvD/hH9N/n35bXID8B0QO+inVrG58CxU6LoxNMRGFcHN/JsrZZIiVXTueOJ
    NV0KlE1wZ5JhT3CvgTqiGCx9BpwLrLpvricEQHjTSHK5ZsW/2ilvo9gvcs2O2mzVtxU5M6
    QSWd8J7whSUN6qsiYclB1r/lRd8X/VVu8KTEjzT8C8FlAMgQj4vZrrC1WH8+raoT6nm9A9
    9i9PM4jg1OPurz7Q9JHPGHZMNKD2iyxpqQsQeQ6nr6hzSaUyysSpE0tQpzzlVAl5V1euex
    +9ZKZpBM5Bag8l2G8agEwqMQEH3EFOxX7gn6mH7XDlXH/Uh/XEub6MKuA4mfJugZ/iLKZz
    FlS+Voa96TPWe09ob0H1NpOlrHg7wYpefJMrHf5Q2ZGaDXHT5sRnzjhHEmwkp+7G3LtX5W
    i+jrlhDvaAuNUr00nMndszCJ5kZGwywo/HyJzRrPifuKZvZje/vEIczX6405a6KcQ5g4iS
    hL4kVrOmoR4bTMidcuo2+0mCH2LQ6pgPPDhlPd7DAB2wSUJozqNW3tuoLUcIONP5dKT8Me
    /pjFP2bylvoL+u/jj0WuxaILH0VbLuEw0T9LCVcmJ5cIJ2J00Tmiy7XL3NflrZQErfv0G8
    fWlghI9E7fjBIIBlbWU4iQy0goHRLDrCAo7Bqberx63DB0KtqgeNcEmXy83g
X-ME-Proxy: <xmx:KDi6ajHX7fyrc1iGRczH_KTSxAp_llIn5cRcX-Brc0zhxQWJHbFm_g>
    <xmx:KDi6apQjjSlC0rD9O_E5qhxNwuUlx0QoGmsJQ5_uWrN_YrRw26YSPw>
    <xmx:KDi6anEJF0GT0KC-Zvo1B3rp6ozk5wfqsIuolK9-hXGbh1iSYnTVSA>
    <xmx:KDi6at89C_cLFbhHKXUyXOnmDLhIwc-iFxdlS5TbwEXDmdjcem0HXw>
    <xmx:KDi6atOUO0T60A3li9WEdRJah8CwQoZDMBWMshi9ftRIa_0VzlJ-SZA8>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:49:27 -0400 (EDT)
Message-ID: <9ea48161f0ffb0ca0b0175631d0a5af9660e71f9.camel@pbarker.dev>
Subject: Re: [PATCH] cache: Reuse os.path.exists() results during dependency
 validation
From: Paul Barker <paul@pbarker.dev>
To: ecordonnier@snap.com, bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2026 10:49:26 +0100
In-Reply-To: <20260923170633.1313487-1-ecordonnier@snap.com>
References: <20260923170633.1313487-1-ecordonnier@snap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Sep 2026 09:49:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20267

On Wed, 2026-09-23 at 19:06 +0200, ecordonnier@snap.com wrote:
> From: Etienne Cordonnier <ecordonnier@snap.com>
>=20
> cacheValidUpdate() checks each recipe's file_checksums entries with
> os.path.exists(). Many recipes reference the same optional class or
> checksum candidate paths, so the same path is checked repeatedly within
> one validation pass. In a warm parse of 5,112 recipes (poky, meta-yocto,
> meta-oe, meta-python), the real cache data shows 585,348 such calls
> against only 48,757 unique paths, with the hottest path checked 16,894
> times: 536,591 calls are redundant. At 3.5us per os.path.exists() call on
> a nonexistent path on this machine, that is about 1.9s of avoidable
> syscall time per validation pass. Cache the result per Cache instance,
> which is discarded and recreated at the start of each validation pass, so
> a filesystem change between passes is still observed.
>=20
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  lib/bb/cache.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index 2361c5684..01020f844 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -401,6 +401,8 @@ class Cache(object):
>          self.clean =3D set()
>          self.checked =3D set()
>          self.depends_cache =3D {}
> +        # os.path.exists() results for this validation pass (see file_ex=
ists())
> +        self.exists_cache =3D {}
>          self.data_fn =3D None
>          self.cacheclean =3D True
>          self.data_hash =3D data_hash
> @@ -619,7 +621,8 @@ class Cache(object):
>                      if not f:
>                          continue
>                      f, exist =3D f.rsplit(":", 1)
> -                    if (exist =3D=3D "True" and not os.path.exists(f)) o=
r (exist =3D=3D "False" and os.path.exists(f)):
> +                    file_exists =3D self.file_exists(f)
> +                    if (exist =3D=3D "True" and not file_exists) or (exi=
st =3D=3D "False" and file_exists):
>                          self.logger.debug2("%s's file checksum list file=
 %s changed",
>                                               fn, f)
>                          self.remove(fn)
> @@ -657,6 +660,11 @@ class Cache(object):
>          self.clean.add(fn)
>          return True
> =20
> +    def file_exists(self, fn):
> +        if fn not in self.exists_cache:
> +            self.exists_cache[fn] =3D os.path.exists(fn)
> +        return self.exists_cache[fn]

In the example given in the commit message this will result in a
dictionary with 48,757 entries. With more layers included this could be
larger still.

Would it make sense to use an LRU cache with a maximum size here, as you
did in [1]?

[1]: https://lore.kernel.org/bitbake-devel/20260923140208.1915740-1-ecordon=
nier@snap.com/

Best regards,

--=20
Paul Barker


