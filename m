Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D1C83F1B
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 08:16:34 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web10.17143.1752653787649263206
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 01:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YMX44HNv;
 spf=pass (domain: gmail.com, ip: 209.85.167.54, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5562838ce68so5661802e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752653785; x=1753258585; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjNi1XjvpEKEDmwEdYap6kok/m8ayZ85XQWqCWIx4uE=;
        b=YMX44HNvQibxA+QsqFXppSOSPZ7lnzykz8TCcGREEN/ekG33JvgIXT2WuT5ytBloia
         ihEr4vsxwQFkVczBI53+zFrCzp7Q9KauzQUg9m+s2+tQVmlj1z74XKtqs1XzhPSL/D5W
         EvhhI1gOMAZvAsh7PWsFQVmPFnalna02iLnbAbqwX2Utpkc0unKiJLDwEyKn1VHFI1QC
         H+u3itGeZSMeeFekuLV/Ojsk5kRq/+AWM/x/mcZB/Z3C7oCrje5BKbijVNedN6qEhir7
         0PGVm8q5k8giihx4l6Eaq0Bi39zvmp3Nlt2fKVBbzgKHqn1mVIc/1Jx3LtgMk6NDHYD3
         OdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653785; x=1753258585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjNi1XjvpEKEDmwEdYap6kok/m8ayZ85XQWqCWIx4uE=;
        b=wFxnlVaMSSrQxwVcmEY6IIzapv8NzMUZrkvN2WABinSBomP8SdpBdn7WZH5L0Gw6G3
         zR5RzpMexak6GC1EzxvwmO0cdwMcQF8n11m66KSt8MualpYvQ9+Z35IBp/lGDiAq6c8L
         wT/+fmHQhEM8oOL/9guNqhI6sR9CrQ4GD4iaVuj3/ldXnJ2NKpM4vluAJxx4xYjdr59m
         WHXu2CBXnZMh187iQMMjo+aoLPgEHZW1i6LfUzv+mt1tIxhNxaWE7J+1epss5kNond/7
         TvAKO79eIREJ1Ea96dN3iTgE+igARUv7PbwhxZ06rKvzBa4MdEYncCCHyPdzrE53IjaM
         McEg==
X-Gm-Message-State: AOJu0Ywj7GqpdRqcZR8xRZX6CEY2g1Iu4t2BSazVkQesy1uf5/HTf5xj
	wVIinY5m4GxLqVZZ5Md1L7+LCGKI/vr6/yGO8lxmSef5HqOiDBLXZYU79t82iko/+5gqvAh0cPw
	NE93r9ZA91qviCleZX7oXERV+xmRdh/c=
X-Gm-Gg: ASbGncvyNYpLZFbWaAL1O7pcuDMuqojygFmJ8PqCHRXfaoFxEzzURU5VskDoUsNlWBa
	UgW8R0M2Gl+QqCaWybM7IqGTUmphmbbl81pE6OKJgHvp2rjAWORGJ0sIxyDQDvaz5pX4IUZaLiv
	57xVc/wQyMBNJv+SO2dhiqdWhoiCS5I0DqRvISj2vSF7Fz2qtYREIuTxBp8MOdsZy/gAjE3eYld
	vQPaVpWqg==
X-Google-Smtp-Source: AGHT+IH06R4JarAe1Yo6K/QPpVod9F76BZjEbTLBnzFc1Z6Gqqd7RW0OTYfwdonSkcJWlcOSNUYcZSwMhGmfjAMRJtA=
X-Received: by 2002:a05:6512:4de:b0:554:f9c5:6b30 with SMTP id
 2adb3069b0e04-55a23f592eamr501221e87.38.1752653785331; Wed, 16 Jul 2025
 01:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250708124711.3541367-1-martin.jansa@gmail.com> <CANNYZj8zpTF-hs2inMOcJ0mJnYKCijgD0VopeP4-_F0NM6rG1g@mail.gmail.com>
In-Reply-To: <CANNYZj8zpTF-hs2inMOcJ0mJnYKCijgD0VopeP4-_F0NM6rG1g@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 16 Jul 2025 10:16:13 +0200
X-Gm-Features: Ac12FXziyHAffV8FmhmrYl3_sqKWHUjtD6k0FdmyfAokatQItMlvZbvqC-KkhPM
Message-ID: <CA+chaQfrXL8dcSMvprRGUC-X5BGsTBCQyoYQKdoD1q0-K5EGVw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: zstd: use --force to allow
 decompressing symlinks
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:16:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17775

On Tue, Jul 8, 2025 at 4:45=E2=80=AFPM Alexander Kanavin <alex.kanavin@gmai=
l.com> wrote:
>
> On Tue, 8 Jul 2025 at 14:47, Martin Jansa via lists.openembedded.org
> <martin.jansa=3Dgmail.com@lists.openembedded.org> wrote:
> > -                cmd =3D 'zstd --decompress --stdout %s | %s -f -' % (f=
ile, tar_cmd)
> > +                cmd =3D 'zstd --force --decompress --stdout %s | %s -f=
 -' % (file, tar_cmd)
> >              elif file.endswith('.zst'):
> > -                cmd =3D 'zstd --decompress --stdout %s > %s' % (file, =
efile)
> > +                cmd =3D 'zstd --force --decompress --stdout %s > %s' %=
 (file, efile)
>
>
>        =E2=80=A2   -f, --force: disable input and output checks. Allows
> overwriting existing files, input from console, output to stdout,
> operating on links, block devices, etc. During decompression and when
> the output
>            destination is stdout, pass-through unrecognized formats as-is=
.
>
> I'm not sure using this --force option to fix this one particular
> issue is right. It will mask other problems that should stop the build
> at the decompression point.

So we're not going to fix the known issue, because there could be
unknown potential issues?

If zstd decompresses garbage, then tar will fail like it does now when
zstd decompresses the symlinked archive to:
"Warning : /OE/downloads/some-ver.tar.zst is a symbolic link, ignoring"
message which tar doesn't recognize.

and the symlink is created by the default bitbake fetcher behavior
when MIRROR is over file:// (e.g. nfs mount).

Luckily only a few recipes are using .zst (my DL_DIR only has one
after building world with many layers).

