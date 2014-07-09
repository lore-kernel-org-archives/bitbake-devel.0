Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f177.google.com (mail-lb0-f177.google.com
	[209.85.217.177])
	by mail.openembedded.org (Postfix) with ESMTP id 2755B70253
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 15:20:28 +0000 (UTC)
Received: by mail-lb0-f177.google.com with SMTP id u10so5058086lbd.22
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Eq3ADEs3/19JHo/Y5likjP+utH01DJtCCrzganHxhPg=;
	b=YaGGouBowOAqH9UhzJnKS+iq7DMK8H9Opxae20RpvI4KI7mDlt4i49U2UFlSBdk6kO
	/6BYPXa8ba6xMfzvMDsRgWOMF+hihWZoK0C/71NweSmcZ3gpufmfWcDpfgNK7aURdn7L
	oFsqMboceg7EGUnE7kZYDevIFU6FeZIv6iYS4mnOQ9aEWFrUGoyRTWYEGHRMqnzlYE2a
	V6RNhhcOfuRd/v6xxdxkKz5n8ImPvBfbtjwkBoGIAFAph3+sTNw2qimRb9ailmvZcwND
	lddDu2l2Vydx/rRvs4AtEbMoNZ9YkjC8AGnNld5l5VwBM3kxF/Kw0VCsHXmVJBWpd+Cp
	EujQ==
X-Received: by 10.152.19.164 with SMTP id g4mr32817490lae.47.1404919228734;
	Wed, 09 Jul 2014 08:20:28 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.168.66 with HTTP; Wed, 9 Jul 2014 08:20:07 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.11.1407090934540.8165@localhost>
References: <alpine.LFD.2.11.1407090934540.8165@localhost>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 9 Jul 2014 08:20:07 -0700
X-Google-Sender-Auth: VzoOKphlqmkEW-nb9EcKj5ZARQ0
Message-ID: <CABcZAN=OPjSrfQNSjarThUu37Q3LgoZc8jvX4t1+CN8nZnEh=w@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: should list of "Variable Flags" include "fakeroot"?
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
X-List-Received-Date: Wed, 09 Jul 2014 15:20:32 -0000
Content-Type: multipart/alternative; boundary=089e0149423091256b04fdc43f43

--089e0149423091256b04fdc43f43
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 9, 2014 at 6:38 AM, Robert P. J. Day <rpjday@crashcourse.ca>
wrote:

>   user manual, "3.6 Variable Flags" includes "fakeroot" as one of the
> numerous flags, but that section claims that all of those flags can be
> set using the standard variable syntax. but IIRC, fakeroot is set as
> an *attribute* on tasks these days, as in:
>
>   fakeroot tar_sdk() {
>
> so how should that entry be worded/reworded? unless i'm misreading
> something.
>

It likely shouldn't be mentioned as a flag. The fact that it's a flag
internally is a bitbake implementation detail that likely isn't something
they need to be aware of, in my personal opinion, anyway.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e0149423091256b04fdc43f43
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jul 9, 2014 at 6:38 AM, Robert P. J. Day <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:rpjday@crashcourse.ca" target=3D"_blank">rpjday@crashcourse.c=
a</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":xm" class=3D"a3s" style=3D"overf=
low:hidden">=C2=A0 user manual, &quot;3.6 Variable Flags&quot; includes &qu=
ot;fakeroot&quot; as one of the<br>


numerous flags, but that section claims that all of those flags can be<br>
set using the standard variable syntax. but IIRC, fakeroot is set as<br>
an *attribute* on tasks these days, as in:<br>
<br>
=C2=A0 fakeroot tar_sdk() {<br>
<br>
so how should that entry be worded/reworded? unless i&#39;m misreading<br>
something.</div></blockquote></div><br></div><div class=3D"gmail_extra">It =
likely shouldn&#39;t be mentioned as a flag. The fact that it&#39;s a flag =
internally is a bitbake implementation detail that likely isn&#39;t somethi=
ng they need to be aware of, in my personal opinion, anyway.<br>

-- <br>Christopher Larson<br>clarson at kergoth dot com<br>Founder - BitBak=
e, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software Engine=
er, Mentor Graphics
</div></div>

--089e0149423091256b04fdc43f43--
