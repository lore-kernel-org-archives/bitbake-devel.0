Return-Path: <kergoth@gmail.com>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
	[209.85.215.45])
	by mail.openembedded.org (Postfix) with ESMTP id 836D76CB7C
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Feb 2014 04:14:37 +0000 (UTC)
Received: by mail-la0-f45.google.com with SMTP id b8so3142571lan.18
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Feb 2014 20:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=E6EFVUuX1SG1m6TbPcnotPHwhf3ejL08bvNFtXCIj1o=;
	b=Y58ZGuM4lyTAYpQ2A9M1i7bm2lgU1brD3znSlNZQs/m3thAWXlZ7gy7MSW7+ngF34f
	375j8PKCBpZ3fQ660+pFdP+3/pSoi5UINvT8+b5YJQNN/jasXdaiA/Ggl3Vw15cFpjJ5
	sbHiykxIB+WC9tOBX8emTjgaEaJyx8td4CVIvqRHYr9u4k0NJnw2L/viJzjBb1mIkG/4
	Fw501Dtt8ta+EQqkMgNxkaa/Hfd9vLkTcRLGoZGVWR/hVQYWYvOlhbMW4jMFUL3Vl/q6
	4H28j4d1Pw4jGatV4fhSg7Bmpp3Lm1/IktBmYDoP/hOvdB0fEjmpFp9YxmA9u17KI/Zh
	qTVQ==
X-Received: by 10.112.34.231 with SMTP id c7mr5626659lbj.56.1393042478372;
	Fri, 21 Feb 2014 20:14:38 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.35.200 with HTTP; Fri, 21 Feb 2014 20:14:18 -0800 (PST)
In-Reply-To: <1393001163-7170-1-git-send-email-jacob.kroon@mikrodidakt.se>
References: <1393001163-7170-1-git-send-email-jacob.kroon@mikrodidakt.se>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 21 Feb 2014 21:14:18 -0700
X-Google-Sender-Auth: 3bL_IazJ5U7RjZrRI1q38ZXfwYM
Message-ID: <CABcZAN=VNGf1yrJMxybs8cPbFR66__85oYihLamBDg0EY6gmwQ@mail.gmail.com>
To: Jacob Kroon <jacob.kroon@mikrodidakt.se>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] Fix support for anonymous methods in foobar_%.bbappend files
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
X-List-Received-Date: Sat, 22 Feb 2014 04:14:40 -0000
Content-Type: multipart/alternative; boundary=14dae93d94d4149b3104f2f6fa3f

--14dae93d94d4149b3104f2f6fa3f
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 21, 2014 at 9:46 AM, Jacob Kroon <jacob.kroon@mikrodidakt.se>wrote:

> -            funcname = ("__anon_%s_%s" % (self.lineno,
> self.filename.translate(string.maketrans('/.+-@', '_____'))))
> +            funcname = ("__anon_%s_%s" % (self.lineno,
> self.filename.translate(string.maketrans('/.+-@%', '______'))))
>

I know it's not related to this particular patch, but there's no reason for
us to call string.maketrans() inside of MethodPool.eval(), that should
probably have been a class member, no reason to regenerate the translation
table every time, after all :)
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--14dae93d94d4149b3104f2f6fa3f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 21, 2014 at 9:46 AM, Jacob Kroon <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jacob.kroon@mikrodidakt.se" target=3D"_blank">jacob.kroon@mikrod=
idakt.se</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":12f" class=3D"a3s" style=3D"over=
flow:hidden">- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0funcname =3D (&quot=
;__anon_%s_%s&quot; % (self.lineno, self.filename.translate(string.maketran=
s(&#39;/.+-@&#39;, &#39;_____&#39;))))<br>


+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0funcname =3D (&quot;__anon_%s_%s=
&quot; % (self.lineno, self.filename.translate(string.maketrans(&#39;/.+-@%=
&#39;, &#39;______&#39;))))</div></blockquote></div><br></div><div class=3D=
"gmail_extra">I know it&#39;s not related to this particular patch, but the=
re&#39;s no reason for us to call string.maketrans() inside of MethodPool.e=
val(), that should probably have been a class member, no reason to regenera=
te the translation table every time, after all :)<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--14dae93d94d4149b3104f2f6fa3f--
