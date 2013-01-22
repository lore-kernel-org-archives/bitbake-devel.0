Received: from mail-la0-f53.google.com ([209.85.215.53])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Txnbl-0005jz-ET
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Jan 2013 00:50:38 +0100
Received: by mail-la0-f53.google.com with SMTP id fr10so1949066lab.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Jan 2013 15:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=PQmMZcMhAB5+ggG52VoVFqCHkEaspzL9ofjYvy9+das=;
	b=qGUeayiUBZHTAMNz3CAkc+TPr+yQNZiwdFmpzli6pGH8mYUXlJ9K3QtGP3eoLgcMcR
	7m5Cw7vHAPZxT79fcQpMGr8a51mxZ6BkpgfwDk0RVobg60LxcS5yNZ54V9ET5zrAWQpd
	ksQgfxrJBGPME4Ohf5bwX5mDHUuQD9tJKDZzclo6Vwn1H7mHBDRNguGbP/uha3Sx5S73
	rJ/xuhZ0tz2nUqfHIIqBoJiEFBbMgHj6/BWUOVETdTjSjfM/bSKXjCmnk9xN4Q3Cyg5B
	ldet49c5kGGmZ1xrmU9oG7OEAZXRBypOOcY7ezbrklKHnAAir7xj/kd5qHkYa5r4uLww
	2INg==
X-Received: by 10.112.99.2 with SMTP id em2mr9967829lbb.11.1358897694678; Tue,
	22 Jan 2013 15:34:54 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Tue, 22 Jan 2013 15:34:34 -0800 (PST)
In-Reply-To: <20130122142430.1cc1a705@e6410-2>
References: <20130122142430.1cc1a705@e6410-2>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 22 Jan 2013 16:34:34 -0700
X-Google-Sender-Auth: lT1Q9zZ-aAC7knugOhB_n7L86U0
Message-ID: <CABcZANnAOifC1=0i71USA+wPo2VyCRgGE3NXA82eaiDm88F3Jg@mail.gmail.com>
To: Peter Seebach <peter.seebach@windriver.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Half-baked proposal: Introduce @{foo} variable expansion for bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 22 Jan 2013 23:50:39 -0000
Content-Type: multipart/alternative; boundary=f46d0401f971609faa04d3e90683

--f46d0401f971609faa04d3e90683
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 22, 2013 at 1:24 PM, Peter Seebach
<peter.seebach@windriver.com>wrote:

> PREFIX = "${@['', (d.getVar("BBEXTENDVARIANT", True) or "") +
> '-'][(d.getVar("BBEXTENDVARIANT", True) or "") != ""]}"
>
> and then use ${PREFIX}${FOO}.
>
> ... wait, that's horrible. What if I could write:
>         @{BBEXTENDVARIANT+@{BBEXTENDVARIANT}-}
> instead? That's practically legible by comparison. Or, with the new
> bonus features,
>

BBEXTENDVARIANT ??= ""
PREFIX = "${@BBEXTENDVARIANT + '-' if BBEXTENDVARIANT else ''}"

Which leverages the python inline if statement syntax, coupled with the
bitbake feature which allows you to reference variables as though they were
python variables.
-- 
Christopher Larson

--f46d0401f971609faa04d3e90683
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 22, 2013 at 1:24 PM, Peter Seebach <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:peter.seebach@windriver.com" target=3D"_blank">peter.seebach@wi=
ndriver.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":1wy">PREFIX =3D &quot;${@[&#39;&=
#39;, (d.getVar(&quot;BBEXTENDVARIANT&quot;, True) or &quot;&quot;) +<br>
&#39;-&#39;][(d.getVar(&quot;BBEXTENDVARIANT&quot;, True) or &quot;&quot;) =
!=3D &quot;&quot;]}&quot;<br>
<br>
and then use ${PREFIX}${FOO}.<br>
<br>
... wait, that&#39;s horrible. What if I could write:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @{BBEXTENDVARIANT+@{BBEXTENDVARIANT}-}<br>
instead? That&#39;s practically legible by comparison. Or, with the new<br>
bonus features,</div></blockquote></div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra" style>BBEXTENDVARIANT ??=3D &quot;&quot;</div>=
PREFIX =3D &quot;${@BBEXTENDVARIANT + &#39;-&#39; if BBEXTENDVARIANT else &=
#39;&#39;}&quot;<br>

</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Which=
 leverages the python inline if statement syntax, coupled with the bitbake =
feature which allows you to reference variables as though they were python =
variables.<br>

-- <br>Christopher Larson</div></div>

--f46d0401f971609faa04d3e90683--
