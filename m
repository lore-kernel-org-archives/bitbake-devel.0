Return-Path: <raj.khem@gmail.com>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
	[209.85.160.196])
	by mail.openembedded.org (Postfix) with ESMTP id 0B53F7F957
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 22:12:36 +0000 (UTC)
Received: by mail-qt1-f196.google.com with SMTP id g24so23628370qtq.11
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 Nov 2019 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8LWLhUP4L19t8DKv7cQwzvEKrUo/VxtmnXKoshET/dM=;
	b=F7olnDOVmvWwIRR+mULImNdXPT3ERglHtx4K2mQfWNkyGjin0EJSMJEoRsq1f27ABv
	/2smj9Cm7Qp/QyBUjLZvb062hy5rand52CNNKF16Y80mBdA0Jdy8umObByV+4708+N4z
	eWeDJ2BvBrd8b5mqt7yjVkSYZV0v6Tsp6yz9RTZ9L28XHHIGvGxdbCMkreHNNUCogI5D
	UjD6Y2ObaRL7jPM13LBvM37h4ovjEA/AFKjFTSbuUA/pC3DsAWHCfjisl0L3jufHN4fl
	pS0fgcL6OFpnydakoqHoBeg3ZjswLpuAlapGrVI+D9tUHtReErpkZ0IVrmh96t2bxdFx
	wSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8LWLhUP4L19t8DKv7cQwzvEKrUo/VxtmnXKoshET/dM=;
	b=jVsnGPiyqa5me41oht7Qs4SAWay+5NYoyMipBZb6ZAFg9+0EV9eFULg85BuD3FYZOP
	AbVI+Edhe/8F+N3SugXhuR5r4+PmtStQuFQata2xQwgsOEpTc5nB7nI4FyWQRmUFtH4K
	AYYY18NfnD7+7ghYrd8+54/xHcVI2V1anQfuZczmcFeuXNrUT60FEO61E3bGGJB4eqqC
	UtQN+eUO5EE5NIfc3ApiV0AAE1HVVoQFITPgPJWRIJV/fmP9M92IRodx82fS2HpwXAbA
	QsACjxMSDF2yG6m0qDf0YThQqU7eiUtD0g5LCUzJIY7ChVmhl1cbhImAJ5c72zLrIM+O
	Lp5A==
X-Gm-Message-State: APjAAAUTTdmbFyGNGDX3oHA51ZMOpA0r1vA/ODTLzAAMR7use5wBQ1c7
	qE8a9F4pYerpMrVNTUwoEq2+4c0tP+ka+CUFmOQ=
X-Google-Smtp-Source: APXvYqzVvCxBav+xZx2CRYEnyLkGfU5l761htTx1XNMkT1Mdd7dN3sWg1mrHbNO0wXNAg0foK533nJ24kxFiwwnPMBw=
X-Received: by 2002:ac8:66d7:: with SMTP id m23mr38680834qtp.53.1574979157334; 
	Thu, 28 Nov 2019 14:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20191128040947.3413821-1-raj.khem@gmail.com>
	<4835c6d4-a3a2-45cb-ad0c-1a95070b4c22@Spark>
In-Reply-To: <4835c6d4-a3a2-45cb-ad0c-1a95070b4c22@Spark>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 28 Nov 2019 14:12:26 -0800
Message-ID: <CAMKF1sqmNcJSaZFkR+iaZ99s4gXRvRvnLuYbMFkAuvuqg2mjQQ@mail.gmail.com>
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 28 Nov 2019 22:12:37 -0000
Content-Type: multipart/alternative; boundary="00000000000033a00305986f69bd"

--00000000000033a00305986f69bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 1:20 PM Christopher Larson <kergoth@gmail.com>
wrote:

> EXTRANATIVEPATH is an oe-core-ism, not bitbake, so this isn=E2=80=99t an
> appropriate place for it. Perhaps in do_fetch in base.bbclass.
>

Perhaps a better idea thanks

On Nov 27, 2019, 9:10 PM -0700, Khem Raj <raj.khem@gmail.com>, wrote:
>
> This helps fix an issue where python interpreter in hg script could
> overflow the BINPRM_BUF_SIZE which is 128 on most of systems, because
> interpreter is hardcoded and build paths can be deep.
>
> This patch helps, because now the absolute python interp path in hg can
> be replaced with '/usr/bin/env python3' and it will ensure that python3
> from native install is used instead of the one on host.
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
> lib/bb/fetch2/hg.py | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
> index e21115de..a640a80c 100644
> --- a/lib/bb/fetch2/hg.py
> +++ b/lib/bb/fetch2/hg.py
> @@ -65,6 +65,7 @@ class Hg(FetchMethod):
> ud.pkgdir =3D os.path.join(hgdir, hgsrcname)
> ud.moddir =3D os.path.join(ud.pkgdir, ud.module)
> ud.localfile =3D ud.moddir
> + d.appendVar("EXTRANATIVEPATH", " python3-native ")
> ud.basecmd =3D d.getVar("FETCHCMD_hg") or "/usr/bin/env hg"
>
> ud.setup_revisions(d)
> --
> 2.24.0
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>
>

--00000000000033a00305986f69bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Nov 28, 2019 at 1:20 PM Christopher Larson &lt;<a h=
ref=3D"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">



<div>
<div name=3D"messageBodySection">
<div dir=3D"auto">EXTRANATIVEPATH is an oe-core-ism, not bitbake, so this i=
sn=E2=80=99t an appropriate place for it. Perhaps in do_fetch in base.bbcla=
ss.</div></div></div></blockquote><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Perhaps a better idea thanks=C2=A0</div><div dir=3D"auto"><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div><div name=3D"messageBodySection"><div dir=
=3D"auto"></div>
</div>
<div name=3D"messageReplySection"></div></div><div><div name=3D"messageRepl=
ySection">On Nov 27, 2019, 9:10 PM -0700, Khem Raj &lt;<a href=3D"mailto:ra=
j.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt;, wrote:<br>
<blockquote type=3D"cite" style=3D"margin:5px 5px;padding-left:10px;border-=
left:thin solid #1abc9c">This helps fix an issue where python interpreter i=
n hg script could<br>
overflow the BINPRM_BUF_SIZE which is 128 on most of systems, because<br>
interpreter is hardcoded and build paths can be deep.<br>
<br>
This patch helps, because now the absolute python interp path in hg can<br>
be replaced with &#39;/usr/bin/env python3&#39; and it will ensure that pyt=
hon3<br>
from native install is used instead of the one on host.<br>
<br>
Signed-off-by: Khem Raj &lt;<a href=3D"mailto:raj.khem@gmail.com" target=3D=
"_blank">raj.khem@gmail.com</a>&gt;<br>
---<br>
lib/bb/fetch2/hg.py | 1 +<br>
1 file changed, 1 insertion(+)<br>
<br>
diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py<br>
index e21115de..a640a80c 100644<br>
--- a/lib/bb/fetch2/hg.py<br>
+++ b/lib/bb/fetch2/hg.py<br>
@@ -65,6 +65,7 @@ class Hg(FetchMethod):<br>
ud.pkgdir =3D os.path.join(hgdir, hgsrcname)<br>
ud.moddir =3D os.path.join(ud.pkgdir, ud.module)<br>
ud.localfile =3D ud.moddir<br>
+ d.appendVar(&quot;EXTRANATIVEPATH&quot;, &quot; python3-native &quot;)<br=
>
ud.basecmd =3D d.getVar(&quot;FETCHCMD_hg&quot;) or &quot;/usr/bin/env hg&q=
uot;<br>
<br>
ud.setup_revisions(d)<br>
--<br>
2.24.0<br>
<br>
--<br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" ta=
rget=3D"_blank">http://lists.openembedded.org/mailman/listinfo/bitbake-deve=
l</a><br></blockquote>
</div>
</div>

</blockquote></div></div>

--00000000000033a00305986f69bd--
