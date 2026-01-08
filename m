Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB8D185CC
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 11:28:51 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4459.1767871729738917157
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 03:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=E1vkkpJx;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso25319885e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 03:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767871728; x=1768476528; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXcg+3R74OZJBXFCa0WQUAimoSJnygg20VVFF+vcYK4=;
        b=E1vkkpJx/Abi9Fk+yaCINexoJe/PQuENgK580QKrmmwo0iyJEVWMywN+iNsvnm4eZt
         QQvmDqUtMiQOlTXx3Ha021gpeUdVxhQpym0wI5+wbVqF7HRShVwP6ua3wqgkWwJycSdy
         ZZtTjtELj2zzLbrHsHFjd+PPcIkNvdNvP0P9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767871728; x=1768476528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXcg+3R74OZJBXFCa0WQUAimoSJnygg20VVFF+vcYK4=;
        b=xKiKba5U2PGBALVc9kgw+ag5rIBPQvpLsE2QJoDxkIg6DU17a6bucoMKSuIKw8FuuV
         5V//M6/wZYkAJVIoh6ahb6YRWOMZT1I37YbLFHTKcsBQcuv8INasykAga4vkaQ/Rt/S4
         ukyaDVxvapz//tYeujXAoDCkurhJvqnKArl0gjndSTr3FIMW8D18DviIcPAEfNBZl5ug
         qgdrOgxxxvmNlsMDHdZGSHyG0hXyixiulKeVy7RcapRJQK491TE4e6xnZ/qImQTxfzyq
         nEZNFnhiXIB09sRqCMdzElbl5S08IGR35B/BSo72xbjVDQTb/6KXPJQSJMbK7EDq8NmG
         oz+A==
X-Gm-Message-State: AOJu0YxPmdzvkGXrvYfDwrf+uwYQ0E3Y1W8mBGOjGbKPzmM0ZPBsJYq3
	xN+IMXplWms/aXbR4NHpZPBfwjYYSVJabHxIw1t6qcUMgClASZvX5gJtSqr/r6XCeC5PFltDzS8
	AZFRWZBo5XJyuWkl6SANxbkrzQsko69wtSkRX4VnH+w==
X-Gm-Gg: AY/fxX78g/4frloXKQfVlgTQonY101N7ZEaEpCZyEPoC6XDoapWb4Ex5tA27IRJFvL2
	4Ilk3JLZc1azjXzjSOYObLhnh9koo+V8g24lQlGlEqM7/xx90IkvEDqFl0wlFumTyNrP2mPZaGY
	yvCnv92N7HOLj+jtOUITb7Opr62Z4U4gDhSjfXWkHrgUmCUMePIQ9KnR6hCK+2AdeOFWbK9YnwP
	NMkzZJzJk6wtQSCoSNDWmtKbF5vSIbnd6Vk6Uztes/MNoLwDk4kOP7KBDXl6bSha/LWOjwySwNw
	VOB/gHnCEmZm0JWWxbq4K6zdnwUw
X-Google-Smtp-Source: AGHT+IEQbg3UJgpumvCl3H6Z3LTzJmKGVpkwfDoR89383zvueTmwm386RrBEBfZdIxxpQ4l7eBQDRw2ZYKOcmDJffUA=
X-Received: by 2002:a05:600c:8706:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-47d84b407e4mr68811065e9.36.1767871728114; Thu, 08 Jan 2026
 03:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20251219-update-releases-rst-v1-1-39fa5d19cb58@bootlin.com>
In-Reply-To: <20251219-update-releases-rst-v1-1-39fa5d19cb58@bootlin.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 8 Jan 2026 12:28:22 +0100
X-Gm-Features: AQt7F2oVhQcHryhdo3gIuEhNF1ohTYEDw060gTIkkbQN_gRaFzPH7Vc6qRAm1vQ
Message-ID: <CAMSfU+6OuTd2Gbk2D7q5SJhDohB9SbguYb10ckeQV6xtfLuPwg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc/releases.rst: add whinlatter, move
 walnascar to EOL
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000005cee9b0647deb605"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 11:28:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18706

--0000000000005cee9b0647deb605
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Le ven. 19 d=C3=A9c. 2025 =C3=A0 14:19, Antonin Godard via lists.openembedd=
ed.org
<antonin.godard=3Dbootlin.com@lists.openembedded.org> a =C3=A9crit :

> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  doc/releases.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/doc/releases.rst b/doc/releases.rst
> index 676db66ec5..ed96650b7c 100644
> --- a/doc/releases.rst
> +++ b/doc/releases.rst
> @@ -4,11 +4,11 @@
>  BitBake Supported Release Manuals
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -******************************
> -Release Series 5.2 (walnascar)
> -******************************
> +*******************************
> +Release Series 5.3 (whinlatter)
> +*******************************
>
> -- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
> +- :yocto_docs:`BitBake 2.14 User Manual </bitbake/2.14/>`
>

The correct bitbake version for whinlatter is 2.16 (not 2.14). See
https://wiki.yoctoproject.org/wiki/Releases.
Something happened and prevented the usual X.Y+2 jump, hence the X.Y+4 jump=
.

 *******************************
>  Release Series 5.0 (scarthgap)
> @@ -26,6 +26,12 @@ Release Series 4.0 (kirkstone)
>  BitBake Outdated Release Manuals
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> +******************************
> +Release Series 5.2 (walnascar)
> +******************************
> +
> +- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
> +
>  ****************************
>  Release Series 5.1 (styhead)
>  ****************************
>
> ---
> base-commit: 6e511d035a3d1e4129dab7b0dfbf216bd8e99b47
> change-id: 20251219-update-releases-rst-433a08815494
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18621):
> https://lists.openembedded.org/g/bitbake-devel/message/18621
> Mute This Topic: https://lists.openembedded.org/mt/116858773/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--0000000000005cee9b0647deb605
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0ven. 19 d=C3=A9c.=
 2025 =C3=A0=C2=A014:19, Antonin Godard via <a href=3D"http://lists.openemb=
edded.org">lists.openembedded.org</a> &lt;antonin.godard=3D<a href=3D"mailt=
o:bootlin.com@lists.openembedded.org">bootlin.com@lists.openembedded.org</a=
>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Antonin Godard &lt;<a href=3D"mailto:antonin.goda=
rd@bootlin.com" target=3D"_blank">antonin.godard@bootlin.com</a>&gt;<br>
---<br>
=C2=A0doc/releases.rst | 14 ++++++++++----<br>
=C2=A01 file changed, 10 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/doc/releases.rst b/doc/releases.rst<br>
index 676db66ec5..ed96650b7c 100644<br>
--- a/doc/releases.rst<br>
+++ b/doc/releases.rst<br>
@@ -4,11 +4,11 @@<br>
=C2=A0BitBake Supported Release Manuals<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
-******************************<br>
-Release Series 5.2 (walnascar)<br>
-******************************<br>
+*******************************<br>
+Release Series 5.3 (whinlatter)<br>
+*******************************<br>
<br>
-- :yocto_docs:`BitBake 2.12 User Manual &lt;/bitbake/2.12/&gt;`<br>
+- :yocto_docs:`BitBake 2.14 User Manual &lt;/bitbake/2.14/&gt;`<br></block=
quote><div><br></div><div>The correct bitbake version for whinlatter is 2.1=
6 (not 2.14). See <a href=3D"https://wiki.yoctoproject.org/wiki/Releases">h=
ttps://wiki.yoctoproject.org/wiki/Releases</a>.</div><div>Something happene=
d and prevented the usual X.Y+2 jump, hence the X.Y+4 jump.</div><div><br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0*******************************<br>
=C2=A0Release Series 5.0 (scarthgap)<br>
@@ -26,6 +26,12 @@ Release Series 4.0 (kirkstone)<br>
=C2=A0BitBake Outdated Release Manuals<br>
=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
+******************************<br>
+Release Series 5.2 (walnascar)<br>
+******************************<br>
+<br>
+- :yocto_docs:`BitBake 2.12 User Manual &lt;/bitbake/2.12/&gt;`<br>
+<br>
=C2=A0****************************<br>
=C2=A0Release Series 5.1 (styhead)<br>
=C2=A0****************************<br>
<br>
---<br>
base-commit: 6e511d035a3d1e4129dab7b0dfbf216bd8e99b47<br>
change-id: 20251219-update-releases-rst-433a08815494<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18621): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18621" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18621</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116858773/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116858773/4316185</a><br>
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

--0000000000005cee9b0647deb605--

