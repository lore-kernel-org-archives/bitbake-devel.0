Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF6C6FD1F
	for <webhook@archiver.kernel.org>; Thu, 16 Mar 2023 12:24:47 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web11.10653.1678969486658602477
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Mar 2023 05:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ceTQTFyd;
 spf=pass (domain: gmail.com, ip: 209.85.166.51, mailfrom: alex.kiernan@gmail.com)
Received: by mail-io1-f51.google.com with SMTP id o14so692151ioa.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678969486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVmjmz9DiE9PQ1ClPnuzGhUYomUjx1Jyea+rC/EhkeU=;
        b=ceTQTFyd8Y8Z1SFv/le3hOIb44EkAJv4IRkYD3ujtHPdligLm92NtFTRRkB+nRthtq
         A7krq4zrPyzvgyqaR/nn3kKSXuxUdnoHxjilX9SkslchiHPLB+L9+sisZUX8ttLnwAVy
         hNMhJXkVQP6l9X7qCCiXsdhOj8vG0qDJbdPig/HsAZKQXGcjfit/FDT8sgjso5xRML4U
         Q9o1LDO9BVVnXz8vzWSsq3tWRGrThS4b7KAWzSEUd9mCR66PvJtcRVSTeDA/jTvYLJDb
         +pK4a4nePZYkLr0KpYcZp8f+TcTSoFWTzxJ1OqwCK6+hvX7dxTm+uMpLLs8ByZGeJMbY
         GPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678969486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVmjmz9DiE9PQ1ClPnuzGhUYomUjx1Jyea+rC/EhkeU=;
        b=3oQhsUVQq9aRuVIGF4lfZHtilOYUAqf4V9X6KIeZnjGDwDy6lGpiNq++L+rotQ1F0S
         flLw7//3T5E7O/rydU5TeYQ6V/zFF2hs6AccpOH6czcWOjq/hIX3pS5RHH5dIPBBlYW2
         9aph81qNMKhod8vjZK+dZ5EsGeolWIeEm62RD5jqCEz30VreWvvXrcB1BgABmBg8JqlL
         tdw2ELCK0Rdgh4vxIThirwyqiu0TKs52KSgvXSQ1di/LJeH+N5IEEaz3TVPiIY65UspX
         qQOMeS+mDX2aiH1QBwbB7XFjGeBIv9oyo1ABbGsXtA6XWlCGAVGztNLHoiWTRelEzAPG
         Q7nA==
X-Gm-Message-State: AO0yUKV4+frlF/M9RrbermnMicBzbyB/ZRr2Yb6B9cVCiUnAJ+xXMn4e
	2UcEuItyEl5Hgkvp4O0phoV3jpWAbtO/Z0GH/LU=
X-Google-Smtp-Source: AK7set+SOBT7PaKSE9jEn3X7AbCwSrAYGCOy/JGbi5o021eUkPXgHVJlJXYjlL7Njbxb1uqVmN26d+I2+o1inF6fJNU=
X-Received: by 2002:a05:6638:37a8:b0:3ec:46d4:e15 with SMTP id
 w40-20020a05663837a800b003ec46d40e15mr13410312jal.3.1678969485888; Thu, 16
 Mar 2023 05:24:45 -0700 (PDT)
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
 <CANNYZj8gxTwCXE=6PT4uU0fEKwMTq3s2YV0DNo=qbhgWdgOi4Q@mail.gmail.com> <CA+cAkeom=GRNhvTG+KyjD2ViMCZRHkWsUq19A+xnu+66C15YXg@mail.gmail.com>
In-Reply-To: <CA+cAkeom=GRNhvTG+KyjD2ViMCZRHkWsUq19A+xnu+66C15YXg@mail.gmail.com>
From: Alex Kiernan <alex.kiernan@gmail.com>
Date: Thu, 16 Mar 2023 12:24:32 +0000
Message-ID: <CAO5Uq5SKYKHAEp4Uspd2EiN-beK9Ow1B_BNfyHNXegHB2vzO4A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>, Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Mar 2023 12:24:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14587

On Thu, Mar 16, 2023 at 10:52=E2=80=AFAM Fr=C3=A9d=C3=A9ric Martinsons
<frederic.martinsons@gmail.com> wrote:
>
> A rust/cargo project can perfectly be built without Cargo.lock since carg=
o will generate
> it on the fly.
>

But what you build is undefined as you'll get the latest non-yanked
crate that satisfies the dependency solver.

> I'll provide the Cargo.lock from git along with the recipe then.
>
>
>
> On Thu, 16 Mar 2023 at 11:42, Alexander Kanavin <alex.kanavin@gmail.com> =
wrote:
>>
>> On Thu, 16 Mar 2023 at 11:07, Fr=C3=A9d=C3=A9ric Martinsons
>> <frederic.martinsons@gmail.com> wrote:
>> > I managed easily to update uutils-coreutils (I removed its README.txt =
by the way) but
>> > I cannot do it for python3-pyruvate because I cannot find a Cargo.lock=
 file, the git
>> > repository had once though (see the tag under gitlab) so it seems that=
 it is related
>> > to the fetch by pypi which doesn't embed the Cargo.lock (or a bug in t=
he packaging
>> > of the project). I don't know what to do with this one.
>>
>> It does seem like a bug, how can it build without Cargo.lock?
>> You can inject the Cargo.lock from the git repo into the tree, and
>> generate checksums with that.
>>
>> Alex



--=20
Alex Kiernan

