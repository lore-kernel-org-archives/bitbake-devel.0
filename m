Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B547AC2A09A
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 11:25:40 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62028.1767612332099412468
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Jan 2026 03:25:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=krVZqXGc;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so159477956d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 Jan 2026 03:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612331; x=1768217131; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10R0qCAaB9kry6Fqxif06v8gJi2i5tyqiz9NjJfzJuM=;
        b=krVZqXGc83mcgYzXK38S5In8zid4KoNe4zOge6iXz/0VHcwi7JkUv8IuLY9z/AxxfN
         AqzNwg4DFvC7Ps9GWPRoqWrwZ0SSuaXLIufHqqw/i6ajBQZPdssWHCrc1IlwCP5UHZ3J
         nzYsMExtfBGuW9UwTeADJ/PzInejjX2CAAZZCi/HHR92coAOGi7MUBYHAEhWnuKhaLMr
         Usu8+DCy2VrHHHQDAhTJNxTQu9XMRSrdiDkQfsNYu/88umG3XrgwUyAAIoud+8nYgGA+
         uCqsqWsxN36H/cU/g9qiyIulfiWQD9j2DX0GrI9zouDCAjhkCzkvqKwk0rkOZpIThhqn
         uamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612331; x=1768217131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10R0qCAaB9kry6Fqxif06v8gJi2i5tyqiz9NjJfzJuM=;
        b=nmDvs6NieSipd7T+7SdFlpgqkPnvc5Qa8vnqvD5iCIllciTgv0yPYJWxUYvUW0g/6m
         BjBVM3UnozTVjUkkW7C9i8LRowsIXX4g7+/HGwc9b2qVHchRWJV1KYLEhk87wxhpuYA3
         lSh0NTjRUPkjrnsCzwPubIaKjDNI2eA17M8gg9xMPBjJRYamePID2zGpLzyE2y6NqW9o
         uZ+IUyMBg1EUYnJ9M514+6uNlGYTp53mKP4Ak8WNsbzD+uJtBXxO/3Dw+xWUt28sDAdi
         M6dwJE36v6GQ6fZgPQW0XrmAaoXP8p4cYd0BthOWjMFAHAXRToU3tYOFnx0FGIIM5Plg
         phNw==
X-Gm-Message-State: AOJu0YwqOCrtuaGhtiETJ4rhmmvJqDnUglkl1+M+5ntXjKFZg4vcMq/r
	FemQ9pIwkLE8YSGkz/Lwp4SLTey64zHfj2QIR7zCozO1PMhj1shW7x23695wMkn0DPI69tOdhFN
	n0fdXXY4HX07WKJ5FUnlCVoV1fwHt/26MBA==
X-Gm-Gg: AY/fxX5w+hYXmuubMbiCAyarwAQ2WIYsXUsFE1gBl2DncerI1vjIGFo5Qms2mKlsCcS
	3TeckiX/hVp66I2TJ5HCb74V4tVShP4q5nS0j+SezspIKZkrepJqUjPjfQ88nnLvm10e/GGTVVW
	jzFPnUAMEzejnyo/EB3z/wxtDu0WnNT4eUzK/g+1zLS7cM2NoaPAtYfo6F79xAJstxSUtzXA7oo
	JTdcu1CSzY7UEn9QyeSWfRZtkRbpiuUCz0BzX7fEDWY6cGSsI0d21eU92rKj2GPbq7UJQ==
X-Google-Smtp-Source: AGHT+IEOltQewgzU8tcir3WFOlpxwBXzUlP9yG6v6pZK4k3XzNQK1uDk7toVs9TDq3sDRLL1Oj62dlDLD4h9Qt5n4FU=
X-Received: by 2002:ad4:45a2:0:b0:880:4dd2:1d15 with SMTP id
 6a1803df08f44-88d84536730mr558555106d6.44.1767612330978; Mon, 05 Jan 2026
 03:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20251230235724epcms1p84d784e88ac7f220b8e1e5a6ee09e83a9@epcms1p8>
 <CANNYZj_8kRAM0rFdtFyXbfR=NWhBE7RnwRObWesT945tNW_RMg@mail.gmail.com>
 <20251231152535epcms1p259b6e8d7eb72f7c1416edeffdb3b57e4@epcms1p2>
 <CGME20251230234958epcms1p5f6e7ba1c00c63d05a1b71fcdbcb7a18a@epcms1p2>
 <CANNYZj80xgLiqcTrxicomF11pwtmA3VSKErYTX4WRNvw_D35yw@mail.gmail.com> <20260105014323epcms1p200e14e48c6e5c7025d3538e064e68622@epcms1p2>
In-Reply-To: <20260105014323epcms1p200e14e48c6e5c7025d3538e064e68622@epcms1p2>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 5 Jan 2026 12:25:20 +0100
X-Gm-Features: AQt7F2oYczbijEneYF3Bq26CVi6js9WuK4CGJjof1SY3JFGpB4ttcr-kuYy63gI
Message-ID: <CANNYZj9xF0kbrdpO06VXsAqoaAe6dDiZUf7GJR3Wt8TY0+oLjA@mail.gmail.com>
Subject: Re: (2) (2) [bitbake-devel] [PATCH] Enhance shell_trap_code to
 support custom shebang
To: sangmin5.lee@samsung.com
Cc: "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000016b3b70647a251d4"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Jan 2026 11:25:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18687

--00000000000016b3b70647a251d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 5 Jan 2026 at 02:43, =EC=9D=B4=EC=83=81=EB=AF=BC <sangmin5.lee@sams=
ung.com> wrote:

> Thank you for your response.
>
> I also agree that changing the global setting is not good idea, because i=
t
> will affect all shell tasks and make different build results.
>
>
> Currently, our partner company is modifying the global setting in
> hack-like way. We are looking for better approach.
>
> Our situation is difficult: partner code is keep modifying, and every tim=
e
> we receive new code, it is hard for us to modify it by ourselves. To
> refactor each recipe one by one is not possible for us.
>
> What we need is clear way that we can recommend to our partners, instead
> of current hack. If there is way to configure bash usage at layer level
> (like in local.conf) or recipe directory level, that would be good for us=
.
>
> This way we can limit bash requirement only to layers or recipes that nee=
d
> it, and we can suggest this to our partners.
>
> Could you please tell us if such mechanism exists, or if there are other
> ways we should think about?
>

I would suggest this: rather than come up with a 'technical' way to handle
this, have a clear definition of acceptance criteria for the code your
partners deliver. Yocto has always supported only POSIX shell, and any
bashisms in recipes are treated as a bug to be fixed, with
scripts/verify-bashisms to help.

Acceptance criteria could state something like: the layer must build
without errors on both Debian and Fedora, against unmodified upstream
bitbake/oe-core.

One problem with mandating bash at the layer or recipe or task level is:
how would it work with .bbappends that contain do_install:append()? The
recipe that defines do_install() is in one layer, bbappend is in another
layer. If the first layer prescribes sh, and the one with .bbappend
prescribes bash, then bitbake should choose sh. And if bbapend has
bash-isms, then it will still break.

Alex

>

--00000000000016b3b70647a251d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, 5 Jan 2026 at 02:43, =EC=9D=B4=EC=83=
=81=EB=AF=BC &lt;<a href=3D"mailto:sangmin5.lee@samsung.com">sangmin5.lee@s=
amsung.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div class=3D"msg8086403962212643174"><u></u>





<div><p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fra=
ctions,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common=
-ligatures;font-weight:400;text-align:left;background-color:rgb(255,255,255=
)">Thank you for your response.=C2=A0</span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">I =
also agree that changing the global setting is not good idea, because it wi=
ll affect all shell tasks and make different</span><span style=3D"color:rgb=
(29,28,29);font-family:Slack-Lato,Slack-Fractions,appleLogo,sans-serif;font=
-size:11.25pt;font-variant-ligatures:common-ligatures;font-weight:400;text-=
align:left;background-color:rgb(255,255,255)">=C2=A0</span><span style=3D"b=
ackground-color:rgba(255,198,0,0.18);color:rgb(29,28,29);font-family:Slack-=
Lato,Slack-Fractions,appleLogo,sans-serif;font-size:11.25pt;font-variant-li=
gatures:common-ligatures;font-weight:400;text-align:left">build</span><span=
 style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fractions,appleL=
ogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-ligatures;fo=
nt-weight:400;text-align:left;background-color:rgb(255,255,255)">=C2=A0</sp=
an><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">re=
sults.</span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)"><b=
r></span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">Cu=
rrently, our partner company is modifying the global setting in hack-like w=
ay. We are looking for better approach.=C2=A0</span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">Ou=
r situation is difficult: partner code is keep modifying, and every time we=
 receive new code, it is hard for us to modify it by ourselves.=C2=A0</span=
><span style=3D"background-color:rgb(255,255,255);color:rgb(29,28,29);font-=
family:Slack-Lato,Slack-Fractions,appleLogo,sans-serif;font-size:11.25pt;fo=
nt-variant-ligatures:common-ligatures">To refactor each recipe one by one i=
s not possible for us.</span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">Wh=
at we need is clear way that we can recommend to our partners, instead of c=
urrent hack. If there is way to configure bash usage at layer level (like i=
n local.conf) or recipe directory level, that would be good for us.=C2=A0</=
span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">Th=
is way we can limit bash requirement only to layers or recipes that need it=
, and we can suggest this to our partners.</span></p>
<p><span style=3D"color:rgb(29,28,29);font-family:Slack-Lato,Slack-Fraction=
s,appleLogo,sans-serif;font-size:11.25pt;font-variant-ligatures:common-liga=
tures;font-weight:400;text-align:left;background-color:rgb(255,255,255)">Co=
uld you please tell us if such mechanism exists, or if there are other ways=
 we should think about?</span></p></div></div></blockquote><div><br></div><=
div>I would suggest this: rather than come up with a &#39;technical&#39; wa=
y to handle this, have a clear definition of acceptance criteria for the co=
de your partners deliver. Yocto has always supported only POSIX shell, and =
any bashisms in recipes are treated as a bug to be fixed, with scripts/veri=
fy-bashisms to help.</div><div><br></div><div>Acceptance criteria could sta=
te something like: the layer must build without errors on both Debian and F=
edora, against unmodified upstream bitbake/oe-core.</div><div><br></div><di=
v>One problem with mandating bash at the layer or recipe or task level is: =
how would it work with .bbappends that contain do_install:append()? The rec=
ipe that defines do_install() is in one layer, bbappend is in another layer=
. If the first layer prescribes sh, and the one with .bbappend prescribes b=
ash, then bitbake should choose sh. And if bbapend has bash-isms, then it w=
ill still break.<br></div><div><br></div><div>Alex<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div class=3D"msg8086403962212643174">
<table style=3D"display:none"><tbody><tr><td><img style=3D"display: none;" =
border=3D"0" src=3D"http://ext.samsung.net/mail/ext/v1/external/status/upda=
te?userid=3Dsangmin5.lee&amp;do=3DbWFpbElEPTIwMjYwMTA1MDE0MzIzZXBjbXMxcDIwM=
GUxNGU0OGM2ZTVjNzAyNWQzNTM4ZTA2NGU2ODYyMiZyZWNpcGllbnRBZGRyZXNzPWFsZXgua2Fu=
YXZpbkBnbWFpbC5jb20_" width=3D"0" height=3D"0"></td></tr></tbody></table></=
div></blockquote></div></div>

--00000000000016b3b70647a251d4--

