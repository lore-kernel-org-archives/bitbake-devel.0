Return-Path: <martin.jansa@gmail.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 37A7D78383
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Nov 2017 09:22:27 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id r68so15630990wmr.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 09 Nov 2017 01:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=5BoMhEWV9m1HJqC3FW0z1qPZYfsWxAqA7eQ3AFXroH4=;
	b=sIpQEsDlPyKwgFJmV8a8efxKUZXdaUsbilyVPgCT1C/N3TR6YGPBUWy9ohiQby2NZ9
	7NqiY0Wl4Kyd6iZ9I8P19q4rnG3uWPWFjJ9bMX1TZLNhJ5HQH1rqkc70QXrYxsjx6WBf
	ddgAxk4B2cai7a6d4Kcq6W9+YpUq6WshFA4U8IhP59IC3M6A6ILhbPf7wRfyspO9H+Y2
	dh31dNpYmVMcs+iQ4iA6VuYIWi9ebN0KSKS1hheR/8ZwVfdo0832bUzP6h3wHL3iv+jv
	GkvEbr7Zk4G2IB8kqQrdAzYZEK/oRk33vOwMi33a1B8WzRwff4kJarPoTa7ExKG53r/t
	7Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=5BoMhEWV9m1HJqC3FW0z1qPZYfsWxAqA7eQ3AFXroH4=;
	b=kKUqUgsBPc/Vxg3KKG8ihrUEKtxHf0nDoQJRXxE8vxPPrjYFUavW6EdG8ecOH/CPXC
	wlw2AhaooSAIaqn/wyUtxAiFVCBlXS885i/nA9fx98xgI8zRaxysGDdU99uaU/AV33It
	dpwdj42sjmf0yEpVy4qvl8U8lalX6zpMlPq5XX5Zvxc4c1vJPvKDPywQ/LxuvflsMIw0
	MYsC2q3EV7WRKR7Bqhp6HdVeCe5r4BMxwvj4EfhLdceKPhU/kby1ZwfPB0tdLFCnnRj0
	egIQfhcMiar+HyKwB+rUk7zVlusAz8k3iALDYHThrMq7YfvK6qM/dECk8zk/UFc+zfLa
	SpBA==
X-Gm-Message-State: AJaThX6R/uLl0dwKaLEdFoSDQYJxsuV80Cq0hJc/g3HiYlQfwkF9w8m0
	Ea/Ch1KC+U3AnwJDsTt1BMnrBNj4ZPgLE2tgShU=
X-Google-Smtp-Source: ABhQp+Thntx8rBuMrdrXB6q2Vyc1+TwicnEzpW0+5tWA6Mhm34EWqmlUbEk1sQKB4RZ30w0yPTRbRgQmhOEYTkgLFlo=
X-Received: by 10.28.231.10 with SMTP id e10mr2498622wmh.1.1510219348905; Thu,
	09 Nov 2017 01:22:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.183.212 with HTTP; Thu, 9 Nov 2017 01:22:28 -0800 (PST)
In-Reply-To: <CAEg-Je9hYNXunpv6wprTAZhnyRnu4yUFanY0aTd2C4-LSeV5vA@mail.gmail.com>
References: <CAEg-Je9okCK9dEaV9Ytk6SvyzcCT=LeViP5o53F7B4oL+eR0vw@mail.gmail.com>
	<8732517.rS9bQnFJfK@peggleto-mobl.ger.corp.intel.com>
	<CAEg-Je9hYNXunpv6wprTAZhnyRnu4yUFanY0aTd2C4-LSeV5vA@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 9 Nov 2017 10:22:28 +0100
Message-ID: <CA+chaQc2CyPr6SnwP7x0TC6-V5zqt=DmW1QmJOVofWBWas_vjA@mail.gmail.com>
To: Neal Gompa <ngompa13@gmail.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Releases of BitBake to package for Fedora?
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
X-List-Received-Date: Thu, 09 Nov 2017 09:22:28 -0000
Content-Type: multipart/alternative; boundary="089e082f84b4d31190055d895760"

--089e082f84b4d31190055d895760
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is also the opposite use case where people are using bitbake to build
intentionally older release of OE metadata and bitbake often isn't
backwards compatible. So as Paul said they need to use older release of
bitbake with older release of metadata and the latest version of bitbake
from their favorite distribution won't be compatible with it.

On Thu, Nov 9, 2017 at 4:53 AM, Neal Gompa <ngompa13@gmail.com> wrote:

> On Wed, Nov 8, 2017 at 10:48 PM, Paul Eggleton
> <paul.eggleton@linux.intel.com> wrote:
> > Hi Neal,
> >
> > On Thursday, 9 November 2017 12:58:08 AM NZDT Neal Gompa wrote:
> >> I'm looking reintroduce BitBake into Fedora, but it seems like there
> >> hasn't been releases in two years. I also cannot identify anywhere
> >> that provides tarballs of BitBake to package.
> >>
> >> The Fedora package previously referenced snapshot tarballs generated
> >> by tagged releases in OE Git, but there haven't been new tagged
> >> releases in two years.
> >>
> >> I'd previously asked this on oe-core ML and was redirected to
> >> bitbake-devel, so apologies to cross-list subs. But it was also
> >> pointed out there that apparently BitBake has moved to a model where
> >> they don't have stable points of releases, which seems rather odd for
> >> a tool that is used by more than OpenEmbedded.
> >
> > It's not that we don't have stable points - we do, it's that from the
> other
> > side, each stable release of OE-Core is only tested with the
> corresponding
> > stable release of BitBake, so if people start using BitBake from their
> distro
> > we are probably going to have extra mismatch issues to deal with. We
> really
> > ought to be tagging releases, not having done that is an oversight but
> it's
> > reflective of the current typical usage.
> >
> > It would be nice to get some exposure of BitBake as a standalone tool,
> and
> > having it packaged by distros might be one way to help that, but my
> concern
> > for OE usage would be that when this has been done in the past we have
> had
> > situations where BitBake from the distro has been older than needed by
> OE-Core
> > and users end up having to fetch it themselves anyway, so we'd have to
> have a
> > strategy for handling that.
> >
> > (This is not necessarily an official answer - I'd be interested to hear
> what
> > RP and others have to say about it.)
> >
>
> For what it's worth, if you guys are regularly tagging BitBake, this
> can be automatically tracked in Fedora infrastructure and I can update
> BitBake relatively quickly after that.
>
> Unlike most distributions, it's usually not a problem to update
> relatively frequently in Fedora. But that doesn't mean you should
> stress me out with tons of releases out the wazoo. :)
>
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

--089e082f84b4d31190055d895760
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There is also the opposite use case where people are using=
 bitbake to build intentionally older release of OE metadata and bitbake of=
ten isn&#39;t backwards compatible. So as Paul said they need to use older =
release of bitbake with older release of metadata and the latest version of=
 bitbake from their favorite distribution won&#39;t be compatible with it.<=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Nov =
9, 2017 at 4:53 AM, Neal Gompa <span dir=3D"ltr">&lt;<a href=3D"mailto:ngom=
pa13@gmail.com" target=3D"_blank">ngompa13@gmail.com</a>&gt;</span> wrote:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">O=
n Wed, Nov 8, 2017 at 10:48 PM, Paul Eggleton<br>
&lt;<a href=3D"mailto:paul.eggleton@linux.intel.com">paul.eggleton@linux.in=
tel.com</a><wbr>&gt; wrote:<br>
&gt; Hi Neal,<br>
&gt;<br>
&gt; On Thursday, 9 November 2017 12:58:08 AM NZDT Neal Gompa wrote:<br>
&gt;&gt; I&#39;m looking reintroduce BitBake into Fedora, but it seems like=
 there<br>
&gt;&gt; hasn&#39;t been releases in two years. I also cannot identify anyw=
here<br>
&gt;&gt; that provides tarballs of BitBake to package.<br>
&gt;&gt;<br>
&gt;&gt; The Fedora package previously referenced snapshot tarballs generat=
ed<br>
&gt;&gt; by tagged releases in OE Git, but there haven&#39;t been new tagge=
d<br>
&gt;&gt; releases in two years.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;d previously asked this on oe-core ML and was redirected to<=
br>
&gt;&gt; bitbake-devel, so apologies to cross-list subs. But it was also<br=
>
&gt;&gt; pointed out there that apparently BitBake has moved to a model whe=
re<br>
&gt;&gt; they don&#39;t have stable points of releases, which seems rather =
odd for<br>
&gt;&gt; a tool that is used by more than OpenEmbedded.<br>
&gt;<br>
&gt; It&#39;s not that we don&#39;t have stable points - we do, it&#39;s th=
at from the other<br>
&gt; side, each stable release of OE-Core is only tested with the correspon=
ding<br>
&gt; stable release of BitBake, so if people start using BitBake from their=
 distro<br>
&gt; we are probably going to have extra mismatch issues to deal with. We r=
eally<br>
&gt; ought to be tagging releases, not having done that is an oversight but=
 it&#39;s<br>
&gt; reflective of the current typical usage.<br>
&gt;<br>
&gt; It would be nice to get some exposure of BitBake as a standalone tool,=
 and<br>
&gt; having it packaged by distros might be one way to help that, but my co=
ncern<br>
&gt; for OE usage would be that when this has been done in the past we have=
 had<br>
&gt; situations where BitBake from the distro has been older than needed by=
 OE-Core<br>
&gt; and users end up having to fetch it themselves anyway, so we&#39;d hav=
e to have a<br>
&gt; strategy for handling that.<br>
&gt;<br>
&gt; (This is not necessarily an official answer - I&#39;d be interested to=
 hear what<br>
&gt; RP and others have to say about it.)<br>
&gt;<br>
<br>
</div></div>For what it&#39;s worth, if you guys are regularly tagging BitB=
ake, this<br>
can be automatically tracked in Fedora infrastructure and I can update<br>
BitBake relatively quickly after that.<br>
<br>
Unlike most distributions, it&#39;s usually not a problem to update<br>
relatively frequently in Fedora. But that doesn&#39;t mean you should<br>
stress me out with tons of releases out the wazoo. :)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there&#39;s only one truth!<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">--<br>
______________________________<wbr>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org">bitbake-devel@lists=
.<wbr>openembedded.org</a><br>
<a href=3D"http://lists.openembedded.org/mailman/listinfo/bitbake-devel" re=
l=3D"noreferrer" target=3D"_blank">http://lists.openembedded.org/<wbr>mailm=
an/listinfo/bitbake-devel</a><br>
</div></div></blockquote></div><br></div>

--089e082f84b4d31190055d895760--
