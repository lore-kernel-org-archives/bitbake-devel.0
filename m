Return-Path: <kergoth@gmail.com>
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
	[209.85.167.193])
	by mail.openembedded.org (Postfix) with ESMTP id 984646D728
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Apr 2019 02:53:57 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id a6so6740552oie.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Apr 2019 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=h9AESnKTfJyzUg5jjWAR5MjARynF00XfZ5AMIHb98lA=;
	b=FRcdTNsKV41CXcwPxfYImcR6LjO6PZoKX1bwY8ztXwmd0F3mvF7Gnt99NDAYn7Woan
	FI0gSj5l99oUZ5ihw0/iwx2GyFYIppENIcvkXYUoZWbnVaFHkId9QJHMrvAwhmIeePHb
	ZBOKdoYzs/XMddIEB4w0pq5iG+DCRocSteeZwK8+XOToDY7z3u1v5PGopYFXBmK3qjfL
	qjQVd7UNZDaSt6H+SHigy65j86LDsPTnuO2zFAnKKsJrRUYTVM5wf02YdpXwt0wRbham
	uxg9lyZNWKZ439bXVe7wujWmAM4HxLLNbHZSgcis6tXH5x0ErjaESyf/VYi0DPBPsHeP
	Pn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=h9AESnKTfJyzUg5jjWAR5MjARynF00XfZ5AMIHb98lA=;
	b=mhE/GFzOtFtysUPS7JRLiTdMsd/ZdkaUeWM0D0UG4ZuCUDPDuKBptoBHu1EsQNrncc
	GFJ9Fth6KX0uftx5tZG3Bmm+u4DZ3Oa1TCAH5w7JqhLHjFgyBLayqDi4w0fqMi8K7nY6
	oCGSJ/+VPnyk78PCy+GkJLPCXF1SBTyjD9jPzSIl0PisFOzvcUjMvrMBSvPlGtAk3BNB
	NBoK7LT9vGeHvbfSUhW1TBDh30vCiC5/zVQUdyD9cvRFixIRapZjY4N9n52GB4A73UdH
	GIzQS7yUlVUE3tuNiTnOTltChdqi+4JIQk29knFf8JQhgfU6Tik8FVn6FGx5Pg53uIR9
	niAg==
X-Gm-Message-State: APjAAAUpae4YTVUzGkoob7SXFae08O0XPMKoCgQfM7Xy1eKfQoh6aHTR
	D5oHqpiyrzw9o3dGwLbdPBRYihqvMfBiGHZyeic=
X-Google-Smtp-Source: APXvYqxfxyjNRJ5OHT5FwIFOjHkI+1zVaVhalQoV0Z80Yx5K2bgOV0TU7/0X/+uckv/pDWULLUnmX7vJvotb8hlw9KU=
X-Received: by 2002:aca:ad8e:: with SMTP id w136mr8557798oie.109.1555037638477;
	Thu, 11 Apr 2019 19:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <1555031998-3975-1-git-send-email-akuster808@gmail.com>
In-Reply-To: <1555031998-3975-1-git-send-email-akuster808@gmail.com>
From: Christopher Larson <kergoth@gmail.com>
Date: Thu, 11 Apr 2019 19:53:47 -0700
Message-ID: <CABcZAN=v6z1wYty0EbjVAtAKeR_EQgzRuZcYYXLBOWxh4m=-qw@mail.gmail.com>
To: Armin Kuster <akuster808@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH]] bitbake: update masters version to some farout version
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
X-List-Received-Date: Fri, 12 Apr 2019 02:53:57 -0000
Content-Type: multipart/alternative; boundary="0000000000000dcc5205864c6aa1"

--0000000000000dcc5205864c6aa1
Content-Type: text/plain; charset="UTF-8"

My concern here is a user of an old clone of bitbake master won't trigger
the oe-core bitbake version checks, it could just silently behave badly, or
explode instead :)

On Thu, Apr 11, 2019 at 6:20 PM Armin Kuster <akuster808@gmail.com> wrote:

> This is to avoid having master being updated when we branch
> for a new release.
>
> Also, master should not be at the same version as the last
> stable release.
>
> Signed-off-by: Armin Kuster <akuster808@gmail.com>
> ---
>  bin/bitbake        | 2 +-
>  lib/bb/__init__.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index 57dec2a..952c47e 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -38,7 +38,7 @@ from bb.main import bitbake_main,
> BitBakeConfigParameters, BBMainException
>  if sys.getfilesystemencoding() != "utf-8":
>      sys.exit("Please use a locale setting which supports UTF-8 (such as
> LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading
> so we need a UTF-8 when Python starts or things won't work.")
>
> -__version__ = "1.40.0"
> +__version__ = "1.99.0"
>
>  if __name__ == "__main__":
>      if __version__ != bb.__version__:
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index 4bc47c8..a86197a 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -21,7 +21,7 @@
>  # with this program; if not, write to the Free Software Foundation, Inc.,
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>
> -__version__ = "1.40.0"
> +__version__ = "1.99.0"
>
>  import sys
>  if sys.version_info < (3, 4, 0):
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

--0000000000000dcc5205864c6aa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">My concern here is a user of an old clone of bitbake maste=
r won&#39;t trigger the oe-core bitbake version checks, it could just silen=
tly behave badly, or explode instead :)</div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 11, 2019 at 6:20 PM Armi=
n Kuster &lt;<a href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-c=
olor:rgb(204,204,204);padding-left:1ex">This is to avoid having master bein=
g updated when we branch<br>
for a new release.<br>
<br>
Also, master should not be at the same version as the last<br>
stable release.<br>
<br>
Signed-off-by: Armin Kuster &lt;<a href=3D"mailto:akuster808@gmail.com" tar=
get=3D"_blank">akuster808@gmail.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0lib/bb/__init__.py | 2 +-<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/bin/bitbake b/bin/bitbake<br>
index 57dec2a..952c47e 100755<br>
--- a/bin/bitbake<br>
+++ b/bin/bitbake<br>
@@ -38,7 +38,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters=
, BBMainException<br>
=C2=A0if sys.getfilesystemencoding() !=3D &quot;utf-8&quot;:<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(&quot;Please use a locale setting which suppor=
ts UTF-8 (such as LANG=3Den_US.UTF-8).\nPython can&#39;t change the filesys=
tem locale after loading so we need a UTF-8 when Python starts or things wo=
n&#39;t work.&quot;)<br>
<br>
-__version__ =3D &quot;1.40.0&quot;<br>
+__version__ =3D &quot;1.99.0&quot;<br>
<br>
=C2=A0if __name__ =3D=3D &quot;__main__&quot;:<br>
=C2=A0 =C2=A0 =C2=A0if __version__ !=3D bb.__version__:<br>
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py<br>
index 4bc47c8..a86197a 100644<br>
--- a/lib/bb/__init__.py<br>
+++ b/lib/bb/__init__.py<br>
@@ -21,7 +21,7 @@<br>
=C2=A0# with this program; if not, write to the Free Software Foundation, I=
nc.,<br>
=C2=A0# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
<br>
-__version__ =3D &quot;1.40.0&quot;<br>
+__version__ =3D &quot;1.99.0&quot;<br>
<br>
=C2=A0import sys<br>
=C2=A0if sys.version_info &lt; (3, 4, 0):<br>
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
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Christoph=
er Larson<br>kergoth at gmail dot com<br>Founder - BitBake, OpenEmbedded, O=
penZaurus<br>Senior Software Engineer, Mentor Graphics</div></div></div></d=
iv>

--0000000000000dcc5205864c6aa1--
