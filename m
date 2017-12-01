Return-Path: <nandojve@gmail.com>
Received: from mail-yb0-f170.google.com (mail-yb0-f170.google.com
	[209.85.213.170])
	by mail.openembedded.org (Postfix) with ESMTP id 544CF71B50
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Dec 2017 20:07:11 +0000 (UTC)
Received: by mail-yb0-f170.google.com with SMTP id 184so4451860ybw.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 01 Dec 2017 12:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to; 
	bh=f0JF7Xetx422f/tN/GCxrXkzheNqjQcY1G+MVEjAV6w=;
	b=SpdzdGghq+XOsGRd6YCTdC4ZGLWQwI+EgSZzfXAJJL7LIiFQeuxAP9LKnU51Lk4qKx
	sqFiZGqLGWQxcRXtKrjGu6JXXKqv3Cf57WByrYMUNw/tC3XJsPIOwRw/vN1xySONSLTH
	53ATDb26AunPoWW1NCfInhm1i0W7i0GC28wLj/lWS6HBBDAuHriJV1US8kPNGLKcf3te
	83PQkOFCpaaJfA1vskjD4l4AUqWEE05qvMF+I8p1Zrn9TXA8osSJ/cwpCfC/9mf+36xf
	ZcMIZWFt37yuLSqjl5xcY81jS20X+ZUdvWfRM8ST24Z3DSvslNyfZ/2F8xDkLTu9Jrl0
	WcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to;
	bh=f0JF7Xetx422f/tN/GCxrXkzheNqjQcY1G+MVEjAV6w=;
	b=fM9RS3Qgnaj51G9unk8ELNTeIwbcccRAkRuu0sTena694niOBtoAn5dUo4+di6S2qy
	ryz0toIMik6cJ3WO6zvqvRp5toVoVOHN2pRyx8bHScCAg7LOEd67wbWCXebiHGQ7IhBW
	II3Rx94oOdvqbsZd+7G/wEz+K/TTHevIrLmzuO2FGHOzVv/GLcMKWVpoUqyPWSWsuyv/
	SBDNaAouPZvObO7/HDqhSmRKpSibezuu/PwEPyKEXGnTFEoXAKDNtoibVctNIIDk5sKx
	KgWnntsxCNpo8gwMbPGHFStXWBbHhy/gQRvVxjDfOaM8meKjCMRE8pyTCGS3xcwlFdFO
	R6yQ==
X-Gm-Message-State: AJaThX51FLK8YTwPPqEO0blnmTWPaWjhHnlM4OWSbQXTY8Fdg4oZ3LTE
	A6btFZyaZ+PH5p1oACRf02csb6FaTNuJ7g+gNtiKTA==
X-Google-Smtp-Source: AGs4zMbuSLb6Ea8gu5GAAUZEl4fWdXBpXoDjb6R16UmICF+XDhQoBq4yUiTrTjZUb38AKM0fiyBK/08LHw9mqAo9TzE=
X-Received: by 10.37.7.194 with SMTP id 185mr4465533ybh.90.1512158832962; Fri,
	01 Dec 2017 12:07:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.163.71 with HTTP; Fri, 1 Dec 2017 12:07:12 -0800 (PST)
In-Reply-To: <CABOv41NE7a0+ib2f9NchT=9bJVthSZdxjetwnJfoxdNVDk+hVA@mail.gmail.com>
References: <CABOv41NE7a0+ib2f9NchT=9bJVthSZdxjetwnJfoxdNVDk+hVA@mail.gmail.com>
From: Gerson Fernando Budke <nandojve@gmail.com>
Date: Fri, 1 Dec 2017 18:07:12 -0200
Message-ID: <CABOv41O66-vDvQAYDszGHJbxsJVF=UNPF7HUHGYPvUSV5ssM7A@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: Server timeout after codeparser.py: support deeply nested tokens
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
X-List-Received-Date: Fri, 01 Dec 2017 20:07:12 -0000
Content-Type: multipart/alternative; boundary="001a114e7c84153151055f4cea48"

--001a114e7c84153151055f4cea48
Content-Type: text/plain; charset="UTF-8"

Could this be the final solution?

ping!!

2017-10-09 9:49 GMT-03:00 Gerson Fernando Budke <nandojve@gmail.com>:

> I've been facing the "WARNING: Timeout while attempting to communicate
> with bitbake server"
> after the patch "codeparser.py: support deeply nested tokens" has been
> added in morty branch.
> As I'm using cache the problem is recorrent.
>
> I've been suspected that 'self.process_tokens(tokens)' is more time
> consuming:
>
> -        for token in tokens:
> -            self.process_tokens(token)
> +        self.process_tokens(tokens)
>
> So, I fixed the server timeout value, as follow,
>
> From 26e253c9f1d8767cad0ddc2fd556314c726d725d Mon Sep 17 00:00:00 2001
> From: Gerson Fernando Budke <gerson.budke@intelbras.com.br>
> Date: Mon, 9 Oct 2017 08:25:08 -0300
> Subject: [PATCH] process.py: Update timeout from 5 to 30s
>
> As codeparser support deeply nested tokens and this operation is more
> time consuming the server timeout should be increased to avoid errors
> while attempting to communicate with bitbake server. This increase
> the value from 5 to 30 seconds.
>
> Signed-off-by: Gerson Fernando Budke <gerson.budke@intelbras.com.br>
> ---
>  lib/bb/server/process.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
> index 982fcf7..bcd40bf 100644
> --- a/lib/bb/server/process.py
> +++ b/lib/bb/server/process.py
> @@ -54,7 +54,7 @@ class ServerCommunicator():
>              # don't let the user ctrl-c while we're waiting for a response
>              try:
>                  for idx in range(0,4): # 0, 1, 2, 3
> -                    if self.connection.poll(5):
> +                    if self.connection.poll(30):
>                          return self.connection.recv()
>                      else:
>                          bb.warn("Timeout while attempting to communicate
> with bitbake server")
> --
> 2.7.4
>
> Could this be the final solution?
>

--001a114e7c84153151055f4cea48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"color:rgb(136,136,136);font-size:12.8px">Co=
uld this be the final solution?</span><br><div><span style=3D"color:rgb(136=
,136,136);font-size:12.8px"><br></span></div><div><span style=3D"color:rgb(=
136,136,136);font-size:12.8px">ping!!</span></div></div><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">2017-10-09 9:49 GMT-03:00 Gerson Fer=
nando Budke <span dir=3D"ltr">&lt;<a href=3D"mailto:nandojve@gmail.com" tar=
get=3D"_blank">nandojve@gmail.com</a>&gt;</span>:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><div dir=3D"ltr"><div><div>I&#39;ve been facing the &quot;WARNING:=
 Timeout while attempting to communicate with bitbake server&quot;</div><di=
v>after the patch &quot;codeparser.py: support deeply nested tokens&quot; h=
as been added in morty branch.</div><div>As I&#39;m using cache the problem=
 is recorrent.</div><div><br></div><div>I&#39;ve been suspected that &#39;s=
elf.process_tokens(tokens)&#39; is more time consuming:</div><div><br></div=
><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 for token in tokens:</div><div>-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_tokens(token)</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.process_tokens(tokens)</div><div><br></div=
><div>So, I fixed the server timeout value, as follow,=C2=A0</div></div><di=
v><br></div><div><div>From 26e253c9f1d8767cad0ddc2fd55631<wbr>4c726d725d Mo=
n Sep 17 00:00:00 2001</div><div>From: Gerson Fernando Budke &lt;<a href=3D=
"mailto:gerson.budke@intelbras.com.br" target=3D"_blank">gerson.budke@intel=
bras.com.br</a><wbr>&gt;</div><div>Date: Mon, 9 Oct 2017 08:25:08 -0300</di=
v><div>Subject: [PATCH] process.py: Update timeout from 5 to 30s</div><div>=
<br></div><div>As codeparser support deeply nested tokens and this operatio=
n is more</div><div>time consuming the server timeout should be increased t=
o avoid errors</div><div>while attempting to communicate with bitbake serve=
r. This increase</div><div>the value from 5 to 30 seconds.</div><div><br></=
div><div>Signed-off-by: Gerson Fernando Budke &lt;<a href=3D"mailto:gerson.=
budke@intelbras.com.br" target=3D"_blank">gerson.budke@intelbras.com.br</a>=
<wbr>&gt;</div><div>---</div><div>=C2=A0lib/bb/server/process.py | 2 +-</di=
v><div>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)</div><div><br></=
div><div>diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py</=
div><div>index 982fcf7..bcd40bf 100644</div><div>--- a/lib/bb/server/proces=
s.py</div><div>+++ b/lib/bb/server/process.py</div><div>@@ -54,7 +54,7 @@ c=
lass ServerCommunicator():</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0# don&#39;t let the user ctrl-c while we&#39;re waiting for a res=
ponse</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:</div><=
div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for idx i=
n range(0,4): # 0, 1, 2, 3</div><div>-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.connection.poll(5):</div><div>+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if se=
lf.connection.poll(30):</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.connection.rec=
v()</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else:</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.warn(&quot;Timeout while=
 attempting to communicate with bitbake server&quot;)</div><span class=3D"H=
OEnZb"><font color=3D"#888888"><div>--=C2=A0</div><div>2.7.4</div></font></=
span></div><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><d=
iv>Could this be the final solution?<br></div></font></span></div>
</blockquote></div><br></div>

--001a114e7c84153151055f4cea48--
