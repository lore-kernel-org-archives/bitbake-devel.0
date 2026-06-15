Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151AACD98DE
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 08:28:27 +0000 (UTC)
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.125236.1781512097233703850
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 01:28:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=YMo2Q3nW;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=gqglEp5H;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.153, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EC847A0156;
	Mon, 15 Jun 2026 04:28:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 15 Jun 2026 04:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781512096; x=1781598496; bh=7eAyMnXeCt
	OG8ruDd6OZFzlV84J5WxJjiLqKrygQpuk=; b=YMo2Q3nWUXDyl94HVq0TzqW+53
	HPYWdLk+B167wUnb05L+M3UUrqAOc85Okg9kXwdeNCjOYvJha4/ZWAP9qoGSZ39p
	Tc8Sn1uySOtHtd01+zf8rqzhTlBSXZkcnDpQpmWGWwrsb/YRRdzAakR+iEuk/iMn
	4hvPs8itReLqZIaSYGMUmUBxdxpVh5/kJRUSwSRLjxrTjW5RItD3SrXJXyziDo+I
	aQu/ESEKChX1M8MfGGBTovvS9FivVQhpufIIXtvjT9O9rFJ3LslJsp65ZcO2nCTq
	z5YvEtZjh4vFSgV6xoTOp5DPTSPPiIm50WQP9JY0cW0seTvBQ4semCrSKKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781512096; x=1781598496; bh=7eAyMnXeCtOG8ruDd6OZFzlV84J5WxJjiLq
	KrygQpuk=; b=gqglEp5HeNgCzFPuQ14sI98HW84ItgcMSUbAX1BQ5q0w+jtXJ9F
	kFaozLnHAth8FSQEALQRaV/cPA5IU5R5cZxi5H5FxgCSvNI2vuWfYESt0E2zwrZk
	5eJxkcoQgde8lecs+cHwPMCGncru1mI4X59+GkALC3ob+9R6vbqbRbZ5tWHp0TAV
	p0/Lnkb8P572HunuhhzTby5E8vV1kv2J5RlNrOYsrFcd1TZx9F2WZ62KN80Nifdt
	8nDPZwTUt4l6ll/ZLGU09Tn5k/esIo/nRquaxc+0vRoEil7a8ejzQOvZnIVY2HrD
	QMuIOnSU/JgMK8IwquH1i2JM6VP+DrUewRg==
X-ME-Sender: <xms:oLcvakpCcwofx1BI9qmkQuC1MxLD1qF6ecVNxcfq6IcXsGxRQ1Obmw>
    <xme:oLcvagpVbSE5jzwvudGGL1Rs1D0x76q6bzya1pMMCSKHT7ZwzH1DrdKpUCx5JSEgV
    mbMPza4ODxQHfckX-_lgtr_DJaPDpDmd758zJqpcY4y7jk2pQe9KzKT>
X-ME-Received: <xmr:oLcvam0ndbtKtlsGzPe8-SA89aVnVwd3YI9pNGE5eCFQ8tIdkh0AUJmT5tlgirskh3sp0C72tsWc3OvxqzhSmpUaY7_hWni0UAiIl7Mz2Luq>
X-ME-Proxy-Cause: dmFkZTF0Ot2lTMY/QFsGxbMCAM14Krj9z3CjpeeqxwR2a6glJrKu2/v/632jA0/P/B5mLI
    1kwFOd4fqVevHcLKYikgm498DmRIH06jJH9UjymjOf1nIPxGf8Dl8t5hMTEn97PbQRHqm3
    RTCwui1MwJwDRAG7t4tm6QG5VThiqMyveriRNEVN+RH46d6NL/qhYNJcteMxoAdp1iBlrs
    YniyG/h5R4JZP8XGnUbgc/mum2tpwLVqbZCE9mz9U6e1pu0sNaV1TER+ueW/kmu6496Bx2
    rqQvoKhmg0biMpH38np7cbJKhi2M5aPwKlcHjwf/6dwEyFB/AejMfOqWUsv6X2Jn7VwzPQ
    Kfmejkx0D5fzTlPmaZ4ch+HjYOvdZmDMjRmHgbVd6N8mANXLr3x6z5qC8TmuqvVJ+0S2Uo
    VvIvPgEQjClif/1pDCBQpUQRT+irTYk9n4xaibzBgvxgbc5k+v0l3tmpmgGkc1X9SK1yVa
    7lYzIuMYqh2BtCJt3OITluUB+yROp/D/mL4S6E7o+/0Jpkz7FSutOUFGeCnA/9MQFpAGTI
    gyxEVSeLX2uAZGQFBSQK9K4mGQsoUl1wc5r6XXgToe8zPoKgVHO4jau0EeDh2hCZ2WcQKc
    uw2Eg/b9fJ/gADC86PbKGwD5/V/XiYiun3u2QhK1echJkHQxh0x4NKwAitEg
X-ME-Proxy: <xmx:oLcvanAApBhFEBYu5HJPHNRjlzayT0E5F3rFZF8qY83tlzmsUZthug>
    <xmx:oLcvamdNP0cHFtxQfYiJd9YxUlVZTCtYa81Gy_VFNhfXZJ1y0CfPxw>
    <xmx:oLcvakhqCoDbt_26oSyJT4cUpkTKdGCz2o_HdMYiRyEZKFpBs2P0Lw>
    <xmx:oLcvamqj4CWL3zo4SeYsi8I3r9mgAcSSK5vQz9aIB7WQTLH3hsJszQ>
    <xmx:oLcvapzLLeu8SvSF6aH-N13avnV8AdJqwGTbqtOS0w9y4Ur_LBa0Ccb_>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 04:28:15 -0400 (EDT)
Message-ID: <8d50983b587b19901608279ee8fd946a6503ff97.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH [RFC] 1/2] utils: Add
 landlock_restrict_network function
From: Paul Barker <paul@pbarker.dev>
To: David =?ISO-8859-1?Q?Nystr=F6m?= <david.nystrom@est.tech>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 15 Jun 2026 09:28:12 +0100
In-Reply-To: <20260612-landlock-v1-1-77891f63ed7f@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
	 <20260612-landlock-v1-1-77891f63ed7f@est.tech>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tVTNbaA8we48DqqOGQQz"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 08:28:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19683


--=-tVTNbaA8we48DqqOGQQz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m wrote:
> Add landlock_restrict_network() which blocks TCP bind/connect using
> Landlock LSM (ABI v4+, kernel 6.7+). Designed to stack with the
> existing disable_network() namespace isolation, covering the case
> where disable_network() is skipped for non-local UIDs.
>=20
> Gracefully returns False on older kernels (ABI < 4).
>=20
> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>

Hi David,

I think adding this is a good idea, but the code needs a few changes to
ensure it is maintainable.

> ---
>  lib/bb/utils.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 181082c95..1347c29d0 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -2054,6 +2054,32 @@ def disable_network(uid=3DNone, gid=3DNone):
>      with open("/proc/self/gid_map", "w") as f:
>          f.write("%s %s 1" % (gid, gid))
> =20
> +def landlock_restrict_network():
> +    """Block TCP bind/connect using Landlock LSM (ABI v4+, kernel 6.7+).
> +    Gracefully skipped on older kernels. Stacks with disable_network()."=
""
> +
> +    NR_CREATE =3D 444  # landlock_create_ruleset
> +    NR_SELF   =3D 446  # landlock_restrict_self
> +    NET_TCP   =3D 0x3  # BIND_TCP | CONNECT_TCP

We should base these on the names used in the Linux kernel so it's easy
to search for things and compare with example C code in the docs. So,

    NR_landlock_create_ruleset =3D 444
    NR_landlock_add_rule =3D 445

    LANDLOCK_ACCESS_NET_BIND_TCP =3D 0x1
    LANDLOCK_ACCESS_NET_CONNECT_TCP =3D 0x2

    LANDLOCK_CREATE_RULESET_VERSION =3D 1

> +
> +    libc =3D ctypes.CDLL('libc.so.6')
> +
> +    abi =3D libc.syscall(NR_CREATE, 0, 0, 1)
> +    if abi < 4:
> +        return False

    # Check that landlock is enabled and supports network access
    # restriction (added in ABI version 4)
    abi =3D libc.syscall(NR_landlock_create_ruleset,
                       0, 0,
                       LANDLOCK_CREATE_RULESET_VERSION)
    if abi < 4:
        logger.debug("System doesn't support disabling network via landlock=
")
        return False

That's a little more verbose, but much clearer.

> +
> +    attr =3D struct.pack("QQ", 0, NET_TCP)
> +    buf =3D ctypes.create_string_buffer(attr)
> +    fd =3D libc.syscall(NR_CREATE, buf, len(attr), 0)
> +    if fd < 0:
> +        return False

We probably also want a logger.debug() call to log the failure here as
well.

> +
> +    libc.prctl(38, 1, 0, 0, 0)  # PR_SET_NO_NEW_PRIVS

The commit message only describes use of landlock, not no_new_privs. We
need constants for this call as well.

> +    r =3D libc.syscall(NR_SELF, fd, 0)
> +    os.close(fd)
> +    return r =3D=3D 0
> +
> +
>  def export_proxies(d):
>      from bb.fetch2 import get_fetcher_environment
>      """ export common proxies variables from datastore to environment ""=
"

Thanks,

--=20
Paul Barker



--=-tVTNbaA8we48DqqOGQQz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCai+3nBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpsCAQDcS3mR8up3qIDULC2BNelDMWQcK6zP9OQD
cauEld0NTgEAzCqWY55hjhD+wp7S/5rr8ZaB6BxThhlDuBW1DSHVeQQ=
=3v2U
-----END PGP SIGNATURE-----

--=-tVTNbaA8we48DqqOGQQz--

