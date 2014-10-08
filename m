Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
	[209.85.217.169])
	by mail.openembedded.org (Postfix) with ESMTP id D8C7660167
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Oct 2014 16:21:39 +0000 (UTC)
Received: by mail-lb0-f169.google.com with SMTP id 10so8497949lbg.14
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Oct 2014 09:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=AU2w2444Y1tmNevAvvcxmZ/uKq60Bp2rRetXJ4sjw9I=;
	b=k2WuAkF8/uKIPB42cvBACZBbynXk48LbvGCjPEMIy6VZqn1sLw5im52M2Q0eHhrK60
	MGACDd51sKqZdNfrG7UAnTGuFKM+k3ahbmNQTFhUEnxZK+dPbFCzTETxpbSrVKIiF61L
	QH2fQOlQ/Ej6Kj7tJNOd0SQf8mEr50JkU0/oFvsgqDJ+6i5yZh0p6ljwKu/7CMXqGFEI
	YhCpaoURXaL1CGQUe4JekbrmwYs7wz8Lbwz14m91bCu1/jXBsecxFl6agVs2IJdF3+rb
	eSW+cJRqt6dzV8vMHn3DSy2JM0uiUR4SbVIqtnbg3vaiAS8lFbk05+OCH1ea8INN3U1D
	/woA==
X-Received: by 10.152.87.170 with SMTP id az10mr12553648lab.20.1412784812794; 
	Wed, 08 Oct 2014 09:13:32 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.97.200 with HTTP; Wed, 8 Oct 2014 09:13:12 -0700 (PDT)
In-Reply-To: <1412094118-27406-1-git-send-email-alejandro.hernandez@linux.intel.com>
References: <1412094118-27406-1-git-send-email-alejandro.hernandez@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 8 Oct 2014 09:13:12 -0700
X-Google-Sender-Auth: H6gSX-Oh8lV5iqexEorAberTryE
Message-ID: <CABcZAN=+nJjhKpGXnshy-VuFdW85oXwG5V9KsPMe79qm5cWXsQ@mail.gmail.com>
To: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] fetcher: fix BB_STRICT_CHECKSUM datatype check
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
X-List-Received-Date: Wed, 08 Oct 2014 16:21:41 -0000
Content-Type: multipart/alternative; boundary=001a11c223b6e9286b0504eb984a

--001a11c223b6e9286b0504eb984a
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 30, 2014 at 9:21 AM, Alejandro Hernandez <
alejandro.hernandez@linux.intel.com> wrote:

> Forcing strict to be a string, to avoid problems when performing
> comparisons
>
> [YOCTO #6762]
>
> Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
> ---
>  lib/bb/fetch2/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index df2f2b0..10c3346 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -543,8 +543,8 @@ def verify_checksum(ud, d):
>
>      if ud.method.recommends_checksum(ud):
>          # If strict checking enabled and neither sum defined, raise error
> -        strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
> -        if strict and not (ud.md5_expected or ud.sha256_expected):
> +        strict = d.getVar("BB_STRICT_CHECKSUM", "1") or "0"
> +        if (strict == "1") and not (ud.md5_expected or
> ud.sha256_expected):
>

Why was True (second argument of getVar) changed to "1" here? It violates
our conventions and doesn't actually change anything in the behavior.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c223b6e9286b0504eb984a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Sep 30, 2014 at 9:21 AM, Alejandro Hernandez <span dir=3D"ltr">&lt;=
<a href=3D"mailto:alejandro.hernandez@linux.intel.com" target=3D"_blank">al=
ejandro.hernandez@linux.intel.com</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div id=3D":b1" class=3D"a3s" style=3D"overflow:hidden">Forc=
ing <span class=3D"il">strict</span> to be a string, to avoid problems when=
 performing comparisons<br>
<br>
[YOCTO #6762]<br>
<br>
Signed-off-by: Alejandro Hernandez &lt;<a href=3D"mailto:alejandro.hernande=
z@linux.intel.com">alejandro.hernandez@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/__init__.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py<br>
index df2f2b0..10c3346 100644<br>
--- a/lib/bb/fetch2/__init__.py<br>
+++ b/lib/bb/fetch2/__init__.py<br>
@@ -543,8 +543,8 @@ def verify_checksum(ud, d):<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ud.method.recommends_checksum(ud):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# If <span class=3D"il">strict</span> che=
cking enabled and neither sum defined, raise error<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span class=3D"il">strict</span> =3D d.getVar(=
&quot;BB_STRICT_CHECKSUM&quot;, True) or None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <span class=3D"il">strict</span> and not (u=
d.md5_expected or ud.sha256_expected):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <span class=3D"il">strict</span> =3D d.getVar(=
&quot;BB_STRICT_CHECKSUM&quot;, &quot;1&quot;) or &quot;0&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (<span class=3D"il">strict</span> =3D=3D &q=
uot;1&quot;) and not (ud.md5_expected or ud.sha256_expected):</div></blockq=
uote></div><br>Why was True (second argument of getVar) changed to &quot;1&=
quot; here? It violates our conventions and doesn&#39;t actually change any=
thing in the behavior.<br>-- <br>Christopher Larson<br>clarson at kergoth d=
ot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib=
<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a11c223b6e9286b0504eb984a--
