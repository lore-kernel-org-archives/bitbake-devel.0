Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
 by mx.groups.io with SMTP id smtpd.web09.36192.1631023584574762414
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 07:06:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=UazRJJSU;
 spf=pass (domain: gmail.com, ip: 209.85.217.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f52.google.com with SMTP id f6so8411235vsr.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68gcJArg11bFNZr43Mc6Z8NN31mHhonj6TNSFfjVCZI=;
        b=UazRJJSU2xeVHAJVoyrCPAL6pyoSpWH7tyQAzTvRqcBySIPxLP9JRMDV42IXPxiQkU
         S+deSNphbTgEAwdYHgj1bD1JVL7OuwoObQOqfmPq126QGv/5Z+hz9DvyjCSvSuM9tfg7
         f9FPiCtEMWbyX828/HeYkFA+Sl7zJWtZtF/ayJQH0+q4zqwvEbq45VauCi6YKe+YdStA
         Q8xtjRXhGdCm/lCIInHUzP0+sIVBZrQXbSsLTBmgrZ9ZZ7bFKPafYYVyejJ8F5Whdjfm
         OX8iRNwfJbvNZqNmKui7snt+OQaM+jJXG+UhfGUK+3H56c73K/8wr5UTo13YlfChlpZq
         nbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68gcJArg11bFNZr43Mc6Z8NN31mHhonj6TNSFfjVCZI=;
        b=YXIM+ZXlAGDTjMhGUrsBsnNbZo+KoINs2bbLZA/EGVJUwoiwenFCVfi509VHN9HWFq
         fl4auf2JfKWnw1LRMwDck/mFLKdngdDKRElTISqeqwl0CzpE+xX/D/uzXwcR1G63TfOw
         XUnUluWz+45aT/d77r3i9anXnpLniHjtBVbAfzNeKJLcsWK9AO/btJDrTqj/cb4tnqST
         vphaBN+uoJcUC3vdHO55XTpcQeUCPr9OMv0ceChaYaKUvsLHS8PCb4oXdmA5ltpwjbyJ
         4gQVaBbdVCrg0wPJjZSxpH/L/+ni+pZxBc2S7RZh93vmxcH9WQNDpj1f55wm3s2iD2VR
         YLPA==
X-Gm-Message-State: AOAM530S2XGY7PIj7FNrssqkRJm847f9XE9yHqFC+AX9Qi4BN0GN+gn5
	NMSTjKTRitC7QVX3eaciRNbxj9/1NM+uN2All90=
X-Google-Smtp-Source: ABdhPJz54BISm+sOMid5qwEiOJqoAckeQ4ZyaoWr7yr7fqHydat8RNaYllz0+C0D0dQiQ63Vi1AwjfyoslcwoPxkWTQ=
X-Received: by 2002:a05:6102:94e:: with SMTP id a14mr9070493vsi.1.1631023583659;
 Tue, 07 Sep 2021 07:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <209f7a813b8003ad75e5edb9600f729a91abee7b.camel@linuxfoundation.org>
 <3199.1631004870582679813@lists.openembedded.org> <3ac3e69e0b3d7f0cbb25da58c450411b466259a7.camel@linuxfoundation.org>
 <17bc0861fe8.10265a7ec273381.5356961515124934870@ertelnet.rybnik.pl>
In-Reply-To: <17bc0861fe8.10265a7ec273381.5356961515124934870@ertelnet.rybnik.pl>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Tue, 7 Sep 2021 16:06:12 +0200
Message-ID: <CANNYZj8J0OSx4Ce+_xQ4jq24QnZxwJJ0eFNk1BUdt_xNrAuU2w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000053097805cb68459a"

--00000000000053097805cb68459a
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Sept 2021 at 15:50, Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
wrote:

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

I still do not understand what the problem is. meta-clang does have a
dunfell branch, that sets LAYERSERIES_COMPAT accordingly, why are you not
using that?

Alex

--00000000000053097805cb68459a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Tue, 7 Sept 2021 at 15:50, Damian Wrobel &lt;<a href=3D"mailto:dw=
robel@ertelnet.rybnik.pl">dwrobel@ertelnet.rybnik.pl</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Let&#39;s consider the =
following example:<br>
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
So the question is why we have to modify also (a) to make (c) happy?<br></b=
lockquote><div><br></div><div>I still do not understand what the problem is=
. meta-clang does have a dunfell branch, that sets LAYERSERIES_COMPAT accor=
dingly, why are you not using that?</div><div><br></div><div>Alex<br></div>=
</div></div>

--00000000000053097805cb68459a--
