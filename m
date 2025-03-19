Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15435C35FFC
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 15:07:22 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web10.10458.1742396837062890708
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Mar 2025 08:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=kIRAkPQJ;
 spf=softfail (domain: sakoman.com, ip: 209.85.219.169, mailfrom: steve@sakoman.com)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso5309880276.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 08:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1742396836; x=1743001636; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2cpEKYdZ5BEFsJEqY9MfxdqYuUFfYu+nDDNuXT0FLg=;
        b=kIRAkPQJavVVYXEC9FZlVviWyeJF9qHBc85oNmqpZlXwkmu1M3nIJUWq5e70FMXWYz
         x4d8gXPetZ5xT8bQfzLHRGRsBhQ1sFSQRmm4ti7IJWvYI99KhecdLv5zPGFrGdYj5sOW
         py0PmDYGmWMIxnSpt23VO37ggj+hq67zaKbct2gSIOvEX1HmLs+5slYyYMgcxDdU3ppV
         fkji2fo18/7473S5ji4rzYX5pBWK5RFfQ/PqDJFAMQMv49DmPSV5ZUmbrDOUtN0NRffP
         JrbjwtvZW51GfkLWgMRMg4eI8eRWJaY+2GqdxI2S1R4Dbx3uPx+16A56VxvbPcNynmmh
         gg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396836; x=1743001636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2cpEKYdZ5BEFsJEqY9MfxdqYuUFfYu+nDDNuXT0FLg=;
        b=h9z8u0OjSDBk5nivDkGKpHFe0HWXPeOisHjLxBW6hAyLHO8s6zJm6bV7PTCbb0OYjC
         9hRcwQYoueZU7OG97ZEGsMejV3HpqV/TAQ4016aHDVnsn03O+DBya1O1n4rD+FPyPwXO
         MULW+15588OxHw6t2KoanjyWx2WDjgvJFEz9/0TFApQGIMdB33lB/Q8hbNQK8SNsnLT+
         GimeGtldQXRON6cnElWub+m1ehWiQyRcWpvyBXymCd1LUpEqRRjAf3+7JXH6h+OVCFXC
         vpxWohIyPMQfAtWt53SIpTXQXEPxK+PaQasy4BmYnl1BZeMsyHP6koSxvxPaok5mgmKT
         0+KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSIaZlz0TI1I09BfuqAReGkY8YmGWvd9RApBfuzQ5DiLTIwc2q5a54uGd9YUeURt6lPoDKhuh+g6Y8hc0l@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy33nCkslE/e9Z5tqEO4eHJ4Z2+uqBFpRU++RtqATPDKyv3TXOl
	pClGYreDuB+ynZgU3xBpFWNet9klYGJaF8f1CPotuVF8bq+K/A/cDSfSQaspuN4zM7QiyuKglRE
	9XxEVT0J4lBZikOLcrkESFIIksEqxdDsLVSC9qQ==
X-Gm-Gg: ASbGncv0IL806mp699zsT5FhYYc1iVhx0jXTb/7Nlzi+KKH2U7ejV8whh0/MllImTDO
	3xPwCyLbR1XfuVHlmrUplhG8treQDfJqzV7jW0A9xPUsOAmKVD0ENWNR0vkB0rrQB0jCykgJt01
	ZZY17vz8NlqKWtB9o8WnXuWlOem5q74QfNJ2KQ6BigzhbZuWxqUXfebIQQSg==
X-Google-Smtp-Source: AGHT+IFh/NvjMI2tZZanyByATjrnqBxx3/cqcFelkwIoFDtTvs/X/WlHeNiYv1KFumuN2LrT3CtzrDQ5ZT6TpgY11Rw=
X-Received: by 2002:a05:6902:2612:b0:e63:c5fd:17ac with SMTP id
 3f1490d57ef6-e667b3fd194mr3654218276.29.1742396836072; Wed, 19 Mar 2025
 08:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1741808747.git.steve@sakoman.com> <da5f41996687e18b78d9c9845e621d832115aa1e.1741808747.git.steve@sakoman.com>
 <CAD=4a=Umi_YD9i=FB+412DQJLLi4b_AdDn0MeTWiBMMmZ+WE3w@mail.gmail.com>
 <CAOSpxdaupXeT4cg9jMOfzB2fE+Lmt6e679-igdqKc42qw-PfQQ@mail.gmail.com> <d47238f4771f505dcb0816e03ab731f7c5ff1c2e.camel@linuxfoundation.org>
In-Reply-To: <d47238f4771f505dcb0816e03ab731f7c5ff1c2e.camel@linuxfoundation.org>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 19 Mar 2025 08:07:04 -0700
X-Gm-Features: AQ5f1JpuMvo2J-RInlHX5ozWlmT0XusKgMlt1LrjR16D_FCIJw8NJDzV9z5d620
Message-ID: <CAOSpxdbvyXcgz4ZmLYEtwhmGr6wjHGG_EoW0WBtmErpfJTgv-g@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][kirkstone][2.0][PATCH 1/1] siggen.py:
 Improve taskhash reproducibility
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Ernst Persson <ernstp@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Mar 2025 15:07:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17470

On Wed, Mar 19, 2025 at 8:03=E2=80=AFAM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2025-03-19 at 06:43 -0700, Steve Sakoman wrote:
> > On Wed, Mar 19, 2025 at 1:05=E2=80=AFAM Ernst Persson <ernstp@gmail.com=
>
> > wrote:
> > >
> > > I tried building in an old kirkstone workspace with this patch
> > > applied and I got a lot of taskhash mismatch errors.
> > > After deleting tmp and cache the build was fine, though it did
> > > rebuild everything from scratch.
> > > Does this need bumping of something like HASHEQUIV_HASH_VERSION or
> > > SSTATE_VERSION... ?
> >
> > I didn't see any taskhash mismatch errors in any of my testing, so
> > I'm
> > not sure what happened in your build!
> >
> > I don't think bumps to HASHEQUIV_HASH_VERSION or SSTATE_VERSION are
> > required, but perhaps Richard can confirm.
>
> I think it probably needs a cache version bump, something like:
>
> https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/cache.py?id=3Dfce=
d0b8d7c852e52606fa8da321211a98a1dfaea
>
> which would then trigger a reparse. Things should be ok after the
> reparse.

Ok, thanks!  I'll send a patch.

Steve

