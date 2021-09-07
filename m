Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.35608.1631023034467795763
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 06:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=nTd41ZxQ;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: martin.jansa@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id e7so5866045plh.8
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXFMdQxd8KBb22vWQbF6li4nc3bndU0+Z90sM5JvwO4=;
        b=nTd41ZxQtZr92v4zhCU8ij5lkd8yoa4R+R3cNuVKdIgQJxjc6HKNlsVHmsLx2e4Dlk
         /oJLYCOtNIYshPnKH8Mpay2gxSaPbXOLgaSgQ/x/2ilNfeAeGjzxmkDPdosL4Nw/ZnTo
         9kTLPU4nSmZeB6mBwqzVkxp6L/FuGCTQLEjkGu8Y3KY9YVWwcp+RiPhDDMXeU1XP9ceB
         ovkz20jqOaAY+xFkEUFYnobNKW84cQd8Sy0vEk+13NTPQes84EZlqs7vredfMpaxYRrO
         MozUp3oEKh8Xv2cPCO+Epi/S41pH72WqLj/lMX69BbZe68FwY6ULX7oMLvvWRgj3qHSw
         wIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXFMdQxd8KBb22vWQbF6li4nc3bndU0+Z90sM5JvwO4=;
        b=AsM1G6Gz1K8kPYpdzD1g/TUDDhLJhHzMpVnqfvsbLj3GyeQmukSNctREEOMj/8n6aG
         tpde7vsTJHlKt1G5RfVoCYAOa32WinZCDIPPmhlrz6BMf/yqcZWbASD0xalG0igbZ6LU
         yUaduXJ0gjpS8tU38uQMpV0EIqm3k04x/nmRJmfoWApQVbrswF+55CWslvoRQs3JGmI9
         Ssn/wXTjDkv6GtaZBOOQ1Bfj91j2Xa+QAuYqY5V0L9dMdONLISeclti2nw0t+cKvXAQJ
         +pV8bMjhogEEqIRFp/ntlcDrAXTuZNOWCidZXfYI9FGd5owWalbgRknzyBHFg7FM/ZVe
         I+hg==
X-Gm-Message-State: AOAM531lWVHAbLhBbTxa1Yyj4utWVlZlmNgIeofUU58SSWLTmJOhY7JJ
	gJiCZN3lzHlBBBCUKwlMQddX1hsaKvf6YHkKx0k=
X-Google-Smtp-Source: ABdhPJw9w+HT6BmiIJZcisgn9wgXbM9d+m6ml3Cm8nIbK8Qnhj/Anet8oNDhpi0TM+1MMzutYHiDfh9URQj6xt1x3wg=
X-Received: by 2002:a17:90a:7a8b:: with SMTP id q11mr4718902pjf.35.1631023033718;
 Tue, 07 Sep 2021 06:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
 <3199.1631004870582679813@lists.openembedded.org> <3ac3e69e0b3d7f0cbb25da58c450411b466259a7.camel@linuxfoundation.org>
 <17bc0861fe8.10265a7ec273381.5356961515124934870@ertelnet.rybnik.pl>
In-Reply-To: <17bc0861fe8.10265a7ec273381.5356961515124934870@ertelnet.rybnik.pl>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 7 Sep 2021 15:57:02 +0200
Message-ID: <CA+chaQf+u6gyD_XdgKbzEq=JXi=3vZvYoM85QEBPnt4nYtxG1Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000008b99e405cb682464"

--0000000000008b99e405cb682464
Content-Type: text/plain; charset="UTF-8"

You can modify LAYERSERIES_COMPAT_clang-layer to whatever you need after
you provide whatever is needed for layer (a) to be compatible with the rest
of your stack of layers.

See meta-qt5-compat as an example
https://github.com/webosose/meta-webosose/tree/2db6a1bc8e1a6f82db5b8f345d5aaa29e74fede5/meta-qt5-compat

Regards,

On Tue, Sep 7, 2021 at 3:50 PM Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
wrote:

>
>
>
>  ---- On Tue, 07 Sep 2021 13:40:07 +0200 Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote ----
>  > On Tue, 2021-09-07 at 01:54 -0700, Damian Wrobel wrote:
>  > > On Sat, Sep 4, 2021 at 09:54 AM, Richard Purdie wrote:
>  > > > Adding a single keyword every six months to show the layer is
> active and
>  > > > meant
>  > > > to work with a new release is not in my view a huge maintenance
> burden
>  > > > compared
>  > > > to showing that the layer is actively maintained and clearly
> showing which
>  > > > combinations are meant to work.
>  > >
>  > > It's not feasible because if the layer required some extra bbclasses
> cherry-
>  > > picked to be support it in the older yocto, then no one can simply
> add this
>  > > keyword to mark it's supported with older yocto.
>  >
>  > I don't understand your example here. If you can cherry-pick changes
> into a
>  > layer, you can also add a patch to mark the layer as supported using the
>  > standard variables?
>
> Let's consider the following example:
>
> a) meta-layer-which-we-want-to-consume (contains:
> LAYERSERIES_COMPAT_clang-layer = "gatesgarth hardknott")
> b) openembedded-core
> c) bitbake
> d) meta-our-layer
>
> By saying that layer (a) required some extra bbclasses to be cherry-picked
> I meant that
> in order to use layer (a) we had to cherry-pick some extra bbclasses or
> other changes
> into (d) to get (a) working with (b) and (c).
>
> This worked for us when (b), (c) and (d) were on yocto morty, but stopped
> to work when
> we switched to dunfell because dunfell started to utilize
> LAYERSERIES_COMPAT.
>
> This is very common situation that nothing needs to be modified in (a) to
> get it working with different versions
> of (b) and (c).
>
> So the question is why we have to modify also (a) to make (c) happy?
>
> --
> Regards,
> Damian
>
>  >
>  > > This in practise means that despite the layer itself didn't require
> any
>  > > changes to be supported in older yocto it will be unconditionally
> rejected by
>  > > bitbake.
>  >
>  > Your previous sentence says "the layer required some extra bbclasses"
> so it did
>  > need changes?
>  >
>  > > So, in reality it mean that such a layer has to be forked and
> modified to be
>  > > accepted by bitbake.
>  > >
>  > > I hope this clearly shows why this kind of checking in bitbake is
>  > > inappropriate.
>  >
>  > I'm afraid I don't understand your example.
>  >
>  > Cheers,
>  >
>  > Richard
>  >
>  >
>
> 
>
>

--0000000000008b99e405cb682464
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You can modify LAYERSERIES_COMPAT_clang-layer to whatever =
you need after you provide whatever is needed for layer (a) to be compatibl=
e with the rest of your stack of layers.<div><br></div><div>See meta-qt5-co=
mpat as an example=C2=A0<a href=3D"https://github.com/webosose/meta-webosos=
e/tree/2db6a1bc8e1a6f82db5b8f345d5aaa29e74fede5/meta-qt5-compat">https://gi=
thub.com/webosose/meta-webosose/tree/2db6a1bc8e1a6f82db5b8f345d5aaa29e74fed=
e5/meta-qt5-compat</a></div><div><br></div><div>Regards,</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 7=
, 2021 at 3:50 PM Damian Wrobel &lt;<a href=3D"mailto:dwrobel@ertelnet.rybn=
ik.pl">dwrobel@ertelnet.rybnik.pl</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><br>
<br>
<br>
=C2=A0---- On Tue, 07 Sep 2021 13:40:07 +0200 Richard Purdie &lt;<a href=3D=
"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdi=
e@linuxfoundation.org</a>&gt; wrote ----<br>
=C2=A0&gt; On Tue, 2021-09-07 at 01:54 -0700, Damian Wrobel wrote:<br>
=C2=A0&gt; &gt; On Sat, Sep 4, 2021 at 09:54 AM, Richard Purdie wrote:<br>
=C2=A0&gt; &gt; &gt; Adding a single keyword every six months to show the l=
ayer is active and<br>
=C2=A0&gt; &gt; &gt; meant<br>
=C2=A0&gt; &gt; &gt; to work with a new release is not in my view a huge ma=
intenance burden<br>
=C2=A0&gt; &gt; &gt; compared<br>
=C2=A0&gt; &gt; &gt; to showing that the layer is actively maintained and c=
learly showing which<br>
=C2=A0&gt; &gt; &gt; combinations are meant to work.<br>
=C2=A0&gt; &gt;<br>
=C2=A0&gt; &gt; It&#39;s not feasible because if the layer required some ex=
tra bbclasses cherry-<br>
=C2=A0&gt; &gt; picked to be support it in the older yocto, then no one can=
 simply add this<br>
=C2=A0&gt; &gt; keyword to mark it&#39;s supported with older yocto.<br>
=C2=A0&gt; <br>
=C2=A0&gt; I don&#39;t understand your example here. If you can cherry-pick=
 changes into a<br>
=C2=A0&gt; layer, you can also add a patch to mark the layer as supported u=
sing the<br>
=C2=A0&gt; standard variables?<br>
<br>
Let&#39;s consider the following example:<br>
<br>
a) meta-layer-which-we-want-to-consume (contains: LAYERSERIES_COMPAT_clang-=
layer =3D &quot;gatesgarth hardknott&quot;)<br>
b) openembedded-core<br>
c) bitbake<br>
d) meta-our-layer<br>
<br>
By saying that layer (a) required some extra bbclasses to be cherry-picked =
I meant that<br>
in order to use layer (a) we had to cherry-pick some extra bbclasses or oth=
er changes<br>
into (d) to get (a) working with (b) and (c).<br>
<br>
This worked for us when (b), (c) and (d) were on yocto morty, but stopped t=
o work when<br>
we switched to dunfell because dunfell started to utilize LAYERSERIES_COMPA=
T.<br>
<br>
This is very common situation that nothing needs to be modified in (a) to g=
et it working with different versions<br>
of (b) and (c).<br>
<br>
So the question is why we have to modify also (a) to make (c) happy?<br>
<br>
--<br>
Regards,<br>
Damian<br>
<br>
=C2=A0&gt; <br>
=C2=A0&gt; &gt; This in practise means that despite the layer itself didn&#=
39;t require any<br>
=C2=A0&gt; &gt; changes to be supported in older yocto it will be unconditi=
onally rejected by<br>
=C2=A0&gt; &gt; bitbake.<br>
=C2=A0&gt; <br>
=C2=A0&gt; Your previous sentence says &quot;the layer required some extra =
bbclasses&quot; so it did<br>
=C2=A0&gt; need changes?<br>
=C2=A0&gt; <br>
=C2=A0&gt; &gt; So, in reality it mean that such a layer has to be forked a=
nd modified to be<br>
=C2=A0&gt; &gt; accepted by bitbake.<br>
=C2=A0&gt; &gt; <br>
=C2=A0&gt; &gt; I hope this clearly shows why this kind of checking in bitb=
ake is<br>
=C2=A0&gt; &gt; inappropriate.<br>
=C2=A0&gt; <br>
=C2=A0&gt; I&#39;m afraid I don&#39;t understand your example.<br>
=C2=A0&gt; <br>
=C2=A0&gt; Cheers,<br>
=C2=A0&gt; <br>
=C2=A0&gt; Richard<br>
=C2=A0&gt; <br>
=C2=A0&gt; <br>
<br>
<br>
<br>
</blockquote></div>

--0000000000008b99e405cb682464--
