Return-Path: <kergoth@gmail.com>
Received: from mail-vk0-f50.google.com (mail-vk0-f50.google.com
	[209.85.213.50])
	by mail.openembedded.org (Postfix) with ESMTP id 47DCE76104
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:09:00 +0000 (UTC)
Received: by vkfp126 with SMTP id p126so109604810vkf.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=G18tPvg+n/vCktKSk9oY1BdYdzRIEI8fUItgWU3wX1w=;
	b=KtLp9qup047AjMDjrhN0BHQT+oFCEr8sBv16CQfX4PwvD1m0o3GM1QYzhx2ME2+dDR
	QhZCREf+AbeiELYhxs9F7poI4+3rD66Cp8FPFKPlWKs9uL6j3IhEsR6mbmoNjRpYLzhB
	0ZtFIG0Yo53c+5p9dMxq6WswfU7hTP/pp1bx0vpDX0mXG+FHwv7XGMJIVd5E0uMixOwD
	U+7tPE3TDNrWTe3IKbHb8YM9QrEtnznWQ88v7eyt7+M6ojIInBfcnmKxBDl6WUus7Bel
	KSu8rJpT/v+Bcen8T9w8iNNCudrXFVGSeYEBGbM2dlve7svvaB1/XH32ij6L8T3lyOAA
	asZQ==
X-Received: by 10.31.52.140 with SMTP id b134mr29229044vka.136.1442437740815; 
	Wed, 16 Sep 2015 14:09:00 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.31.203.2 with HTTP; Wed, 16 Sep 2015 14:08:41 -0700 (PDT)
In-Reply-To: <1442436260.26666.164.camel@linuxfoundation.org>
References: <1442436260.26666.164.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 16 Sep 2015 14:08:41 -0700
X-Google-Sender-Auth: RkPg7pYtr9qE01ZsR_Evo478HLk
Message-ID: <CABcZAN=_8ToduVFQmaYuqfckNEHtnzT427R8oMxZU83j-GGu-g@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: Handle spaces and colons in directory names for file-checksums
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
X-List-Received-Date: Wed, 16 Sep 2015 21:09:01 -0000
Content-Type: multipart/alternative; boundary=001a1143f92426ecd5051fe3b556

--001a1143f92426ecd5051fe3b556
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 16, 2015 at 1:44 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> -                for f in fl.split():
> +                fl = fl.strip()
> +                while fl:
> +                    # A .split() would be simpler but means spaces or
> colons in filenames would break
> +                    a = fl.find(":True")
> +                    b = fl.find(":False")
> +                    if ((a < 0) and b) or ((b > 0) and (b < a)):
> +                       f = fl[:b+6]
> +                       fl = fl[b+7:]
> +                    elif ((b < 0) and a) or ((a > 0) and (a < b)):
> +                       f = fl[:a+5]
> +                       fl = fl[a+6:]
> +                    else:
> +                       break
> +                    fl = fl.strip()
>

Hmm, another option would be to re.split('(:(True|False))', fl). When the
pattern you're splitting on is grouped, it's kept in the results, so you'd
get a list of file, :True/False, next file, :True/False, ..
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1143f92426ecd5051fe3b556
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Sep 16, 2015 at 1:44 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.=
purdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div id=3D":4nx" class=3D"a3s" style=3D"overflow:hidden">-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in fl.split():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fl =3D fl.strip()<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while fl:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # A =
.split() would be simpler but means spaces or colons in filenames would bre=
ak<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a =
=3D fl.find(&quot;:True&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b =
=3D fl.find(&quot;:False&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (=
(a &lt; 0) and b) or ((b &gt; 0) and (b &lt; a)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0f =3D fl[:b+6]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fl =3D fl[b+7:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif=
 ((b &lt; 0) and a) or ((a &gt; 0) and (a &lt; b)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0f =3D fl[:a+5]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fl =3D fl[a+6:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fl =
=3D fl.strip()</div></blockquote></div><br>Hmm, another option would be to =
re.split(&#39;(:(True|False))&#39;, fl). When the pattern you&#39;re splitt=
ing on is grouped, it&#39;s kept in the results, so you&#39;d get a list of=
 file, :True/False, next file, :True/False, ..</div><div class=3D"gmail_ext=
ra">-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at =
kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintaine=
r - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1143f92426ecd5051fe3b556--
