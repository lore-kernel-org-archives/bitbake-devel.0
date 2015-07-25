Return-Path: <kergoth@gmail.com>
Received: from mail-ie0-f181.google.com (mail-ie0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 3B0EC7629A
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Jul 2015 19:15:17 +0000 (UTC)
Received: by iecrl10 with SMTP id rl10so36056645iec.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Jul 2015 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=SAHsQ6fzsrtRLJOfUWJtLhkuTMOuufNF4TwQXzx60XA=;
	b=esrJeKdmhGRSN9Bhi3KEbuhmLXC1Hn1YwYd1+MFjPqJKvsIW46CKANQmDMhdandS8H
	ERHodzWqtGjU5XKx1NKHGg4d6i3EfSOq4Pvx/qJXvwGsZAdgGW1DAfrUavB9XBzGcFWc
	UPJX4sKDoowPkTmV7Oi8MCMj+8z49pUIa1JYfuB/8/k1+C5Ro5IjA/4+oO5zDDL6BJal
	T3yaC8UzXq1MKERTvpykUrYHmMCrEFkRFoLQwS2jMAMtMNoh7DZhiHIJ+IfiogiXzFpe
	w75vXuF1wACFTXT+Qj0YhIjJNVD4MvEUEP+nDaT2+Zb0+dLy/uLpu/o/kqaBzz4h0tq7
	Lcyg==
X-Received: by 10.50.6.38 with SMTP id x6mr6744916igx.74.1437851717742; Sat,
	25 Jul 2015 12:15:17 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.199 with HTTP; Sat, 25 Jul 2015 12:14:58 -0700 (PDT)
In-Reply-To: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
References: <1437849163-1577-1-git-send-email-juro.bystricky@intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 25 Jul 2015 12:14:58 -0700
X-Google-Sender-Auth: 1sv1bLSbaVJzqj2uXDLx-3qMRmA
Message-ID: <CABcZANkHbT0R6HY5jtuCN+LLnJ2fVJV2nSVa5u_VCcTdzrct9w@mail.gmail.com>
To: Juro Bystricky <juro.bystricky@intel.com>
Cc: richard.purdie@intel.com, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] wget.py: support for semi-colons in URL
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
X-List-Received-Date: Sat, 25 Jul 2015 19:15:20 -0000
Content-Type: multipart/alternative; boundary=047d7bb03d7ee0387e051bb7f0cb

--047d7bb03d7ee0387e051bb7f0cb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2015 at 11:32 AM, Juro Bystricky <juro.bystricky@intel.com>
wrote:

> Some URLs contain semi-colons. For example, some GIT repositories
> support downloading snapshots using URL such as:
>
> "http://abc123.com/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5dd47"
>
> Currently there is no way to construct SRC_URI with such URLs.
> Bitbake uses semi-colons in SRC_URI as delimiters for various parameters.
>
> This patch allows using of semi-colons in URLs: ';;' (double semi-colon)
> in SRC_URI is processed  as a single semi-colon that is a part of a URL
> name.
> For example, the above URL would become:
>
> SRC_URI =3D "http://abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsnapshot;;h=3Da5=
dd47"
>
> Note that it is not possible to determine the name of the downloaded file
> from URL alone. The onus to specify the proper name is on the user,
> via the parameter 'downloadfilename':
>
> SRC_URI =3D "
> http://abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsnapshot;;h=3Da5dd47;download=
filename=3Dmyfile.tar.gz
> "
>
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
>

In my opinion, if we=E2=80=99re going to support this, we should really sup=
port it
in a generic way, in urldecode/urlencode & the URL class, and if needed
leverage that in wget.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bb03d7ee0387e051bb7f0cb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jul 25, 2015 at 11:32 AM, Juro Bystricky <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:juro.bystricky@intel.com" target=3D"_blank">juro.bystricky@in=
tel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D"=
:1gi" class=3D"a3s" style=3D"overflow:hidden">Some URLs contain semi-colons=
. For example, some GIT repositories<br>
support downloading snapshots using URL such as:<br>
<br>
&quot;<a href=3D"http://abc123.com/git/?p=3Dgcc/gcc.git;a=3Dsnapshot;h=3Da5=
dd47" rel=3D"noreferrer" target=3D"_blank">http://abc123.com/git/?p=3Dgcc/g=
cc.git;a=3Dsnapshot;h=3Da5dd47</a>&quot;<br>
<br>
Currently there is no way to construct SRC_URI with such URLs.<br>
<span class=3D"il">Bitbake</span> uses semi-colons in SRC_URI as delimiters=
 for various parameters.<br>
<br>
This patch allows using of semi-colons in URLs: &#39;;;&#39; (double semi-c=
olon)<br>
in SRC_URI is processed=C2=A0 as a single semi-colon that is a part of a UR=
L name.<br>
For example, the above URL would become:<br>
<br>
SRC_URI =3D &quot;<a href=3D"http://abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsn=
apshot;;h=3Da5dd47" rel=3D"noreferrer" target=3D"_blank">http://abc123.com/=
git/?p=3Dgcc/gcc.git;;a=3Dsnapshot;;h=3Da5dd47</a>&quot;<br>
<br>
Note that it is not possible to determine the name of the downloaded file<b=
r>
from URL alone. The onus to specify the proper name is on the user,<br>
via the parameter &#39;downloadfilename&#39;:<br>
<br>
SRC_URI =3D &quot;<a href=3D"http://abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsn=
apshot;;h=3Da5dd47;downloadfilename=3Dmyfile.tar.gz" rel=3D"noreferrer" tar=
get=3D"_blank">http://abc123.com/git/?p=3Dgcc/gcc.git;;a=3Dsnapshot;;h=3Da5=
dd47;downloadfilename=3Dmyfile.tar.gz</a>&quot;<br>
<br>
Signed-off-by: Juro Bystricky &lt;<a href=3D"mailto:juro.bystricky@intel.co=
m">juro.bystricky@intel.com</a>&gt;</div></blockquote></div><br>In my opini=
on, if we=E2=80=99re going to support this, we should really support it in =
a generic way, in urldecode/urlencode &amp; the URL class, and if needed le=
verage that in wget.<br>-- <br><div class=3D"gmail_signature">Christopher L=
arson<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, Ope=
nZaurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics<=
/div>
</div></div>

--047d7bb03d7ee0387e051bb7f0cb--
