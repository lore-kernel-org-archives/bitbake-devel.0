Return-Path: <kergoth@gmail.com>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
	[74.125.82.193])
	by mail.openembedded.org (Postfix) with ESMTP id A52A177776
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Mar 2017 03:10:08 +0000 (UTC)
Received: by mail-ot0-f193.google.com with SMTP id a12so2642983ota.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Mar 2017 19:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=jFFkpiKBRbzNTdqW2HJqY32Qx5Mj3tgRhONaE5x3KVU=;
	b=XzU5UVY1KA5TfHgtWjM3HILKrV45wgPF1Y7cq2RLAXO0Am+GHZPf6LbFAQrDD9PAVc
	9XtXBLav0FOaUPGgsIFiYazDu3fR2T61lKuXwqLIDCaIlD5NBWpDB95zLLak0xElh8aD
	LkfGLlIj8td0UHTexzvRTWepiFfx2pCzzKIr2uCMRhwbSg6EycnW8HVeSumoyM0UwXIv
	8EYDd8pvtODy8uvqgQOay3JqXh6JNLD8qGu72Y1t515dCATxZ2Ba4CrGAu666AnqqFh/
	czU+LH5h0ruO5qmtAp4vdyWwaPs6/BqK1OcOiqrJp9Odyl47BlpT4TOZCR8E4Rxt3jfU
	MzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=jFFkpiKBRbzNTdqW2HJqY32Qx5Mj3tgRhONaE5x3KVU=;
	b=jNzIV5e2d1B7qoSn0C2lA9EkxmJH4RIrk3pidfERZMZ4FDfzxjstWy3SF4lBlNq0Lj
	6UIZoI/iSQkh6RioLE3oe8EkjV76Nwy/t9POrtHup7ItUNYD4r8dMdgLThnRughNoH6R
	sygpeX4dDp6b74E/3db9DK3SjDp+52/UqPiPj47Ez/pGK7wEVHlmWOKMaYsBbNstlEem
	Sf7YuOAMAWFzCy6tOItQ14SVp8Zi5YU/mc/MyaHDRtOGxMbc0ugSjAJ71NZlzY6j2OPs
	OpepPOhNWI/KL4I8xOkW3LNbAodqWUfU38zHSDd3D/uYxpbq88CIhor/XDPN+UH39b5q
	wmGQ==
X-Gm-Message-State: AMke39kfP0MNhNrMgbPV1csq5ZULxvwTsw9jPF7vYwbHuRaD5EcuDho60VPDwOOipl1TJvSPbAqMrkMIfjt4Hw==
X-Received: by 10.157.34.36 with SMTP id o33mr2428308ota.111.1488942609721;
	Tue, 07 Mar 2017 19:10:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.32.161 with HTTP; Tue, 7 Mar 2017 19:09:49 -0800 (PST)
In-Reply-To: <1488941850-22002-1-git-send-email-msm-oss@mcclintock.net>
References: <1488941850-22002-1-git-send-email-msm-oss@mcclintock.net>
From: Christopher Larson <kergoth@gmail.com>
Date: Tue, 7 Mar 2017 20:09:49 -0700
Message-ID: <CABcZAN=48nxf2k4v0eKdbNs8pz+NnRh4gHaC_n7cEBKVVAHEng@mail.gmail.com>
To: Matthew McClintock <msm-oss@mcclintock.net>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] runqueue: add option to run all tasks in specific build target
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 08 Mar 2017 03:10:09 -0000
Content-Type: multipart/alternative; boundary=001a113ad6a657f1e6054a2f772f

--001a113ad6a657f1e6054a2f772f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 7, 2017 at 7:57 PM, Matthew McClintock <msm-oss@mcclintock.net>
wrote:

> For example:
>
> $ bitbake core-image-minimal --runall unpack
> ...
> NOTE: Tasks Summary: Attempted 326 tasks of which 88 didn't need to be
> rerun and all succeeded.
>
> $ bitbake core-image-minimal --runall patch
> NOTE: Tasks Summary: Attempted 453 tasks of which 332 didn't need to be
> rerun and all succeeded.
>
> This can replace fetchall as well:
> $ bitbake core-image-minimal --runall fetch
> NOTE: Tasks Summary: Attempted 135 tasks of which 119 didn't need to be
> rerun and all succeeded.
>
> Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
> ---
>  lib/bb/cookerdata.py |  1 +
>  lib/bb/main.py       |  3 +++
>  lib/bb/runqueue.py   | 14 ++++++++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 53f4587..722d860 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -148,6 +148,7 @@ class CookerConfiguration(object):
>          self.writeeventlog =3D False
>          self.server_only =3D False
>          self.limited_deps =3D False
> +        self.runall =3D None
>
>          self.env =3D {}
>
> diff --git a/lib/bb/main.py b/lib/bb/main.py
> index 3ff43cf..bda3e0c 100755
> --- a/lib/bb/main.py
> +++ b/lib/bb/main.py
> @@ -287,6 +287,9 @@ class BitBakeConfigParameters(
> cookerdata.ConfigParameters):
>                            help=3D"Writes the event log of the build to a
> bitbake event json file. "
>                                 "Use '' (empty string) to assign the name
> automatically.")
>
> +        parser.add_option("", "--runall", action=3D"store", dest=3D"runa=
ll",
> +                          help=3D"Run all tasks in build target that is
> specified.")
> +


This looks good (I=E2=80=99m sick of having to keep adding =E2=80=98all=E2=
=80=99 variants for
tasks), but I don=E2=80=99t think this argument help description is very cl=
ear.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a113ad6a657f1e6054a2f772f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Mar 7, 2017 at 7:57 PM, Matthew McClintock <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:msm-oss@mcclintock.net" target=3D"_blank">msm-oss@mcclintoc=
k.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">For example:<br>
<br>
$ bitbake core-image-minimal --runall unpack<br>
...<br>
NOTE: Tasks Summary: Attempted 326 tasks of which 88 didn&#39;t need to be =
rerun and all succeeded.<br>
<br>
$ bitbake core-image-minimal --runall patch<br>
NOTE: Tasks Summary: Attempted 453 tasks of which 332 didn&#39;t need to be=
 rerun and all succeeded.<br>
<br>
This can replace fetchall as well:<br>
$ bitbake core-image-minimal --runall fetch<br>
NOTE: Tasks Summary: Attempted 135 tasks of which 119 didn&#39;t need to be=
 rerun and all succeeded.<br>
<br>
Signed-off-by: Matthew McClintock &lt;<a href=3D"mailto:msm-oss@mcclintock.=
net">msm-oss@mcclintock.net</a>&gt;<br>
---<br>
=C2=A0lib/bb/cookerdata.py |=C2=A0 1 +<br>
=C2=A0lib/bb/main.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
</span>=C2=A0lib/bb/runqueue.py=C2=A0 =C2=A0| 14 ++++++++++++++<br>
=C2=A03 files changed, 18 insertions(+)<br>
<span class=3D""><br>
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py<br>
index 53f4587..722d860 100644<br>
--- a/lib/bb/cookerdata.py<br>
+++ b/lib/bb/cookerdata.py<br>
@@ -148,6 +148,7 @@ class CookerConfiguration(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.writeeventlog =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.server_only =3D False<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.limited_deps =3D False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.runall =3D None<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.env =3D {}<br>
<br>
diff --git a/lib/bb/main.py b/lib/bb/main.py<br>
index 3ff43cf..bda3e0c 100755<br>
--- a/lib/bb/main.py<br>
+++ b/lib/bb/main.py<br>
@@ -287,6 +287,9 @@ class BitBakeConfigParameters(<wbr>cookerdata.ConfigPar=
ameters):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;Writes the event log of the build to a=
 bitbake event json file. &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Use &#39;&#39; (empty string) =
to assign the name automatically.&quot;)<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_option(&quot;&quot;, &quot;--runall=
&quot;, action=3D&quot;store&quot;, dest=3D&quot;runall&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 help=3D&quot;Run all tasks in build target that is specif=
ied.&quot;)<br>
+</span></blockquote></div><br>This looks good (I=E2=80=99m sick of having =
to keep adding =E2=80=98all=E2=80=99 variants for tasks), but I don=E2=80=
=99t think this argument help description is very clear.<br>-- <br><div cla=
ss=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
<div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Fou=
nder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mento=
r Graphics</div></div></div></div>
</div></div>

--001a113ad6a657f1e6054a2f772f--
