Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
	[209.85.217.181])
	by mail.openembedded.org (Postfix) with ESMTP id B40F56BB14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Aug 2013 14:55:16 +0000 (UTC)
Received: by mail-lb0-f181.google.com with SMTP id u14so1537922lbd.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Aug 2013 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=APxQS0BmYAWW5KFWKCpp5DPTLeI/DM31mAw58Eb5lCU=;
	b=oBHFThTCIHdYeJCRr4oOiWy8dPlX7Ij3Jc3v32hch9VuoHnN/cBjjo9dvRCk9S0juH
	5W8UVORj8aSEjgmiIHD8z7y3XAiZyxUTOiN9x7ikqOMypFegKxjTyxq9lHU+imQXw/HN
	QLGSWxFdBTqXg9QRUpvthi5K8jtCxXGcNpofU7zZJfB0JwXjU4anCL4BpYb+/Vy65OTE
	kO4xX3g7xw8zurjsKPpKFlgTIHWFfEJK+UJKPkrmZhvmluzYZovmMXWn/IGUc6bSki2L
	4kQjubkWZmLWoOCt7mL2GTPsjEtmdyI7xY9/V37GWLfEXD0vlESx5cN6eFhgNyLz6Ne4
	QQzg==
X-Received: by 10.152.27.130 with SMTP id t2mr1047904lag.35.1377528916548;
	Mon, 26 Aug 2013 07:55:16 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.53.197 with HTTP; Mon, 26 Aug 2013 07:54:56 -0700 (PDT)
In-Reply-To: <1377356035.6762.193.camel@ted>
References: <1377356035.6762.193.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 26 Aug 2013 07:54:56 -0700
X-Google-Sender-Auth: QNMfe8G_U_A7HqO1hzs89vbuNa8
Message-ID: <CABcZAN=pe52=h7NUyBWCE3s2Eu47fbuBwzpAaCdgaY+nmu_v0w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH v2] data_smart: Add _remove operator
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
X-List-Received-Date: Mon, 26 Aug 2013 14:55:17 -0000
Content-Type: multipart/alternative; boundary=089e0160b6d0bd21a904e4daf1bd

--089e0160b6d0bd21a904e4daf1bd
Content-Type: text/plain; charset=UTF-8

On Sat, Aug 24, 2013 at 7:53 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> @@ -583,6 +588,14 @@ class DataSmart(MutableMapping):
>                  value = copy.copy(local_var["defaultval"])
>          if expand and value:
>              value = self.expand(value, None)
> +        if value and flag == "_content" and local_var and "_removeactive"
> in local_var:
> +            for i in local_var["_removeactive"]:
> +                if " " + i + " " in value:
> +                    value = value.replace(" " + i + " ", " ")
> +                if value.startswith(i + " "):
> +                    value = value[len(i + " "):]
> +                if value.endswith(" " + i):
> +                    value = value[:-len(" " + i)]
>

I'm curious, did you profile this implementation vs a split-filter-rejoin?
-- 
Christopher Larson

--089e0160b6d0bd21a904e4daf1bd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Aug 24, 2013 at 7:53 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":10q" style=3D"overflow:hidden">@=
@ -583,6 +588,14 @@ <span class=3D"il">class</span> DataSmart(MutableMappin=
g):<br>


=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D cop=
y.copy(local_var[&quot;defaultval&quot;])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if expand and value:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D self.expand(value=
, None)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if value and flag =3D=3D &quot;_content&quot; =
and local_var and &quot;_removeactive&quot; in local_var:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for i in local_var[&quot;_remove=
active&quot;]:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot; &quot; +=
 i + &quot; &quot; in value:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valu=
e =3D value.replace(&quot; &quot; + i + &quot; &quot;, &quot; &quot;)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if value.startswit=
h(i + &quot; &quot;):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valu=
e =3D value[len(i + &quot; &quot;):]<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if value.endswith(=
&quot; &quot; + i):<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0valu=
e =3D value[:-len(&quot; &quot; + i)]</div></blockquote></div><br>I&#39;m c=
urious, did you profile this implementation vs a split-filter-rejoin?<br>--=
 <br>Christopher Larson</div></div>

--089e0160b6d0bd21a904e4daf1bd--
