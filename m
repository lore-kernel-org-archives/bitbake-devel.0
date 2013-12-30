Return-Path: <kergoth@gmail.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
	[209.85.217.182])
	by mail.openembedded.org (Postfix) with ESMTP id 7DA7E6A5A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 16:18:49 +0000 (UTC)
Received: by mail-lb0-f182.google.com with SMTP id l4so5736551lbv.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Dec 2013 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=+hC3mGLLzEGYZ6XLknG5SKEeTRM9+zHDti1LOB+YK8s=;
	b=NzKx/yXSqHOWK3z+FuLsd5jOuwD6C6bsFFVtbsiRjfJXnE4ljMOsQ9ednhN4C1dyTm
	PVVZNUp8BnazSQO3HBE6ciM4PWJvAy95zEgxzwBd/Nz/gNNTuZ64c/7KVQSLAWH/LLlJ
	vxsW+H0ulGhYHOF4usThFLqRovWcbifSbJz+QXNzk+pze1GsSH+GkBqWjmivpXD1Knvz
	fmkfmMxwxGguVVkBYKCTi3+hmzNGhoAW4uGie7qq3TmsJr6i/1zJn1/wu0EbislsPj9c
	BkHRi2doM8KHDlq0nY4Syc9WRMIpqFQztTc3PE9EMSk4f44LmrZw7PfpAoQX7EimpMTw
	v+5A==
X-Received: by 10.112.52.6 with SMTP id p6mr1643003lbo.67.1388420329854; Mon,
	30 Dec 2013 08:18:49 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.22.167 with HTTP; Mon, 30 Dec 2013 08:18:29 -0800 (PST)
In-Reply-To: <20131228132413.GB3706@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 30 Dec 2013 09:18:29 -0700
X-Google-Sender-Auth: 0psxMGaora-7g2c7QTTiOKaxMgc
Message-ID: <CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Mon, 30 Dec 2013 16:18:50 -0000
Content-Type: multipart/alternative; boundary=001a11c3cd4a8f5c9104eec2cc41

--001a11c3cd4a8f5c9104eec2cc41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2013 at 6:24 AM, Martin Jansa <martin.jansa@gmail.com>wrote=
:

> On Wed, Dec 18, 2013 at 04:21:27PM +0000, Richard Purdie wrote:
> > Its useful to understand where the delta starts against an existing
> sstate cache
> > for a given target. Adding this to the output of the -S option seems
> like a
> > natural fit.
> >
> > We use the hashvalidate function to figure this out and assume it can
> find siginfo
> > files for more than just the setscene tasks.
>
> I haven't tried to find smaller reproducer or exact part of code where
> it happends, but in bigger builds I have it fails with
>
> I'll try to reproduce and narrow it a bit, but if you have tip where
> to look first..
>
> IndexError: list index out of range:


I=E2=80=99m hitting this now as well.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11c3cd4a8f5c9104eec2cc41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Sat, Dec 28, 2013 at 6:24 AM=
, Martin Jansa <span dir=3D"ltr">&lt;<a href=3D"mailto:martin.jansa@gmail.c=
om" target=3D"_blank">martin.jansa@gmail.com</a>&gt;</span> wrote:<br><div =
class=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Wed, Dec 18, 2013 at 04=
:21:27PM +0000, Richard Purdie wrote:<br>
&gt; Its useful to understand where the delta starts against an existing ss=
tate cache<br>
&gt; for a given target. Adding this to the output of the -S option seems l=
ike a<br>
&gt; natural fit.<br>
&gt;<br>
&gt; We use the hashvalidate function to figure this <span class=3D"il">out=
</span> and assume it can find siginfo<br>
&gt; files for more than just the setscene tasks.<br>
<br>
</div>I haven&#39;t tried to find smaller reproducer or exact part of code =
where<br>
it happends, but in bigger builds I have it fails with<br>
<br>
I&#39;ll try to reproduce and narrow it a bit, but if you have tip where<br=
>
to look first..<br>
<br>
<span class=3D"il">IndexError</span>: <span class=3D"il">list</span> <span =
class=3D"il">index</span> <span class=3D"il">out</span> of <span class=3D"i=
l">range</span>:</blockquote></div><br>I=E2=80=99m hitting this now as well=
.<br>-- <br>Christopher Larson<br>

clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<b=
r>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics
</div></div>

--001a11c3cd4a8f5c9104eec2cc41--
