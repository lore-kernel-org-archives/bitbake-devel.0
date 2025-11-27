Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBDD116F3
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 09:11:15 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14804.1764234670709844250
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 01:11:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jY9ReffP;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42bb288c17bso383110f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1764234669; x=1764839469; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qEnVDAMYNDlIYJbdevEumLXZgeNVg+XQFxWZVKBCLyA=;
        b=jY9ReffPHtxcKp1Q8wgbbkaT0y2cLuB+P2nScD0Yx0d4tE4jr8X18Y74PQ1Sjiiv2c
         n2Ylbn3vbuaDC8MA06iWveBWaiGzjl5wHjg7Gfl7eGf5cQm8XC2LiDQeNfRIKRyIjz0J
         KcVm47XZqTZZ9CtbeId6U50fdQl5cOBqyi6FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234669; x=1764839469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEnVDAMYNDlIYJbdevEumLXZgeNVg+XQFxWZVKBCLyA=;
        b=nJNiQX+1PuJPC9EE21pQ0tKk/dibFJnooVGDXCIhh0AkXw2gAg6ZDxwfegTRrh9EeP
         9sCa9KzdT5oW8dN0jEQQFlE7ctgq6bB9PHAKJcCHQnVJ4Vmf3YfZMO21dlcffIvCO1N5
         9FngXEA14eBjQsOj9SHWzzpFm8wLiTSVQXga98lBLXz2eS9HHfgZhcK6hDvmE2pPLmOC
         2DKlEvt0FVGMMAOW28ZRWXUqTVLZ5rSDhHpzh1rd5NumehkfhsTf+abdKD1nsJY/4PZO
         LHLxxrP4ACaEOaf+rUW4KhBMMQd3C+mdzUJu4AeCJy6UEcdteu48OquDW/cWj/7CF/OQ
         f4iA==
X-Gm-Message-State: AOJu0YxYVwDgt8p7uRwKWw2GPYoSj1hpynM1857rojRzk+4ft71dIPsY
	0F38Hu3nDURenxTIq143kBzskKEmCYHoq83IYHRYsgtVB1UOI/op3PyMMQju3oa7/R/utMs9MJd
	e/stBtdFDC7GVvzhmdQExlsbJ0FCHdDQIzyn7zwjF5A==
X-Gm-Gg: ASbGncuwzSXssbrgFvBILXXD8agj95rrYawwNPXt2gWpTcXydJYv69ARo1+MNzYutsy
	nfGf9dSzrJpfcD6u6Fehr7Ci7qsC0WD11aBMYa4AWD/PR7XuGzwqVTYV5Y5LAMZWVomtu+zBztG
	PH3BKTZE3pvNPlLXiIGUTzOlMERj8oRbRtbOXFvXKFuXbCb2UMSwf6JDuy3zYnTpmISK0p8NLh1
	K62gnoiTcocNDP6YFqcHgNwFu/pheYzt3yn7Q0i+WuL4uLoU3Y0uSjseQGfue6kJL0k5a0YxKcB
	WKbkSDAmioSDHWDR3M9MtyB8eVySvrkt3vL7/Zo=
X-Google-Smtp-Source: AGHT+IHwE7X/6CVa5rH8/8qR4HVXqOa9p14heVLH5FnM+xIp2cI923rEVS5PpRzYNA1EvdYS+5ShcgFUw+HeKsBE754=
X-Received: by 2002:a05:6000:1252:b0:42b:47da:c318 with SMTP id
 ffacd0b85a97d-42cc1d19514mr19233152f8f.52.1764234668810; Thu, 27 Nov 2025
 01:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20251127-bbsetup-path-option-v1-1-2d2565eb927c@bootlin.com>
In-Reply-To: <20251127-bbsetup-path-option-v1-1-2d2565eb927c@bootlin.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 27 Nov 2025 10:10:42 +0100
X-Gm-Features: AWmQ_bmscLFxH9c9zoz_Xyb5QvhfglXoHgQYSJqVckCCqJvhj_XFtUm15NQC2Z8
Message-ID: <CAMSfU+5aTymkg9Aws_AQcKhbfU1UpfOx-gSGM-ejK9s68PvNXA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-setup: extend doc of "path" option
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000bc315f06448fe414"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 09:11:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18498

--000000000000bc315f06448fe414
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 nov. 2025 =C3=A0 09:56, Antonin Godard via lists.openembedded.or=
g
<antonin.godard=3Dbootlin.com@lists.openembedded.org> a =C3=A9crit :

> The commit 6727d0852f3f ("bitbake-setup: make "path" optional") changed
> the behavior of this bitbake-setup JSON option. Document it.
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>

Thanks Antonin!


> ---
>  doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 4 ++=
+-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 2b8051bcb4..edbc749ad6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -688,7 +688,9 @@ They contain the following sections:
>     -  ``branch`` (**required**): the Git branch, used to check that the
>        specified ``rev`` is indeed on that branch.
>
> -   -  ``path`` is where the source is extracted.
> +   -  ``path`` (*optional*): where the source is extracted, relative to
> the
> +      ``layers/`` directory of a :term:`Setup`. If unspecified, the name
> of the
> +      source is used.
>
>  -  ``expires`` (*optional*): Expiration date of the configuration. This
> date
>     should be in :wikipedia:`ISO 8601 <ISO_8601>` format
> (``YYYY-MM-DDTHH:MM:SS``).
>
> ---
> base-commit: 6ee4df8ab58e0175b43106d8a6cbac1f6ab8d022
> change-id: 20251127-bbsetup-path-option-ca416ef22fa8
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18497):
> https://lists.openembedded.org/g/bitbake-devel/message/18497
> Mute This Topic: https://lists.openembedded.org/mt/116498233/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Yoann Congal
Smile ECS

--000000000000bc315f06448fe414
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Le=C2=A0jeu. 27 nov. 2025 =C3=A0=C2=A009:=
56, Antonin Godard via <a href=3D"http://lists.openembedded.org">lists.open=
embedded.org</a> &lt;antonin.godard=3D<a href=3D"mailto:bootlin.com@lists.o=
penembedded.org">bootlin.com@lists.openembedded.org</a>&gt; a =C3=A9crit=C2=
=A0:</div><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">The commit 6727d0852f3f (&quot;bitbake-se=
tup: make &quot;path&quot; optional&quot;) changed<br>
the behavior of this bitbake-setup JSON option. Document it.<br>
<br>
Signed-off-by: Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootlin.=
com" target=3D"_blank">antonin.godard@bootlin.com</a>&gt;<br>
</blockquote><div><br></div><div>Thanks Antonin!</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">---<br>
=C2=A0doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 4=
 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst<br>
index 2b8051bcb4..edbc749ad6 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst<br>
@@ -688,7 +688,9 @@ They contain the following sections:<br>
=C2=A0 =C2=A0 -=C2=A0 ``branch`` (**required**): the Git branch, used to ch=
eck that the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0specified ``rev`` is indeed on that branch.<br>
<br>
-=C2=A0 =C2=A0-=C2=A0 ``path`` is where the source is extracted.<br>
+=C2=A0 =C2=A0-=C2=A0 ``path`` (*optional*): where the source is extracted,=
 relative to the<br>
+=C2=A0 =C2=A0 =C2=A0 ``layers/`` directory of a :term:`Setup`. If unspecif=
ied, the name of the<br>
+=C2=A0 =C2=A0 =C2=A0 source is used.<br>
<br>
=C2=A0-=C2=A0 ``expires`` (*optional*): Expiration date of the configuratio=
n. This date<br>
=C2=A0 =C2=A0 should be in :wikipedia:`ISO 8601 &lt;ISO_8601&gt;` format (`=
`YYYY-MM-DDTHH:MM:SS``).<br>
<br>
---<br>
base-commit: 6ee4df8ab58e0175b43106d8a6cbac1f6ab8d022<br>
change-id: 20251127-bbsetup-path-option-ca416ef22fa8<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18497): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18497" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18497</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/116498233/431=
6185" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/116498233/4316185</a><br>
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

--000000000000bc315f06448fe414--

