Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA6C761AF
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 16:29:09 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web10.135157.1680712145628942192
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 09:29:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=N2KHjmdo;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id e9so22602778ljq.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680712143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mo3xIrz1AdnRegES9fDTC1owiKaJJPM2hLs3qfghqqE=;
        b=N2KHjmdoGmbsiIrwi+z3+eVHkuAx1oK7WUyy0grlQ6CdEbzV2SQFlDe0ue4YzsGBuL
         +1yprijH99pJMMXYs5EGQZ02QafHLbEgsCfss+O+aZexdXywyidgypp2DFfP4VNtIaTc
         b2FX7Vc/WM1kdA1nH+oQWc1xRB6nb45EwSAeBrwGHsf3uSVNFeLW5o4+9Z717OxW+ouV
         3p+3Tb6haj+XmfCOvctUwMSpzQ7/MxixfptHwRxdlG/iDE3svDfv350IuQv0c2N7WGq9
         oNS68X87QiVEg3dazKZmqizUXpdiG8Lxyll6jfuwSyYrIzWSrQ0+Q1h9CFzoks3RIF3i
         dx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mo3xIrz1AdnRegES9fDTC1owiKaJJPM2hLs3qfghqqE=;
        b=mWRVTi6GzaZdZQDMt78T8ru6JlaD2+SSCnDInPdYV8SHa0R+JIj8ylgcAbnW/HHEzB
         WiRhDzKXxvISxcIeQJVX8nZxM505MI8CiAWOcZvlb7jnzi21qAzCa7CEGV7NPQ1UeFOD
         HzK/WIh4wsjQYqSj38ihHBmx/QehVj7lcsarY1fKJAkKNia0gHG6av8g6b6HCxkWmawc
         Ki2voghUNEc6ngN6k5sADRz6K2/szCqOIXqYzaPYA9iqr4bYb9ESWSvMDrmX5hzLlFis
         7FI4K08rlhMiuCTnl3wD9oxF477SoB9h0QAko5aD8H8C7rRy/hNlfL1W2I0+7PjpAQNJ
         vGAQ==
X-Gm-Message-State: AAQBX9dbUJSBCW/RR1wp3XwgjBIOCn8FmKOy85BsU551+qfGYbaCexcC
	ZC4Z9aY81jjAK7cAaL0HCm2FTypt8f3su9tgTZM=
X-Google-Smtp-Source: AKy350amRQZ1R3tPBMOouMGc2ebUPqgZgZumIzGqQ/B3lEtk213cV9gz5GT4xs7cBBWbHO3DGTl5lERo9N/rQ5v651E=
X-Received: by 2002:a2e:9115:0:b0:298:b32c:e4f9 with SMTP id
 m21-20020a2e9115000000b00298b32ce4f9mr2456147ljg.3.1680712143315; Wed, 05 Apr
 2023 09:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de> <17530ADB1695B5D1.3977@lists.openembedded.org>
In-Reply-To: <17530ADB1695B5D1.3977@lists.openembedded.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 18:28:51 +0200
Message-ID: <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000045a54505f8994adc"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 16:29:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14659

--00000000000045a54505f8994adc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No, I take that back, it should not be an issue since you set the name only
if it is not already there. But, to be sure, did you try to build some
existing cargo based recipe (zvariant but also python3-bcrypt for example).

Anyway, I tend to think we should keep using
cargo-update-update-recipe-crates as the only entry point to update those
recipe so maybe we want to made modifications there to handle the most
possible use case (missing Cargo.lock, bad Cargo.lock, some other corner
cases... Etc)

Le mer. 5 avr. 2023, 14:50, Frederic Martinsons via lists.openembedded.org
<frederic.martinsons=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :

> It remains the problem with zvariant recipe in meta-selftest layer but
> I'll let others answer since they may have a bigger picture on that
>
> Le mer. 5 avr. 2023, 14:24, Enrico Scholz <enrico.scholz@sigma-chemnitz.d=
e>
> a =C3=A9crit :
>
>> Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:
>>
>> > A rust project must have a Cargo.lock in its source (
>> >
>> https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-have-cargolock-=
in-version-control-but-not-libraries
>>
>> It is recommended (due to documentation issues), but not required.
>>
>>
>> Enrico
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14656):
> https://lists.openembedded.org/g/bitbake-devel/message/14656
> Mute This Topic: https://lists.openembedded.org/mt/98079257/6213388
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> frederic.martinsons@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000045a54505f8994adc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>No, I take that back, it should not be an issue sinc=
e you set the name only if it is not already there. But, to be sure, did yo=
u try to build some existing cargo based recipe (zvariant but also python3-=
bcrypt for example).=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Anyway, I tend to think we should keep using cargo-update-update-recipe-=
crates as the only entry point to update those recipe so maybe we want to m=
ade modifications there to handle the most possible use case (missing Cargo=
.lock, bad Cargo.lock, some other corner cases... Etc)=C2=A0<br><br><div cl=
ass=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">Le m=
er. 5 avr. 2023, 14:50, Frederic Martinsons via <a href=3D"http://lists.ope=
nembedded.org" target=3D"_blank" rel=3D"noreferrer">lists.openembedded.org<=
/a> &lt;frederic.martinsons=3D<a href=3D"mailto:gmail.com@lists.openembedde=
d.org" target=3D"_blank" rel=3D"noreferrer">gmail.com@lists.openembedded.or=
g</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div =
dir=3D"auto">It remains the problem with zvariant recipe in meta-selftest l=
ayer but I&#39;ll let others answer since they may have a bigger picture on=
 that=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">Le mer. 5 avr. 2023, 14:24, Enrico Scholz &lt;<a href=3D"mailto:=
enrico.scholz@sigma-chemnitz.de" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">enrico.scholz@sigma-chemnitz.de</a>&gt; a =C3=A9crit=C2=A0:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Fr=C3=A9d=C3=A9ric Martinsons &lt;<a href=3D=
"mailto:frederic.martinsons@gmail.com" rel=3D"noreferrer noreferrer norefer=
rer" target=3D"_blank">frederic.martinsons@gmail.com</a>&gt; writes:<br>
<br>
&gt; A rust project must have a Cargo.lock in its source (<br>
&gt; <a href=3D"https://doc.rust-lang.org/cargo/faq.html#why-do-binaries-ha=
ve-cargolock-in-version-control-but-not-libraries" rel=3D"noreferrer norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://doc.rust-lang.org/car=
go/faq.html#why-do-binaries-have-cargolock-in-version-control-but-not-libra=
ries</a><br>
<br>
It is recommended (due to documentation issues), but not required.<br>
<br>
<br>
Enrico<br>
</blockquote></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14656): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14656" rel=3D"noreferrer noreferrer noreferrer" target=
=3D"_blank">https://lists.openembedded.org/g/bitbake-devel/message/14656</a=
><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/98079257/6213=
388" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lis=
ts.openembedded.org/mt/98079257/6213388</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" rel=3D"noreferrer noreferrer" target=3D"_blank">bitbake-devel+owner@lists=
.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://lists=
.openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:frederic.mar=
tinsons@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">frederic=
.martinsons@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div></div>

--00000000000045a54505f8994adc--

