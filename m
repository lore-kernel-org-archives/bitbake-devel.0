Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
	[209.85.213.171])
	by mail.openembedded.org (Postfix) with ESMTP id F37CA770A6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 22:20:49 +0000 (UTC)
Received: by igbif5 with SMTP id if5so31182573igb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Oct 2015 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Z/JpxsfyQdUYb5X8zcMYRjD5Z5vuH/kYSczQ1qgkSGs=;
	b=lqt8dlFOgaycNBkTlbHK94NmHilqriyOwIFc3norpRQtFRy6tIsqjPzwTYcw7h8DgI
	oRUwWAeWbYZVOBUGDqQWiBp2NSflA1PaUMys2uacRUyU2pEiEe+FNFbAREcQ9MJ6Wvqc
	6v1b3yK33hh/UoZtmLFF3R0/Zn9DoUn5ysfQaIwPnlDpTdd+LfG0qsOCM1S5V960xaqi
	7e3WufO+rGM+EEfr7bLnAigyMLeppjCQ2X3/s/cMEAB4KQ3SRnr5HznipkDKuF7awHag
	jNiLT5xnaRQWnzFvRXmw/H5JRHx3Apoq0xZ+AvyTxrUYqkEVHPBmNQxDz2kNJELu0u7p
	kO5Q==
X-Received: by 10.50.50.139 with SMTP id c11mr7363184igo.10.1444861249320;
	Wed, 14 Oct 2015 15:20:49 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.65.204 with HTTP; Wed, 14 Oct 2015 15:20:29 -0700 (PDT)
In-Reply-To: <1444812073-9024-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1444625699.29375.12.camel@linuxfoundation.org>
	<1444812073-9024-1-git-send-email-ed.bartosh@linux.intel.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 14 Oct 2015 15:20:29 -0700
X-Google-Sender-Auth: l4tGxir4iNs23wWSnMpnFb8FcRY
Message-ID: <CABcZANmHoWBvfF0JKMt4SCVef5-qgGvF+OJ+or6-Pu5pgpz46w@mail.gmail.com>
To: Ed Bartosh <ed.bartosh@linux.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: normalize build targets
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
X-List-Received-Date: Wed, 14 Oct 2015 22:20:53 -0000
Content-Type: multipart/alternative; boundary=047d7bdca0408400c3052217f938

--047d7bdca0408400c3052217f938
Content-Type: text/plain; charset=UTF-8

On Wed, Oct 14, 2015 at 1:41 AM, Ed Bartosh <ed.bartosh@linux.intel.com>
wrote:

> +        for target in fulltargetlist:
> +            if ":" in target:
> +                if ":do_" not in target:
> +                    target = "%s:do_%s" % tuple(target.split(":"))
>

I know it's an unlikely and theoretical case, but just in case the user
asks to build foo:: or something, we wouldn't want to explode horribly with
a traceback. It's best to do target.split(":", 1) here, so you know we'll
get 2 values for the format strings, no more.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--047d7bdca0408400c3052217f938
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Oct 14, 2015 at 1:41 AM, Ed Bartosh <span dir=3D"ltr">&lt;<a href=
=3D"mailto:ed.bartosh@linux.intel.com" target=3D"_blank">ed.bartosh@linux.i=
ntel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=
=3D":vo" class=3D"a3s" style=3D"overflow:hidden">+=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for target in fulltargetlist:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;:&quot; in target:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;:do_&quot=
; not in target:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 targ=
et =3D &quot;%s:do_%s&quot; % tuple(target.split(&quot;:&quot;))</div></blo=
ckquote></div><br>I know it&#39;s an unlikely and theoretical case, but jus=
t in case the user asks to build foo:: or something, we wouldn&#39;t want t=
o explode horribly with a traceback. It&#39;s best to do target.split(&quot=
;:&quot;, 1) here, so you know we&#39;ll get 2 values for the format string=
s, no more.</div><div class=3D"gmail_extra">-- <br><div class=3D"gmail_sign=
ature">Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics</div>
</div></div>

--047d7bdca0408400c3052217f938--
