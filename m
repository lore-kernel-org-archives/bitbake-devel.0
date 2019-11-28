Return-Path: <kergoth@gmail.com>
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by mail.openembedded.org (Postfix) with ESMTP id 5AF6D7F953
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 21:20:55 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x185so944091pfc.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:message-id:in-reply-to:references:subject:mime-version; 
	bh=wA+BJDo8PD4oKymEel/LDyVeI+emZTkH1w+TrGLEYa8=;
	b=jpfgGp9sF5OpCX5hZkO11c0KYnq4CGzh/FwXOL7il4ODp5r7qkrNJdBZBidOabQ4bJ
	OL4Wk3Cqb3wU9C9BoqxhDgTQ/QvurONfYppMII7KDg37RYtBr5uMPsK2ZXTzfal7NeE5
	KyRGDVm6wPLxVIwfvoscxL/QIY50Uexiiq39D1sf5MqyBd2haPFTTnJZB9FkxfhQ7BWC
	wJETelGOQj1PvQQ2PaLucK3NVkZ+p/YV5FYqTrSb9z3nJRa9g1lEeSQ6qMos/w3QiDSl
	HaUo/OhT58ipQpGug+9IINhDp4gfb89al2alJXDlmTDFbnu7yfw0fmIqc8ZUGZiP2U7D
	qg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
	:subject:mime-version;
	bh=wA+BJDo8PD4oKymEel/LDyVeI+emZTkH1w+TrGLEYa8=;
	b=A0UwekLGI5WUxPVYZkJj0cN177N2YhLugmawyuaUgV4aqcEzlzdboO2KK3QyzLLqeE
	/ISCMkplORqtEpz87UWPodD7GOReNDOqVgwz3gX0wanYuxetK5mfsXM+9laECqJBBFYI
	184EC5IH/xoBKJpSps6M+bIYq774AD4znQHfi8+2dVIVdFhaAOj0y5GXN7GgboZHugxG
	2zFt4TFBm9Iv5/rqTrfcDXjm+dOKhLHiOqhXqHZ0Tl7AJS2MPyRm7fqYdrhsmeCJa94O
	vJSe042Cg2UnFdku/haqifOi/2CeuBvvW8P4+A8wMXRfVxzrGBLhasZMXvCH6+9UyFxx
	+Npw==
X-Gm-Message-State: APjAAAUwQKgghVZ1s1Dv8/pH0lW50YsH1O3ZVLyXaFHfXNGxt3/Nef2f
	UQEITI+YrtSU1Ub7mJRckphLy8mjgtQ=
X-Google-Smtp-Source: APXvYqxditafbSo+Zt1YQfoOiCcdqxRCkQOXKhH/ey7zlTKRxxsL9akPh94k+eH9J+9zFc50Kh/izw==
X-Received: by 2002:aa7:8edd:: with SMTP id b29mr54710748pfr.23.1574976056034; 
	Thu, 28 Nov 2019 13:20:56 -0800 (PST)
Received: from [192.168.1.17] (ip70-180-21-74.ph.ph.cox.net. [70.180.21.74])
	by smtp.gmail.com with ESMTPSA id j18sm7527983pgk.1.2019.11.28.13.20.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Nov 2019 13:20:54 -0800 (PST)
Date: Thu, 28 Nov 2019 14:20:48 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Khem Raj <raj.khem@gmail.com>
Message-ID: <4835c6d4-a3a2-45cb-ad0c-1a95070b4c22@Spark>
In-Reply-To: <20191128040947.3413821-1-raj.khem@gmail.com>
References: <20191128040947.3413821-1-raj.khem@gmail.com>
X-Readdle-Message-ID: 4835c6d4-a3a2-45cb-ad0c-1a95070b4c22@Spark
MIME-Version: 1.0
Subject: Re: [PATCH] hg: Add python3-native to native paths
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
X-List-Received-Date: Thu, 28 Nov 2019 21:20:55 -0000
Content-Type: multipart/alternative; boundary="5de03a35_6b68079a_2d9"

--5de03a35_6b68079a_2d9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

EXTRANATIVEPATH is an oe-core-ism, not bitbake, so this isn=E2=80=99t an =
appropriate place for it. Perhaps in do=5Ffetch in base.bbclass.
On Nov 27, 2019, 9:10 PM -0700, Khem Raj <raj.khem=40gmail.com>, wrote:
> This helps fix an issue where python interpreter in hg script could
> overflow the BINPRM=5FBU=46=5FSIZE which is 128 on most of systems, bec=
ause
> interpreter is hardcoded and build paths can be deep.
>
> This patch helps, because now the absolute python interp path in hg can=

> be replaced with '/usr/bin/env python3' and it will ensure that python3=

> from native install is used instead of the one on host.
>
> Signed-off-by: Khem Raj <raj.khem=40gmail.com>
> ---
> lib/bb/fetch2/hg.py =7C 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index e21115de..a640a80c 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> =40=40 -65,6 +65,7 =40=40 class Hg(=46etchMethod):
> ud.pkgdir =3D os.path.join(hgdir, hgsrcname)
> ud.moddir =3D os.path.join(ud.pkgdir, ud.module)
> ud.localfile =3D ud.moddir
> + d.appendVar(=22EXTRANATIVEPATH=22, =22 python3-native =22)
> ud.basecmd =3D d.getVar(=22=46ETCHCMD=5Fhg=22) or =22/usr/bin/env hg=22=

>
> ud.setup=5Frevisions(d)
> --
> 2.24.0
>
> --
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> bitbake-devel mailing list
> bitbake-devel=40lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel

--5de03a35_6b68079a_2d9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>EXTRANATIVEPATH is an oe-core-ism, not bitbake, so =
this isn=E2=80=99t an appropriate place for it. Perhaps in do=5Ffetch in =
base.bbclass.</div>
</div>
<div name=3D=22messageReplySection=22>On Nov 27, 2019, 9:10 PM -0700, Khe=
m Raj &lt;raj.khem=40gmail.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 class=3D=22spark=5Fquote=22 style=3D=22marg=
in: 5px 5px; padding-left: 10px; border-left: thin solid =231abc9c;=22>Th=
is helps fix an issue where python interpreter in hg script could<br />
overflow the BINPRM=5FBU=46=5FSIZE which is 128 on most of systems, becau=
se<br />
interpreter is hardcoded and build paths can be deep.<br />
<br />
This patch helps, because now the absolute python interp path in hg can<b=
r />
be replaced with '/usr/bin/env python3' and it will ensure that python3<b=
r />
from native install is used instead of the one on host.<br />
<br />
Signed-off-by: Khem Raj &lt;raj.khem=40gmail.com&gt;<br />
---<br />
lib/bb/fetch2/hg.py =7C 1 +<br />
1 file changed, 1 insertion(+)<br />
<br />
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py<br />
index e21115de..a640a80c 100644<br />
--- a/lib/bb/fetch2/hg.py<br />
+++ b/lib/bb/fetch2/hg.py<br />
=40=40 -65,6 +65,7 =40=40 class Hg(=46etchMethod):<br />
ud.pkgdir =3D os.path.join(hgdir, hgsrcname)<br />
ud.moddir =3D os.path.join(ud.pkgdir, ud.module)<br />
ud.localfile =3D ud.moddir<br />
+ d.appendVar(=22EXTRANATIVEPATH=22, =22 python3-native =22)<br />
ud.basecmd =3D d.getVar(=22=46ETCHCMD=5Fhg=22) or =22/usr/bin/env hg=22<b=
r />
<br />
ud.setup=5Frevisions(d)<br />
--<br />
2.24.0<br />
<br />
--<br />
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<br />
bitbake-devel mailing list<br />
bitbake-devel=40lists.openembedded.org<br />
http://lists.openembedded.org/mailman/listinfo/bitbake-devel<br /></block=
quote>
</div>
</body>
</html>

--5de03a35_6b68079a_2d9--
