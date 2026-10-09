Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F408CA601F
	for <webhook@archiver.kernel.org>; Fri,  9 Oct 2026 19:29:59 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3712.1791574189806486553
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Oct 2026 12:29:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pu1UKjvh;
 spf=pass (domain: gmail.com, ip: 74.125.224.42, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-675676afc3cso20060d50.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Oct 2026 12:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791574189; cv=none;
        d=google.com; s=arc-20260327;
        b=IDVREvXgwN74RC7ucVrBjsVwooA+gl5i6HzRk1Yg+9yDiCPWTpkMPrKVmWlThl/ix3
         eBRXu7jOGGHQfU1fGDOXyAEb1BXhTW1VrqcKo1A/1uP5DVr1X/M74ngfre++CzB+a5ER
         TWjKUJp+WlCG8j28jnvMP8DD4+J+fOtFYCMeP5CjiCLBDmtqIBTb649I3RAhtNVDuUNl
         08Sdlo3nw77X72NYSkhXMgjEsey+4CoyvznXOoQpqglY7NNIRPLaQd9dHxcFgnR2z8ra
         lHjINMj+bqtYJoXKoMHNwTM9Rby6rztmYKbKnoQLnuo/kgCsp0ddsdMN+dQJWg2vwYN5
         0CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cxTnqJ7LyCsJJy7gKoUfSk8nQ9Y04wIA0gMTNxocguU=;
        fh=VAN6qaCIkhNr5QeyHNm6DpzuUcRl7gO8CtfOVzKeeyU=;
        b=daMtVLoT0NVKklxAa1zMog0KNiOdjwkX4acxaxzClxdpBkrrQy0kpJ/cpEvN+uaNYc
         xAuP/T5SJ1mc2VXiauo51ROverdnKE35ev5kcT8oKfPMy8jr1S51Yx5H4M9YEoQ7KwVS
         KOgwWsuPpdQRmKqQbZJedN/NJ9IWT6ZRRR17EdPnvX0TENFALwy48Q9af4R3nTWSe8CW
         J6R2mP+2X0tkUbyhStXaQ61Rtz3Zz3pxZlha1Ob8Te7pCuAOH3c0yo4IwacP96R7LOfP
         u+S1eJ4v+oRFZ9nrbWJ424GlRXHUXlb93oRCJXR1p9EXi9TaiLnItarLHhHFrlA7voxU
         cEdg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791574189; x=1792178989; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cxTnqJ7LyCsJJy7gKoUfSk8nQ9Y04wIA0gMTNxocguU=;
        b=pu1UKjvh+AJWb8YIsbdtURWThQmcokfYUlaSQwZa0EeojvpttBpyM85aId5mnrhCgS
         Re8VqL6QX4neZd0gawh/91yhxp6dG2yvsYY9T3chMQsS57f1JcP/4DkMqeg1cWVPIrSE
         E99qVt39k2b0Vzi6KAlUUyr7wUEf6+FXZPwRfM35y600RoJAb4cAXXFlecP538Tsz5/e
         bAK/NPc14/7nOr45Vq7FfChk5Pjd4mJ6FNx0/kngfiKjAeKfdcINcykD6T/3nCQyIqoR
         pCuNXtZOUG1/F8OfG2G1ld+wzlSqDUp/b+7/bdsiBKjtZpbtZA3yxVuD0CQep/CgUXwj
         8fCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791574189; x=1792178989;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cxTnqJ7LyCsJJy7gKoUfSk8nQ9Y04wIA0gMTNxocguU=;
        b=qziikCboO1jMedxt61EBaUnabBcqTTpmOWHFYW7rhz6BsfJTE4n7CYDx6Bv/Xx+1ec
         LzN56u4uPq5485lplFzVSuNLc6JS9JGAeg3FFt8m/xm+VnmS+1sEdqaOcXR3PwPBoyOf
         mx22V8Jnwt7TM12RvXJ4QS+p1UtwRrrAmpQQZDm2G/nVhYCcc/Uf3iHkZMH52H0/1tVS
         FWQ9kqrOsMYn9/HNZ/CiMg1iYTbNDUhT6N0sVcWhWxLQGYsYEh3osuKXuQvUm2TKclGw
         FvkcR82vPh5mw+XztUVKy2+oWAk5UMGbfyWrsoGnLBE79tnJwQESTkASLcx14WgBhuyK
         Bkxg==
X-Gm-Message-State: AFq9FYKR7P5lWTn6r7a7gMXw3DQSMfKSMYa57fu4dXg7GFLbFRZtqais
	GeJrbp0nk+ra0fhHxe9wZD9b2eoujgru6qP7qMN6kC2rFgEc6XOkGKcLlFFCy80YIvRCnvTAoVM
	BoZo/yw1t5RFM0XJGWOafVXO72MJgv3g=
X-Gm-Gg: AYBFou0ce1qugEn5WRbs2slFqfgk7tJ+eBPpoSYtkKH0K/0pJNJqExciaWj20iOFM48
	MjPT4kOqUdUgK5+CkkazZwFJwoAbKUusjPy4SP+4LCkpy+D1SXQCphOzZcIc2ibb8M6lc38y2yW
	nbJ9Uaoj+9JX9fgzDOimTDZcuLF4PgGaGsYy6BHkl0qTIFq0q4rD7ERFambx35B1EZhYjujW/IJ
	njhpF9f2vWdnGvgFYNMYjeGgvlmTgOfGrCWmXrXWjUW26YQZKjRn7aJ7XCk5wVos8Ol1a+iX8RX
	HR+aINztumCU9Z69TGzTfPKApqm4QB+7gnpC8+C9Ge5ScdxrZyxKdcKanAsGIMbp+WRVSLOogh9
	y5lMkkN0y2FtLRXMTB4Chg0s=
X-Received: by 2002:a05:690e:11c3:b0:677:b8bb:3443 with SMTP id
 956f58d0204a3-679360066d1mr1210452d50.29.1791574188684; Fri, 09 Oct 2026
 12:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261009133418.215223-1-ross.burton@arm.com>
In-Reply-To: <20261009133418.215223-1-ross.burton@arm.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Fri, 9 Oct 2026 15:29:36 -0400
X-Gm-Features: AclHuK_5oGJbv0bAGHnl9G_xmJ70Jl0XnBQ5sIEhoF7pgzrcjud3fFOWOQsCdRU
Message-ID: <CAGAhMByanL8TzBt=EPnW15bdPOaY1mjY4JtTv54ghie7AZx=Tg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] packaging-pypi: make bitbake-setup depend
 on websockets
To: ross.burton@arm.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000001af943065d6d5fdd"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Oct 2026 19:29:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20311

--0000000000001af943065d6d5fdd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ross,

I think this would add the websocket module to the bitbake-setup package,
even though it doesn't deliver the bitbake code that uses websocket.

I looked at the bitbake code, and it seems to already cover this failure
case in a commit from Alexander:
https://git.openembedded.org/bitbake/commit/?id=3D2d15e6fc93f6a73c9c84e3996=
13f931f1c783922

It looks like it should output the following message to the user in this
situation:

Unable to use hash equivalence server at 'websocket' due to missing or
incorrect python module:
websocket
Please install the needed module on the build host, or use an environment
containing it:
 - if you are using bitbake-setup, run 'bitbake-setup install-buildtools'
 - openembedded-core layer contains 'scripts/install-buildtools' that can
also be used
 - or set up pip venv
You can also remove the BB_HASHSERVE_UPSTREAM setting, but this may result
in significantly longer build times as bitbake will be unable to reuse
prebuilt sstate artefacts.


Is there a use case where the user won't see the message?

Cheers,
Rob

On Fri, Oct 9, 2026 at 9:34=E2=80=AFAM Ross Burton via lists.openembedded.o=
rg
<ross.burton=3Darm.com@lists.openembedded.org> wrote:

> If you're installing bitbake-setup via a venv and pip, you'll usually
> have a self-containted venv that doesn't have access to the system-wide
> site-packages tree.  This means that even if you have websockets
> installed on the host, the venv with bitbake-setup in will not, and if
> the same venv is used to run bitbake it won't be able to connect to
> the hashserver.
>
> Solve this by adding a dependency on websockets to the bitbake-setup
> wheel.  This isn't strictly true as bitbake-setup itself doesn't use the
> hashserver, but reusing the venv is common and this solves a common pain
> point when setting up a new build environment.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  packaging-pypi/bitbake-setup/pyproject.toml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/packaging-pypi/bitbake-setup/pyproject.toml
> b/packaging-pypi/bitbake-setup/pyproject.toml
> index 90ed1ffb98..0cd2d37803 100644
> --- a/packaging-pypi/bitbake-setup/pyproject.toml
> +++ b/packaging-pypi/bitbake-setup/pyproject.toml
> @@ -20,7 +20,9 @@ classifiers =3D [
>  ]
>
>  dependencies =3D [
> -  # bitbake-setup is mostly self-contained
> +  # bitbake-setup is mostly self-contained, but hashserver needs
> websockets
> +  "websockets >=3D 9.0; python_version =3D=3D '3.9'",
> +  "websockets >=3D 10.0; python_version >=3D '3.10'"
>  ]
>
>  [project.optional-dependencies]
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20310):
> https://lists.openembedded.org/g/bitbake-devel/message/20310
> Mute This Topic: https://lists.openembedded.org/mt/121671625/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000001af943065d6d5fdd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Ross,</div><div><br></div><div>I think this would =
add the websocket module to the bitbake-setup package, even though it doesn=
&#39;t deliver the bitbake code that uses websocket.<br><br>I looked at the=
 bitbake code, and it seems to already cover this failure case in a commit =
from Alexander:=C2=A0<a href=3D"https://git.openembedded.org/bitbake/commit=
/?id=3D2d15e6fc93f6a73c9c84e399613f931f1c783922">https://git.openembedded.o=
rg/bitbake/commit/?id=3D2d15e6fc93f6a73c9c84e399613f931f1c783922</a></div><=
div><br></div><div>It looks like it should output the following message to =
the user in this situation:</div><div><br></div><blockquote style=3D"margin=
:0 0 0 40px;border:none;padding:0px"><div><div>Unable to use hash equivalen=
ce server at &#39;websocket&#39; due to missing or incorrect python module:=
</div></div><div><div>websocket</div></div><div><div>Please install the nee=
ded module on the build host, or use an environment containing it:</div></d=
iv><div><div>=C2=A0- if you are using bitbake-setup, run &#39;bitbake-setup=
 install-buildtools&#39;</div></div><div><div>=C2=A0- openembedded-core lay=
er contains &#39;scripts/install-buildtools&#39; that can also be used</div=
></div><div><div>=C2=A0- or set up pip venv</div></div><div><div>You can al=
so remove the BB_HASHSERVE_UPSTREAM setting, but this may result in signifi=
cantly longer build times as bitbake will be unable to reuse prebuilt sstat=
e artefacts.<br></div></div></blockquote><div><div><br>Is there a use case =
where the user won&#39;t see the message?<br><br></div><div><span style=3D"=
background-color:transparent">Cheers,</span></div><div>Rob</div></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fr=
i, Oct 9, 2026 at 9:34=E2=80=AFAM Ross Burton via <a href=3D"http://lists.o=
penembedded.org" target=3D"_blank">lists.openembedded.org</a> &lt;ross.burt=
on=3D<a href=3D"mailto:arm.com@lists.openembedded.org" target=3D"_blank">ar=
m.com@lists.openembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">If you&#39;re installing bitbake-setup via a ve=
nv and pip, you&#39;ll usually<br>
have a self-containted venv that doesn&#39;t have access to the system-wide=
<br>
site-packages tree.=C2=A0 This means that even if you have websockets<br>
installed on the host, the venv with bitbake-setup in will not, and if<br>
the same venv is used to run bitbake it won&#39;t be able to connect to<br>
the hashserver.<br>
<br>
Solve this by adding a dependency on websockets to the bitbake-setup<br>
wheel.=C2=A0 This isn&#39;t strictly true as bitbake-setup itself doesn&#39=
;t use the<br>
hashserver, but reusing the venv is common and this solves a common pain<br=
>
point when setting up a new build environment.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
---<br>
=C2=A0packaging-pypi/bitbake-setup/pyproject.toml | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/packaging-pypi/bitbake-setup/pyproject.toml b/packaging-pypi/b=
itbake-setup/pyproject.toml<br>
index 90ed1ffb98..0cd2d37803 100644<br>
--- a/packaging-pypi/bitbake-setup/pyproject.toml<br>
+++ b/packaging-pypi/bitbake-setup/pyproject.toml<br>
@@ -20,7 +20,9 @@ classifiers =3D [<br>
=C2=A0]<br>
<br>
=C2=A0dependencies =3D [<br>
-=C2=A0 # bitbake-setup is mostly self-contained<br>
+=C2=A0 # bitbake-setup is mostly self-contained, but hashserver needs webs=
ockets<br>
+=C2=A0 &quot;websockets &gt;=3D 9.0; python_version =3D=3D &#39;3.9&#39;&q=
uot;,<br>
+=C2=A0 &quot;websockets &gt;=3D 10.0; python_version &gt;=3D &#39;3.10&#39=
;&quot;<br>
=C2=A0]<br>
<br>
=C2=A0[project.optional-dependencies]<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#20310): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/20310" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/20310</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/121671625/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/121671625/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000001af943065d6d5fdd--

