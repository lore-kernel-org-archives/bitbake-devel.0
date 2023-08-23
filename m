Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32772C3DA66
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:20:29 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.49.1692825622465899346
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:20:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=Xe0sT677;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50091b91a83so2796185e87.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825620; x=1693430420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R4sXmc1440XMgfwrhVhmkxwm8wG6ddsxAYgNkuyG4ko=;
        b=Xe0sT677TPuAdNsXFzpDjAYEsnmZbB9sq4wkowiKhbnFuJRTvk+cMmziPHC17b5o7A
         xJrFs+4Eok9WTb1zHCtq1HomyfWMCfpmYWqY1pkMKAvG29DnJagX5n6SJ4m3SDwSIslb
         zPh1Br4VVVFtEMd+bYCTIKQgPMJmK7jUDJRhBppA0fzTQMDTAy6WdAUEy3/LTqcca0BT
         J9dUSlamtp23HVkCp+SdzyG15GL9kQJfPZHkgr2xj2W2EIMvi2NmvR0krBFvmNgdJJrN
         Sdg9e6FayA+W/f2a8tvRzoinSk2cgTjoqbtbQlWU1hBpRwQbv9pJC0uqrwjq0A/eb4jL
         4BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825620; x=1693430420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R4sXmc1440XMgfwrhVhmkxwm8wG6ddsxAYgNkuyG4ko=;
        b=QZRTBK0z2qqqQWrVI6OPJnsoMp7iQC+yeU85k/WswR5Q1CXOJnbQPlxpVj38W2JQLt
         MaqhQkduEM6s46aLPdsvdX7t5HerzID8quT13tYyGThL5o82WWMeQtvVRuL3MyX916ZS
         r0OFxVpfsqOxviQb2wi5bV5HSnWfpWW6p0wEbkqKPQXQiWIUMysIVEsC5jdd54qq8R1T
         tEl9U+JAKl/B7j0UETUF2+fO8KfBxmk7xS1J/T2vWCmE2g8hs9TzoQmajtVzDYrEH2Up
         6GXRG3soLWUIJvCzP/p6i/vqbSgU1FQxH6623HTiGgu0+GYYQGvzoIuU8qJYgSuRpKcd
         c85w==
X-Gm-Message-State: AOJu0YxpfJoIo5lFsngpLd2S9PklCBI1bixe/IzF0xCu189/czgaaKVo
	CttNYwrrzTQ6+mVH8IaA1QpePrpblibi4+2zxwI=
X-Google-Smtp-Source: AGHT+IGrSFnv3DklluaPyoWU8fL6l2D6P3N5gHIYIlUPaJgLLt2/QSLwlLyNnmUIv8pN/94hsF7Iiug6bA7CXx5OYAw=
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id
 y7-20020ac255a7000000b005008fcdc3b5mr3263380lfg.12.1692825620246; Wed, 23 Aug
 2023 14:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230823210438.2172797-1-rs@ti.com>
In-Reply-To: <20230823210438.2172797-1-rs@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Aug 2023 23:20:09 +0200
Message-ID: <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: export_proxies if network
 flag = 1
To: rs@ti.com
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: multipart/alternative; boundary="000000000000c2f3d606039dad0f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:20:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14960

--000000000000c2f3d606039dad0f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Something doesn=E2=80=99t compute here. How did it work all this time in ta=
sks like
fetch?

Alex

On Wed 23. Aug 2023 at 23.04, Randolph Sapp via lists.openembedded.org <rs=
=3D
ti.com@lists.openembedded.org> wrote:

> From: Randolph Sapp <rs@ti.com>
>
> Call the export_proxies() function if the network flag is set. Not sure
> why anyone would want to enable access without passing proxy variables
> if they are set.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  bin/bitbake-worker | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 451e6926..ba199ef9 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -285,6 +285,10 @@ def fork_off_task(cfg, data, databuilder, workerdata=
,
> extraconfigdata, runtask):
>                  for e, v in exports:
>                      os.environ[e] =3D v
>
> +                # if network is true we should assume proxy variables ar=
e
> to be passed through
> +                if the_data.getVarFlag(taskname, 'network', False):
> +                    bb.utils.export_proxies(the_data)
> +
>                  for e in fakeenv:
>                      os.environ[e] =3D fakeenv[e]
>                      the_data.setVar(e, fakeenv[e])
> --
> 2.41.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14959):
> https://lists.openembedded.org/g/bitbake-devel/message/14959
> Mute This Topic: https://lists.openembedded.org/mt/100924096/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000c2f3d606039dad0f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Something doesn=E2=80=99t compute here. How did it work a=
ll this time in tasks like fetch?</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Alex</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Wed 23. Aug 2023 at 23.04, Randolph Sapp via <a href=
=3D"http://lists.openembedded.org">lists.openembedded.org</a> &lt;rs=3D<a h=
ref=3D"mailto:ti.com@lists.openembedded.org">ti.com@lists.openembedded.org<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left=
:1ex;border-left-color:rgb(204,204,204)">From: Randolph Sapp &lt;<a href=3D=
"mailto:rs@ti.com" target=3D"_blank">rs@ti.com</a>&gt;<br>
<br>
Call the export_proxies() function if the network flag is set. Not sure<br>
why anyone would want to enable access without passing proxy variables<br>
if they are set.<br>
<br>
Signed-off-by: Randolph Sapp &lt;<a href=3D"mailto:rs@ti.com" target=3D"_bl=
ank">rs@ti.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-worker | 4 ++++<br>
=C2=A01 file changed, 4 insertions(+)<br>
<br>
diff --git a/bin/bitbake-worker b/bin/bitbake-worker<br>
index 451e6926..ba199ef9 100755<br>
--- a/bin/bitbake-worker<br>
+++ b/bin/bitbake-worker<br>
@@ -285,6 +285,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, =
extraconfigdata, runtask):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for e, v in e=
xports:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0os.environ[e] =3D v<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # if network is tr=
ue we should assume proxy variables are to be passed through<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if the_data.getVar=
Flag(taskname, &#39;network&#39;, False):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.u=
tils.export_proxies(the_data)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for e in fake=
env:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0os.environ[e] =3D fakeenv[e]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0the_data.setVar(e, fakeenv[e])<br>
-- <br>
2.41.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14959): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14959" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14959</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/100924096/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/100924096/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000c2f3d606039dad0f--

