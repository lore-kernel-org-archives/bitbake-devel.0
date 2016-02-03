Return-Path: <raj.khem@gmail.com>
Received: from mail-pf0-f179.google.com (mail-pf0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 486E877343;
	Wed,  3 Feb 2016 06:07:07 +0000 (UTC)
Received: by mail-pf0-f179.google.com with SMTP id 65so7976841pfd.2;
	Tue, 02 Feb 2016 22:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:mime-version:content-type:from:in-reply-to:date:cc
	:message-id:references:to;
	bh=mf/xjbMOJno2QWvMTUOvFlAaAKayvVZW2CreWQefCBo=;
	b=kqawUYMcqkITyytcZRujEhFRbRH8NEqiOab7e/aqvIGQXlcns8t0gBF6eUHhOvJtf4
	bXqtzM8yaNvKcWsGHWpoIPh4lLNFs7PF08HtipnKLOh/nrH7UXCauuqTFM5H9qx8HREs
	vejvT26qpeG3eEMEACDNDBaTVBlLx+AYLzMS0Z5a/4NZJlnaCjtOyc6eRJ1a9NQMfb55
	SJlUSh5yZ1y9RfjGsrA5NHw67ZZrr77he3RCPNf1M1WG9rj9fV6tiXpfscIELit4doL3
	IJySsp1SlzaGaYwa2f8i7r4HcR2f0mOaToiOl+OEt05SJNJFpg9yGyRX92Hf71DvXqSJ
	owxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:mime-version:content-type:from
	:in-reply-to:date:cc:message-id:references:to;
	bh=mf/xjbMOJno2QWvMTUOvFlAaAKayvVZW2CreWQefCBo=;
	b=Un/F6uKp1Hzt37HvaqeLwoB4mE0k8HNrAmIswWvDwJ1LZYquX8sK/1z10Bh6IUzWaN
	kQp6x4Q9bivhPaFWdWib/noRJfwetqWra8Ceeh8M0cnTpowxYBH7W+5I0TcqFf2aRQL1
	DQmo/9xYsvOfnDEVLmj2s95TMK6F1LzbIp306LfxesxxDXktllnH6ukQYH+gW2ndD8r8
	r9AJRtkLI8gmaerubg10e95jiz2pX3XwdUOGZyS85UwYTWVmO9fyMa4opqMh+X3G+nBC
	kAtVw/H+FCWIQ80VmEgeqO5U4rY4P89Gm94BcZYT9/iSW13+5pNzSgRV7+2HK9euGedE
	ldFQ==
X-Gm-Message-State: AG10YOTWayIQTGfdF/w9ZL6pu0zS213Gh3Y8uCbcNvdDvwTyAl8KUoB7GrkP1taPr2KjOQ==
X-Received: by 10.98.34.84 with SMTP id i81mr12918315pfi.160.1454479628287;
	Tue, 02 Feb 2016 22:07:08 -0800 (PST)
Received: from ?IPv6:2601:646:8802:5d5c:6d69:5a78:5946:6549?
	([2601:646:8802:5d5c:6d69:5a78:5946:6549])
	by smtp.gmail.com with ESMTPSA id
	w12sm6665311pfa.79.2016.02.02.22.07.06
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 02 Feb 2016 22:07:06 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
X-Pgp-Agent: GPGMail 2.6b2
From: Khem Raj <raj.khem@gmail.com>
In-Reply-To: <1454422078.27087.76.camel@linuxfoundation.org>
Date: Tue, 2 Feb 2016 22:06:56 -0800
Message-Id: <E2415570-99E9-4C56-87F3-C1424ADD2495@gmail.com>
References: <1454422078.27087.76.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3112)
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] build/data: Don't expand python functions before execution [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 06:07:08 -0000
X-Groupsio-MsgNum: 6976
Content-Type: multipart/signed;
	boundary="Apple-Mail=_3FDF2A1F-DABC-4B79-85D6-6B4EA697C142";
	protocol="application/pgp-signature"; micalg=pgp-sha1

--Apple-Mail=_3FDF2A1F-DABC-4B79-85D6-6B4EA697C142
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Feb 2, 2016, at 6:07 AM, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> Right now, if you have some python code like:
>=20
> X =3D "a"
>=20
> def somefunction(d):
>    d.setVar("X", "b")
>    d.setVar("Y", "${X}")
>=20
> then any sane person would expect that Y =3D "b" at the end of the
> function. This is not the case, Y =3D "a".
>=20
> This is due to the python function being expanded before execution, =
the
> executed code would read d.setVar("Y", "a"). This understandably
> confuses people, it also makes it near impossible to write ${} in a
> python function without unintended things happening.
>=20
> I think there is general agreement we should fix this and standardise
> on non-expansion of python functions. We already don't expand =
anonymous
> python (mostly).
>=20
> I've checked OE-Core with buildhistory before and after this change =
and
> there were a small number of issues this exposed which I've sent
> patches for.
>=20
> I propose we default to not expanding python code and then deal with
> any consequences from that if/as/where identified. This will improve
> new user understanding and usability of the system, it also allows
> several long standing weird expansion issues to be fixed.

I support this too. Additionally, it will be a nice to document this if =
it has not been done
thus far.

>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 52a4916..b7c49eb 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -239,7 +239,7 @@ def exec_func_python(func, d, runfile, cwd=3DNone):
>     """Execute a python BB 'function'"""
>=20
>     bbfile =3D d.getVar('FILE', True)
> -    code =3D _functionfmt.format(function=3Dfunc, body=3Dd.getVar(func,=
 True))
> +    code =3D _functionfmt.format(function=3Dfunc, body=3Dd.getVar(func,=
 False))
>     bb.utils.mkdirhier(os.path.dirname(runfile))
>     with open(runfile, 'w') as script:
>         bb.data.emit_func_python(func, script, d)
> diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
> index 1f1f0d2..86ad4ed 100644
> --- a/bitbake/lib/bb/data.py
> +++ b/bitbake/lib/bb/data.py
> @@ -308,7 +308,7 @@ def emit_func_python(func, o=3Dsys.__stdout__, d =3D=
 init()):
>=20
>     write_func(func, o, True)
>     pp =3D bb.codeparser.PythonParser(func, logger)
> -    pp.parse_python(d.getVar(func, True))
> +    pp.parse_python(d.getVar(func, False))
>     newdeps =3D pp.execs
>     newdeps |=3D set((d.getVarFlag(func, "vardeps", True) or =
"").split())
>     seen =3D set()
>=20
>=20
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel


--Apple-Mail=_3FDF2A1F-DABC-4B79-85D6-6B4EA697C142
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iEYEARECAAYFAlaxmQkACgkQuwUzVZGdMxTyqgCeI4E70+G9il0SmBIZE2maqkEC
MVgAn23paHDm+gUaYgqOOFWQOeo9xi2D
=D8bR
-----END PGP SIGNATURE-----

--Apple-Mail=_3FDF2A1F-DABC-4B79-85D6-6B4EA697C142--
