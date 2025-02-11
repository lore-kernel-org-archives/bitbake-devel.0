Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB0EC0219B
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 10:08:09 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.8750.1739268478678213591
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 02:07:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=VdeG2Mgb;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so15088965e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 02:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1739268477; x=1739873277; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m66GQr9wCIlru9HfBtNfHBzgiQ81SNcr8obRg/hxPPQ=;
        b=VdeG2MgbNdR5wYKMmeyFc6+jpmeJ1+MU1EU6bzz/5fJ+9NIbXLi/bI9E2lbn+uJ7ct
         4LULo+HzWRPxRW7K0NS0z6R/9BvIh17nAPUxzy5neUCW1/Nl/AevnQOiMJrrmdu3QsiB
         hwUL6mD5v0zogihS+XLqAdaHdpbfRTI7+xzb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739268477; x=1739873277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m66GQr9wCIlru9HfBtNfHBzgiQ81SNcr8obRg/hxPPQ=;
        b=ODZKeZ6NZpYWVcSdpGsJGAkQXlNyDVj+XWgyZJ1k/8XcVm+Y7/ODa+kGN61CROY3BN
         cHmYeEEgCVjTWXWkMcGK8BRpq+3d1V2O0YC8PETy0cVq9ifzjhzuoLmVVkk/OJAgexfh
         NwMeQGifaRkiAjxAR1GwFn95Vcsx4Yt7dHvcygjEFn6soGGS/EKqeZSstoWs43qFtBi5
         CgJhY3gkqeUuvNwF2NR0FToGu7InzqC2TTj6MYmwj4RsL3rRaGUnylJPwy2ZRw4zPH0r
         O9FgB2rTxg39w2m+BYkot8mHLz9v7mpWlDLJ82kusB3Y5qFgwUJbWawoGU8XQBQ6K2yQ
         HFiQ==
X-Gm-Message-State: AOJu0Yyqs6mbL+XsH6Y6Gd4pu+kvxf94sueAHiyHllsgv8/uyRfEdKYu
	IFAUbD+ho9iy5YaSNLKsGfMgOFvaSIdtEghT4DoqrVXSP7q0MZfgAr9mbbTogz8zF5CHPitso1o
	iZ+X4Bi7l+q0ujSnh19QyfokdFDBNl0QHUIHhKw==
X-Gm-Gg: ASbGncs8/JXvvjgeEouoLkJipjNlyAjLPVh3MS7knA7dcUB2iUHnRc8svuVZJZXbPxC
	/TrLTnIdPQ0oc3uSkkmVpIeCK40Ltu/dhUvAr9yWvECWdQrATeW94gqRsmu+qmFnlHTmqeXbW
X-Google-Smtp-Source: AGHT+IFJrWLpdvya+LFckrDoAgG5pMKuxApinCv/+/+zBBUt6MGR0HLYH1L3lASBg8p+oUxfwBYzSr4pUexvRzvg7sc=
X-Received: by 2002:a5d:64c4:0:b0:38d:dcc4:1dcb with SMTP id
 ffacd0b85a97d-38de416d704mr2740992f8f.2.1739268476782; Tue, 11 Feb 2025
 02:07:56 -0800 (PST)
MIME-Version: 1.0
References: <c0723d2e-7742-4746-bc78-b0aee82fb8ed@syslinbit.com>
In-Reply-To: <c0723d2e-7742-4746-bc78-b0aee82fb8ed@syslinbit.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 11 Feb 2025 11:07:30 +0100
X-Gm-Features: AWEUYZnz2d3HtEcvtpx4POSbqL9WqsVSAQxs3ioAjaNaf5Qnp1KrsKGQnrZIzrI
Message-ID: <CAMSfU+4cpu9nqUuAS18+1MTBpOnJPd52Yt1jK3XKH66ywJ09+Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [scarthgap] backport request for ??= operator for
 variable flags fix
To: louis.rannou@syslinbit.com
Cc: bitbake-devel@lists.openembedded.org, Steve Sakoman <steve@sakoman.com>, 
	pascal.eberhard@se.com, Louis Rannou <louis.rannou@non.se.com>
Content-Type: multipart/alternative; boundary="000000000000ba5e7d062ddafff4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 10:08:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17189

--000000000000ba5e7d062ddafff4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Le mar. 11 f=C3=A9vr. 2025 =C3=A0 10:31, Louis Rannou via lists.openembedde=
d.org
<louis.rannou=3Dsyslinbit.com@lists.openembedded.org> a =C3=A9crit :

> Hello,
>
> May we apply the commit following commit to scarthgap as the issue also
> exist:
>
> commit 0329a7e3ac694737f2d2c1861f65492551360663
> Author: Yoann Congal <yoann.congal@smile.fr>
> Date:   Sat Jan 11 15:13:51 2025 +0100
>
>      data_smart: fix ??=3D operator for variable flags
>
> I suppose the other commit that came along for tests is also fine:
>
> commit e3536b3c67ad1a4195fcbd5485d2dc8308014fff (HEAD -> 2.8)
> Author: Yoann Congal <yoann.congal@smile.fr>
> Date:   Sat Jan 11 15:13:50 2025 +0100
>
>      tests/parse: add test for ?=3D and ??=3D operators for variable flag=
s
>
> Here is the path link for details
>
> https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.cong=
al@smile.fr/#t
>
> Thanks,
> Louis Rannou
>

To clarify, you target the "2.8" bitbake branch (the one Scarthgap poky
uses)
I could not find the doc for this but we usually have "[2.8]" in mail title
for bitbake backport requests (for example:
https://lists.openembedded.org/g/bitbake-devel/message/16872)

You may also want to state explicitly that this is related to the bug
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685

Thanks (always nice to see my patches getting used :) )!
--=20
Yoann Congal
Smile ECS - Tech expert

--000000000000ba5e7d062ddafff4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello,</div></div><br><div class=3D"=
gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=
=C2=A0mar. 11 f=C3=A9vr. 2025 =C3=A0=C2=A010:31, Louis Rannou via <a href=
=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;louis.ran=
nou=3D<a href=3D"mailto:syslinbit.com@lists.openembedded.org">syslinbit.com=
@lists.openembedded.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
May we apply the commit following commit to scarthgap as the issue also <br=
>
exist:<br>
<br>
commit 0329a7e3ac694737f2d2c1861f65492551360663<br>
Author: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D=
"_blank">yoann.congal@smile.fr</a>&gt;<br>
Date:=C2=A0 =C2=A0Sat Jan 11 15:13:51 2025 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0data_smart: fix ??=3D operator for variable flags<br>
<br>
I suppose the other commit that came along for tests is also fine:<br>
<br>
commit e3536b3c67ad1a4195fcbd5485d2dc8308014fff (HEAD -&gt; 2.8)<br>
Author: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr" target=3D=
"_blank">yoann.congal@smile.fr</a>&gt;<br>
Date:=C2=A0 =C2=A0Sat Jan 11 15:13:50 2025 +0100<br>
<br>
=C2=A0 =C2=A0 =C2=A0tests/parse: add test for ?=3D and ??=3D operators for =
variable flags<br>
<br>
Here is the path link for details <br>
<a href=3D"https://lore.kernel.org/bitbake-devel/20250111141351.3993834-1-y=
oann.congal@smile.fr/#t" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/bitbake-devel/20250111141351.3993834-1-yoann.congal@smile.fr/#t<=
/a><br>
<br>
Thanks,<br>
Louis Rannou<br></blockquote><div><br></div><div>To clarify, you target the=
 &quot;2.8&quot; bitbake branch (the one Scarthgap poky uses)</div><div>I c=
ould not find the doc for this but we usually have &quot;[2.8]&quot; in mai=
l title for bitbake backport requests (for example: <a href=3D"https://list=
s.openembedded.org/g/bitbake-devel/message/16872">https://lists.openembedde=
d.org/g/bitbake-devel/message/16872</a>)</div><div><br></div><div>You may a=
lso want to state explicitly that this is related to the bug <a href=3D"htt=
ps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D15685">https://bugzilla.yo=
ctoproject.org/show_bug.cgi?id=3D15685</a></div><div><br></div><div>Thanks =
(always nice to see my patches getting used :) )!<br></div></div><span clas=
s=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</f=
ont><div><font face=3D"Raleway, regular">Smile ECS - Tech expert<br></font>=
</div></div></div></div>

--000000000000ba5e7d062ddafff4--

