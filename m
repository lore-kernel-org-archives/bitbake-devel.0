Return-Path: <kergoth@gmail.com>
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
	[209.85.167.169])
	by mail.openembedded.org (Postfix) with ESMTP id F0A7F6C466
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 16:02:25 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id y23so717246oia.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=vi1dE65Fq5rbv6qyW+4HbuH4cIRMJQ43uPt9xdqyaOI=;
	b=i2xjqpNofRjayRDbyNbI3gQHzuC63vlW88+o/6xehI9QrawMLUFpM6zWI4vEZvIyMS
	V9VwSkAuCK+GGfM+pZPGUbwAL+mBZ5poZHl/s2alWX2uRi0yc3j74Lj9vLojrMVktOQl
	vbFeEz3dS8Lgnl5Gm3qbdJiefQMOfVvcQ4xNvnIyzGzWpjRB9l3I9a+CC3SBUPumV4dT
	pDl55ylKkFNvOzhSS9aTsq7o3WppTaQ1C54Bo6NYecrfRFYQxB4WxJV6BzNVbhdksU5y
	UO+Z41H0/4aJyEtpMaFCmrtABS4h/7KuxSaP5dTRGMHMDr+7N+IL/1lr+v42CsHHyu84
	CZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=vi1dE65Fq5rbv6qyW+4HbuH4cIRMJQ43uPt9xdqyaOI=;
	b=ucvmg2zeXfPlY8YvZZTQAIl4F+a3tdLPSeXReO7so4DAS0XJAnYDhS0fGZKXDHmkt2
	ObTO/Mg8aCHlWsVvR7hRKZK9QzzdL58pJ7dzE8ixFecup/FXb40OAm19zUfvTgKPH+yH
	1GWUWn3K/vUWvRJKyQ7RvW4DfV/G+JSemKVGIJN0EarnKaszZcCyglpiKVySbWJSnBA4
	n8J4Lfttyil5sq9ETo9foB4xOcYlrR4nRFfZAmAclJXPggYPOodBdLHnnIBg+9FHT8YK
	9lSJ9Z3+DdVPDr3RBmmsGGFySr2T8hybvLpOoRpfW76hgE4Pl1YZCuK8h6jPZ3/UAXI/
	bpNg==
X-Gm-Message-State: AJcUukcAhP0Y6vDEG+Fau1LEu5ek0FZk3yFDXdwLSIxPWMStT6rKfnXB
	xH4NaLwtBSOTZ0FP/1uI4s8+vxEa1t73ZE46OXA=
X-Google-Smtp-Source: ALg8bN4BOEASGyb9zYrr3xJ3TqA5KSVm9HXxjVjcmvVEcwrR7xXutWOfbtb6uLbC2lDom8RvqYRWGCmMYU6whIMCxmU=
X-Received: by 2002:aca:d09:: with SMTP id 9mr7942750oin.19.1546876946831;
	Mon, 07 Jan 2019 08:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
	<20190107155536.6062-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20190107155536.6062-3-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Mon, 7 Jan 2019 09:02:15 -0700
Message-ID: <CABcZANkY0HGOzB2JKZC08=QzRzM_BoVJf0PZ-MrRFcD1XZTMRQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/4] cooker: Allow faster exitting from parser threads
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
X-List-Received-Date: Mon, 07 Jan 2019 16:02:26 -0000
Content-Type: multipart/alternative; boundary="000000000000ed602a057ee05a91"

--000000000000ed602a057ee05a91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Empty is raised when it times out, not just when it=E2=80=99s actually empt=
y,
though.

On Mon, Jan 7, 2019 at 8:55 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> We don't push "None" values onto the parser queue so currently idle parsi=
ng
> threads loop every 0.25s and idle. They may as well exit out of their wor=
k
> is done.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index d1d2868d6f..9b2a0920f9 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -1943,9 +1943,6 @@ class Parser(multiprocessing.Process):
>                  try:
>                      job =3D self.jobs.get(timeout=3D0.25)
>                  except queue.Empty:
> -                    continue
> -
> -                if job is None:
>                      break
>                  result =3D self.parse(*job)
>
> --
> 2.19.1
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000ed602a057ee05a91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Empty is raised when it times out, not just when it=E2=80=
=99s actually empty, though.</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Mon, Jan 7, 2019 at 8:55 AM Richard Purdie &lt;<a href=3D"mailt=
o:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-co=
lor:rgb(204,204,204);padding-left:1ex">We don&#39;t push &quot;None&quot; v=
alues onto the parser queue so currently idle parsing<br>
threads loop every 0.25s and idle. They may as well exit out of their work<=
br>
is done.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/cooker.py | 3 ---<br>
=C2=A01 file changed, 3 deletions(-)<br>
<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index d1d2868d6f..9b2a0920f9 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -1943,9 +1943,6 @@ class Parser(multiprocessing.Process):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0job =3D self.jobs.get(timeout=3D0.25)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except queue.=
Empty:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cont=
inue<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if job is None:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D se=
lf.parse(*job)<br>
<br>
-- <br>
2.19.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--000000000000ed602a057ee05a91--
