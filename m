Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C79C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 09:13:36 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
 by mx.groups.io with SMTP id smtpd.web10.17997.1702545213552231009
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 01:13:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bLoUWNKO;
 spf=pass (domain: gmail.com, ip: 209.85.222.50, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7cafdcaf187so1322036241.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702545212; x=1703150012; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ItoGwsjM5zN8z9cM+NdRXCgEw5keIhnxG0w2QJ/hebE=;
        b=bLoUWNKOUu5Ti9LYrGPA5IzT1i5xf9a6sK8jsiZa20vbXvKK/1twFx8AKxXGwdXAGh
         iOaJch58rQm6oR6fp9VovyR8PFp6khNHYCZrfTsiS7Hoj/kExNcFQsUwc98/U9Oj1ghv
         esXuoTt38qIGIGYm4GraTkiTeqnIBzXarCQNyrrL2zXdLsiJuMbtfW1O57g5Kyr11SPc
         8CK3prS//IP3WSdlgY9xpt645Tf44tUeIbB7MnzJx63nxAEGeHbcWQj2YgbnBh8z7J/i
         +eH2bxMBXsv4V4d6EcXO6Unai1aXIyyfiI0UOKjZ8yju/1aHYjEhYGrzo8ga2tM+GMww
         /XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545212; x=1703150012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItoGwsjM5zN8z9cM+NdRXCgEw5keIhnxG0w2QJ/hebE=;
        b=IOtZOW6h8fFrb6A0kubCqlwR0H5ykYoB2RNJStm6zoyFbifYPodVPxFOvaE57Sk7sc
         Spb+H2onoovM49ZFiS4LFdFOQV0PFH/XmcZouHYX0mm/JJiGyk51yIjT6FcV58Psw6W7
         kIIUYKp6cX9yoHIuylxvVKpF6+StJ88b725WE4LpAI7fp0EHmNfcfnYjeb32fOEyfDDh
         lGUmWBzmlfZSVmxfilIuYaA3icFtvX6COED9hO6kvklpc6MwbIv0L/RyP6vcSMNzgJSO
         3/hygIBPZl8FjJKI7aGk3A7ML20qIBwuXFBOQe9MVlkDh94OYULf4F+aJkrzFmbyqIKe
         qQ6Q==
X-Gm-Message-State: AOJu0YxYncQS51iMsheAl5snYkv0O7JCLHHZi95fKjam+w8sBHvb2SKT
	qNJMYcKnow6yihhtuT5D4W9a9LtTDXEPuTAYkYo=
X-Google-Smtp-Source: AGHT+IE7TeV/wAxprhjMlWJXI3ckR4s0+D/gWk2J5OFADSiNpLVsW0PtnDp70U/Yjv76kE7yyVVTqlbPWOsQn1g1zk0=
X-Received: by 2002:a05:6102:38cc:b0:464:827f:75aa with SMTP id
 k12-20020a05610238cc00b00464827f75aamr7432414vst.18.1702545212174; Thu, 14
 Dec 2023 01:13:32 -0800 (PST)
MIME-Version: 1.0
References: <17A012684A72999E.8967@lists.openembedded.org>
In-Reply-To: <17A012684A72999E.8967@lists.openembedded.org>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 14 Dec 2023 09:13:21 +0000
Message-ID: <CANPvuRntahuGpsSVeFXRWSfna2o=hVuqZ2my_iUrAKeu+sAXLw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake.conf remove duplicate PERSISTENT_DIR
To: quaresma.jose@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Jose Quaresma <jose.quaresma@foundries.io>
Content-Type: multipart/alternative; boundary="00000000000095f941060c74b27d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 09:13:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15666

--00000000000095f941060c74b27d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch was merged in bitbake master:

f88f314c toaster: Commandline build import table improvements
-> 13cbc987 bitbake.conf remove duplicate PERSISTENT_DIR
da7f91d6 bitbake: toaster: add functional testing toaster error details

but I can't see it on poky master:

524255ad26 bitbake: toaster: Commandline build import table improvements
dc608a5bbe bitbake: bitbake: toaster: add functional testing toaster error
details
799c131d92 bitbake: toaster: remove test and update setup to avoid
rebuilding image

Is there a bug somewhere?

Jose

Jose Quaresma via lists.openembedded.org <quaresma.jose=3D
gmail.com@lists.openembedded.org> escreveu no dia ter=C3=A7a, 12/12/2023 =
=C3=A0(s)
11:34:

> Signed-off-by: Jose Quaresma <jose.quaresma@foundries.io>
> ---
>  conf/bitbake.conf | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/conf/bitbake.conf b/conf/bitbake.conf
> index baf0a76f..2c1d8be2 100644
> --- a/conf/bitbake.conf
> +++ b/conf/bitbake.conf
> @@ -42,5 +42,4 @@ T =3D "${WORKDIR}/temp"
>  TARGET_ARCH =3D "${BUILD_ARCH}"
>  TMPDIR =3D "${TOPDIR}/tmp"
>  WORKDIR =3D "${TMPDIR}/work/${PF}"
> -PERSISTENT_DIR =3D "${TMPDIR}/cache"
>  GITPKGV =3D "${@bb.fetch2.get_srcrev(d, 'gitpkgv_revision')}"
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15650):
> https://lists.openembedded.org/g/bitbake-devel/message/15650
> Mute This Topic: https://lists.openembedded.org/mt/103127894/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000095f941060c74b27d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>This patch was merged in bitba=
ke master:<br><br>f88f314c toaster: Commandline build import table improvem=
ents<br>-&gt; 13cbc987 bitbake.conf remove duplicate PERSISTENT_DIR<br>da7f=
91d6 bitbake: toaster: add functional testing toaster error details<br><br>=
but I can&#39;t see it on poky master:<br><br>524255ad26 bitbake: toaster: =
Commandline build import table improvements<br>dc608a5bbe bitbake: bitbake:=
 toaster: add functional testing toaster error details<br>799c131d92 bitbak=
e: toaster: remove test and update setup to avoid rebuilding image<br><br>I=
s there a bug somewhere?<br><span style=3D"font-family:monospace">
<br></span></div>Jose<br><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">Jose Quaresma via <a href=3D"http://lists.openembedded.o=
rg">lists.openembedded.org</a> &lt;quaresma.jose=3D<a href=3D"mailto:gmail.=
com@lists.openembedded.org">gmail.com@lists.openembedded.org</a>&gt; escrev=
eu no dia ter=C3=A7a, 12/12/2023 =C3=A0(s) 11:34:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Signed-off-by: Jose Quaresma &lt;<a href=
=3D"mailto:jose.quaresma@foundries.io" target=3D"_blank">jose.quaresma@foun=
dries.io</a>&gt;<br>
---<br>
=C2=A0conf/bitbake.conf | 1 -<br>
=C2=A01 file changed, 1 deletion(-)<br>
<br>
diff --git a/conf/bitbake.conf b/conf/bitbake.conf<br>
index baf0a76f..2c1d8be2 100644<br>
--- a/conf/bitbake.conf<br>
+++ b/conf/bitbake.conf<br>
@@ -42,5 +42,4 @@ T =3D &quot;${WORKDIR}/temp&quot;<br>
=C2=A0TARGET_ARCH =3D &quot;${BUILD_ARCH}&quot;<br>
=C2=A0TMPDIR =3D &quot;${TOPDIR}/tmp&quot;<br>
=C2=A0WORKDIR =3D &quot;${TMPDIR}/work/${PF}&quot;<br>
-PERSISTENT_DIR =3D &quot;${TMPDIR}/cache&quot;<br>
=C2=A0GITPKGV =3D &quot;${@bb.fetch2.get_srcrev(d, &#39;gitpkgv_revision&#3=
9;)}&quot;<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15650): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15650" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15650</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/103127894/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/103127894/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--00000000000095f941060c74b27d--

