Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id E7D896067C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 15:23:04 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id y195so1231319iod.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Jul 2016 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=w3eykP7kK4rHKGYMvpbfGihCgD3sU7XJO7IPATcAPOc=;
	b=YdgACP0eYNGBvvLwDm0Nv3sp86sFgKidASj/bhmg+Vf4J0/gig7ILMTgZ3o0To47NM
	7NEww7brlkjY1Li1iRbnkMvIdIzEdr/S7wjTG/mUH7vvY39JkFLAAaR17mWmbVrrbQss
	3+EYgboUh2oz466lRAF/zGQtlhwaz4OI3MC2L93NIQtx6CVKHrtsxk1wK6TGW3LFwkGQ
	4ECUbJZk5X1NQ8eebZpt7LtnvEezoOH3dUKmSe7QqGI2DwHb0mlQ30H1FIjYPs1yzfb1
	eQpRsx14jPMComAw8rmjnF490RG9K3ryRaEWrPgaJe58r8A3EV0mv4jECvO9YWkESUxh
	uDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=w3eykP7kK4rHKGYMvpbfGihCgD3sU7XJO7IPATcAPOc=;
	b=eGH4mFTfG7xA+eMw573IgxryXuAq8vdkStCssDf89ZkMWiik08zJrcR6RaXXp08Xhp
	oY1OJauC7KvuCvDyY4HnZPqcMLQSJbsdcULW2raaE1+3NcE6JqTQpEtBoEDv+AgluOf6
	4U4ZK1daC9yj4F+cwpYemzyVcWaNFFDEJOnudmSwvZzd9v/EvF36AbqEGD2RRfjpcT72
	yJJGUVp1mUhFdGz2kwr6hGuOS/peaXu5HiIlXTUeaFYSkKDB76B1Uugmv8dWBmNUyacf
	6iHswhnvcuIBzilB/Qbbjy2J+LO5phS9SesqJ2fGova4SrPG9VWWXOwk0woLaB28UUvv
	fOJg==
X-Gm-Message-State: ALyK8tIlGnZf9e7uKejneaQ6oIG71pw4lXg7e+gqqStK7SUPO7psyCzR7WWXxuAlBgAmt/bN2I70VxGzGRGMJw==
X-Received: by 10.107.205.129 with SMTP id d123mr3555342iog.70.1468336849076; 
	Tue, 12 Jul 2016 08:20:49 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.21.197 with HTTP; Tue, 12 Jul 2016 08:20:29 -0700 (PDT)
In-Reply-To: <1468336521-8177-1-git-send-email-ross.burton@intel.com>
References: <1468336521-8177-1-git-send-email-ross.burton@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 12 Jul 2016 08:20:29 -0700
X-Google-Sender-Auth: wAapSw3yivWPPnbLLTqok7WiIjE
Message-ID: <CABcZAN=KiVhYkSOUBiOdPSW3kKdJJXfWfrV9FE=o4bbjY5wkng@mail.gmail.com>
To: Ross Burton <ross.burton@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] lib/bb/utils: fix set_process_name
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
X-List-Received-Date: Tue, 12 Jul 2016 15:23:05 -0000
Content-Type: multipart/alternative; boundary=94eb2c18a9c2579c65053771d036

--94eb2c18a9c2579c65053771d036
Content-Type: text/plain; charset=UTF-8

On Tue, Jul 12, 2016 at 8:15 AM, Ross Burton <ross.burton@intel.com> wrote:

> With Python 3 create_string_buffer needs a bytes() not a str() but as we
> were
> catching all exceptions nobody noticed.
>
> [ YOCTO #9910 ]
>
> Signed-off-by: Ross Burton <ross.burton@intel.com>
> ---
>  bitbake/lib/bb/utils.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> index 0a1bf68..3bc2437 100644
> --- a/bitbake/lib/bb/utils.py
> +++ b/bitbake/lib/bb/utils.py
> @@ -1444,9 +1444,8 @@ def set_process_name(name):
>      # This is nice to have for debugging, not essential
>      try:
>          libc = cdll.LoadLibrary('libc.so.6')
> -        buff = create_string_buffer(len(name)+1)
> -        buff.value = name
> -        libc.prctl(15, byref(buff), 0, 0, 0)
> +        buf = create_string_buffer(bytes(name, 'utf-8'))
> +        libc.prctl(15, byref(buf), 0, 0, 0)
>      except:
>          pass
>

Why are we catching all exceptions, anyway? That's not usually a good idea.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c18a9c2579c65053771d036
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jul 12, 2016 at 8:15 AM, Ross Burton <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ross.burton@intel.com" target=3D"_blank">ross.burton@intel.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":1ej" cla=
ss=3D"a3s aXjCH m155dfad9e8510148">With Python 3 create_string_buffer needs=
 a bytes() not a str() but as we were<br>
catching all exceptions nobody noticed.<br>
<br>
[ YOCTO #9910 ]<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@intel.com">ros=
s.burton@intel.com</a>&gt;<br>
---<br>
=C2=A0<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/ut=
ils.py | 5 ++---<br>
=C2=A01 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</s=
pan>/utils.py b/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb=
</span>/utils.py<br>
index 0a1bf68..3bc2437 100644<br>
--- a/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/ut=
ils.py<br>
+++ b/<span class=3D"il">bitbake</span>/lib/<span class=3D"il">bb</span>/ut=
ils.py<br>
@@ -1444,9 +1444,8 @@ def set_process_name(name):<br>
=C2=A0 =C2=A0 =C2=A0# This is nice to have for debugging, not essential<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libc =3D cdll.LoadLibrary(&#39;libc.so.6&=
#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buff =3D create_string_buffer(len(name)+1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 buff.value =3D name<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 libc.prctl(15, byref(buff), 0, 0, 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf =3D create_string_buffer(bytes(name, &#39;=
utf-8&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 libc.prctl(15, byref(buf), 0, 0, 0)<br>
=C2=A0 =C2=A0 =C2=A0except:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass</div></blockquote></div><br>Why are =
we catching all exceptions, anyway? That&#39;s not usually a good idea.<br>=
-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Ch=
ristopher Larson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEm=
bedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mento=
r Graphics</div>
</div></div>

--94eb2c18a9c2579c65053771d036--
