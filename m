Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B959CC6FD19
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 10:42:26 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.9186.1678963338726275010
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 03:42:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=oMI1GMPF;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id bi9so1679648lfb.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678963337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt7UC941A9DalhaSzzTvd15LBwCHC8LegHSjFN0EOKM=;
        b=oMI1GMPFUjLSS83Xvv3AX5X6ILq2q9EAe6dJrj7KBiMKgP8D2l/cmT2j/ZntqDXvVC
         spXrpONF5cm2ac79Ku+kXdaNxV+0l3FEpCa5UetFmPkzwLrZYLN9Q5z1Fgqv/JVf7Unv
         oBtUWurPcN9RU1YBvct+4Fa93ErSrpZQGQg3Y6XbuEk296imri+d0USWdLiKEt6I56OM
         LTx3EQ6uXrq28TY6zqMa+E1PTJGOGA1chsaAYIUevKa/hBZb46i/UpHr6Zqp6IhlsUHa
         +p5Z6K1r+tiZn4YREUHTXn/HcqJyu3l81vbtrWq8deZDjdGnPNFFlezihtI0MYUIxrG/
         k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dt7UC941A9DalhaSzzTvd15LBwCHC8LegHSjFN0EOKM=;
        b=Ll7YJeaPP/lV7HYAQzyue+Bv0bLA/JHHHElkAAphlbRmfizF6NWudBn2InyIB94djz
         Vtikc0QTTEseo6k6/XpZrx6b1cUMoDYfhanDYz+ho4QPYcBh6idbqJpcvstHCIfECRnT
         Gov93O579cH2EedeK2PjPC7urwqAuIXl1vzutQUtIED8IzJ8BmcygQ/qVIrCQ/BsIylV
         khTeP+2LQH5WGBcz0GjkSgEEC8eK6wXTHkzjt9v/QgUSgAqT8255qzAuqmaoDEfDPxuE
         a2RGPg2tv/+NFrnbrToZXVIzKdq3uWpxi/2/l8hPTVj8TmufT41ruIak4gYS26RxpyoW
         VI5w==
X-Gm-Message-State: AO0yUKVO2OXu3MYryenbIguhnPtNcV/yFHUtlQVMzrURsj/nU0RalTHT
	biXHy+vvFbPI5uV0hQHrmiiJrYiSIp9VHA5hS0I=
X-Google-Smtp-Source: AK7set8rHzWM5A+TNRVvkUQ3CH8b8MUKSUFnfEQRt9YtrEPQT0odESdF30qb0knEar77Xhrp0m5fuLcW8Vdu0X8PhCk=
X-Received: by 2002:a05:6512:486:b0:4e9:5b3a:e8a2 with SMTP id
 v6-20020a056512048600b004e95b3ae8a2mr495907lfq.11.1678963336825; Thu, 16 Mar
 2023 03:42:16 -0700 (PDT)
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
 <CANNYZj_2S+=MyyLtJC2Z8vV1TnEgY9gmX_uT_KC0hagpMi48Qg@mail.gmail.com> <CA+cAkeo99FtejmqyBYShTPRfRuS3nnA=wUWVSHHt+nkx8dzz7w@mail.gmail.com>
In-Reply-To: <CA+cAkeo99FtejmqyBYShTPRfRuS3nnA=wUWVSHHt+nkx8dzz7w@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 16 Mar 2023 11:42:05 +0100
Message-ID: <CANNYZj8gxTwCXE=6PT4uU0fEKwMTq3s2YV0DNo=qbhgWdgOi4Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Alex Kiernan <alex.kiernan@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 10:42:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14581

On Thu, 16 Mar 2023 at 11:07, Fr=C3=A9d=C3=A9ric Martinsons
<frederic.martinsons@gmail.com> wrote:
> I managed easily to update uutils-coreutils (I removed its README.txt by =
the way) but
> I cannot do it for python3-pyruvate because I cannot find a Cargo.lock fi=
le, the git
> repository had once though (see the tag under gitlab) so it seems that it=
 is related
> to the fetch by pypi which doesn't embed the Cargo.lock (or a bug in the =
packaging
> of the project). I don't know what to do with this one.

It does seem like a bug, how can it build without Cargo.lock?
You can inject the Cargo.lock from the git repo into the tree, and
generate checksums with that.

Alex

