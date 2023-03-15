Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F441C6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 18:47:26 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web11.1676.1678906038742899986
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 11:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=nso8lRSk;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id t11so25511108lfr.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678906037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECM1Ii7FPA1E21yfReWGwHJei6kUfKyU3UA4jMI0TVc=;
        b=nso8lRSk66E5mRCVbmwwx4sTlaWinFsPK1qgjnQZ/xZV6bg0k654mmjh5g5lVp2grz
         lMWIJFmR0/dY/HkYbOT5bQV/FL7jLhJKPCyTuZTAOdhfQJ89PZ8XXcX3IsZM9ocn5toE
         3GokUh3uNEmN0DuzffqFPsDW0uNK4DzKunUWjU8VOEu18xDN0oMTCthcdi/KgT8Nsuhh
         LdHPtr+Bab/N4oEh4lteAaA/DnnnyQ57QiBRKJjcogWxV+Er49G0InlfdKBE4Gz12pNA
         sUWTDeoZ/L554XY+3CmeLdINZll7gspGQ+dxI0wW1HZi/1/JnshqB9du/Iy5wtviF7GL
         XvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECM1Ii7FPA1E21yfReWGwHJei6kUfKyU3UA4jMI0TVc=;
        b=auQMKVP/M1m3pNNk3TqdHoq7R0OTXisXu058IwoybAVKiXBQGbAO8tBB7/zfxHzDwp
         cJuQr0FHgcDP9sY0HPnn0XyGLPJJyw6MrYGeNn6Vg17LevJP+ifyVUQP59brnHMIeNdp
         +WeraiyWoKJGQe3TFpbmtfe3EqrQRuODwYtYMxruJBIa+46xjnOiPRSDAiWVR3kXW4oi
         LXvZXbAkwp3332sz4jckuS68NNlmtuSacOXRUcLCnjHwc6w/JzKOqJ8XSbWapmJLSmJi
         t56TYyCTe1ZE1ARO5I727f0O/patW6km+2U+2jiurrkI0hDSa7qOpF0HMnf8GlFf17qO
         oYwA==
X-Gm-Message-State: AO0yUKWTM6Z432F0ZlNUGBxMrurdVrcO7JAvmB6ecN8poL2w1iul3wx6
	MIXvIoqYbtPFgwbKbK76Bxe/qtQMlJWDAgPitGY=
X-Google-Smtp-Source: AK7set8OsdKsMvx4/5Vm09xcezfqmGqG23agyUlFZ2lw/qApUS01JYd9JOCaru9jPRRYi9Hz6UvgKrARORsltlr9FF4=
X-Received: by 2002:ac2:53ad:0:b0:4e8:3eda:4305 with SMTP id
 j13-20020ac253ad000000b004e83eda4305mr2320881lfh.11.1678906036889; Wed, 15
 Mar 2023 11:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com>
 <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
 <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com> <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
In-Reply-To: <CA+cAkeoxvY6F+TySPXP1vDeUEiD14EZpxW06UM28DVd0G7KVjw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 15 Mar 2023 19:47:05 +0100
Message-ID: <CANNYZj9msRQ5MnC9wHtD0w9zscDXeq2+dxt8fwzZzNnAcPquWg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 18:47:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14574

On Wed, 15 Mar 2023 at 19:26, Fr=C3=A9d=C3=A9ric Martinsons
<frederic.martinsons@gmail.com> wrote:
> But I still need some answers to go further:
>     - Should checksum verification for crate fetcher be mandatory ?

Yes.

>     - What about librsvg ? It doesn't include any crate:// but needs to i=
nherit cargo_common, what should I do for this recipe ?

I think this was mentioned by mistake. You might want to check if
meta-oe recipes would need fixing though.

Alex

