Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C93C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 23:46:11 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2878.1786664770771287819
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 16:46:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=f5EhlMC+;
 spf=pass (domain: gmail.com, ip: 209.85.128.179, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8200ca16f26so7223657b3.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 16:46:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786664770; cv=none;
        d=google.com; s=arc-20260327;
        b=qWJn5PvN6CcPusEOn5ktiuk6y0sb7iLw1yU8LV/Vm64ty51BU0R9IJQ9s6CQoJqo9d
         unSshy1gQuQmyqA4oDG8gpyRTQIvvxy/e2VOeLGUQeeq7Crj2kxmFVKj9UAoDLThcjSd
         7PACbPCZyhrjFHumo6Wc2+2riiOe04rkj2ubYTPj2coC2m9Y4tyovI86fu7ddeTdqw7q
         5WibgRXzSt6bojLn0Ls8Ld2CIWEM7HMPnqDSQOX81UYIunQIoYozsGwqIUjnWl5exIcx
         2IE2q4INb5fowgeuadMjNkZQX6B2zOz2Tdf05dbPFgvTaoBDj+kbe6cNqxRk4mr0yNHn
         4VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W4pyJXcNjGtidJ+/8IrXc2PYujY8L7rgtP15Kgga+JU=;
        fh=eXhDJDsIfFzCgyQ0Q2WLQFoLX1rIBonapojPdzUIvqQ=;
        b=iEq3Ryo/Fuv7B8oE/xqPsfqn+lGG+r+0QjHEbbMnj5s/GncHxGrvIVWqTOS3ACdlWp
         9kwoI9Njw1KpnIPC8yNPOBWeLU4rDfHsURXhBrNNnsh+JOkQVyAa4o7UF/zeHIoxLyxP
         OZLBiglzEF5i4E4fsD9lSHiKdna3FPkmCW8wL+eX1CIULIeYlrYREYobkkF7zFaIXWSE
         T8lJ2izrL1WlO2q0aViRFB7Nm4zkQODq+2VR+kl5QD6WZRVeFRYIGIbJ2JD5CvAsrJln
         J1U+Ef0Uu4RqZBd1dqPiXp/+QJpsh6FJGTOSIBtQXC/FycUxnEgD+X0YxfpHDO0o8ZoQ
         B+QA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786664770; x=1787269570; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4pyJXcNjGtidJ+/8IrXc2PYujY8L7rgtP15Kgga+JU=;
        b=f5EhlMC+qJnoci31iW4SDwLxFJiybsXBq0BKON89pOMSjfwzsOs+RAH7ChPTDqm9kj
         6NV+ZbFxFCVZU2X6pROwsgY+ttYkWAfEYeACHTxhv2t51PPkSBRbYmxNe8bYLdolMs0t
         wdf0v7zbZmyul7iTozTBjO/WPS1tWfU8uUgaMdz0U6z6qx8U2itqvg+ZFe79+z8rwbYh
         hwkdxOC0JZedlfGobK+tsKMCc7PRzI7nSCjZR1pDznXywjxj+Yb/n1xkcp0hlSmeHatG
         5zH/1nyf5n1cbWeGbpVVoxtXcqgXguSk2uTebvrAw592RIsTUEqdfW6LB74AngbYVkKs
         VqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786664770; x=1787269570;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W4pyJXcNjGtidJ+/8IrXc2PYujY8L7rgtP15Kgga+JU=;
        b=Q3YyAkgqrSMZdKgcRi5lkV0Fd21yqnT3zrlkvGhv0i2bkFiY26RY8XU0gpbCz+AHQR
         r4Hq+2/ASU+dfVmcCaaLJIuUp4HZaOHVhFMEWWee40kV7KQKQewJpfcIcEbkoNz/wEgc
         EtyeLSMkGgNj5Ze+ZA98hM8S85pCWeG/PluAtobIVGDoNEodX6MprTx5R/R/G34QEcuV
         0440AnioV4x2tkMSvk5sGEe9iFE5J8P7NeRIhuM/TyApbnVf9mWUYqOmYUl0nPJtBBRu
         ZBClvj5Ck48nykZ1aLKTzNrnQuMmQkYJnDqjbf5ETLYIyYSuuLhbWRmymqaiZlq8Okyk
         yhOQ==
X-Gm-Message-State: AOJu0YyvW7yWiuDOB1RQq6/LkNWdMWrlu8BDCqcyhMEHAmPsUQ7xL29D
	LZaHEtX5c/1rToWVBLRlWlUxgm5IRwHi6c1v5gk0chhBy/oiLwuRkT/RwMQMNqfSmgt17pa6Npu
	Zm5jCd1bv87jX4ACQV78odbVdUu1/8klnJ31a
X-Gm-Gg: AR+sD13wXTCKKAZsoWRwmqABFqg0cL6pTsNFB3xJKd+Ch/25TsRYIsuEuTG6decKJ2Y
	t7v7BZmZFjcxJk7vPKC7rp5u4KxX/ikc7VZ6EU/efgC55ZadjwS3tTwt5gzCNR8AeIYFIF+tBrs
	AAm2/VL6ylwsdFKkHgeIsBnzjQsMy4fiCNG9KppJh9gmLTtIR9pp2zQZUfRC1NXQQ6coGmM/bTW
	wQyCu+9RkPeq1wzEEkfZmciDcl+ap5XJW8n2lDej0dy/LZI3wYgon7K+QEL/ikoV2xRL2gJ2Cc9
	yBZidVtxyqw3neech0Zim7sDPY15agKvwhn8775U1ISMz2UgF86ZrKt1gUfRYwGr2X9FsovAsa1
	gfro2JWQKAda5
X-Received: by 2002:a05:690c:94:b0:806:b6ab:a410 with SMTP id
 00721157ae682-83707723da2mr9610907b3.0.1786664769781; Thu, 13 Aug 2026
 16:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260812194433.40594-1-chris.laplante@agilent.com> <20260812194433.40594-2-chris.laplante@agilent.com>
In-Reply-To: <20260812194433.40594-2-chris.laplante@agilent.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Thu, 13 Aug 2026 19:45:58 -0400
X-Gm-Features: AUfX_myeV2wiv4fWr34QA_kESHACfViggNl1VFfS-UIl41N3kVXtegpfKCbBNu8
Message-ID: <CAGAhMByMYPx=gUNTfNxrtdox7MkX4OHM2PhLo45Kipx=t1e7WA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] pyproject.toml: add scripts
To: chris.laplante@agilent.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000ef86c50658f64e43"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 23:46:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19934

--000000000000ef86c50658f64e43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

I tried out using "uv run bitbake" and get the following message:

ERROR: The BBPATH variable is not set and bitbake did not find a
conf/bblayers.conf file in the expected location.
Maybe you accidentally invoked bitbake from the wrong directory?


I think some of the challenges with packaging bitbake is that the version
is tied to a specific Yocto Project, the sys.path is modified at runtime to
find the lib directory, and that it needs to run in the oe-init-build-env
environment.  This could make it difficult to work in this workflow.

Out of curiosity, were you able to do bitbake builds with this setup?

Regards,
Rob

On Wed, Aug 12, 2026 at 3:44=E2=80=AFPM Chris Laplante via lists.openembedd=
ed.org
<chris.laplante=3Dagilent.com@lists.openembedded.org> wrote:

> From: Chris Laplante <chris.laplante@agilent.com>
>
> This change lets you do, e.g. uv run bitbake
>
> which is convienent for development.
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  pyproject.toml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/pyproject.toml b/pyproject.toml
> index 886753f14..d3555bc42 100644
> --- a/pyproject.toml
> +++ b/pyproject.toml
> @@ -9,6 +9,19 @@ requires-python =3D ">=3D 3.9"
>
>  [tool.setuptools]
>  package-dir =3D {"" =3D "lib"}
> +script-files =3D [
> +    "bin/bitbake",
> +    "bin/bitbake-config-build",
> +    "bin/bitbake-diffsigs",
> +    "bin/bitbake-dumpsig",
> +    "bin/bitbake-getvar",
> +    "bin/bitbake-hashclient",
> +    "bin/bitbake-hashserv",
> +    "bin/bitbake-layers",
> +    "bin/bitbake-prserv",
> +    "bin/bitbake-selftest",
> +    "bin/bitbake-setup"
> +]
>
>  [tool.setuptools.packages.find]
>  where =3D ["lib"]
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19920):
> https://lists.openembedded.org/g/bitbake-devel/message/19920
> Mute This Topic: https://lists.openembedded.org/mt/120723538/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000ef86c50658f64e43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Chris,<div><br></div><div>I tried out using &quot;uv ru=
n bitbake&quot; and get the following message:<br><br></div><blockquote sty=
le=3D"margin:0 0 0 40px;border:none;padding:0px"><div>ERROR: The BBPATH var=
iable is not set and bitbake did not find a conf/bblayers.conf file in the =
expected location.</div><div>Maybe you accidentally invoked bitbake from th=
e wrong directory?</div></blockquote><div><br></div><div>I think some of th=
e challenges with packaging bitbake is that the version is tied to a specif=
ic Yocto Project, the sys.path is modified at runtime to find the lib direc=
tory, and that it needs to run in the oe-init-build-env environment.=C2=A0 =
This could make it difficult to work in this workflow.</div><div><br></div>=
<div>Out of curiosity, were you able to do bitbake builds with this setup?<=
br><br>Regards,<br>Rob</div></div><br><div class=3D"gmail_quote gmail_quote=
_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12, 2026 at 3=
:44=E2=80=AFPM Chris Laplante via <a href=3D"http://lists.openembedded.org"=
>lists.openembedded.org</a> &lt;chris.laplante=3D<a href=3D"mailto:agilent.=
com@lists.openembedded.org">agilent.com@lists.openembedded.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Chris L=
aplante &lt;<a href=3D"mailto:chris.laplante@agilent.com" target=3D"_blank"=
>chris.laplante@agilent.com</a>&gt;<br>
<br>
This change lets you do, e.g. uv run bitbake<br>
<br>
which is convienent for development.<br>
<br>
Signed-off-by: Chris Laplante &lt;<a href=3D"mailto:chris.laplante@agilent.=
com" target=3D"_blank">chris.laplante@agilent.com</a>&gt;<br>
---<br>
=C2=A0pyproject.toml | 13 +++++++++++++<br>
=C2=A01 file changed, 13 insertions(+)<br>
<br>
diff --git a/pyproject.toml b/pyproject.toml<br>
index 886753f14..d3555bc42 100644<br>
--- a/pyproject.toml<br>
+++ b/pyproject.toml<br>
@@ -9,6 +9,19 @@ requires-python =3D &quot;&gt;=3D 3.9&quot;<br>
<br>
=C2=A0[tool.setuptools]<br>
=C2=A0package-dir =3D {&quot;&quot; =3D &quot;lib&quot;}<br>
+script-files =3D [<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-config-build&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-diffsigs&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-dumpsig&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-getvar&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-hashclient&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-hashserv&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-layers&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-prserv&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-selftest&quot;,<br>
+=C2=A0 =C2=A0 &quot;bin/bitbake-setup&quot;<br>
+]<br>
<br>
=C2=A0[tool.setuptools.packages.find]<br>
=C2=A0where =3D [&quot;lib&quot;]<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19920): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19920" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19920</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120723538/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/120723538/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000ef86c50658f64e43--

