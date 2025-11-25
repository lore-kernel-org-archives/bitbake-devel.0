Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC6CFD364
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 07:50:27 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12370.1764057026334888691
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 23:50:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=euAJinff;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32900c8bso2954355f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 23:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764057025; x=1764661825; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EFvBiTnZUhPpuweAvjpFyyu/Op9SaqfLZggUXe2UcKQ=;
        b=euAJinffJ1BDLlFVJ1/jVDnMhNfieUsSW0qeYGT1TfVmuJ/yN2LROnK4znQ2Ys8hUv
         JZrG2N8Nk7hFv05Y+fn8Bptfa233Hj4Z6N2rr5pHAhciDB0URc7MMX2SkGKo2EikDW2K
         xBSQTe/42Q6HEMptONtAX2Mv0F2sm8Ds8aFPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057025; x=1764661825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFvBiTnZUhPpuweAvjpFyyu/Op9SaqfLZggUXe2UcKQ=;
        b=hWJFY8X8bnjxojKBwjp9nw/5GFifdZTlVVNCNEDueDbzzlJORzvdXULH6gbiUsFLYv
         Ibe2jE/r5sCsysbMfTOZ6WpAJ+Ao0UruikkAAjcx4cVDcD7Ip1HqT1cfU8JpXKjqtvIS
         xwMikhT45HdyRYv4uZrl6iEFI2nQMetW+Xj+nxLq5Gnd1e1JVIcLg/G3e1MXXmW2ylwT
         RVQYQGHMxSbBrrW538q2oGfZ8szhD5sLv/YsCQeLviIPNFAucLXNXe9SyTk5D7TUqrSD
         5ArZm0JgJjlnABcWG/hO1zslDKxAyItNpLPkRTroxyZK8Ctn9gIKsLOunKBy3JRg1a5G
         GbOw==
X-Gm-Message-State: AOJu0YyYTyIbAB9JU73hagCZdlFivvsDLyg6yz7vzll+RKXjW3pNBcWc
	i9UidutzhFAL8hy1zsFqwLUm7eG0wt/64Xl9hAqVfxQdXKXQXW9nW/bCVYFISvmOOeJ6rcUqUxt
	ar/wpgn6qy7zM05jBCw3NxtEbTmfw8WN5VL5d6M11TO8yqOHeVoJOuZo=
X-Gm-Gg: ASbGncuu/KxLs16xcRM6a1gwFvHPLymkw8Fsluhw5X/hRK0Si7fMH8uzMeQXLZTu7f+
	7VAgXbwc4E8DoQ1dbS1z5wmhAhXqYRg0Ci6KRfImYsiuX8zST1ybNE/oICeh8HlKGgLMkViGamo
	KAbdOrMCt59sWFExv4FFkM6UXZUOGqJBgAUPKmzL+heJDiSHXDdw4OvAGj2iA5Q8ZPsTR7KiQja
	Ytyv3bfVaUpJ1Ibu8cWlNealI4npgcuqom8FqnxA48wGM7BOdggOW/aujSfGhT2jbxYbEl+vWJ8
	sB1YCTcz6SlS6Q2I286s8ttK8Cme18T8kPyxQ7OV
X-Google-Smtp-Source: AGHT+IFM2AQaGEcTWuNO2l9cmwnjXtyyVhIkVM3GVPOWoF5XsReYdRaLz2KFEKmqCo3d8xZiNnllo9cg6ZPzCi9pqWA=
X-Received: by 2002:a05:6000:26cb:b0:42b:3ee9:4772 with SMTP id
 ffacd0b85a97d-42cc1d525b7mr15317475f8f.52.1764057024478; Mon, 24 Nov 2025
 23:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20251125073454.1282407-1-changqing.li@windriver.com>
In-Reply-To: <20251125073454.1282407-1-changqing.li@windriver.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 25 Nov 2025 08:49:58 +0100
X-Gm-Features: AWmQ_bmOxM1qE74COkTTOWYn3j9fuWezeuMc3zxP-S1wbKkZt3nLXD8PECvx0PM
Message-ID: <CAMSfU+5eewRwOVNLL-VmJgsAXpZUdXkoLO6FfcSizGp3vJpY6w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: Avoid unexpected
 positional parameter propagation when sourcing scripts
To: changqing.li@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000004ecca206446688ea"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 07:50:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18488

--0000000000004ecca206446688ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 25 nov. 2025 =C3=A0 08:34, Changqing Li via lists.openembedded.org =
<
changqing.li=3Dwindriver.com@lists.openembedded.org> a =C3=A9crit :

> From: Changqing Li <changqing.li@windriver.com>
>
> Using `set` to define positional parameters in the current shell causes
> those parameters to persist. When another script is sourced in the same
> shell without explicit arguments, it unexpectedly inherits these
> positional parameters. This change prevents such unintended propagation.
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 75be90940..7f77bda55 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -184,7 +184,7 @@ def setup_bitbake_build(bitbake_config, layerdir,
> setupdir, thisdir, update_bb_c
>
>      def _make_init_build_env(builddir, oeinitbuildenvdir):
>          builddir =3D os.path.realpath(builddir)
> -        cmd =3D "cd {}\nset {}\n.
> ./oe-init-build-env\n".format(oeinitbuildenvdir, builddir)
> +        cmd =3D "cd {}\n. ./oe-init-build-env
> {}\n".format(oeinitbuildenvdir, builddir)
>

Sadly, dash does not support this (I used "set {}", to enable its support).
Maybe use "set --" to remove any added positional argument? That seem to
work:
 $ dash
$ set A
$ echo $1
A
$ set --
$ echo $1

$

Regards,


>          initbuild_in_builddir =3D os.path.join(builddir, 'init-build-env=
')
>
>          with open(initbuild_in_builddir, 'w') as f:
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18487):
> https://lists.openembedded.org/g/bitbake-devel/message/18487
> Mute This Topic: https://lists.openembedded.org/mt/116465767/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--0000000000004ecca206446688ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 25 nov.=
 2025 =C3=A0=C2=A008:34, Changqing Li via <a href=3D"http://lists.openembed=
ded.org" target=3D"_blank">lists.openembedded.org</a> &lt;<a href=3D"http:/=
/changqing.li" target=3D"_blank">changqing.li</a>=3D<a href=3D"mailto:windr=
iver.com@lists.openembedded.org" target=3D"_blank">windriver.com@lists.open=
embedded.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">From: Changqing Li &lt;<a href=3D"mailto:changqing=
.li@windriver.com" target=3D"_blank">changqing.li@windriver.com</a>&gt;<br>
<br>
Using `set` to define positional parameters in the current shell causes<br>
those parameters to persist. When another script is sourced in the same<br>
shell without explicit arguments, it unexpectedly inherits these<br>
positional parameters. This change prevents such unintended propagation.<br=
>
<br>
Signed-off-by: Changqing Li &lt;<a href=3D"mailto:changqing.li@windriver.co=
m" target=3D"_blank">changqing.li@windriver.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
index 75be90940..7f77bda55 100755<br>
--- a/bin/bitbake-setup<br>
+++ b/bin/bitbake-setup<br>
@@ -184,7 +184,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setup=
dir, thisdir, update_bb_c<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _make_init_build_env(builddir, oeinitbuildenvdir):<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0builddir =3D os.path.realpath(builddir)<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;cd {}\nset {}\n. ./oe-init-build=
-env\n&quot;.format(oeinitbuildenvdir, builddir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;cd {}\n. ./oe-init-build-env {}\=
n&quot;.format(oeinitbuildenvdir, builddir)<br></blockquote><div><br></div>=
<div>Sadly, dash does not support this (I used &quot;set {}&quot;, to enabl=
e its support).</div><div>Maybe use &quot;set --&quot; to remove any added =
positional argument? That seem to work:</div><div>=C2=A0$ dash<br>$ set A<b=
r>$ echo $1<br>A<br>$ set --<br>$ echo $1=C2=A0<br><br></div><div>$</div><d=
iv><br></div><div>Regards,</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0initbuild_in_builddir =3D os.path.join(bu=
ilddir, &#39;init-build-env&#39;)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(initbuild_in_builddir, &#39;w&#=
39;) as f:<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18487): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18487" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18487</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116465767/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116465767/4316185</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_=
blank">yoann.congal@smile.fr</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>

--0000000000004ecca206446688ea--

