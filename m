Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD7DC6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 12:31:57 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.10824.1678969908605108131
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 05:31:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=eor/bCw2;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id a32so1510045ljq.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678969907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ISvd+A/od4qHN40hvnWpsUjgRsxyHZN4PZmwcJmTzYk=;
        b=eor/bCw2GXpODGfc2PhuP8oAfk97fYvzmWQXhJ39oMCsgFaPioy1Au+kMuWauIUPWP
         HUVX7syskTPi8z1CtqOYDJSP0GAH4Tg+FUFqg0PVsI1hSz6Z1+/QjWwn/hiY/6mFvNUt
         0ywZhOT0ECl8+2qLr8Kg9ofdFL1vAcebIMDhYhJ+2HKXEx3vVGQ/eXndW9OLYBdERZFB
         hSAbaTnCZGbEpY0hm8evyvIA+/LOtTdHicSd5gddIuGa1jfSSodFzo2DPGkyqm4zZ+JU
         fStUaGlHGWePWDeKTd4fQPG2OdT45uCoCc4MBGwwwd/Qo/D/AIPzUxlGEIBmDe0r45vy
         opew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISvd+A/od4qHN40hvnWpsUjgRsxyHZN4PZmwcJmTzYk=;
        b=LQgOCPVWdByNYoLXurP5jDBT7GBfWAjpr4DfW7nQBs+C0s1Q0jJLLeCb3LyKxk1O/6
         RMK1uEhN9gl5WZfDHfn9WR4i4cV4y8AXQCaHdfZAXcsWZv9D+aDsXRYeNMxc9lcmytBX
         skX+RAikR3aHmHy/IZbhtthZYWkWQACFM+JBbVomAtSt98j0ioh2c0JSnTNhF3MIMyYw
         AAbvXbxz8lznlKHqloFO2ylqH9AKfBCC0QEyTPmdCP5w0iLu3ueO+ZjNh/DlzmlWSPRe
         A3lm4tiloyjlrjiLs/IpJe+KjGcr3AdY2QE7E3xf6WI+45BoBdruw4h+mJuPlYIJXBuP
         LSzg==
X-Gm-Message-State: AO0yUKUHjJvlE7tSonYtIS3EqrryXFtaSymZPAYV5gGPDkFovwo/2051
	29IH++gWdvQeMcmlh7pRHsP3JDaMTm9/orQ8aME=
X-Google-Smtp-Source: AK7set8VXMl7yKKvkKhtbxP/Y7AbLNsg1RzR2af64XA5ERHR9ZSzeruTH1Pebg8boLhbFuROqakvx+CcZ5DbJjYEA/Y=
X-Received: by 2002:a2e:b521:0:b0:294:6de5:e642 with SMTP id
 z1-20020a2eb521000000b002946de5e642mr2048739ljm.3.1678969906674; Thu, 16 Mar
 2023 05:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
 <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
 <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com>
 <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
 <CANNYZj9msRQ5MnC9wHtD0w9zscDXeq2+dxt8fwzZzNnAcPquWg@mail.gmail.com>
 <174CACDDD2990A66.7968@lists.openembedded.org> <CA+cAker=UA3mMte8-+ghj2y-r4x46Jre+ODo5m-4jn4bgr-bxg@mail.gmail.com>
 <CANNYZj_2S+=MyyLtJC2Z8vV1TnEgY9gmX_uT_KC0hagpMi48Qg@mail.gmail.com>
 <CA+cAkeo99FtejmqyBYShTPRfRuS3nnA=wUWVSHHt+nkx8dzz7w@mail.gmail.com>
 <CANNYZj8gxTwCXE=6PT4uU0fEKwMTq3s2YV0DNo=qbhgWdgOi4Q@mail.gmail.com>
 <CA+cAkeom=GRNhvTG+KyjD2ViMCZRHkWsUq19A+xnu+66C15YXg@mail.gmail.com> <CAO5Uq5SKYKHAEp4Uspd2EiN-beK9Ow1B_BNfyHNXegHB2vzO4A@mail.gmail.com>
In-Reply-To: <CAO5Uq5SKYKHAEp4Uspd2EiN-beK9Ow1B_BNfyHNXegHB2vzO4A@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 16 Mar 2023 13:31:35 +0100
Message-ID: <CA+cAkeox33SiB+D-rxdTkL5K_wp+ZQNWcT0rLA5R5MK7E-3eGA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000e03dbd05f703a476"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 12:31:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14588

--000000000000e03dbd05f703a476
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

True.

Le jeu. 16 mars 2023, 13:24, Alex Kiernan <alex.kiernan@gmail.com> a =C3=A9=
crit :

> On Thu, Mar 16, 2023 at 10:52=E2=80=AFAM Fr=C3=A9d=C3=A9ric Martinsons
> <frederic.martinsons@gmail.com> wrote:
> >
> > A rust/cargo project can perfectly be built without Cargo.lock since
> cargo will generate
> > it on the fly.
> >
>
> But what you build is undefined as you'll get the latest non-yanked
> crate that satisfies the dependency solver.
>
> > I'll provide the Cargo.lock from git along with the recipe then.
> >
> >
> >
> > On Thu, 16 Mar 2023 at 11:42, Alexander Kanavin <alex.kanavin@gmail.com=
>
> wrote:
> >>
> >> On Thu, 16 Mar 2023 at 11:07, Fr=C3=A9d=C3=A9ric Martinsons
> >> <frederic.martinsons@gmail.com> wrote:
> >> > I managed easily to update uutils-coreutils (I removed its README.tx=
t
> by the way) but
> >> > I cannot do it for python3-pyruvate because I cannot find a
> Cargo.lock file, the git
> >> > repository had once though (see the tag under gitlab) so it seems
> that it is related
> >> > to the fetch by pypi which doesn't embed the Cargo.lock (or a bug in
> the packaging
> >> > of the project). I don't know what to do with this one.
> >>
> >> It does seem like a bug, how can it build without Cargo.lock?
> >> You can inject the Cargo.lock from the git repo into the tree, and
> >> generate checksums with that.
> >>
> >> Alex
>
>
>
> --
> Alex Kiernan
>

--000000000000e03dbd05f703a476
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">True.=C2=A0</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Le jeu. 16 mars 2023, 13:24, Alex Kiernan &lt=
;<a href=3D"mailto:alex.kiernan@gmail.com">alex.kiernan@gmail.com</a>&gt; a=
 =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Mar 16, =
2023 at 10:52=E2=80=AFAM Fr=C3=A9d=C3=A9ric Martinsons<br>
&lt;<a href=3D"mailto:frederic.martinsons@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">frederic.martinsons@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; A rust/cargo project can perfectly be built without Cargo.lock since c=
argo will generate<br>
&gt; it on the fly.<br>
&gt;<br>
<br>
But what you build is undefined as you&#39;ll get the latest non-yanked<br>
crate that satisfies the dependency solver.<br>
<br>
&gt; I&#39;ll provide the Cargo.lock from git along with the recipe then.<b=
r>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, 16 Mar 2023 at 11:42, Alexander Kanavin &lt;<a href=3D"mailto:=
alex.kanavin@gmail.com" target=3D"_blank" rel=3D"noreferrer">alex.kanavin@g=
mail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, 16 Mar 2023 at 11:07, Fr=C3=A9d=C3=A9ric Martinsons<br>
&gt;&gt; &lt;<a href=3D"mailto:frederic.martinsons@gmail.com" target=3D"_bl=
ank" rel=3D"noreferrer">frederic.martinsons@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt; I managed easily to update uutils-coreutils (I removed its RE=
ADME.txt by the way) but<br>
&gt;&gt; &gt; I cannot do it for python3-pyruvate because I cannot find a C=
argo.lock file, the git<br>
&gt;&gt; &gt; repository had once though (see the tag under gitlab) so it s=
eems that it is related<br>
&gt;&gt; &gt; to the fetch by pypi which doesn&#39;t embed the Cargo.lock (=
or a bug in the packaging<br>
&gt;&gt; &gt; of the project). I don&#39;t know what to do with this one.<b=
r>
&gt;&gt;<br>
&gt;&gt; It does seem like a bug, how can it build without Cargo.lock?<br>
&gt;&gt; You can inject the Cargo.lock from the git repo into the tree, and=
<br>
&gt;&gt; generate checksums with that.<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
<br>
<br>
<br>
-- <br>
Alex Kiernan<br>
</blockquote></div>

--000000000000e03dbd05f703a476--

