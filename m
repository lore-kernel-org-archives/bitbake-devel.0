Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
	[209.85.218.44])
	by mail.openembedded.org (Postfix) with ESMTP id C9E4F78B36
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jul 2018 02:29:46 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id b15-v6so295203oib.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=K9YxrNaA05YjWuO8TIrXfnVRsFy2JL/RrmT89NPwzzE=;
	b=XEIC5RK3BOcR3JCxWH1dXgZV7It+Tmy4YZu8NPJ1X8PSTnwpK/03tu3/XZNsyiwarw
	W97YyLDgIsQylpfTfRs9i8wtvcwotmy+jVz15g+7PrFuYHXU4BQZzK25Dzl0fOeVkh0l
	eAKr1l0+38SJ5Sx0CsSzZUwzsB0OI6e9TqAf0EeqWHt1iJ62YedWn1mhswQSouFdIYqn
	BnraEEGqPUtxFVTLfuFY5i4mjrG+0ySwEeSfDlVXaajV/wxmAv6jbcA40GX6TxnUYubz
	wvfligNyoPzPyOjxnZXSXlGTYRVPPPgAcLzMRS5uR70HARUZ3Q8uyP14L+Oxma19aQR1
	lfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=K9YxrNaA05YjWuO8TIrXfnVRsFy2JL/RrmT89NPwzzE=;
	b=hFBmf1Yrra/QKXre0xqeYdf3Pza3/RQ7d+ER9ZWbhzdDfErg1OLrkS7FIaLYcelDmf
	d0nk/VeiZhQND+sn4FjMXcYQ4y+Vl5Jt6Ivcx6PxX7xHQUg0rH8P5GBsHvAGs1PPDA63
	kskKz9xSazdNJiYDlxfxFORFG24/W0dyiw7fQq5Jnw2sMGTdI0YBS58XLhVUFTxvwp33
	BjqvQaOKuya9a1QMQ5kPa7EZGqCu57jY9ml0HonEPR3mPcvDqiUkykTltQlkBRuiUnw5
	YxcSerbbHo2v1lXHtD1tYq0QFwyowbSL4woLQTpqjtBaB/lFtJfSWozEO/S2LZT1IV7n
	UzTw==
X-Gm-Message-State: AOUpUlGyC0ZQCNOh0uM/92yYBCkzTTE+RmpyMBJ3BAjoCcPLxarJ2Dy8
	PI4VwgTgC9ZKKpRHqJ3qZ3mh3diHKhVbvYWRJIg=
X-Google-Smtp-Source: AAOMgpcGWEXVy5OAYxCvBeNuA+VeXthgFqCR3idTKcQKLKeNcmdFKom8FjcJTqzFj9I9NeGUWsicpJyg5WHR/RoH6Xs=
X-Received: by 2002:aca:2c3:: with SMTP id 186-v6mr65488oic.85.1532572187525; 
	Wed, 25 Jul 2018 19:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <1532564810-2025-1-git-send-email-changhyeok.bae@gmail.com>
In-Reply-To: <1532564810-2025-1-git-send-email-changhyeok.bae@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 25 Jul 2018 19:28:41 -0700
Message-ID: <CABcZANmPoDTRWoKCm8w1KL9uw0iNaMCfrM5C8rY_cSCyRDGZMw@mail.gmail.com>
To: changhyeok.bae@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v2][1.32] fetch2: fix import error for Python 3.6.5
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
X-List-Received-Date: Thu, 26 Jul 2018 02:29:46 -0000
Content-Type: multipart/alternative; boundary="000000000000d4871b0571ddc451"

--000000000000d4871b0571ddc451
Content-Type: text/plain; charset="UTF-8"

subprocess searches PATH by default, /usr/bin/env is redundant anywhere but
in a #! line of an executable script, as far as I know.

On Wed, Jul 25, 2018 at 5:27 PM Changhyeok Bae <changhyeok.bae@gmail.com>
wrote:

> From: Tzu Hsiang Lin <t9360341@ntut.org.tw>
>
> When running bitbake command with Python 3.6.5 always result in
> import error causing by the change of distutils module.
> This patch replaces the method to search executable in PATH by
> "/usr/bin/env <command>".
>
> Signed-off-by: Tzu Hsiang Lin <t9360341@ntut.org.tw>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Changhyeok Bae <changhyeok.bae@gmail.com>
> ---
>  lib/bb/fetch2/clearcase.py | 3 +--
>  lib/bb/fetch2/npm.py       | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py
> index 70e280a..41cd46f 100644
> --- a/lib/bb/fetch2/clearcase.py
> +++ b/lib/bb/fetch2/clearcase.py
> @@ -70,7 +70,6 @@ from   bb.fetch2 import FetchMethod
>  from   bb.fetch2 import FetchError
>  from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
> -from   distutils import spawn
>
>  class ClearCase(FetchMethod):
>      """Class to fetch urls via 'clearcase'"""
> @@ -108,7 +107,7 @@ class ClearCase(FetchMethod):
>          else:
>              ud.module = ""
>
> -        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or
> spawn.find_executable("cleartool") or spawn.find_executable("rcleartool")
> +        ud.basecmd = d.getVar("FETCHCMD_ccrc", True) or "/usr/bin/env
> cleartool || rcleartool"
>
>          if data.getVar("SRCREV", d, True) == "INVALID":
>            raise FetchError("Set a valid SRCREV for the clearcase fetcher
> in your recipe, e.g. SRCREV = \"/main/LATEST\" or any other label of your
> choice.")
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index 699ae72..7ccaba9 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -33,7 +33,6 @@ from   bb.fetch2 import runfetchcmd
>  from   bb.fetch2 import logger
>  from   bb.fetch2 import UnpackError
>  from   bb.fetch2 import ParameterError
> -from   distutils import spawn
>
>  def subprocess_setup():
>      # Python installs a SIGPIPE handler by default. This is usually not
> what
> --
> 2.7.4
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--000000000000d4871b0571ddc451
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">subprocess searches PATH by default, /usr/bin/env is redun=
dant anywhere but in a #! line of an executable script, as far as I know.<b=
r></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Wed, Jul 25, 201=
8 at 5:27 PM Changhyeok Bae &lt;<a href=3D"mailto:changhyeok.bae@gmail.com"=
>changhyeok.bae@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">From: Tzu Hsiang Lin &lt;<a href=3D"mailto:t9360341@ntut.org.tw" targ=
et=3D"_blank">t9360341@ntut.org.tw</a>&gt;<br>
<br>
When running bitbake command with Python 3.6.5 always result in<br>
import error causing by the change of distutils module.<br>
This patch replaces the method to search executable in PATH by<br>
&quot;/usr/bin/env &lt;command&gt;&quot;.<br>
<br>
Signed-off-by: Tzu Hsiang Lin &lt;<a href=3D"mailto:t9360341@ntut.org.tw" t=
arget=3D"_blank">t9360341@ntut.org.tw</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<b=
r>
Signed-off-by: Changhyeok Bae &lt;<a href=3D"mailto:changhyeok.bae@gmail.co=
m" target=3D"_blank">changhyeok.bae@gmail.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/fetch2/clearcase.py | 3 +--<br>
=C2=A0lib/bb/fetch2/npm.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -<br>
=C2=A02 files changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/lib/bb/fetch2/clearcase.py b/lib/bb/fetch2/clearcase.py<br>
index 70e280a..41cd46f 100644<br>
--- a/lib/bb/fetch2/clearcase.py<br>
+++ b/lib/bb/fetch2/clearcase.py<br>
@@ -70,7 +70,6 @@ from=C2=A0 =C2=A0bb.fetch2 import FetchMethod<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import FetchError<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
-from=C2=A0 =C2=A0distutils import spawn<br>
<br>
=C2=A0class ClearCase(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Class to fetch urls via &#39;clearcas=
e&#39;&quot;&quot;&quot;<br>
@@ -108,7 +107,7 @@ class ClearCase(FetchMethod):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ud.module =3D &quot;&quot;<=
br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&quot;FETCHCMD_ccrc&qu=
ot;, True) or spawn.find_executable(&quot;cleartool&quot;) or spawn.find_ex=
ecutable(&quot;rcleartool&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ud.basecmd =3D d.getVar(&quot;FETCHCMD_ccrc&qu=
ot;, True) or &quot;/usr/bin/env cleartool || rcleartool&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if data.getVar(&quot;SRCREV&quot;, d, Tru=
e) =3D=3D &quot;INVALID&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise FetchError(&quot;Set a valid=
 SRCREV for the clearcase fetcher in your recipe, e.g. SRCREV =3D \&quot;/m=
ain/LATEST\&quot; or any other label of your choice.&quot;)<br>
diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
index 699ae72..7ccaba9 100644<br>
--- a/lib/bb/fetch2/npm.py<br>
+++ b/lib/bb/fetch2/npm.py<br>
@@ -33,7 +33,6 @@ from=C2=A0 =C2=A0bb.fetch2 import runfetchcmd<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import logger<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import UnpackError<br>
=C2=A0from=C2=A0 =C2=A0bb.fetch2 import ParameterError<br>
-from=C2=A0 =C2=A0distutils import spawn<br>
<br>
=C2=A0def subprocess_setup():<br>
=C2=A0 =C2=A0 =C2=A0# Python installs a SIGPIPE handler by default. This is=
 usually not what<br>
-- <br>
2.7.4<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><d=
iv dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - =
BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engineer, Mentor Graph=
ics</div></div></div></div>

--000000000000d4871b0571ddc451--
