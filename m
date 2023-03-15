Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC94BC6FD1D
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 18:09:15 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web11.627.1678903750675984992
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 11:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ivZur9St;
 spf=pass (domain: gmail.com, ip: 209.85.208.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f172.google.com with SMTP id g18so20387082ljl.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678903749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdvv3DGNjZWDJ/i2niS/62XlI0N6WL0miQv3fEaCO1s=;
        b=ivZur9Stc0RGeFLTEQhP18EGAClsUw5X+7pxkEkjQQfso0WJYzi651r6HplVLsCdHL
         6K3qqNSLNi2pZoNwFG8G1AKsFwSdTQKu/HWAbOn8j7qgXkGlAvNAM+98oYdcQ/jfxJtW
         GHCpbWCdcv3cOAhQKQM5jp6E8q7roCz92KHlcVFIIP7iw456pVeq+MXkcB0pvLentjGZ
         n34L63ZcBSbzZR2DmG9uKMxyzSx4dggISMmA2sGmqG14MmU7KMf8gWajDkeJnrLyvclX
         pZQ5jzjCyL/nV5VNnqtVy2hDFz3snDOj9ocYBYHWOrqUJthn5w6kkFP3zeMpd8QzfHg9
         oFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdvv3DGNjZWDJ/i2niS/62XlI0N6WL0miQv3fEaCO1s=;
        b=YgLTU6+3WOYl1cAjF0FJludkap9+C9aGwLAnrVd3z5Z1YZCH+MWgrYqsxC7F4Ta0qv
         F3LkS42SvsutTBnQdKYttDzt/+Wf+BL4HyAac0a09qdjueRu/7LnM5ojNkFjD9tV3BjM
         GNRKlYBwoQU0vLXyMBgWBOSBFoYS2wnBN82X9be5QlUvHSV48sw+IO5Xm38Oq0pihP35
         6Xe8vwvq4C/9iklmnKaOgfPvYVQ/0Ydt1jNw4XFZqCZfqbbs1MueDPjDfAiVHbACKRIx
         T4ryXZ4k8boRGEg8WyKV9jVi2VhDqZnlJWbMiuC6Yzn6thix3CCRcrFGCCJyIdT0RqG0
         Bs/w==
X-Gm-Message-State: AO0yUKXWBlTcmDMgP5ye6sB9hvngdB7PHRGlTYAML9HeCM2y9pKzQubU
	51KRPm+Ehr5sJyS7+chgtVcWLQzOjqZDZWvsK3s=
X-Google-Smtp-Source: AK7set/obkHse4YBQ91/7KEHjegkOgrhJ3Q1bB5ysdDWiW9eGvU3qRv0/HvxXGrcqKHFf2VIhbGNaOD28nxn88rKDcQ=
X-Received: by 2002:a2e:9113:0:b0:298:b3c7:293d with SMTP id
 m19-20020a2e9113000000b00298b3c7293dmr423492ljg.7.1678903748850; Wed, 15 Mar
 2023 11:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com>
 <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
 <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
 <CA+chaQeZTRjUG4Dy+A89iZfG68DkQi3MT4kr3h=JH6K=iPMZmw@mail.gmail.com>
 <CAO5Uq5RK8o_he_741feA-NQT01-tgGnXhi8pgwYqFPpHqA+-UQ@mail.gmail.com> <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
In-Reply-To: <CA+cAkepJt0FbV1Oq6ErCOA1qsa5DCmk=z9dACo+FrpCrj0vXvQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 15 Mar 2023 19:08:57 +0100
Message-ID: <CANNYZj9EWbPrg0ThbT=oM3RcN_UmC3y8yz-=OODOnMLKcMoq_w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 18:09:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14571

On Wed, 15 Mar 2023 at 18:54, Fr=C3=A9d=C3=A9ric Martinsons
<frederic.martinsons@gmail.com> wrote:
> Alex, when you talk about updating librsvg and cargo crate updater, do yo=
u mind elaborate?

classes-recipe/cargo-update-recipe-crates.bbclass should be updated to
write out not just the crate list into SRC_URI, but also their
checksums (this is not hard because it works from Cargo.lock, and that
already provides the checksums).

Then the class should be used to update all recipes (e.g.
python3-bcrypt, python3-cryptography) that use the crate:// fetcher.

Alex

