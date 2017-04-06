Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
	[209.85.218.54])
	by mail.openembedded.org (Postfix) with ESMTP id 0C6E277A50
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 01:32:38 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id d2so35974398oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Apr 2017 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Hzh5GJZkXFpX4CX4/PH0LgJJbFZNiZ0cURj+/ySbv4k=;
	b=C9ShWgFnk4W4HWwV2i1pKbStwYN3VpQoo5zxwYEjAEtlAWElIIDsuVJ00RiY+FzGL4
	chewdiIiNyAR7fPq2ZJJw1Bk4lgwxkWhtUz7LsYrIJXvIXHf/enpdBRqO/0NIVLFsMSl
	5OlTm6V3bRYApKs5QmJ20GXFdjgOC7Ma0oU0yfAT4i7wJ2kZAXoSXibyLe0wbMIbMpM2
	2FzS8XWes0R0toGF8nSRXCL99oQI8tvA2MyHWMvldPUV/Lyytv7fMfQ7G8ZJ7e8xLq3x
	hS3Flk3u3OnBPyeKn3hn1lwJN5VbWc81I+6UbIe886gf/FbMV+Rw1MXtCzs8XVaZiV9e
	KZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Hzh5GJZkXFpX4CX4/PH0LgJJbFZNiZ0cURj+/ySbv4k=;
	b=SORBcz7Per809H3njtINnqP0QhNnyHFEGqQAGZY1B4uJPDv1VB2WM5z/+YDXfF1hEt
	mDLhqTDGgSgB864/UOBPbcodT9iZa2Lx0unDSm1s8cQB4FKpIAYVjhdwVA3fMFZ1YSdH
	pw72lyDNtg3Rs6zEyXH/QGK0Z9OC8koaw4iz5eDEUfD1r/a2x0SrfvWT7C6HFqX/Y3rE
	+GsMNusnX4KoFA9zq7MCVTKYb+dfnHWQFRcgav1tkxxebAFlFEgJAz55hOi8Gcohfp6x
	+DUcdgDVILqC7bfvkebfXeL5PfAKdLe9C/fXmbJ7dN98IDa1FUva8kXgu/OJ8p+aQXDx
	mMyQ==
X-Gm-Message-State: AN3rC/7cFwp+BjW3UsXQ9MnDFeSzFW9Fv2nYK2zgIMVZM0yMKr1DRQboIjUlzhMoJLs8YUy5Gw/qYEM36r8Ydw==
X-Received: by 10.157.56.216 with SMTP id k24mr3292183ote.15.1491442359954;
	Wed, 05 Apr 2017 18:32:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.33.197 with HTTP; Wed, 5 Apr 2017 18:32:19 -0700 (PDT)
In-Reply-To: <1491427991-8595-1-git-send-email-juro.bystricky@intel.com>
References: <1491427991-8595-1-git-send-email-juro.bystricky@intel.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Wed, 5 Apr 2017 18:32:19 -0700
Message-ID: <CABcZAN=6rGsbmXsQaDdpRspNwJBv5p5zD_DqJkJxBMs42j0K+Q@mail.gmail.com>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] tinfoil.py: validate argument in parse_recipe_file
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
X-List-Received-Date: Thu, 06 Apr 2017 01:32:39 -0000
Content-Type: multipart/alternative; boundary=001a11c0478611708d054c757c40

--001a11c0478611708d054c757c40
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 5, 2017 at 2:33 PM, Juro Bystricky <juro.bystricky@intel.com>
wrote:

> Check for an empty file name to avoid an exception.
>
> [YOCTO#11210]
>
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
>

IMO this is pointless. If you=E2=80=99re calling parse_recipe_file with an =
empty
string, it=E2=80=99s programmer error, which means raising an exception is =
a
completely reasonable thing to do.
--=20
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Senior Software Engineer, Mentor Graphics

--001a11c0478611708d054c757c40
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Apr 5, 2017 at 2:33 PM, Juro Bystricky <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:juro.bystricky@intel.com" target=3D"_blank">juro.bystricky@inte=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":o=
4" class=3D"a3s aXjCH m15b400977f39b78d">Check for an empty file name to av=
oid an exception.<br>
<br>
[YOCTO#11210]<br>
<br>
Signed-off-by: Juro Bystricky &lt;<a href=3D"mailto:juro.bystricky@intel.co=
m">juro.bystricky@intel.com</a>&gt;</div></blockquote></div><div class=3D"g=
mail_extra"><br></div>IMO this is pointless. If you=E2=80=99re calling pars=
e_recipe_file with an empty string, it=E2=80=99s programmer error, which me=
ans raising an exception is a completely reasonable thing to do.<br>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot c=
om<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Senior Software Engine=
er, Mentor Graphics</div></div></div></div>
</div></div>

--001a11c0478611708d054c757c40--
