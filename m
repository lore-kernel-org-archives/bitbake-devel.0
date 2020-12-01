Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.12749.1606840291556428454
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:31:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=L32WoLfh;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id lt17so5399517ejb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drGcfDxZEdOKaR78Cd5Iu/Sf2IItI8lVli5Sqt6NQWs=;
        b=L32WoLfht77LYuc++7dSzrY1lqmE0t48/sSfBwkVx/Y/DkaMeKb7iHaaFmqVsZ6bwy
         cd1Gp5NidSvrxOBMdOzsajUKc3+aP68/VNIkq6tz0ONnLwuDcQn6AuuMAiEiVWcH6Ufq
         W0+kc45qgcEsZvWRzNrOr0EsEbvZ232YP3zdG/vaeJFgu9v9yabEuRsqbHHRojrIfTnb
         837ikg/9Dt5RQbGTeSQ3AYr8+XcW03xW55l3FYvClErauv8gUX0rjR+PD6JsOlyZjIf/
         JEIUtciD3Wg60q3ZrwYqpBC7tNCDR3Xl3GBlqzD1NQVFrsHsy3ub2+vTdHYbVex3b+w/
         4VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drGcfDxZEdOKaR78Cd5Iu/Sf2IItI8lVli5Sqt6NQWs=;
        b=LKsXO+szXGKLVaGmCUh+VbiXXVZh0a0BurQ/yLGMtRgo5Zsy7yl5OSFPURRa2RfvKC
         a/tMKKtLRsH5RMHFmSMvs0Av9ePlCEgLDF62tCOKYjXT5Crw8EEjtqcaF4Kb5wJEYk86
         wuug7fNADunfgl9RTpVwJyHGeHxWQNj1OvnmMXiDvh9uJko9GbpY7Q8DXVIAQXU4lp1b
         mrdRs4YoHMzP+laQLj6aWB4FK6+bDD6VmGjf7glFwLz+ChStfVuKobLjvgMcu9FIeQjJ
         V4Dr+GDOy5N+MpybQl/UL1EiDQUczgVPkYpGj6YSlVDtNOW8KeqVF0xkH2swhKEHuKOM
         iyiA==
X-Gm-Message-State: AOAM533d3MHZOUYhxMzJB6dEtl8F//JXH/ZmcUDnom+N9z+HG8jM1mGk
	Qwcv+qbbq3gzy7fzUnAHn5u/dq7IeiGDmyz0XEE=
X-Google-Smtp-Source: ABdhPJxAHiP0PYB0qVjhqnMmYlE39FB8gYHwYiHB0PcWOjXtxRGun+zvuZ5cATSEgJU+Z2l/BdkGB7PezQOC6kL9zPA=
X-Received: by 2002:a17:906:fa8b:: with SMTP id lt11mr3801763ejb.94.1606840290056;
 Tue, 01 Dec 2020 08:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20201201162627.47760-1-ernstp@gmail.com>
In-Reply-To: <20201201162627.47760-1-ernstp@gmail.com>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 1 Dec 2020 17:31:19 +0100
Message-ID: <CA+chaQdG44jXECKPzUS+YBxvdBXrZg56rY+jWRXc69+GdR=HTw@mail.gmail.com>
Subject: Re: [bitbake-devel] [dunfell 1/5] python3: split python target configuration into own class
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000b31f9405b569a8fa"

--000000000000b31f9405b569a8fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not sure if this is worth backport (it's very useful, but requires changes
in other layers - and these changes aren't backwards compatible so they
would need to be applied only in dunfell and not gatesgarth branches of
these layers or the same patchset would need to land in oe-core/gatesgarth
first).

But you're definitely missing this fix from master:
https://git.openembedded.org/openembedded-core/commit/?id=3Dc99bb79087e74a=
967286469e1d8888a546ebec83

On Tue, Dec 1, 2020 at 5:27 PM Ernst Sj=C3=B6strand <ernstp@gmail.com> wro=
te:

> From: Alexander Kanavin <alex.kanavin@gmail.com>
>
> Setting _PYTHON_SYSCONFIGDATA_NAME in python3native class globally was
> problematic as it was leaking into host python environment, which
> was causing tracebacks depending on host distro and action
> (typically anything involving importing sysconfig module).
>
> The new class sets the variable only in specific tasks where it is neede=
d,
> and should be inherited explicitly:
> - use python3native to run scripts with native python
> - use python3targetconfig to run scripts with native python
> if those scripts need to access target config data (such
> as correct installation directories). This also adds a dependency
> on target python, so should be used carefully to avoid lengthening build=
s.
>
> (From OE-Core rev: 5a118d4e7985fa88f04c3611f8db813f0dafce75)
>
> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit c9f7ed88a946078c27fa1a62d54d6310fad9d37a)
> ---
>  meta/classes/python3native.bbclass       |  2 --
>  meta/classes/python3targetconfig.bbclass | 15 +++++++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>  create mode 100644 meta/classes/python3targetconfig.bbclass
>
> diff --git a/meta/classes/python3native.bbclass
> b/meta/classes/python3native.bbclass
> index d98fb4c758..2e3a88c126 100644
> --- a/meta/classes/python3native.bbclass
> +++ b/meta/classes/python3native.bbclass
> @@ -17,8 +17,6 @@ export STAGING_LIBDIR
>  export PYTHON_LIBRARY=3D"${STAGING_LIBDIR}/lib${PYTHON_DIR}${PYTHON_ABI=
}.so"
>  export PYTHON_INCLUDE_DIR=3D"${STAGING_INCDIR}/${PYTHON_DIR}${PYTHON_AB=
I}"
>
> -export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
> -
>  # suppress host user's site-packages dirs.
>  export PYTHONNOUSERSITE =3D "1"
>
> diff --git a/meta/classes/python3targetconfig.bbclass
> b/meta/classes/python3targetconfig.bbclass
> new file mode 100644
> index 0000000000..640d0c97b6
> --- /dev/null
> +++ b/meta/classes/python3targetconfig.bbclass
> @@ -0,0 +1,15 @@
> +inherit python3native
> +
> +DEPENDS_append =3D " python3"
> +
> +do_configure_prepend() {
> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
> +}
> +
> +do_compile_prepend() {
> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
> +}
> +
> +do_install_prepend() {
> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
> +}
> --
> 2.29.2
>
>
>=20
>
>

--000000000000b31f9405b569a8fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Not sure if this is worth backport (it&#39;s very useful, =
but requires changes in other layers - and these changes aren&#39;t backwar=
ds compatible so they would need to be applied only in dunfell and not gate=
sgarth branches of these layers or the same patchset would need to land in =
oe-core/gatesgarth first).<div><br></div><div>But you&#39;re definitely mis=
sing this fix from master:</div><div><a href=3D"https://git.openembedded.or=
g/openembedded-core/commit/?id=3Dc99bb79087e74a967286469e1d8888a546ebec83">=
https://git.openembedded.org/openembedded-core/commit/?id=3Dc99bb79087e74a9=
67286469e1d8888a546ebec83</a><br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 1, 2020 at 5:27 PM Ernst=
 Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail.com">ernstp@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=
=3D"_blank">alex.kanavin@gmail.com</a>&gt;<br>
<br>
Setting _PYTHON_SYSCONFIGDATA_NAME in python3native class globally was<br>
problematic as it was leaking into host python environment, which<br>
was causing tracebacks depending on host distro and action<br>
(typically anything involving importing sysconfig module).<br>
<br>
The new class sets the variable only in specific tasks where it is needed,=
<br>
and should be inherited explicitly:<br>
- use python3native to run scripts with native python<br>
- use python3targetconfig to run scripts with native python<br>
if those scripts need to access target config data (such<br>
as correct installation directories). This also adds a dependency<br>
on target python, so should be used carefully to avoid lengthening builds.=
<br>
<br>
(From OE-Core rev: 5a118d4e7985fa88f04c3611f8db813f0dafce75)<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.=
com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfo=
undation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<=
br>
(cherry picked from commit c9f7ed88a946078c27fa1a62d54d6310fad9d37a)<br>
---<br>
=C2=A0meta/classes/python3native.bbclass=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 --<br>
=C2=A0meta/classes/python3targetconfig.bbclass | 15 +++++++++++++++<br>
=C2=A02 files changed, 15 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 meta/classes/python3targetconfig.bbclass<br>
<br>
diff --git a/meta/classes/python3native.bbclass b/meta/classes/python3nati=
ve.bbclass<br>
index d98fb4c758..2e3a88c126 100644<br>
--- a/meta/classes/python3native.bbclass<br>
+++ b/meta/classes/python3native.bbclass<br>
@@ -17,8 +17,6 @@ export STAGING_LIBDIR<br>
=C2=A0export PYTHON_LIBRARY=3D&quot;${STAGING_LIBDIR}/lib${PYTHON_DIR}${PY=
THON_ABI}.so&quot;<br>
=C2=A0export PYTHON_INCLUDE_DIR=3D&quot;${STAGING_INCDIR}/${PYTHON_DIR}${P=
YTHON_ABI}&quot;<br>
<br>
-export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sysconfigdata&quot;<br>
-<br>
=C2=A0# suppress host user&#39;s site-packages dirs.<br>
=C2=A0export PYTHONNOUSERSITE =3D &quot;1&quot;<br>
<br>
diff --git a/meta/classes/python3targetconfig.bbclass b/meta/classes/pytho=
n3targetconfig.bbclass<br>
new file mode 100644<br>
index 0000000000..640d0c97b6<br>
--- /dev/null<br>
+++ b/meta/classes/python3targetconfig.bbclass<br>
@@ -0,0 +1,15 @@<br>
+inherit python3native<br>
+<br>
+DEPENDS_append =3D &quot; python3&quot;<br>
+<br>
+do_configure_prepend() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sy=
sconfigdata&quot;<br>
+}<br>
+<br>
+do_compile_prepend() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sy=
sconfigdata&quot;<br>
+}<br>
+<br>
+do_install_prepend() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sy=
sconfigdata&quot;<br>
+}<br>
-- <br>
2.29.2<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000b31f9405b569a8fa--
