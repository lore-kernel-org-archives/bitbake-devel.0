Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9346C83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 08:48:24 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web10.17653.1752655700184304762
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 01:48:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TNjS57AJ;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-553b3316160so6763550e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 01:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752655698; x=1753260498; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX3qUuWxRZxLYmMf1l+f6taAAhos8XVGc3Xdc4/tEy0=;
        b=TNjS57AJR5YpgM/ZR9y3U4culX5fCmBnyTo4Mw7klQQL7u4bF7TYERXUZoVPtLtsgD
         4x7HK+CjXs1WMVqz0v7wTFRWMhhND2ZV+Ict4OwH26zPn4o/ESTA9KQsj+SP3sfqQJ9H
         KtJvvJhfQ36/yS7jkVBrW8jUw3uF5RTC3CbrgWP9rP5FIEfuuvAh+VSwjvOlEICBWp3r
         Bd9hB/SAvFlzudheZWkDy9rx/tY/bJtVUXA1i00WBLAGeaB5FZjI1cup+RBEAhB+8jT5
         a7IlnPo3BuVi1aWijLR7VKWaB4Q9QjCLDwkbatMDg5Y+n5LZ9JCxJy4ueBjjxh9JfQak
         h6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655698; x=1753260498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX3qUuWxRZxLYmMf1l+f6taAAhos8XVGc3Xdc4/tEy0=;
        b=VMqhLVu/K8wF5QFK87yIk8au30kP2ngsP7RiIlmPrB7pUubSotCUF5YNfKbCiAmLwr
         9PHzdQ4po9ksZa5q6T7KoECmYwI/R7CYww6OzMkrA7j7J6bYYOcWvTcekSTTv6Fee3fP
         dq+zCiKL0RzU0czudsn0pjSWU2uTF5e8vNqDBXCAgqQGOh8y/sDmXYE1TJziaqv7gUsH
         Jts7XeQf03DVnjS79vCOL41cMdKwECPJurvqzpWwTebnCLAHCQrsLw4GK9Ulv6vPKAno
         NZMvYZA8I9ckvAn2DLH/N3yvr3LmjdjvnYr7EXZs1ZLNHUQD3b3Ma21C2DOvKm2Z/MsG
         mMBg==
X-Gm-Message-State: AOJu0YyS5GQSuV+InM7/FaNLBgm6wiuQgZAbIKZA4j6BFhe9l/guiQyI
	dVJYKYorhz91WIioZWD/yNMbQwQiRmX3QGBhHCfbm1AAyDsHw7op/aDL93pylGkFJS0P9267CXz
	6IHDTHRrxZjqA2pn9FKop24OdQgMLNGk=
X-Gm-Gg: ASbGncvcB9Fg5NT+AkrnoLQCE2lGIDUEB/6FM8mY3OeBCxYNV3fVqp4p5QehG1Un5V4
	TSgV5MtMpVLHw8FxGv5M9FXeDGpZe8fnqkuC9GiQJyW7C0dH4lCpskB7x7ue9jX3RN8V7clQ7qE
	+7k648DJkyoqf7y7AsNq5l6hpX6ATKqMVQcL9nvzBaydiHm3sAn8GCVs2SGpHJ+OR+K2Nvw1dFJ
	fmNd+43WA==
X-Google-Smtp-Source: AGHT+IGfgjj0ltaRAZDEBnmj99F94YwDmY3wa0l4HcQbdCVnEpH90trDEgCVXw8dOP5SYK3bQmRYro9gul+FU9uH0/k=
X-Received: by 2002:a05:6512:3406:b0:553:241d:4e7d with SMTP id
 2adb3069b0e04-55a23f6dd82mr522319e87.42.1752655697594; Wed, 16 Jul 2025
 01:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250708124711.3541367-1-martin.jansa@gmail.com>
 <CANNYZj8zpTF-hs2inMOcJ0mJnYKCijgD0VopeP4-_F0NM6rG1g@mail.gmail.com>
 <CA+chaQfrXL8dcSMvprRGUC-X5BGsTBCQyoYQKdoD1q0-K5EGVw@mail.gmail.com> <CANNYZj82mZdmfi839jKZdd3dibPGvdEao0wj0BoYQ4HHYWaVoA@mail.gmail.com>
In-Reply-To: <CANNYZj82mZdmfi839jKZdd3dibPGvdEao0wj0BoYQ4HHYWaVoA@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 16 Jul 2025 10:48:04 +0200
X-Gm-Features: Ac12FXxKXLFtku394m5LEN7ZDUeda_SVohKrImw0pK4_2pPH16POTN7OdeHjUrs
Message-ID: <CA+chaQfyXsd54aMWU7udvdBC9-EmMr+nXuriCCkQK4rj-tW5Yg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: zstd: use --force to allow
 decompressing symlinks
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:48:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17778

On Wed, Jul 16, 2025 at 10:37=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Wed, 16 Jul 2025 at 10:16, Martin Jansa <martin.jansa@gmail.com> wrote=
:
> > So we're not going to fix the known issue, because there could be
> > unknown potential issues?
>
> That's not what I said. I said we should seek a better solution than this=
.
>
> A patch to add --follow-symlinks, submitted upstream to zstd, would be
> much better received. Or some way to avoid having symlinks in the
> first place.

--force works perfectly fine and I'm not too afraid of "overwriting
existing files (as we're using --stdout anyway), input from console
(as bitbake -s passing a file from SRC_URI), output to stdout (that's
what we need), operating on links (that's what we need), block devices
(if there is a recipe with block device ending with .zst in SRC_URI?),
etc."

I'm not going to spend my time adding --follow-symlinks in zstd-native
unless you've an example where --force might make it worse than it
currently is, because I won't be able to persuade upstream to accept
that patch when I don't agree it's needed.

Cheers,

