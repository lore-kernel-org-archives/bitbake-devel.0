Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F0AC83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 14:45:34 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web10.20653.1751985930576005557
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 07:45:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nh7vBrFa;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so45831006d6.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751985929; x=1752590729; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XJ/FZzi0Uek+FXnmQ1TH56v4YjHEIIWhfbszMTghZg=;
        b=nh7vBrFam1WKvYqbZBBds+uCfQFaiDbZy/73x+wQMU66k2bVXYKPlZqX2na7jV/Aav
         IpyPTVFhDFFxJnWen32E0zpbT/CarXYfI5Yx4I4AlPfOFAvPUc/etwGwzFDZoxINytP+
         dbX8LhuNs0lkDCA76JOPqr0/D/8elWd8esTe5MtU4RQu0APRaArKGXnefevkFcqhjUGm
         gYWlZ7PbzCQefKO3GjOScDfzmnNMkYpl3M4EXiRgnloRD+6+m+jMmMMP/jB94ZVimzzU
         qaUu7iDVVoibMzw5MTjBQWxOkogEAQiY3ORq98x7+TuA2ZqGbvl3ULvVa6fly0XDrFrk
         Zvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751985929; x=1752590729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XJ/FZzi0Uek+FXnmQ1TH56v4YjHEIIWhfbszMTghZg=;
        b=qs8/hUI3+ycWBXNDImcIoov37Ypl8J7QWcD1oBn0RurJq0aZUqwQEzB8ef1Pbn5z73
         PC6sIUvz2Hn7V9Bv6vFm8y6um4ZYGu7kkqC799LysYdeWbK4oixVMF1Vkr4k28FSXJUi
         pjOa2zNP95GVGSDIs4DRQePiREpH0RoiL5MNL/iulNQrqXePCXpHVShP8VC5QRgvk6B/
         EckBQz/YaumDm6QRlplQQtGFrgG7nv83Ol/uc6m9MdmlJVkkAvdQ0OSb0n2dlEk3mfp2
         aurcyrwhMDk2ddwq/pGqOEQ5OuQqt6QDxe+mE5z0qw8IIJ6OZoG2iDzWipPm8dfQEgZ0
         XRsA==
X-Gm-Message-State: AOJu0YzJU91KFE7EIj6jq1kfhMVcYR+9OnBO5fzF/zp5wUVUb7C7zIsf
	/51qSWmUqzZgIANFavVSPjb2gXQtFmZ9jv9+xypq8g3TAtinQ0Yq2BHwWJGP75H/uA8GWvPx+79
	/YeCRlXOSATv1t0rwhEp6wX0iYye9WuA=
X-Gm-Gg: ASbGncu+v8Xk5ltPxfmD8ko7DDDr3uDTluATHyvvppwhBVWlymQ+Wn81wpLVWgz6VKU
	6vZadbI+SBgo6I0fZQe4BBkXjIaJVoqm6kQg59455L4CzN8B1sQ+tscZyB9GJ1qODrB5KM8cxCR
	FAqStoQwrgGMzV6d10ZBkUcEIyyeO5aXEArdcqusTYzFM5
X-Google-Smtp-Source: AGHT+IGaa8T8/LamftcvIXMs7ieiux12Eyu+jrRjNrI5K+2hbTzV9p8jAUbtr6WRhBXCweZ/e4Jsxo3zmSh1SkV9UXg=
X-Received: by 2002:a05:6214:2467:b0:6fa:bb26:1459 with SMTP id
 6a1803df08f44-702c6d0e4fbmr303784316d6.7.1751985929385; Tue, 08 Jul 2025
 07:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250708124711.3541367-1-martin.jansa@gmail.com>
In-Reply-To: <20250708124711.3541367-1-martin.jansa@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 8 Jul 2025 16:45:21 +0200
X-Gm-Features: Ac12FXxPT5PvBpA9MWKaVLcu1d0H3LI-Gy0h5uZZ6Z1nnKNR6Km-II0NLggzyi0
Message-ID: <CANNYZj8zpTF-hs2inMOcJ0mJnYKCijgD0VopeP4-_F0NM6rG1g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: zstd: use --force to allow
 decompressing symlinks
To: martin.jansa@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 14:45:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17761

On Tue, 8 Jul 2025 at 14:47, Martin Jansa via lists.openembedded.org
<martin.jansa=3Dgmail.com@lists.openembedded.org> wrote:
> -                cmd =3D 'zstd --decompress --stdout %s | %s -f -' % (fil=
e, tar_cmd)
> +                cmd =3D 'zstd --force --decompress --stdout %s | %s -f -=
' % (file, tar_cmd)
>              elif file.endswith('.zst'):
> -                cmd =3D 'zstd --decompress --stdout %s > %s' % (file, ef=
ile)
> +                cmd =3D 'zstd --force --decompress --stdout %s > %s' % (=
file, efile)


       =E2=80=A2   -f, --force: disable input and output checks. Allows
overwriting existing files, input from console, output to stdout,
operating on links, block devices, etc. During decompression and when
the output
           destination is stdout, pass-through unrecognized formats as-is.

I'm not sure using this --force option to fix this one particular
issue is right. It will mask other problems that should stop the build
at the decompression point.

Alex

