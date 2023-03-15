Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E259C6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 18:47:16 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.1675.1678906035031157714
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 11:47:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=JwMeEro0;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: alex.kiernan@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id f14so8253756iow.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678906034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nXG47BFagGrqyC5dKlmscBXnvUpktUcRmM0dUgevCM=;
        b=JwMeEro0f0mK/itfwnCwZ+X1Pbf/FucpRGm09GdPo380Qh54A+NEksm0+KKcHEjcP9
         SDLlBreEvR7cVvfW1Jb3ELD9HiXYPCQxQ3bKA6TTkMc5h+V14HJ9xBQP9ntAU62ss2UH
         0GLJf6Ig4o6cNqE+JvazHVuUtGL5RvigSSosqooR2I4fiQAlFGuSYsk0ss4ygdbHwV34
         XbBRsYm/6ecvM4WFX041HPuxlNXfmNHr5T+6axGT2h2iQCSIHh+ukKh9Ithacr5wvtwh
         /s0j1vcOlW3QKfivYg0oiGs8gssBmhpALYG/PtmyUtbzOHypRUR55l0Y9DKwJINXN8K5
         URDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nXG47BFagGrqyC5dKlmscBXnvUpktUcRmM0dUgevCM=;
        b=EmpkT4yNueZNOs2rsvCwZ03z+RB/lKpmHOp+RfUfCKIQQWWlQaaGNIvO9gclyGCP6q
         RNnvzwsNw4BhlgjnftLBP/gS/zjUh1aWbA8RRYsnXTar5Q44HX2TpTKYjaH6dXZEUqP6
         72BacIN8PnEU31NbwkBemGbBs7XHLSE3JsHplmSSAv2BdYRYHBJIxWltIos8c14Iqiag
         srN+wbhKTYqdalOiTlHGuBoHVLEJ3RQ6VJb2f0DFcz0Y6wwm5ClAuR1Sz3/aAMuuMh3h
         wkvgjX4SkQMCOULX0o5gK9l8KumlyibVVyoPrfer90WuWNL2xKTD9LyUyzXirS1J7LDB
         jvPQ==
X-Gm-Message-State: AO0yUKWLdoKiMwl/6ISY5y37UdGpdbZfKUnI1AUEqfjRo0NJZg9jRMLC
	7q/WOS9CXVhO8lgdpObVUbET+MrYjVxZ73QCgt8=
X-Google-Smtp-Source: AK7set830uiFHjamWrAYyWEeYEgwhA3pcfEn5bqxE5/u5++cJyW1ZrFvSKEzDRMTaVccQPsorKiz1sMYMZWoLpb/TxA=
X-Received: by 2002:a05:6602:4287:b0:745:50e5:c861 with SMTP id
 cd7-20020a056602428700b0074550e5c861mr19053836iob.4.1678906034289; Wed, 15
 Mar 2023 11:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
 <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
 <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com> <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
In-Reply-To: <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Wed, 15 Mar 2023 18:47:02 +0000
Message-ID: <CAO5Uq5RLzLLEi-JUPmcPGUamx9no6NcmUSWSqimh1BFJWv5CiQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 18:47:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14573

On Wed, Mar 15, 2023 at 6:26=E2=80=AFPM Fr=C3=A9d=C3=A9ric Martinsons
<frederic.martinsons@gmail.com> wrote:
>
> Alright, I will add another patch for that in the coming days.
>
> But I still need some answers to go further:
>     - Should checksum verification for crate fetcher be mandatory ?
>     - What about librsvg ? It doesn't include any crate:// but needs to i=
nherit cargo_common, what should I do for this recipe ?
>

Sorry that was from the top of my head as a rust recipe - it doesn't
obviously need changes as it's not a cargo build.

>
> Le mer. 15 mars 2023, 19:09, Alexander Kanavin <alex.kanavin@gmail.com> a=
 =C3=A9crit :
>>
>> On Wed, 15 Mar 2023 at 18:54, Fr=C3=A9d=C3=A9ric Martinsons
>> <frederic.martinsons@gmail.com> wrote:
>> > Alex, when you talk about updating librsvg and cargo crate updater, do=
 you mind elaborate?
>>
>> classes-recipe/cargo-update-recipe-crates.bbclass should be updated to
>> write out not just the crate list into SRC_URI, but also their
>> checksums (this is not hard because it works from Cargo.lock, and that
>> already provides the checksums).
>>
>> Then the class should be used to update all recipes (e.g.
>> python3-bcrypt, python3-cryptography) that use the crate:// fetcher.
>>

These ones are the ones which will need work!


--=20
Alex Kiernan

