Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f172.google.com (mail-io0-f172.google.com
	[209.85.223.172])
	by mail.openembedded.org (Postfix) with ESMTP id A173D76FF2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 17:54:37 +0000 (UTC)
Received: by iofh134 with SMTP id h134so67557209iof.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 03 Sep 2015 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=P9EjNWTqOEOTvcV48PwBq3WhuZPusw3wap5gAT7usgo=;
	b=qamTKS20WBM4KxZYcqUr2ZafJv7BHUaxi1FpOYtPK0qmrqFca5vkUAOy1t5stvrpFZ
	mV6m9oGsTFHuox91GycwXV7R0fjiL3kR3x6Ag6y5OKEBAb+y/3Zt3BJHZoJYbdrA6wxF
	ih9niUyv9HFpwo7PfphlsqTenIVik4owEVOzoDAAoEF5XBwCf71G8sE1HhezlaxdVSmg
	Y/ku1sn2n0rKKp4omZxTffQ8c7203HAr0ptFVQs1U6HSAlUkToQL0OtySSWbNCOAC8FQ
	6a6hFIgD12gRrkH035DByII4Z/DGZ13jjHEJ7w5/hbkkMMb0xp84AgFsszaLn8UP7dRZ
	xFqA==
X-Received: by 10.107.38.10 with SMTP id m10mr700555iom.98.1441302877309; Thu,
	03 Sep 2015 10:54:37 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Thu, 3 Sep 2015 10:54:17 -0700 (PDT)
In-Reply-To: <1441290005.24871.116.camel@linuxfoundation.org>
References: <1441290005.24871.116.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Thu, 3 Sep 2015 10:54:17 -0700
X-Google-Sender-Auth: lpOcFlROQeeQhO5RxMTczFBF4BQ
Message-ID: <CABcZANkzjUix=WzxixvA4EpQX9eAZqOJBKadYUMSVtHThv3r=Q@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] event/server: Add _uiready flag to handle missing error messages
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
X-List-Received-Date: Thu, 03 Sep 2015 17:54:43 -0000
Content-Type: multipart/alternative; boundary=001a1140e7b8041165051edb7a18

--001a1140e7b8041165051edb7a18
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 3, 2015 at 7:20 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> -        self.event_handle = bb.event.register_UIHhandler(s)
> +        self.event_handle = bb.event.register_UIHhandler(s, True)
>

Minor quibble: when using positional arguments of this sort, directly,
without an intermediate variable, when reading it, it's not clear what the
argument is doing. Admittedly, we do this all the time with getVar(), but
really that was a crappy API to begin with :) The code becomes a bit more
readable if you pass the argument name as though it was a keyword argument,
so we have context when reading it, e.g.:

    self.event_handle = bb.event.register_UIHhandler(s, mainui=True)

Obviously, this is relatively minor, so shouldn't block a merge, but it's
something to keep in mind going forward.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a1140e7b8041165051edb7a18
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Sep 3, 2015 at 7:20 AM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div id=3D":1rf" class=3D"a3s" style=3D"overflow:hidden">-=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 self.event_handle =3D bb.event.register_UIHhandler(s)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.event_handle =3D bb.event.register_UIHhan=
dler(s, True)</div></blockquote></div><br>Minor quibble: when using positio=
nal arguments of this sort, directly, without an intermediate variable, whe=
n reading it, it&#39;s not clear what the argument is doing. Admittedly, we=
 do this all the time with getVar(), but really that was a crappy API to be=
gin with :) The code becomes a bit more readable if you pass the argument n=
ame as though it was a keyword argument, so we have context when reading it=
, e.g.:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">=C2=A0 =C2=A0 self.event_handle =3D bb.event.register_UIHhandler(s, mainu=
i=3DTrue)</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra">Obviously, this is relatively minor, so shouldn&#39;t block a merge, bu=
t it&#39;s something to keep in mind going forward.</div><div class=3D"gmai=
l_extra">-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarso=
n at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Main=
tainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a1140e7b8041165051edb7a18--
