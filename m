Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE68CD4F21
	for <webhook@archiver.kernel.org>; Wed, 13 May 2026 21:14:02 +0000 (UTC)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7680.1778706836030074889
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 May 2026 14:13:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=OLex4uVj;
 spf=pass (domain: gmail.com, ip: 74.125.224.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65c477a3278so7762778d50.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 14:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778706835; cv=none;
        d=google.com; s=arc-20240605;
        b=B3u0W3siWPfkkE+1F3bL5rjeqhb9pkk+LwDBGjUvhRTCPrKbHrgiqvYod58LSpPnGZ
         2pHf9JtZftPnvo1SA6Abg2DidO7j4ULr7Lmd1T+E93eqBsDt7/aQQtsVbP9S23a44eVQ
         FPxhNxssKVHyLEiayTHNE7z0P/ZIJ8aHCT65/pX9yhrE7DPftmIUC0lKSn5fbzWnUI+R
         i8iY+GqvMn7jY3rz4haumNO6LC2bWI5njQoRrnm+MuzikOZw7TnJcAuvvnxAPc9dUBH+
         AqUm+Z8e8iCBHXRDfcwonh8DahHx9QgD8seeCL/o2GNBBsv0sPCTmoTHf8JpKwwXJdiY
         Od3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tWie8QDRamhbBEkzrUul5Y8Sg0pYdL4wa5Y3e5SaGsU=;
        fh=dGhMZmBQcdDlInfqMh/AGf4gkCSnr037ETBnNt2bW84=;
        b=K5K3/nfrmQ2k6Th5mL3I0p0frcWNV4QraD+LCtcdNaGnz9J+3ZS5YiHGGAXfkPkEAD
         8HMi6WsTwUtidxyjblEZkQ+JilOc3UeaAKotXHl3klIzq8Ux4zzWCB2Nwh/u3+vSr1/m
         QFK0uJwQeRjYNQTxFscOzuxM9pMXugcE73bJIaou/rznX6taxDCqR/c12+Ggx21snNcu
         hcWQHA1A+HqaQ8wNfJtCzHkREw6gVukL7J2ct3k8vwhzO2Nks37qOjRuUOhILKpk084A
         zGExDGpAMkrTW2Whh8eL6BZdaGoasWLAiutBts6/znH51cidM5KzroE9rr473aCCIMvk
         zh8g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706835; x=1779311635; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWie8QDRamhbBEkzrUul5Y8Sg0pYdL4wa5Y3e5SaGsU=;
        b=OLex4uVjV3hdJskJRXSsVCtnnD6pFKf7jKvfuLIm3cJbowK6RPto2dbm77RKoZySbL
         Rak7hisxtLrgStJSI6wSFnXFZFL7PPkDpZ+IFqey/DapYwkIc7eI4+1z5/K215l0jjkd
         Syl9JxtMl/FqCxRhVxdfyPjTcujyzsyLTpUsT6XL4Lp4fwR/eIXHucRTcpJmopm4R5h1
         vf/Jc6Ug9chd1NzVcY+9EekJ4sx6R4IQSq1/GnJFg6RGTfPa1cSFvSeVKtbow4BFOUKR
         lQUQNEtq1b4UgECssAKdbEDkShN9pcldxT9oB+iYHbUHI0ESxiZVDLcZYSJYCSb9D6h6
         ZdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706835; x=1779311635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tWie8QDRamhbBEkzrUul5Y8Sg0pYdL4wa5Y3e5SaGsU=;
        b=aVFYk9kpYN7zxketbI6lOMgvEQIP88iua/9ghndWZnZzt+tTCE1P7QME93VrbHhcF6
         Ah+XkfbXAFvShg4934f2JXWMbbjbeVxdHsjldukPLiJiVd4LAl/UwL1qg+pviHRXz99v
         LIOKzL9K0bghSgOmnVdSkpOG6KeapLzNNY1VHXc/0t0k9g78/wl67CFDBHPkUB1ykhyx
         R34swuXwIXvOobrQp5XA/1xwlpMkOE3cyVmRDs1nfvwRCtl3kj41AvZGP7rZnZg9cCJW
         m2RTQudCqNEzTYeYrEDvu0CT/2DkBZCU2vnleO5THpO/Eax4GbsuHiPXAVMXbAkV27gs
         wZQw==
X-Gm-Message-State: AOJu0YzzfwMjRIQhpf1bTDCY9+tdMVjMeHBa5odNcHkSbRVBTmKz2s9j
	LCyd8JJjFu/IElzzzbWhSVU83i3ohgM6Bq+divsGJ0DSuSqSERHEP27OTXrRzMo+PS13Qhrej8Y
	slSltrLqoDzPTdz292M7ryNCA0FZOsjD6WWBu
X-Gm-Gg: Acq92OGDAGPKrR34w7Is28xN65nzUS9XTu0hf1LPabXlPauu33kor+h/eeHd6oLOMlJ
	a5M/dRrFBMo7elsiUsnzrS2InZAWh4mM8cY/jeyoxEsDucupRg0uf9yIsyzogzQmLqvviF1Ore1
	8keOzsBXX0JqyiKL9DBwzbl9Z0FUkMgWA1wI9NGlq0wsBghZf9xjFlCi1HeP0lXIsToYcyGG1uj
	a51htjdToudMvNOxz1GivPKFgCzA5oW0jIsojt99Aguf32f58oU15vfYSRPDgeZz4FxxsZXNwb1
	l525guNrxeHjLO9d1hs1zg==
X-Received: by 2002:a05:690e:4299:10b0:650:1724:f63c with SMTP id
 956f58d0204a3-65df814dafcmr3625979d50.20.1778706835013; Wed, 13 May 2026
 14:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260513144621.440431-1-JPEWhacker@gmail.com> <CANNYZj-vJB83dvkE-Bt_EDFLdmVxu3gEx5mXg=PXstXKkOt4=w@mail.gmail.com>
In-Reply-To: <CANNYZj-vJB83dvkE-Bt_EDFLdmVxu3gEx5mXg=PXstXKkOt4=w@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 13 May 2026 15:13:43 -0600
X-Gm-Features: AVHnY4K2VuE_c7I1cGOSLtxt1Z5KcTgUPpsLpI5eun9fCD_TbJ8A1LX919SonE8
Message-ID: <CAJdd5GbsTRCyFh=5=yhETHZ_rqPzGm_bhqeun0=mEvFTvuY4MQ@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] fetch: Upgrade shown checksum to SHA-512
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 May 2026 21:14:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19515

On Wed, May 13, 2026 at 2:21=E2=80=AFPM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Wed, 13 May 2026 at 16:46, Joshua Watt via lists.openembedded.org
> <JPEWhacker=3Dgmail.com@lists.openembedded.org> wrote:
> >  CHECKSUM_LIST =3D [ "goh1", "md5", "sha256", "sha1", "sha384", "sha512=
" ]
> > -SHOWN_CHECKSUM_LIST =3D ["sha256"]
> > +SHOWN_CHECKSUM_LIST =3D ["sha256", "sha512"]
>
> This raises so many questions :)
> - why suggest adding/fixing both sha256 and sha512 to users, and not
> just sha512? One checksum is enough, and causes less visual clutter in
> recipes

I suspect we'd want to make SHA-512 the only option by the next LTS. I
don't have a strong opinion if we do that now or in a future release.

> - if sha512 is suggested, should devtool be tweaked to add that in
> version upgrades and newly added recipes? (something similar was
> previously done to assist md5 to sha256 transition)

Probably, but only if we make SHA 512 the only option, so see above.

> - last but not least, should we look into adding support for better,
> newer ways to identify commits in git, replacing the classic,
> not-that-secure sha1 ?

I've not seen any guidance about what to do with git SHAs in e.g. BSI
TR-03183, so I'm operating under the assumption that SHA 1 is fine for
now. If you know of a better way to do it, and/or see some
specification that demands we do something different, we can discuss
that. Either way, I would consider changing the way git works as out
of scope for this change.

>
> Alex

