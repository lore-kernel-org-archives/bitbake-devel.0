Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
	[209.85.218.67])
	by mail.openembedded.org (Postfix) with ESMTP id B884D6003C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 16:33:48 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id u15so19116304oie.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Nov 2016 08:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=nKezdU1BPY48ZhEkW3sxv0i6J4kgTcSklfUPGonrpaY=;
	b=UcvgpgXJexU8rjfgR907Z3v0GISauna41F9QCLOkbKZPweuRF2olnJm3Jsj8J6jQ/X
	lAzbqEWTCisIj2zEmVMUtgBSUcZJStEn+jmYmAcBJiOBESYNf/sJShH2CcxNJ+McsOWb
	/c4f58FHmHRmBFJ7tMGmVNSv2OeDH1XhOZ9JdloqKkpKPchVbl5l1/mhHcY2T1n9mMee
	X3h7zB/1vRJeFYff4q+dvyFpq+mc2mo1aFOI5BmIdGprqIQEGyGufgE/iXZCIAfKyzjK
	t9aGj9oQXY7ZoFiLciVIlVaLCaljcxrqS4lJqjMfgnNnZj06dJ+rB4Uq4pQeR3rQju0N
	KccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=nKezdU1BPY48ZhEkW3sxv0i6J4kgTcSklfUPGonrpaY=;
	b=Fc3ESM2/htUOzSBMmkcu9LxfoWa0gl1f0X+Brki/8mASi3BzYM5dXcBHjVeqHguQnM
	tJPrtmfeQUZZZ1PCxGQkFU4zRUPF0mJxnaFhB+7pmvk7FH4ubEQ8NatpaOffTnmTmqXS
	R7RiORQ1zODuNSqUguPHUT4P9Tb6l9TlAUs0qTR7C9TnDFnWGUURTP5ILE3fg4mXF75p
	eu0WIv5nWJIEON06tyrHWW4GcAQ/zkTDu3gDrL338VBKyWBL3rB6i6Ajk3Nn99B93e8M
	eDxtiLxWVQUojGgZ+qDP3+IIuRkVy5ZJIENUwZB2ipxBA4PaKO3XZY0JFNxrJAk/O+mj
	eR6A==
X-Gm-Message-State: AKaTC01M8npCmcGrLh4ykfTgzj6vx41pBqepW35kygx2HB1QmDc0YUIHHQti+WinbkdiCIorRikGyfFuU3vVdg==
X-Received: by 10.202.228.139 with SMTP id b133mr15768802oih.111.1480437229886;
	Tue, 29 Nov 2016 08:33:49 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.14.20 with HTTP; Tue, 29 Nov 2016 08:33:29 -0800 (PST)
In-Reply-To: <3bd6cc67f0c3973b554f0a77e1db5b96318bea82.1480412829.git.sujith.h@gmail.com>
References: <cover.1480412829.git.sujith.h@gmail.com>
	<3bd6cc67f0c3973b554f0a77e1db5b96318bea82.1480412829.git.sujith.h@gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 29 Nov 2016 09:33:29 -0700
X-Google-Sender-Auth: EvWfB5oyx9S_VMVmvOHAjCXBL5I
Message-ID: <CABcZAN=RUUi+DT78Kw4e+mNcVp-KuEvUHOWyy-xBa=FgRRoFKA@mail.gmail.com>
To: Sujith Haridasan <sujith.h@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake: cooker: convert type which needs to be marshalled
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
X-List-Received-Date: Tue, 29 Nov 2016 16:33:50 -0000
Content-Type: multipart/alternative; boundary=001a114039d23325490542732750

--001a114039d23325490542732750
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 29, 2016 at 2:57 AM, Sujith Haridasan <sujith.h@gmail.com>
wrote:

> From: Sujith H <sujith.h@gmail.com>
>
> We assume that the value taken by variable v can be string,
> integer or any type which can be marshalled by xmlrpc. This
> change would help us to convert the non marshallable types
> to string. So that we don't get exception from xmlrpc.
>
> [YOCTO #10740]
>
> Signed-off-by: Sujith H <sujith.h@gmail.com>
> ---
>  bitbake/lib/bb/cooker.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index c08af45..1dab450 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1488,7 +1488,7 @@ class BBCooker:
>                  v = self.data.getVar(k, expand)
>                  if not k.startswith("__") and not isinstance(v,
> bb.data_smart.DataSmart):
>                      dump[k] = {
> -    'v' : v ,
> +    'v' : repr(v) ,
>      'history' : self.data.varhistory.variable(k),
>                      }
>                      for d in flaglist:
>

I think str(v) would be more appropriate here. We need it to be a string,
not necessarily a more complete representation of the object.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114039d23325490542732750
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Nov 29, 2016 at 2:57 AM, Sujith Haridasan <span dir=3D"ltr">&lt;<a =
href=3D"mailto:sujith.h@gmail.com" target=3D"_blank">sujith.h@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":12h" class=
=3D"a3s aXjCH m158af84dbcba6f08">From: Sujith H &lt;<a href=3D"mailto:sujit=
h.h@gmail.com">sujith.h@gmail.com</a>&gt;<br>
<br>
We assume that the value taken by variable v can be string,<br>
integer or any type which can be marshalled by xmlrpc. This<br>
change would help us to convert the non marshallable types<br>
to string. So that we don&#39;t get exception from xmlrpc.<br>
<br>
[YOCTO #10740]<br>
<br>
Signed-off-by: Sujith H &lt;<a href=3D"mailto:sujith.h@gmail.com">sujith.h@=
gmail.com</a>&gt;<br>
---<br>
<span class=3D"">=C2=A0<span class=3D"il">bitbake</span>/lib/bb/cooker.py |=
 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
</span>diff --git a/<span class=3D"il">bitbake</span>/lib/bb/cooker.py b/<s=
pan class=3D"il">bitbake</span>/lib/bb/cooker.py<br>
index c08af45..1dab450 100644<br>
--- a/<span class=3D"il">bitbake</span>/lib/bb/cooker.py<br>
+++ b/<span class=3D"il">bitbake</span>/lib/bb/cooker.py<br>
@@ -1488,7 +1488,7 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0v =3D self.da=
ta.getVar(k, expand)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not k.star=
tswith(&quot;__&quot;) and not isinstance(v, bb.data_smart.DataSmart):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dump[k] =3D {<br>
-=C2=A0 =C2=A0 &#39;v&#39; : v ,<br>
+=C2=A0 =C2=A0 &#39;v&#39; : repr(v) ,<br>
=C2=A0 =C2=A0 =C2=A0&#39;history&#39; : self.data.varhistory.variable(<wbr>=
k),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for d in flaglist:</div></blockquote></div><br>I think str(v) would be m=
ore appropriate here. We need it to be a string, not necessarily a more com=
plete representation of the object.<br>-- <br><div class=3D"gmail_signature=
" data-smartmail=3D"gmail_signature">Christopher Larson<br>clarson at kergo=
th dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - T=
slib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a114039d23325490542732750--
