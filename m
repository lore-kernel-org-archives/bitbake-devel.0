Return-Path: <msm-oss@mcclintock.net>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id AFB9D71CA3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Mar 2017 03:19:05 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id o126so2137511pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Mar 2017 19:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=JJ2sMQ2W0IVAjeEAmtWAU3zuo9+s21yHYYXN0dg4qMY=;
	b=HzNCezE0t3ZMkn6L/4NELwGz/BrDFZehaIhqd3rv+ULk7tdPthJHnyIcjxmUyTbSM0
	1kVnAKa6UnbvyXkgND6+jSE8hP+S4LfqstY1aF0H93ndeFPQzlB+ZazT9D0Wj/4AvBQF
	I+xGTW18XQvvIdFjgeir4QMKpNaOP1Tr6N1r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=JJ2sMQ2W0IVAjeEAmtWAU3zuo9+s21yHYYXN0dg4qMY=;
	b=c5HY3JLy/3/yjhJ/I9X3m11oqTEeZaj670O0uPtLXBLP0qu8BNft6gfQm6gsXGTtlD
	ZDs59/kC6sPvAIAnVb3PjI+CdCN2UUL8EAdepW/jmb2ZQPXk7lShRh5Iw9TI0kIws7ER
	qhig2qQSHS7lhWOPyUD4GqeV+6XO2yc7Jp/MAdyTYzpqQR/iVpJ2tfWyBVDrWRoR+cXm
	b9NnTZQ+DKJXyl+zQ/vttF/6UmYDFWbFe21WrRrewuOR8stw2/QqRb7JDoteUL4GqMF+
	umRgLb2nsokzNktsk27Yvk+RyWNEPPrNX3NOlO1Vwd9mUaYWVMJ2QO5jReC5WtuFK+ZG
	r6kg==
X-Gm-Message-State: AMke39ksXp7/tLqA6opcQr6RbkK9lACtpq40cszAefydGbL5Hq3zwwLLf32R5YtvL7VFYPdz6wIGBPHkbBsaVg==
X-Received: by 10.99.108.74 with SMTP id h71mr4113895pgc.99.1488943146785;
	Tue, 07 Mar 2017 19:19:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.177.198 with HTTP; Tue, 7 Mar 2017 19:19:05 -0800 (PST)
Received: by 10.100.177.198 with HTTP; Tue, 7 Mar 2017 19:19:05 -0800 (PST)
In-Reply-To: <CABcZAN=48nxf2k4v0eKdbNs8pz+NnRh4gHaC_n7cEBKVVAHEng@mail.gmail.com>
References: <1488941850-22002-1-git-send-email-msm-oss@mcclintock.net>
	<CABcZAN=48nxf2k4v0eKdbNs8pz+NnRh4gHaC_n7cEBKVVAHEng@mail.gmail.com>
From: Matthew McClintock <msm-oss@mcclintock.net>
Date: Tue, 7 Mar 2017 21:19:05 -0600
Message-ID: <CAEsOVNcf+FJKm37LafOdX8igEZ+JG+EadBGVmY745TwRQaStTw@mail.gmail.com>
To: Chris Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Wed, 08 Mar 2017 03:19:05 -0000
Content-Type: multipart/alternative; boundary=94eb2c1407425af28b054a2f97fc

--94eb2c1407425af28b054a2f97fc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mar 7, 2017 9:10 PM, "Christopher Larson" <kergoth@gmail.com> wrote:


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
> @@ -287,6 +287,9 @@ class BitBakeConfigParameters(cooker
> data.ConfigParameters):
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


Ah I was struggling with the verbiage here. Feel free to make a suggestion
otherwise I'll try for something better tomorrow.

-M


--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--94eb2c1407425af28b054a2f97fc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Mar 7, 2017 9:10 PM, &quot;Christopher Larson&quot; &lt;<a hre=
f=3D"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&gt; wrote:<br type=3D"=
attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_=
extra"><div class=3D"elided-text"><br><div class=3D"gmail_quote">On Tue, Ma=
r 7, 2017 at 7:57 PM, Matthew McClintock <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:msm-oss@mcclintock.net" target=3D"_blank">msm-oss@mcclintock.net</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>For example:<br>
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
net" target=3D"_blank">msm-oss@mcclintock.net</a>&gt;<br>
---<br>
=C2=A0lib/bb/cookerdata.py |=C2=A0 1 +<br>
=C2=A0lib/bb/main.py=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
</span>=C2=A0lib/bb/runqueue.py=C2=A0 =C2=A0| 14 ++++++++++++++<br>
=C2=A03 files changed, 18 insertions(+)<br>
<span><br>
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
@@ -287,6 +287,9 @@ class BitBakeConfigParameters(cooker<wbr>data.ConfigPar=
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
+</span></blockquote></div><br></div>This looks good (I=E2=80=99m sick of h=
aving to keep adding =E2=80=98all=E2=80=99 variants for tasks), but I don=
=E2=80=99t think this argument help description is very clear.</div></div><=
/blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Ah I was struggling with the verbiage here. Feel free to make a suggestion=
 otherwise I&#39;ll try for something better tomorrow.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">-M</div><div dir=3D"auto"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div d=
ir=3D"ltr"><div class=3D"gmail_extra"><font color=3D"#888888"><br>-- <br><d=
iv class=3D"m_9127871252908766455gmail_signature" data-smartmail=3D"gmail_s=
ignature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kerg=
oth at gmail dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Seni=
or Software Engineer, Mentor Graphics</div></div></div></div>
</font></div></div>
</blockquote></div><br></div></div></div>

--94eb2c1407425af28b054a2f97fc--
