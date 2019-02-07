Return-Path: <kergoth@gmail.com>
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
	[209.85.210.51])
	by mail.openembedded.org (Postfix) with ESMTP id 36E296C3AD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Feb 2019 22:00:16 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id s5so2557645oth.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2019 14:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=snBPjLy8hpNSVqtVp+krzNyRSn7dA9euYbCq6a+7WcE=;
	b=FbSyEPmVLnCf9W9pfJVA+BeoK3ukR0pB6TsN00UNE9gmkGhPCju+yRC3Z2nJVRYguR
	NOhlSwhZadR+wy2fpwsJT+fdMhmakX+2Q68OXBg44OJFlDT1Tlm9S5vIB445v0yT7Nk+
	i3AngHwcM9cYmw13T8m36lOaNpx9p/Cedb8Mw2pmDYDysot8BOrHmf3soCBmdR47nJzg
	fZDtTTAbzROg58rQThSAeuikTnoMGtyBzIYsiosgUCZTuk70g70fBeSw7x3U6On8TnAG
	fcdVdfiuJRTZW9IsU6+B0VFTa1D2s5EP381ZSP/bSq8husGG0+nO47yvUsjUi0vk3mlg
	k6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=snBPjLy8hpNSVqtVp+krzNyRSn7dA9euYbCq6a+7WcE=;
	b=hmB9jzzFhY78/44Baq7zvdySoSYBOo3iWtw97Bku/aPHOKN9xJU5antGoN7KQSIK4R
	PSNnCA+HcNKr/EWH1P06+eumgpsKeGwZvbsk621Ta71SKOruVZdzplwOuxsTRUbUEkUd
	EC21zpXmLZXQ9BicQhaW8lKF27EE7WdV08y66EQB35SUAaArCiRKNyfNI4SyEqTPpDsJ
	PgoSbw+LAycmoKCWBVvrVzYRyJ9BnB/aC1802NMXdDa6Tjm/QhT2eAiddSmGNl3PXfYm
	QF3U8a9CHVdBZ1KNOJP/Y8Z+D/SPYKNWkEzCTEhvu4ZD7XDECweEOtKpcJeZ3YtjqXbA
	tLgA==
X-Gm-Message-State: AHQUAuYvwogtUi9ItY8b9iwWqjBVSbJDhw+AaWM0xmK+gfPnWudIUK4l
	5EmM4ynNUZ2V8jTeNk2D7qECd+oKjP/xClcNLOE=
X-Google-Smtp-Source: AHgI3IZDrpl7ffN8O/mygiWEQ18a9rdlwdrReT6OgDuUvhCa28gD2GogxrYfWdSPzj5JXDP3R0BkS+xR2cgJC7HHQ9o=
X-Received: by 2002:a9d:2f64:: with SMTP id h91mr10057874otb.14.1549576817002; 
	Thu, 07 Feb 2019 14:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20190207165603.20306-1-JPEWhacker@gmail.com>
In-Reply-To: <20190207165603.20306-1-JPEWhacker@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 7 Feb 2019 15:00:06 -0700
Message-ID: <CABcZANmcMktwVzck8ui_Wx+h3NTi+kJY_UqRB0ejRXbyKR8_XQ@mail.gmail.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: Allow arguments in FAKEROOTCMD
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
X-List-Received-Date: Thu, 07 Feb 2019 22:00:16 -0000
Content-Type: multipart/alternative; boundary="000000000000bacffc058154f7b6"

--000000000000bacffc058154f7b6
Content-Type: text/plain; charset="UTF-8"

This should really use shlex.split rather than str.split to handle quoting,
etc.

On Thu, Feb 7, 2019 at 9:56 AM Joshua Watt <jpewhacker@gmail.com> wrote:

> Changes FAKEROOTCMD so that it can accept additional arguments to pass
> to the fakeroot implementation instead of being treated as a simple
> command
>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/runqueue.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 6002ccf06a8..56b8319528c 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1221,12 +1221,12 @@ class RunQueue:
>          if fakeroot:
>              magic = magic + "beef"
>              mcdata = self.cooker.databuilder.mcdata[mc]
> -            fakerootcmd = mcdata.getVar("FAKEROOTCMD")
> +            fakerootcmd = mcdata.getVar("FAKEROOTCMD").split()
>              fakerootenv = (mcdata.getVar("FAKEROOTBASEENV") or "").split()
>              env = os.environ.copy()
>              for key, value in (var.split('=') for var in fakerootenv):
>                  env[key] = value
> -            worker = subprocess.Popen([fakerootcmd, "bitbake-worker",
> magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
> +            worker = subprocess.Popen(fakerootcmd + ["bitbake-worker",
> magic], stdout=subprocess.PIPE, stdin=subprocess.PIPE, env=env)
>          else:
>              worker = subprocess.Popen(["bitbake-worker", magic],
> stdout=subprocess.PIPE, stdin=subprocess.PIPE)
>          bb.utils.nonblockingfd(worker.stdout)
> --
> 2.20.1
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

--000000000000bacffc058154f7b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This should really use shlex.split rather than str.split t=
o handle quoting, etc.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Thu, Feb 7, 2019 at 9:56 AM Joshua Watt &lt;<a hre=
f=3D"mailto:jpewhacker@gmail.com">jpewhacker@gmail.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,20=
4);padding-left:1ex">Changes FAKEROOTCMD so that it can accept additional a=
rguments to pass<br>
to the fakeroot implementation instead of being treated as a simple<br>
command<br>
<br>
Signed-off-by: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" targ=
et=3D"_blank">JPEWhacker@gmail.com</a>&gt;<br>
---<br>
=C2=A0bitbake/lib/bb/runqueue.py | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py<br>
index 6002ccf06a8..56b8319528c 100644<br>
--- a/bitbake/lib/bb/runqueue.py<br>
+++ b/bitbake/lib/bb/runqueue.py<br>
@@ -1221,12 +1221,12 @@ class RunQueue:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if fakeroot:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0magic =3D magic + &quot;bee=
f&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mcdata =3D self.cooker.data=
builder.mcdata[mc]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fakerootcmd =3D mcdata.getVar(&q=
uot;FAKEROOTCMD&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fakerootcmd =3D mcdata.getVar(&q=
uot;FAKEROOTCMD&quot;).split()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fakerootenv =3D (mcdata.get=
Var(&quot;FAKEROOTBASEENV&quot;) or &quot;&quot;).split()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env =3D os.environ.copy()<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for key, value in (var.spli=
t(&#39;=3D&#39;) for var in fakerootenv):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env[key] =3D =
value<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker =3D subprocess.Popen([fak=
erootcmd, &quot;bitbake-worker&quot;, magic], stdout=3Dsubprocess.PIPE, std=
in=3Dsubprocess.PIPE, env=3Denv)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 worker =3D subprocess.Popen(fake=
rootcmd + [&quot;bitbake-worker&quot;, magic], stdout=3Dsubprocess.PIPE, st=
din=3Dsubprocess.PIPE, env=3Denv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0worker =3D subprocess.Popen=
([&quot;bitbake-worker&quot;, magic], stdout=3Dsubprocess.PIPE, stdin=3Dsub=
process.PIPE)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.nonblockingfd(worker.stdout)<br>
-- <br>
2.20.1<br>
<br>
-- <br>
_______________________________________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/mailman/li=
stinfo/bitbake-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--000000000000bacffc058154f7b6--
