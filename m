Return-Path: <kergoth@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 74F107F265
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 03:01:51 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id q22so404249pgk.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2019 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:message-id:in-reply-to:references:subject:mime-version; 
	bh=Mo68ZlZaESgWRvEXgkrfOL3ErcQEe9oKiHj5G/wnUOM=;
	b=doM/f0Elh9cwtuFNWQbCOcSF3Ek12cg1s2pA2/Xwg9pbXn7R61+YlbaK66My1dIwwN
	OcgWxE9nyn7zUtE8Uvd+GbaANXBVN4Q/IDMUvzN3izLEWJ/y4IhJ1/YpRtPlBS+mF3Az
	G8uxqC6VN8oPLnnR6MSTNiZ1QPAqglMf/n5pyxA4mAybqne/dBR2MeDS9IEEPZSyz1So
	cdosZGRwS4ZiNQhkf+gZCNBN9LSsLcM9RB2tLs+8oTNlppOVb1bv8WnlDFf20bDBkTUA
	hIUIcUC56bGBzPc147taJ2z/4VG6Vun9nari0s4Dymv+iD1uEJULZzfu6Kto7RPhaToL
	TEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
	:subject:mime-version;
	bh=Mo68ZlZaESgWRvEXgkrfOL3ErcQEe9oKiHj5G/wnUOM=;
	b=k3EnclrihsA/wxID7jeuPtS5LDW1UTOSzDg1d4xxJSD1YEudCMHD6PtfB6esAS0DI2
	vqlkHNiNvUpm8vlhYsTsSlUoa/hoeW5zY9kFcWKG/san5ORkI2JWoACCSl2dsEqSBUJC
	/utd4N9SjJOzX4zYz2+QlvRMNm16K1KLK0LAMx1X7uZi77Y7ehewGB5XvOGJnDkVCNfN
	Qup/mHrJvHb/k+p/m70YIWf1VHEJsQnbV5k9B5fYtsH8dUIOLUbHcPWWXOoawmUJcHhr
	QoSSuaxee5CJ6qebSdRW7Zcby27nUjkL6aFdHBVgwpGvnJX9alEGMAgrwUwJRH6+1/yk
	8FkQ==
X-Gm-Message-State: APjAAAWALrP1IQyX8yauPc6rJ5x8WQ/tnLl1qwoVXAcyG7fi6YIkmcMd
	TlfF0u9U9hcNRaUB50GbOE8jseUrB3E=
X-Google-Smtp-Source: APXvYqyushroSWbrltbv3tQF7xz++Epn6PHwbmd5lT155IrSVlR5L2wYrr3+CgkGB8xiWABd0FMpAA==
X-Received: by 2002:a63:cb:: with SMTP id 194mr996376pga.163.1573614111948;
	Tue, 12 Nov 2019 19:01:51 -0800 (PST)
Received: from [192.168.1.17] (ip70-180-21-74.ph.ph.cox.net. [70.180.21.74])
	by smtp.gmail.com with ESMTPSA id
	ay16sm4950370pjb.2.2019.11.12.19.01.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 12 Nov 2019 19:01:50 -0800 (PST)
Date: Tue, 12 Nov 2019 20:01:44 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Alan Kozlay
	<alan.kozlay@ves-solutions.com>
Message-ID: <685e3541-d3fe-4ca4-bb66-7e0c0ff79eca@Spark>
In-Reply-To: <CAJE9sG=reXLA4GZQjBMsHc8eis=W7ejHTSmvNTAfNJ7gDBsQXw@mail.gmail.com>
References: <CAJE9sG=reXLA4GZQjBMsHc8eis=W7ejHTSmvNTAfNJ7gDBsQXw@mail.gmail.com>
X-Readdle-Message-ID: 685e3541-d3fe-4ca4-bb66-7e0c0ff79eca@Spark
MIME-Version: 1.0
Subject: Re: MACHINE_ARCH not in pkgarch (sstatesig.py)
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
X-List-Received-Date: Wed, 13 Nov 2019 03:01:51 -0000
Content-Type: multipart/alternative; boundary="5dcb721d_74b0dc51_4089"

--5dcb721d_74b0dc51_4089
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Nov 12, 2019, 1:50 PM -0700, Alan Kozlay <alan.kozlay=40ves-solutions.=
com>, wrote:
> In:
> oe-core/meta/lib/oe/sstatesig.py
>
> The find=5Fsstate=5Fmanifest function will search for a manifest assumi=
ng a number of potential paths based on various package architecture name=
s.=C2=A0 However, a few of the choices appear to have needed to be querie=
d from the bitbake database but their bb database variable names are used=
, instead.=C2=A0 That yields search paths which could never be correct:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs =3D =5B'=24=7BMACHINE=5FARCH=7D'=5D=

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs =3D pkgarchs + list(reversed(d2.ge=
tVar(=22PACKAGE=5FEXTRA=5FARCHS=22).split()))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs.append('allarch')
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgarchs.append('=24=7BSDK=5FARCH=7D=5F=24=7B=
SDK=5FARCH=7D-=24=7BSDKPKGSU=46=46IX=7D')
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkgarch in pkgarchs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 manifest =3D d2=
.expand(=22=24=7BSSTATE=5FMANI=46ESTS=7D/manifest-%s-%s.%s=22 % (pkgarch,=
 taskdata, taskname))

d2.expand() expands all the variable references from pkgarch, so unless i=
t=E2=80=99s also used later on and *isn=E2=80=99t* passed to expand(), th=
is isn=E2=80=99t an issue.

-Chris

--5dcb721d_74b0dc51_4089
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageReplySection=22>On Nov 12, 2019, 1:50 PM -0700, Ala=
n Kozlay &lt;alan.kozlay=40ves-solutions.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22>
<div dir=3D=22ltr=22>
<div>In:</div>
<div><font face=3D=22monospace=22>oe-core/meta/lib/oe/sstatesig.py</font>=
</div>
<div><font face=3D=22monospace=22><br /></font></div>
<div>The <font face=3D=22monospace=22>find=5Fsstate=5Fmanifest</font> fun=
ction will search for a manifest assuming a number of potential paths bas=
ed on various package architecture names.&=23160; However, a few of the c=
hoices appear to have needed to be queried from the bitbake database but =
their bb database variable <i>names</i> are used, instead.&=23160; That y=
ields search paths which could never be correct:</div>
<div><br /></div>
<div><font face=3D=22monospace=22>&=23160; &=23160; &=23160; &=23160; pkg=
archs =3D =5B<font color=3D=22=23=46=460000=22>'=24=7BMACHINE=5FARCH=7D'<=
/font>=5D<br />
&=23160; &=23160; &=23160; &=23160; pkgarchs =3D pkgarchs + list(reversed=
(d2.getVar(=22PACKAGE=5FEXTRA=5FARCHS=22).split()))<br />
&=23160; &=23160; &=23160; &=23160; pkgarchs.append('allarch')<br />
&=23160; &=23160; &=23160; &=23160; pkgarchs.append(<font color=3D=22=23=46=
=460000=22>'=24=7BSDK=5FARCH=7D=5F=24=7BSDK=5FARCH=7D-=24=7BSDKPKGSU=46=46=
IX=7D'</font>)<br /></font></div>
<div><font face=3D=22monospace=22><br /></font></div>
<div><font face=3D=22monospace=22>&=23160; &=23160; &=23160; &=23160; for=
 pkgarch in pkgarchs:<br />
&=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; &=23160; m=
anifest =3D d2.expand(=22=24=7BSSTATE=5FMANI=46ESTS=7D/manifest-%s-%s.%s=22=
 % (pkgarch, taskdata, taskname))&=23160;<br /></font></div>
</div>
</blockquote>
<div><br /></div>
<div dir=3D=22auto=22>d2.expand() expands all the variable references fro=
m pkgarch, so unless it=E2=80=99s also used later on and *isn=E2=80=99t* =
passed to expand(), this isn=E2=80=99t an issue.</div>
<div dir=3D=22auto=22><br /></div>
<div dir=3D=22auto=22>-Chris</div>
</div>
</body>
</html>

--5dcb721d_74b0dc51_4089--
