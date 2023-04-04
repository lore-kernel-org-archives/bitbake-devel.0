Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A23C761A6
	for <webhook@archiver.kernel.org>; Tue,  4 Apr 2023 17:07:42 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.107948.1680628061806893802
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 10:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oAYJNxwg;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id y7so2211582ljp.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680628060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A/6N5oGnRrj/hpbozYnBJ0wlzDrJAIvSesn3oGIoUYg=;
        b=oAYJNxwgFNT7dGOcRiyruobsCgAV3T+qAlbnhHuwXQu/UJ14a7WwdmJgmIcdf/BFlW
         whlZE7Mq6gV5D1aOJ264wwvxm9w4ytlD+AAaMwkT99jfH4sUc4qOJ98rx87xuqSO2yFR
         LpSdEJDHQZ7sBI/SoH6aWXmkFIElUvzFzRmVRHePzyVNwLkbOYGDEKJb4t/NaTItHuT4
         7GfL8Og/FsHxzEzGO/u1vPWIvBjcD0qTMk8IPLPtSN05HQ9vY/wVaySMTymMy1eK+wEE
         Zwyk7Y0O7RLn0W+t6O+qXAqWussulzTMwbIVoXDBARrX98UYfbnP3siY8XNstlzcSYz1
         LazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/6N5oGnRrj/hpbozYnBJ0wlzDrJAIvSesn3oGIoUYg=;
        b=MPC2UoRRICZJKCnp3GT9YErB3Bd99TMEEDF208KRcVAOnI/7tKAOLZv7DpjZGhzN0n
         u5V8GlXSM/nWLm0edNe7jXZLvl3C4pJ5AI2Ft18/E1SySuVPrpx8iXRsjD8MAhxQXoe/
         DejorDZ+6I6l1dKciqPVGqDXxXm8Eap7jUBfcO7aVOdGaXb2/V8xWQsQ4/wiStODYUyt
         G9Bi3p4MaXyoR+zOKcq4IRUizWOVIVn0inU8cKVinmHpw+rdHkfc70tObnNvguN7+rmD
         YlEJgQZTfpJc921CkH1pyQLynnV4bc2midlGdlrJSIuq2ZIlXeibqIvxFCPxL4EGwg7B
         56VQ==
X-Gm-Message-State: AAQBX9ebJ6Oi2lfM/jNH+kWImtwvcp9YW9lZvymFhd4++U+KspXGsKT4
	86R6zu+e/Xopg1/Uo9PJC6AWw/XnnXaEyN46Lvs=
X-Google-Smtp-Source: AKy350ZCqOgVhEeTERAFF0S4uPkbK8PDpfLcCo8Pe2sO/g1efNmeUaqpDVVyGfPyo101qXCXUXnotx5rjQIcWLL9n3Q=
X-Received: by 2002:a2e:8746:0:b0:29a:9053:ed1b with SMTP id
 q6-20020a2e8746000000b0029a9053ed1bmr1300652ljj.3.1680628059827; Tue, 04 Apr
 2023 10:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com> <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
In-Reply-To: <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Tue, 4 Apr 2023 19:07:28 +0200
Message-ID: <CA+cAkepKcDJSYMq7tbY=27QTaMq8AQXHqevfmux4ka43A4htQQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: akuster <akuster@mvista.com>
Cc: bitbake-devel@lists.openembedded.org, martin.jansa@gmail.com
Content-Type: multipart/alternative; boundary="00000000000081731505f885b632"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 17:07:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14632

--00000000000081731505f885b632
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Apr 2023 at 18:50, akuster <akuster@mvista.com> wrote:

>
>
> On 4/1/23 11:21 AM, Frederic Martinsons wrote:
> > From: Frederic Martinsons <frederic.martinsons@gmail.com>
> >
> > Instead of only display the first and stop.
> > For recipe (crago based) that can contains several artifacts
> > to fetch with their checksum, it will particularly handy
> > to display all of missing one.
> >
> > An example of error message would be
>
> I am confused. Is this patch supposed to add the pkg version or not?  I
> am not seeing any. Any ideas?
>
> I will be holding off branching meta-security until my 4 rust recipes
> can build again.
>
> -armin
>
>
Hello,

This patch is only for showing all missing checksum on crates for a recipe.
To build the checskum list (with the version), you can use bitbake -c
update_crates <your recipe>
and if you start from a pristine, you should have an error which will
contain
all the data you want to copy/paste (if you have this present patch in
bitbake)

The naming for pkg and version is already included in
cargo-update-recipe-crates.bbclass
<https://git.openembedded.org/openembedded-core/tree/meta/classes-recipe/cargo-update-recipe-crates.bbclass?id=1795e98a04ad09b011afcc7cc3bf6dc49475b19a>
from oe-core
master:
see
https://git.openembedded.org/openembedded-core/commit/?id=1795e98a04ad09b011afcc7cc3bf6dc49475b19a

--00000000000081731505f885b632
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, 4 Apr 2023 at 18:50, akuster =
&lt;<a href=3D"mailto:akuster@mvista.com">akuster@mvista.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 4/1/23 11:21 AM, Frederic Martinsons wrote:<br>
&gt; From: Frederic Martinsons &lt;<a href=3D"mailto:frederic.martinsons@gm=
ail.com" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Instead of only display the first and stop.<br>
&gt; For recipe (crago based) that can contains several artifacts<br>
&gt; to fetch with their checksum, it will particularly handy<br>
&gt; to display all of missing one.<br>
&gt;<br>
&gt; An example of error message would be<br>
<br>
I am confused. Is this patch supposed to add the pkg version or not?=C2=A0 =
I <br>
am not seeing any. Any ideas?<br>
<br>
I will be holding off branching meta-security until my 4 rust recipes <br>
can build again.<br>
<br>
-armin<br><br></blockquote><div><br></div><div>Hello,</div><div><br></div><=
div>This patch is only for showing all missing checksum on crates for a rec=
ipe.</div><div>To build the checskum=C2=A0list (with the version), you can =
use bitbake -c update_crates &lt;your recipe&gt;</div><div>and if you start=
 from a pristine, you should have an error which will contain</div><div>all=
 the data you want to copy/paste (if you have this present patch in bitbake=
)</div><div><br></div><div>The naming for pkg and version is already includ=
ed in=C2=A0=C2=A0<a href=3D"https://git.openembedded.org/openembedded-core/=
tree/meta/classes-recipe/cargo-update-recipe-crates.bbclass?id=3D1795e98a04=
ad09b011afcc7cc3bf6dc49475b19a" style=3D"color:blue;font-family:sans-serif;=
font-size:13.3333px">cargo-update-recipe-crates.bbclass</a>=C2=A0from=C2=A0=
oe-core master:</div><div>see <a href=3D"https://git.openembedded.org/opene=
mbedded-core/commit/?id=3D1795e98a04ad09b011afcc7cc3bf6dc49475b19a">https:/=
/git.openembedded.org/openembedded-core/commit/?id=3D1795e98a04ad09b011afcc=
7cc3bf6dc49475b19a</a><br></div><div><br></div><div>=C2=A0</div></div></div=
>

--00000000000081731505f885b632--

