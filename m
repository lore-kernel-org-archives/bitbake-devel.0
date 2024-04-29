Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516E1C4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 21:03:21 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web11.33463.1714424598902689064
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 14:03:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KchUCqZv;
 spf=pass (domain: gmail.com, ip: 209.85.208.178, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e01d666c88so19829481fa.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714424597; x=1715029397; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbTtGD4h+6WLUaqcBBtgq+Yduk9Z879oCBT0u99C/AI=;
        b=KchUCqZv0vc4cE4ofol5g6iFM46nU2BtHPnlq4GRJvtbqr9TyP71AbSFSxQouOk7aV
         6CnilRhI8itHvy5Is52oACyQ73aCqAJ/O6QUFCBqENGXMdnjGXJeZlW1ybrrKQP4NDJf
         AGwtx8jCgS/ANiKgE53u6v9kn8+7amyUnZTj71C7rmZRJ62XZCFzRgJJRrkMntqPO81T
         BzjTBdxf43GeGijdb6kgpzaFUfaElP4bEh8JS+P3o3nxGrykrT/VAPB3k7sG7TCocnfx
         LeUGOudnzhVOKBLuM8NAJz8NLYnqZh4dIXGi6dYosi2XdkUXxZhFYwbAjxMe6lO5va10
         0gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424597; x=1715029397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbTtGD4h+6WLUaqcBBtgq+Yduk9Z879oCBT0u99C/AI=;
        b=ncN8ydjFHQbB8MNaKWNzGGhisGu77fHg3YpG0ntNHjMxzqtYOMKSoDwP8aCDDMekel
         y57SUF7MbrX2cgUztlZVjqudUrHByJ9rUlP3WIapTGpbZOvBGAKt/yG3fr9lwk1M3Kl0
         UCW2+GUOtkErPnqF/c5+suCrwT7Zxytq5FWnuJwskH2UQVV5k8rNQqUEpCu+tT85gsLV
         NcVSEJl4aIhRJ1Qoolhi4valxCoezicAecrEbi8/DLuwnO6Xi18vc/61LMcoiByByG4y
         WIiYLuXWMVrS0HLh/vFpqD5BrVcQeU/RYwKBYNpcms1YTC33JZgHflHc3HRYkWaju/MK
         9oNg==
X-Gm-Message-State: AOJu0YzMNK3jtY6QNFEu1hhjKupjVqXFRbaD0cOb9Y2ZXPv7mLL5qB0X
	rj4AuOfuIeLZxlqD1WkeAIoaPPv+GPnIKSFY4L/YR5SJwAFHZ16O0dcrZSxAqVVONmyFldAnezy
	xIwbVzP4ei9dfdvqWwZpsFElDlxk=
X-Google-Smtp-Source: AGHT+IEd8asT/Sd3Sjw/50v30C+HpthkEAJ7XhuFlXjHGV3ebZrkKuTpzHvbS7w7ZNR4z5W0fswLTwHdY8JX+t8iP20=
X-Received: by 2002:a2e:a4cf:0:b0:2d8:3646:551b with SMTP id
 p15-20020a2ea4cf000000b002d83646551bmr452154ljm.50.1714424596850; Mon, 29 Apr
 2024 14:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240423182543.226113-1-JPEWhacker@gmail.com> <20240423182729.226345-1-JPEWhacker@gmail.com>
 <17C929449F85DB18.1247@lists.openembedded.org> <5361dfb8-3d88-4099-a81c-67e7c64525f1@bootlin.com>
 <CAJdd5GbB5xFBq6sC7kEP0YferegyXQYai9Mo-1jAkxe9wxSG7A@mail.gmail.com>
 <95b0d470-02b7-437d-b9bf-210d3b988f94@bootlin.com> <CAJdd5GZRt8NXpVhh14-Fnpp4ixfj0XcEZUFjoeg0nqheOpkGYg@mail.gmail.com>
 <6e4bf9bc-c5f9-4d85-9100-3cd1c4f000c2@bootlin.com>
In-Reply-To: <6e4bf9bc-c5f9-4d85-9100-3cd1c4f000c2@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 29 Apr 2024 15:03:04 -0600
Message-ID: <CAJdd5GaEuVw+p=aw5D5cw6i1jAwS+eDDRqSF-s_5p4324GEWKA@mail.gmail.com>
Subject: Re: [bitbake-devel][RFC v2] prserv: Enable database sharing
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 21:03:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16157

On Mon, Apr 29, 2024 at 2:27=E2=80=AFPM Michael Opdenacker
<michael.opdenacker@bootlin.com> wrote:
>
> Hi Joshua,
>
> On 4/26/24 at 19:55, Joshua Watt wrote:
> > It has commit() calls also, look in sqlite.py. I frequently forget
> > that the cursor doesn't implicitly commit when closed (unlike SQL
> > Alchemy, which _does_ do that) :)
>
> Correct, I must have checked the wrong file.
>
> Actually, my code should have all the commit() calls it needs. I put one
> every time a change is made to the database.
>
> However, I still have this very weird issue:
>
>   * NOK: in bitbake-selftests, the tests that use the PR server run
>     successfully (except test_3b_readonly, because of the issue), but
>     the PR table is empty in the database file (if opened through the
>     sqlite3 command line). It seems that the table is only updated in
>     memory. It must be so, otherwise the tests wouldn't pass.
>   * OK: the only bitbake-selftests that use the DB functions directly
>     don't have this issue
>   * OK: creating an image with BitBake does create a non empty table in
>     the PR database file (cache/prserv.sqlite3)
>
> Would anyone have any clue why?

I think it might actually be returning the correct value ("0").
Remember that each test case starts with a blank database, and I don't
see any code in that populates anything into the database in that
test.... so "0" seems like it would be the correct PR value?

>
> I've just submitted the latest version of my code if you want to have a
> look or test by yourself:
> https://lore.kernel.org/bitbake-devel/20240429201418.657042-1-michael.opd=
enacker@bootlin.com/T/#t
>
> You can run the bitbake selftests as follows:
> bitbake-selftest prserv.tests
>
> Thanks in advance
> Cheers
> Michael.
>
> --
> Michael Opdenacker, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

