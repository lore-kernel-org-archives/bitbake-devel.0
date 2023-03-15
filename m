Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC6C61DA4
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 18:26:46 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.1099.1678904801555541940
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 11:26:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ctwwSkhi;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id l22so2309482ljc.11
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 11:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678904800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o8Lqj+DTIVGrxADCo+5ATJs/kehLYTikSxfHiAJ0OP8=;
        b=ctwwSkhi68sLwG2/ezMvEO9sJafTAYBZGWn/yt1KlnYb171fAlFBKsV7XFKayCua9+
         yIulEYJiwEM2isKSJyUHdgWtwa3pMrfxO8TJh19LIyURChBfxdb60DOmLfux/8MrQxk6
         4yG2y7THrxUPeDhuEm6AAKqRetipxm1y1z4JDhIuC0mC3DWxdPMUggmob/+RPo9n3j6a
         d1ajsETzja7JEa7bUhinIZnamZ5T+KNgYMPaqVMEt/AFo8KiChfnsOaSh/CVOh5arvKA
         go6gYGG8PNA+1eZ0YH4JZLR3Iz1h0n5fhinrR95N5jLjbuKNXO9Xz4a21McrW7dDme21
         9yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8Lqj+DTIVGrxADCo+5ATJs/kehLYTikSxfHiAJ0OP8=;
        b=yZi+9VyC75umsaDCyQdGKWbJmLRjPMM2bMdAXfnkMAtIFyDDwpjknhNBaqQ2YzdwtW
         ZwqjT0ZoxDu7KQBqStYEUXtb1EkHqoKQPn3FFsKe9fzyWIH/V8g6TA5MJi8XYcL99cOH
         pGL9TdKRwMHkEHTnKW5xWOp1qg18xShswDX+EpY01hJ2l+3k07Y8AsNLe76LdfZY6jmI
         PlfIpQIfTnbI+/FbKvNc9a+Mu4rGHe+Zxmi3re0rB2wmsEwvP6pTBoe7Cc0otCiUMmFI
         TCg4VlEFU2a2Sry2CIO5ZBIPSuggPSeKD+NpCNW9AHW3XM8LIoQbyTEreys7ENz5gY2h
         Kz2A==
X-Gm-Message-State: AO0yUKXC8wx1p6eaiHInF6JbrTRYImYrTR7bRpYlGU6GM0wDAigEAo5O
	zkbc8KHn+Ga/biiL/yZGwmBvxXtRzuOMEw7kKxE=
X-Google-Smtp-Source: AK7set+iedhflbcZ1+jztjXV6jSHA9UYYyvSNxNIyOMWbC8cWEiNfhLJ4VLtnCffE/4IE48XIf1q1bslw/jY6upzVOs=
X-Received: by 2002:a2e:a9a4:0:b0:295:acea:5884 with SMTP id
 x36-20020a2ea9a4000000b00295acea5884mr1629808ljq.3.1678904799679; Wed, 15 Mar
 2023 11:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
 <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com> <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com>
In-Reply-To: <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 15 Mar 2023 19:26:28 +0100
Message-ID: <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000325a2405f6f47c00"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 18:26:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14572

--000000000000325a2405f6f47c00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alright, I will add another patch for that in the coming days.

But I still need some answers to go further:
    - Should checksum verification for crate fetcher be mandatory ?
    - What about librsvg ? It doesn't include any crate:// but needs to
inherit cargo_common, what should I do for this recipe ?


Le mer. 15 mars 2023, 19:09, Alexander Kanavin <alex.kanavin@gmail.com> a
=C3=A9crit :

> On Wed, 15 Mar 2023 at 18:54, Fr=C3=A9d=C3=A9ric Martinsons
> <frederic.martinsons@gmail.com> wrote:
> > Alex, when you talk about updating librsvg and cargo crate updater, do
> you mind elaborate?
>
> classes-recipe/cargo-update-recipe-crates.bbclass should be updated to
> write out not just the crate list into SRC_URI, but also their
> checksums (this is not hard because it works from Cargo.lock, and that
> already provides the checksums).
>
> Then the class should be used to update all recipes (e.g.
> python3-bcrypt, python3-cryptography) that use the crate:// fetcher.
>
> Alex
>

--000000000000325a2405f6f47c00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">Alright, I will add another patch for th=
at in the coming days.</div><div dir=3D"auto"><br></div><div dir=3D"auto">B=
ut I still need some answers to go further:<br><div dir=3D"auto">=C2=A0 =C2=
=A0 - Should checksum verification=C2=A0for crate fetcher=C2=A0be mandatory=
 ?</div><div>=C2=A0 =C2=A0 - What about librsvg ? It doesn&#39;t include an=
y crate:// but needs to inherit cargo_common, what should I do for this rec=
ipe ?<br></div><div><br></div></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">Le mer. 15 mars 2023, 19:09, Alexander =
Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">ale=
x.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, 15 Mar 2023 at 18:54, Fr=C3=A9d=C3=
=A9ric Martinsons<br>
&lt;<a href=3D"mailto:frederic.martinsons@gmail.com" rel=3D"noreferrer" tar=
get=3D"_blank">frederic.martinsons@gmail.com</a>&gt; wrote:<br>
&gt; Alex, when you talk about updating librsvg and cargo crate updater, do=
 you mind elaborate?<br>
<br>
classes-recipe/cargo-update-recipe-crates.bbclass should be updated to<br>
write out not just the crate list into SRC_URI, but also their<br>
checksums (this is not hard because it works from Cargo.lock, and that<br>
already provides the checksums).<br>
<br>
Then the class should be used to update all recipes (e.g.<br>
python3-bcrypt, python3-cryptography) that use the crate:// fetcher.<br>
<br>
Alex<br>
</blockquote></div>

--000000000000325a2405f6f47c00--

