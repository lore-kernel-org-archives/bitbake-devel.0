Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F7BC6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 10:52:16 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.9304.1678963934803547792
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 03:52:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=liuKix6l;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id y20so1766101lfj.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678963933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5I/QJrqMrf5SuWnxbVIxSsi61PsKval4pzsI8BEZug=;
        b=liuKix6lnD38sBOSc/dYv1ZB3HRY4+CS97pOR3pVj4iAuQbaUs8RfJm67bdHf3qpJ5
         X/Uu10i7WWG6O079Emg3r7gP9c4qNKTspdexO+pHChO9xnv/Cnr0MaVkZl45tmP8EDT7
         Pvd7BDxoluYnrheMagSGS9Or2GMlrPkbQ8XWdA24SthIUcGEM33eW8R8XxMhm6NxFkMR
         s2/MxqPr/RZniW5QiXjw50O5zKGzklF8RyNpaUpVEjdoymMiUseJO6glpWBnZWk5kABI
         7Dcjh/e79/zA3poO07YzNmpkCqqkXU10WzR03dpOZzzTekRrD4Ql9rMknvmHi7Hf7gsz
         TTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5I/QJrqMrf5SuWnxbVIxSsi61PsKval4pzsI8BEZug=;
        b=ngNAkVwGo/7cxMFvzOOCpKdzco7n/fhpI9cSJhp+tLG6sTEdgfBUAr0sAgj6NcwpcG
         pxbN+uZBev0JhJWd0vvaxDEbL1GR2yfwpWZoU0UEboQ06ts083NdBNehLQslCbYPNr7H
         Lvd22cC3sR/uU79dWk+RvxmAS56JbilPHvYtxk4CXxo311W0MZmM83U+gIXrtqLX6h0Q
         8SutgPH+ZAOor4L8EnwjjBAZQUC30TjugNLhkKTv8D1LYyi/oVo9RnvBcH2fZfeqK5ig
         n2QDRMSFfrtgbHowGEfglAW4B9FCAiUIqz0ES+ioptEvc90PJyx8sDye35xMdNd4MA4q
         DY9Q==
X-Gm-Message-State: AO0yUKUenfD/HzJOtaOdXGB6gQ9D1kuDwtFsL5BSiYu6UcjwylU6l574
	TsYo5TMseoS9e/uS8WuS3pvewM5Hi1DAEr9W/4TItY+J
X-Google-Smtp-Source: AK7set90WvwaOP5962V6Wwg0wm6YcVCzDdaO7WP/7TuUinpzGBG6PNn5nqtTL+I7Ce/aIBbrQ7Wr3DkgBDfFY1ay51M=
X-Received: by 2002:ac2:5102:0:b0:4e8:45d5:53cd with SMTP id
 q2-20020ac25102000000b004e845d553cdmr2936235lfb.12.1678963932953; Thu, 16 Mar
 2023 03:52:12 -0700 (PDT)
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
 <CA+cAkeo99FtejmqyBYShTPRfRuS3nnA=wUWVSHHt+nkx8dzz7w@mail.gmail.com> <CANNYZj8gxTwCXE=6PT4uU0fEKwMTq3s2YV0DNo=qbhgWdgOi4Q@mail.gmail.com>
In-Reply-To: <CANNYZj8gxTwCXE=6PT4uU0fEKwMTq3s2YV0DNo=qbhgWdgOi4Q@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 16 Mar 2023 11:52:01 +0100
Message-ID: <CA+cAkeom=GRNhvTG+KyjD2ViMCZRHkWsUq19A+xnu+66C15YXg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000d0814805f702405f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 10:52:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14582

--000000000000d0814805f702405f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A rust/cargo project can perfectly be built without Cargo.lock since cargo
will generate
it on the fly.

I'll provide the Cargo.lock from git along with the recipe then.



On Thu, 16 Mar 2023 at 11:42, Alexander Kanavin <alex.kanavin@gmail.com>
wrote:

> On Thu, 16 Mar 2023 at 11:07, Fr=C3=A9d=C3=A9ric Martinsons
> <frederic.martinsons@gmail.com> wrote:
> > I managed easily to update uutils-coreutils (I removed its README.txt b=
y
> the way) but
> > I cannot do it for python3-pyruvate because I cannot find a Cargo.lock
> file, the git
> > repository had once though (see the tag under gitlab) so it seems that
> it is related
> > to the fetch by pypi which doesn't embed the Cargo.lock (or a bug in th=
e
> packaging
> > of the project). I don't know what to do with this one.
>
> It does seem like a bug, how can it build without Cargo.lock?
> You can inject the Cargo.lock from the git repo into the tree, and
> generate checksums with that.
>
> Alex
>

--000000000000d0814805f702405f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">A rust/cargo project can perfectly be built without Cargo.=
lock since cargo will generate<div>it on the fly.=C2=A0</div><div><br></div=
><div>I&#39;ll provide the Cargo.lock from git along with the recipe then.<=
/div><div><br></div><div><br></div></div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, 16 Mar 2023 at 11:42, Alexander =
Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com">alex.kanavin@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Thu, 16 Mar 2023 at 11:07, Fr=C3=A9d=C3=A9ric Martinsons<br>
&lt;<a href=3D"mailto:frederic.martinsons@gmail.com" target=3D"_blank">fred=
eric.martinsons@gmail.com</a>&gt; wrote:<br>
&gt; I managed easily to update uutils-coreutils (I removed its README.txt =
by the way) but<br>
&gt; I cannot do it for python3-pyruvate because I cannot find a Cargo.lock=
 file, the git<br>
&gt; repository had once though (see the tag under gitlab) so it seems that=
 it is related<br>
&gt; to the fetch by pypi which doesn&#39;t embed the Cargo.lock (or a bug =
in the packaging<br>
&gt; of the project). I don&#39;t know what to do with this one.<br>
<br>
It does seem like a bug, how can it build without Cargo.lock?<br>
You can inject the Cargo.lock from the git repo into the tree, and<br>
generate checksums with that.<br>
<br>
Alex<br>
</blockquote></div>

--000000000000d0814805f702405f--

