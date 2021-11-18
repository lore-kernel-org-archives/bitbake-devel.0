Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DCEC433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 21:15:13 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web12.335.1637270112330166631
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 13:15:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mHag/ZDH;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: kergoth@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id y12so32971940eda.12
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 13:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdLlxZ+TXE8zhctkH5apJxMXJZz2hIFOVWyBuW06kFQ=;
        b=mHag/ZDHAV3rIdHnLQQAk9QfR9kQB/h7h5203PR6ZxO7Gej/rna0Rm1KjgX4Z93m/5
         5w1razZIrLgBUs6iTVfGClfWFFEBQe8FPZZz4AcV/yM4UlVGf/BSQQb9QVzRWK72P9D3
         s/ET4QQo9CkTltkrQHIKcc/gBlT2DvVGRgR7DpyUMqodu9vP3e1MTsUooRDhRpOTrQzf
         PfwgSe+C9Kt0CzO7zl44n6RLwWI5CGLTeiK4s1MekhqIxfnrbB9CVKwyDiT1KRDr3dv9
         ZG1j6ym+4gVJeXB/dIHPCyvXul+u/MbTJm9K2t5nCFThYs1tFJHmTPnpa2qhyupeHrzs
         asRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdLlxZ+TXE8zhctkH5apJxMXJZz2hIFOVWyBuW06kFQ=;
        b=kRVww+wIsGNYhtGeSPMt3ugWVuQh0/XgZvCF3rbeEHXLkfLaH6kwQKo1tvYbDfnIlO
         JAncodehXs3f3+Ruvxm5HL8ECFRfDi0B9YMGCUOdP+c3uP3BA8hK3g6Wd/JDnfAVvCQq
         WC5RQTTb4h7KUJjuS4UBvfR+hQmOGgoDkXk2wbwF/ExpewDdcSbyoMzne3P/YmnmWJZK
         8UiF3d0IDgNPtsAqC/5jOad3BKwnuatKFkXsa07tm8exbhb4BkJQhh1jAxq1ZIQQRyK+
         p/Kj9VjgNrB+8Q3grR0LCiYKZDQz6vwVAbw101iW3mHB0Ga7YzWgNxFU2o01Xb++vrfx
         3Cbg==
X-Gm-Message-State: AOAM533HoRYj/Y3uRpQXB93wJokL+sPLjRyhAf4CxWSHys4LzdYryOcD
	MocQSBvFmtg2veKGYmYwgwXHdcIAjnBhmm0f6U4=
X-Google-Smtp-Source: 
 ABdhPJxIvIhsrps+KNmGo8h+5aZ1bajFU7oWAsGzLtBq6ZHT8EVH3uTr0Lqn3eTW9VD5692MwOzTb0lfgLHdhajAHoI=
X-Received: by 2002:a05:6402:1e92:: with SMTP id
 f18mr15694106edf.153.1637270110613;
 Thu, 18 Nov 2021 13:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20211118135421.4068596-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20211118135421.4068596-1-richard.purdie@linuxfoundation.org>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 18 Nov 2021 14:14:57 -0700
Message-ID: 
 <CABcZANk2sMUxGVhoDg8NiViDp5yQruJQB+6_6iR0fWnkCZghfg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] utils: Handle lockfile filenames that are
 too long for filesystems
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000058367805d116a7f0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 21:15:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13073

--00000000000058367805d116a7f0
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 18, 2021 at 6:54 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> The fetcher mirror code can go crazy creating lock filenames which exceed
> the
> filesystem limits. When this happens, the code will loop/hang.
>
> Handle the filename too long exception correctly but also truncate lockfile
> lengths to under 256 since the worst case situation is lockfile overlap
> and lack of parallelism.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/utils.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 70634910f7..23ff64df7a 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -451,6 +451,11 @@ def lockfile(name, shared=False, retry=True,
> block=False):
>      consider the possibility of sending a signal to the process to break
>      out - at which point you want block=True rather than retry=True.
>      """
> +    if len(name) > 255:
> +        components = name.rsplit(".", 1)
> +        components[0] = components[0][:255 - len(components[1]) - 1]
> +        name = ".".join(components)
>

I think this may be easier to read with separate variables and
os.path.splitext:

    root, ext = os.path.splitext(name)
    name = root[:255 - len(ext) - 1] + ext
-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--00000000000058367805d116a7f0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 18, 2021 at 6:54 AM Richa=
rd Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard=
.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The fetcher mirror code can go crazy creating lo=
ck filenames which exceed the<br>
filesystem limits. When this happens, the code will loop/hang.<br>
<br>
Handle the filename too long exception correctly but also truncate lockfile=
<br>
lengths to under 256 since the worst case situation is lockfile overlap<br>
and lack of parallelism.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
---<br>
=C2=A0lib/bb/utils.py | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index 70634910f7..23ff64df7a 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -451,6 +451,11 @@ def lockfile(name, shared=3DFalse, retry=3DTrue, block=
=3DFalse):<br>
=C2=A0 =C2=A0 =C2=A0consider the possibility of sending a signal to the pro=
cess to break<br>
=C2=A0 =C2=A0 =C2=A0out - at which point you want block=3DTrue rather than =
retry=3DTrue.<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 if len(name) &gt; 255:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 components =3D name.rsplit(&quot;.&quot;, 1)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 components[0] =3D components[0][:255 - len(com=
ponents[1]) - 1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 name =3D &quot;.&quot;.join(components)<br></b=
lockquote><div><br></div><div>I think this may be easier to read with separ=
ate variables and os.path.splitext:</div><div><br></div><div>=C2=A0 =C2=A0 =
root, ext =3D os.path.splitext(name)</div><div>=C2=A0 =C2=A0 name =3D root[=
:255 - len(ext) - 1]=C2=A0+ ext</div></div>-- <br><div dir=3D"ltr" class=3D=
"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson=
<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus=
<br>Senior Software Engineer, Mentor Graphics</div></div></div></div></div>

--00000000000058367805d116a7f0--

