Return-Path: <rob.woolleywr@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB3C5DF66
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 23:37:21 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2745.1786664232833106883
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 16:37:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=juhkC7BF;
 spf=pass (domain: gmail.com, ip: 209.85.128.175, mailfrom: rob.woolleywr@gmail.com)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ed2a06b9eso4085007b3.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 16:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786664232; cv=none;
        d=google.com; s=arc-20260327;
        b=lclaDZYLWpdEuPV3HMEUxpmpZAtPMYVdm0/DZWnl/qPGCXTIv86Qcb0sHRQpAixWrd
         e9gGQ+PiFmjVr7cO6WanrxovXsMXO4cktwK44SVE5jzO2r2XJZjBt87pR1dIN85YAgXu
         UQv8Q2Dtsc7PRX977ox/vHeVcdP6bFlMrR69eJv5+hmMJD0ULMuYx/aE9a8EAMXNyTnM
         hsHMHScJnyUTY5T2dry0maYDh+NNVwJoeyNqXyP5VZizILsnbnZKhOwX2ecJdR/NyklJ
         Wyfe343rY2fu5E7LIKyU9lSFld/iwbugnt83pTIFgVI8Z1AUPdiGsxBrvmQYhViG5tum
         KEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dl6QR05XJHMmqDr/Pj5up+Hw5Oyd6De68gYrS1ywymI=;
        fh=eXhDJDsIfFzCgyQ0Q2WLQFoLX1rIBonapojPdzUIvqQ=;
        b=N6SWfCLhptmWRc4ffTLI7fnJxvDat5Hkk3ELRn7ZjCW26FYOyiOigtMqsZkhsqgxZx
         UAVc1m50ZinBeGR0QsR9USpDPEYil6FIIy4pwQxMcukDh5HjAh3n/kin7cjhrS+ltv/G
         mhDm749tkk3d5jx/WIkx9zPqqgObVBCfzzhECWvi8xKXpX5WRox7OIcTRpJe/nPxB95u
         GS/U7OnxspgSUVkpfJkBX05fFzQg6Gw3FgvC47kr5Q6ITq5e1aSNMCtxC9Fszihuv2VY
         cuuQn61+bpjtGS3K/zF/V0IkRt/u9IMnuG0hwLrhQnbyxaG6Ua9nAwSKdfetl5DY84Gm
         mQSg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786664232; x=1787269032; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dl6QR05XJHMmqDr/Pj5up+Hw5Oyd6De68gYrS1ywymI=;
        b=juhkC7BFENf4zuzXt5806NFrrBAg0tWUYDuPaWi+XCkfm60j/2LpXk00VFwlwWGHCx
         L6EOZtbOXIyXe/5hS74Y2YibX5TvPODzHTDxhR9IeCVaaSa+Gi/7pSn3R1d+ouTP8e84
         hxQNFljd4ZMdkxl6B8nf+TvVgo1i6f8Ewe9gl1Pl/aApT+vH7G6W0wPJ1XWFdeMifAJr
         8TylnW1QKfwZxc05byF7tEvDyXINiaX2+X9z4j+gcNSrJj3pXiVqmyw7Ybl70kWWgr5s
         Hyb0VjX6xnD79pvgn1j/qOffB8JWBf//gP2rC1M3t4iIrfK3bVw6a5EIzZ4i/bP/Gl4U
         ZgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786664232; x=1787269032;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dl6QR05XJHMmqDr/Pj5up+Hw5Oyd6De68gYrS1ywymI=;
        b=ff4pTJF8bHXoubreser4OAV6Yn6JWH8A9MZ53V616OK5Z/ALQgQte2M2I2Dj1awZUx
         xWsLg8E++cP+7ptxXliYrJd2VyQiRqcsr8Rv3HO2yDa+XXgm6k4Z4bTBqq6Y7euNUPrc
         FAlyeA6lo3vdN4hJtElfPpLTGVC7uXGoCrpk0AmXOGyznB+zzcVKyahWwHUCk87FLKGN
         2jlhmn/N9I1uyoEIWEpBajVoeAAx/ntSmiwyJHYMk60o2pxhKEejAi+a4OTIekbAzLUr
         bJ2nT8xGO7RIyW9+HkVCT+I/cNbJpBPBJaMEWnL5S7jzwtdYEdH0JHv0CYLql94gHTr3
         KCtA==
X-Gm-Message-State: AOJu0YwyPvW3hj1qvHxIm6f+8WtQOu9ArdNunAowrZqU3WXowVqOXNVE
	McBQSmDqMiAbr7tTCvjeSAlCrkdUliPdJr+397upGC8FNPfcH5PKRdiInOKvllrTykJGvPgCEXL
	xm7Xi+d6RuCREOmdCX+jVe85CLIVSDRKSOg==
X-Gm-Gg: AR+sD11xcHXy4ORd8sr3nMHkKK7uHZzzZI32+j4imBiY5Z4iKuViFNjT/zhZ9EqQuvN
	hL5e/YHihA6arNQiAYUT+nCazaGt5l/h3pST3y043HWtPI2uLbY4xBzzhJMAuwX2cI1GXFbgPWG
	cY7OYyRfN8/H1vq8fdW+iLFWEUBP9bMoJxVGqEjJqPDYGqRq+8+eYANZfOaumrfXauSIfHaNRo/
	5Ppx8zaoMF7fx3XTqhjR5CP2UcQPC7ZpclDrqnEjnGzk5ebHTinIM3mMiBfRfy5B5bpaFo7af0S
	oM9yWkisFQ+eUme7Od2XkPbW+IZc3Zj/eAKeAwJDvPgAUN2OcLKnqy2jQQW4bbzxJf3A/OYZY6A
	SO4h0id3T0rX8
X-Received: by 2002:a05:690c:e295:20b0:81f:b410:b214 with SMTP id
 00721157ae682-837124e9cc0mr5955667b3.27.1786664231608; Thu, 13 Aug 2026
 16:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260812194433.40594-1-chris.laplante@agilent.com>
In-Reply-To: <20260812194433.40594-1-chris.laplante@agilent.com>
From: Rob Woolley <rob.woolleywr@gmail.com>
Date: Thu, 13 Aug 2026 19:37:00 -0400
X-Gm-Features: AUfX_mzl8P__NUi4GQEpu-0sJ-tsFRQlcKnTqUpcdQz0PmE2f0LCei6PMLx6cuU
Message-ID: <CAGAhMBw3AeCPhybRpGBz+z-vp3xs8wWzaUvkCWaPwWhHqpxCrA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] pyproject.toml: add setuptools to
 requires; fix project structure
To: chris.laplante@agilent.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000dba7000658f62ecb"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 23:37:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19933

--000000000000dba7000658f62ecb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

Thanks for pointing this out!

I think it was a mistake for me to include the project and build-system
sections in pyproject.toml.  I had it in there originally to try to improve
the versioning, but we chose to implement it a different way.  It is only
needed if you intend to do packaging which is something we are trying not
to do with bitbake itself.

We have a separate pyproject.toml file for bitbake-setup, which we do want
to package for convenience.

If we remove those sections does that fix the problem you see with PyCharm?

Regards,
Rob


On Wed, Aug 12, 2026 at 3:44=E2=80=AFPM Chris Laplante via lists.openembedd=
ed.org
<chris.laplante=3Dagilent.com@lists.openembedded.org> wrote:

> From: Chris Laplante <chris.laplante@agilent.com>
>
> setuptools is listed as the build backend but wasn't in 'requires'.
>
> We also need to tell setuptools to look for our modules in 'lib' since
> otherwise
> it chokes on our non-standard layout with:
>
> [stderr]
>       error: Multiple top-level packages discovered in a flat-layout:
> ['lib', 'conf', 'vendor', 'contrib', 'classes'].
>
> With these changes, 'uv sync' works and IDEs such as PyCharm can
> properly analyze the project.
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  pyproject.toml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/pyproject.toml b/pyproject.toml
> index 93508d92e..886753f14 100644
> --- a/pyproject.toml
> +++ b/pyproject.toml
> @@ -1,10 +1,17 @@
>  [build-system]
> -requires =3D []
> +requires =3D ["setuptools>=3D64"]
>  build-backend =3D "setuptools.build_meta"
>
>  [project]
>  name =3D "bitbake"
>  version =3D "2.19.0"
> +requires-python =3D ">=3D 3.9"
> +
> +[tool.setuptools]
> +package-dir =3D {"" =3D "lib"}
> +
> +[tool.setuptools.packages.find]
> +where =3D ["lib"]
>
>  [tool.vendoring]
>  destination =3D "lib/bb/_vendor"
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19919):
> https://lists.openembedded.org/g/bitbake-devel/message/19919
> Mute This Topic: https://lists.openembedded.org/mt/120723537/556952
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> rob.woolleywr@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000dba7000658f62ecb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Chris,<div><br></div><div>Thanks for pointing this out!=
</div><div><span style=3D"background-color:transparent"><br></span></div><d=
iv><span style=3D"background-color:transparent">I think it was a mistake fo=
r me to include the project and build-system sections in pyproject.toml.=C2=
=A0 I had it in there originally to try to improve the versioning, but we c=
hose to implement it a different way.=C2=A0=C2=A0</span><span style=3D"back=
ground-color:transparent">It is only needed if you intend to do packaging w=
hich is something we are trying not to do with bitbake itself.</span></div>=
<div><span style=3D"background-color:transparent"><br></span></div><div><sp=
an style=3D"background-color:transparent">We have a separate pyproject.toml=
 file for bitbake-setup, which we do want to package for convenience.</span=
></div><div><br>If we remove those sections does that fix the problem you s=
ee with PyCharm?<br><br>Regards,</div><div>Rob</div><div><div><div><br></di=
v></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Wed, Aug 12, 2026 at 3:44=E2=80=AFPM Chris Laplante via =
<a href=3D"http://lists.openembedded.org" target=3D"_blank">lists.openembed=
ded.org</a> &lt;chris.laplante=3D<a href=3D"mailto:agilent.com@lists.openem=
bedded.org" target=3D"_blank">agilent.com@lists.openembedded.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Chris=
 Laplante &lt;<a href=3D"mailto:chris.laplante@agilent.com" target=3D"_blan=
k">chris.laplante@agilent.com</a>&gt;<br>
<br>
setuptools is listed as the build backend but wasn&#39;t in &#39;requires&#=
39;.<br>
<br>
We also need to tell setuptools to look for our modules in &#39;lib&#39; si=
nce otherwise<br>
it chokes on our non-standard layout with:<br>
<br>
[stderr]<br>
=C2=A0 =C2=A0 =C2=A0 error: Multiple top-level packages discovered in a fla=
t-layout: [&#39;lib&#39;, &#39;conf&#39;, &#39;vendor&#39;, &#39;contrib&#3=
9;, &#39;classes&#39;].<br>
<br>
With these changes, &#39;uv sync&#39; works and IDEs such as PyCharm can<br=
>
properly analyze the project.<br>
<br>
Signed-off-by: Chris Laplante &lt;<a href=3D"mailto:chris.laplante@agilent.=
com" target=3D"_blank">chris.laplante@agilent.com</a>&gt;<br>
---<br>
=C2=A0pyproject.toml | 9 ++++++++-<br>
=C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/pyproject.toml b/pyproject.toml<br>
index 93508d92e..886753f14 100644<br>
--- a/pyproject.toml<br>
+++ b/pyproject.toml<br>
@@ -1,10 +1,17 @@<br>
=C2=A0[build-system]<br>
-requires =3D []<br>
+requires =3D [&quot;setuptools&gt;=3D64&quot;]<br>
=C2=A0build-backend =3D &quot;setuptools.build_meta&quot;<br>
<br>
=C2=A0[project]<br>
=C2=A0name =3D &quot;bitbake&quot;<br>
=C2=A0version =3D &quot;2.19.0&quot;<br>
+requires-python =3D &quot;&gt;=3D 3.9&quot;<br>
+<br>
+[tool.setuptools]<br>
+package-dir =3D {&quot;&quot; =3D &quot;lib&quot;}<br>
+<br>
+[tool.setuptools.packages.find]<br>
+where =3D [&quot;lib&quot;]<br>
<br>
=C2=A0[tool.vendoring]<br>
=C2=A0destination =3D &quot;lib/bb/_vendor&quot;<br>
-- <br>
2.43.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#19919): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/19919" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/19919</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/120723537/556=
952" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/120723537/556952</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:rob.woolleywr@gmail.com" target=3D=
"_blank">rob.woolleywr@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--000000000000dba7000658f62ecb--

