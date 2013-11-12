Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f176.google.com (mail-lb0-f176.google.com
	[209.85.217.176])
	by mail.openembedded.org (Postfix) with ESMTP id 88A816D598
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2013 15:17:53 +0000 (UTC)
Received: by mail-lb0-f176.google.com with SMTP id p9so1996388lbv.21
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2013 07:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=ztcZ/lLcz9MgxebczGCQnu7ORkozdMphaoe4BVfUwm8=;
	b=wqTIsi+c/AQZAMbIkGAqTTil/10CgL9mGlvRj4meXEDEwHaC6treywJvr26PZdHGW4
	kcP0a2TsacUpyPUGor10vHcjSg4QhSOtsjEGYYOMSA6YKmkBh5m2/Wt2NHCPO/iuM0ML
	nWHTVzgnNWK9KsqQDiSRCCR0WGG0B8PG3Bm6Mzm6bThlj/X25aTh+2iwiUVt06b/EmGh
	1kusB0siblzj/fSUdMOkouqIMmsUTM5Rt9X5tQcCoTailRCICAWhjDub/b+c3B6aPRnd
	i/co7PvUvYMkBeINZuERuymkGWadPXdWiuyF2QBE1ROtc1xVAk3J4S89FHHOqyHxvdEO
	tfog==
X-Received: by 10.112.135.103 with SMTP id pr7mr64487lbb.65.1384269474686;
	Tue, 12 Nov 2013 07:17:54 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.53.197 with HTTP; Tue, 12 Nov 2013 07:17:34 -0800 (PST)
In-Reply-To: <1384265249-11307-1-git-send-email-stefanx.stanacar@intel.com>
References: <1384265249-11307-1-git-send-email-stefanx.stanacar@intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 12 Nov 2013 08:17:34 -0700
X-Google-Sender-Auth: t6DZKSZwXbYfk0LUQKmNkiZTgmE
Message-ID: <CABcZANmis=Y6ke+6xG1Bnk5so1DBwvSdf7s9ar-BcTxMs4VxDA@mail.gmail.com>
To: Stefan Stanacar <stefanx.stanacar@intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: remove some redundant file manipulation code
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
X-List-Received-Date: Tue, 12 Nov 2013 15:17:55 -0000
Content-Type: multipart/alternative; boundary=089e01176e734fedfe04eafc5a4b

--089e01176e734fedfe04eafc5a4b
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 12, 2013 at 7:07 AM, Stefan Stanacar <stefanx.stanacar@intel.com
> wrote:

> +        total = ''
>          with open(default_file, 'r') as f:
> -            contents = f.readlines()
> -        f.close()
> -
> -        total = ""
> -        for c in contents:
> -            total += c
> +            for line in f:
> +                total += line
>
>          total += "#added by hob"
>          total += "\n%s += \"%s\"\n" % (var, val)
>
>          with open(default_file, 'w') as f:
>              f.write(total)
> -        f.close()
>

This is weird. Have they ever heard of opening a file in append mode? :)
And obviously, splitting the contents into lines, then re-concatenating
those lines into a string blob makes no sense either.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e01176e734fedfe04eafc5a4b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Nov 12, 2013 at 7:07 AM, Stefan Stanacar <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:stefanx.stanacar@intel.com" target=3D"_blank">stefanx.stanaca=
r@intel.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":zs" style=3D"overflow:hidden">+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0total =3D &#39;&#39;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(default_file, &#39;r&#39;) as f=
:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0contents =3D f.readlines()<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0f.close()<br>
-<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0total =3D &quot;&quot;<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0for c in contents:<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total +=3D c<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for line in f:<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total +=3D line<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total +=3D &quot;#added by hob&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0total +=3D &quot;\n%s +=3D \&quot;%s\&quo=
t;\n&quot; % (var, val)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(default_file, &#39;w&#39;) as f=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(total)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0f.close()</div></blockquote></div><br>This is =
weird. Have they ever heard of opening a file in append mode? :) And obviou=
sly, splitting the contents into lines, then re-concatenating those lines i=
nto a string blob makes no sense either.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--089e01176e734fedfe04eafc5a4b--
