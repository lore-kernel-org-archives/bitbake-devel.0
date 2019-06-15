Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id BADC67EAB4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 07:24:08 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id c6so4315697wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=nHuRm8Mu5J2Su8uHowQpoO8hCT0QYBjpx+Lajkvwk2o=;
	b=MUIKKdQJ4ZYcZvlloWJ9xTNFdww7LmZNWVOWlubDn1fEyY0Fb8XMINrMuzLXGtFlmD
	+dV2ehnDpheen+VnNMQZB2yLecNIiwDx438J0cJaP9v5CZX1tD/l55rKGUZq9A40xd6L
	THCvLwYku4cAoyUeuPseb3Kh6Qj/Ag1kKEX9NLog+MC0k0r2G40vJAMhIYuscSJvW4lz
	ioz5B4HCvbz+J9YJuWSwxN0QLdFqwt/jcX0i8WUQdmmxmE6ulXZUBa5uj341xeKCL1vP
	BkJ2C4xaXJfnK6OtGOr29LNHlj0mtIR5nnijyeO6GhN+juPmRjUal7HTzlc2wjTGkFm4
	Tg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:date:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=nHuRm8Mu5J2Su8uHowQpoO8hCT0QYBjpx+Lajkvwk2o=;
	b=bz15bFXfJT4EEyfwgeSei8sP7kdjk2Y/o5gcT6vptwAFIExmlwXA+z5+9WJvGPSArw
	y79LocyrbKZwvRb9WtKwI7Vx+DuUEvjZcjc6UioqevebRa/po65TRJpiPaUdNfOPgRtr
	OGMmOb+buj3fxpm3fOgrMFlgPH1WfZJLanHNELiLr+ecApVF77Zd5jrTwFdGD5iT5XSF
	yaezrewBcw02BXUkQ8j5jKVvw89ojPPpQsMN6tuq2q2Rn+NXmgtLKwaVDw0bDd7K2Ufo
	YgCCJN3Z+9HN+rBUO4USjcw/5PG955MX+VaoYivqZ6m1/a8zb75MlqxTNSZsrjZt3d3t
	jdOQ==
X-Gm-Message-State: APjAAAXXCnBLTmSz/+BZnSUYHrk+701PbiNSDgiSHqL4ckAM+kHPh/7b
	ZbyFT6lB5MVpzo3j+OoT98FSTieW
X-Google-Smtp-Source: APXvYqy7VykQPHYL6yz58GR78/vQifehmOGsfd8jhLO7Zm+WtmolB2ILBRfgLZNhYUDGiCOU0cv+Jg==
X-Received: by 2002:a1c:cc02:: with SMTP id h2mr10423122wmb.13.1560583449453; 
	Sat, 15 Jun 2019 00:24:09 -0700 (PDT)
Received: from localhost (ip-217-030-068-212.aim-net.cz. [217.30.68.212])
	by smtp.gmail.com with ESMTPSA id p2sm7886687wrx.90.2019.06.15.00.24.08
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sat, 15 Jun 2019 00:24:08 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Sat, 15 Jun 2019 09:24:09 +0200
To: bitbake-devel@lists.openembedded.org
Message-ID: <20190615072409.GA1486@jama>
References: <20190615071743.9494-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190615071743.9494-1-Martin.Jansa@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Subject: Re: [1.40][PATCH] bitbake: fix version comparison when one of the versions ends in .
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 15 Jun 2019 07:24:10 -0000
X-Groupsio-MsgNum: 10262
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2019 at 07:17:43AM +0000, Martin Jansa wrote:
> From: Alexander Kanavin <alex.kanavin@gmail.com>
>=20
> Previously, this would happen:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ERROR: test_vercmpstring (bb.tests.utils.VerCmpString)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/home/alexander/development/poky/bitbake/lib/bb/tests/utils.py", =
line 45, in test_vercmpstring
>     result =3D bb.utils.vercmp_string('1.', '1.1')
>   File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 1=
43, in vercmp_string
>     return vercmp(ta, tb)
>   File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 1=
35, in vercmp
>     r =3D vercmp_part(va, vb)
>   File "/home/alexander/development/poky/bitbake/lib/bb/utils.py", line 1=
24, in vercmp_part
>     elif ca < cb:
> TypeError: '<' not supported between instances of 'NoneType' and 'int'

I was seeing the same error on versions not ending with '.', in my case:
bb.utils.vercmp((0,1.0.2r,r0.0webos22), (0,1.0.2r0webos19,r0.0webos21)

Which lead to do_packagedata failure through buildhistory_emit_pkghistory s=
hown bellow.

Alex's fix works for the above versions as well, should I extend
the bb.utils.vercmp selftest with even weirder versions like we're using
or leave it as is?

The stack trace of python calls that resulted in this exception/failure was:
File: 'exec_python_func() autogenerated', lineno: 2, function: <module>
     0001:
 *** 0002:buildhistory_emit_pkghistory(d)
     0003:
File: 'oe-core/meta/classes/buildhistory.bbclass', lineno: 263, function: b=
uildhistory_emit_pkghistory
     0259:            last_pkge =3D lastversion.pkge
     0260:            last_pkgv =3D lastversion.pkgv
     0261:            last_pkgr =3D lastversion.pkgr
     0262:            bb.warn("bb.utils.vercmp((%s,%s,%s), (%s,%s,%s)" % (p=
kge, pkgv, pkgr, last_pkge, last_pkgv, last_pkgr))
 *** 0263:            r =3D bb.utils.vercmp((pkge, pkgv, pkgr), (last_pkge,=
 last_pkgv, last_pkgr))
     0264:            if r < 0:
     0265:                msg =3D "Package version for package %s went back=
wards which would break package feeds from (%s:%s-%s to %s:%s-%s)" % (pkg, =
last_pkge, last_pkgv, last_pkgr, pkge, pkgv, pkgr)
     0266:                package_qa_handle_error("version-going-backwards"=
, msg, d)
     0267:
File: 'bitbake/lib/bb/utils.py', lineno: 134, function: vercmp
     0130:    (eb, vb, rb) =3D tb
     0131:
     0132:    r =3D int(ea or 0) - int(eb or 0)
     0133:    if (r =3D=3D 0):
 *** 0134:        r =3D vercmp_part(va, vb)
     0135:    if (r =3D=3D 0):
     0136:        r =3D vercmp_part(ra, rb)
     0137:    return r
     0138:
File: 'bitbake/lib/bb/utils.py', lineno: 123, function: vercmp_part
     0119:        if oa < ob:
     0120:            return -1
     0121:        elif oa > ob:
     0122:            return 1
 *** 0123:        elif ca < cb:
     0124:            return -1
     0125:        elif ca > cb:
     0126:            return 1
     0127:
Exception: TypeError: '<' not supported between instances of 'NoneType' and=
 'int'

>=20
> ----------------------------------------------------------------------
>=20
> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/tests/utils.py | 4 ++++
>  lib/bb/utils.py       | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
> index 2f4ccf3c..f1cd83a4 100644
> --- a/lib/bb/tests/utils.py
> +++ b/lib/bb/tests/utils.py
> @@ -42,6 +42,10 @@ class VerCmpString(unittest.TestCase):
>          self.assertTrue(result < 0)
>          result =3D bb.utils.vercmp_string('1.1', '1.0+1.1-beta1')
>          self.assertTrue(result > 0)
> +        result =3D bb.utils.vercmp_string('1.', '1.1')
> +        self.assertTrue(result < 0)
> +        result =3D bb.utils.vercmp_string('1.1', '1.')
> +        self.assertTrue(result > 0)
> =20
>      def test_explode_dep_versions(self):
>          correctresult =3D {"foo" : ["=3D 1.10"]}
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 73b6cb42..215c18cf 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -120,6 +120,10 @@ def vercmp_part(a, b):
>              return -1
>          elif oa > ob:
>              return 1
> +        elif ca is None:
> +            return -1
> +        elif cb is None:
> +            return 1
>          elif ca < cb:
>              return -1
>          elif ca > cb:
> --=20
> 2.17.1
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRU+ejDffEzV2Je2oc3VSO3ZXaAHAUCXQSdGAAKCRA3VSO3ZXaA
HIZoAJ9O9x/ZiM8eqFzSBB9HVYExfXwZPgCgu+PAcAebHOdPHn1ZiA7aDgCl+a8=
=fJLz
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
