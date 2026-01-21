Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9BC44502
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 09:26:10 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8081.1768987562582655856
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 01:26:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xb+2txEs;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c53421cdbfso620511085a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 01:26:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987561; cv=none;
        d=google.com; s=arc-20240605;
        b=JM5kxYgFsGQYt8D/CIcYm8QaqOaENnTEZve3qdkaaIuiRTAdBkm+KYYH7dPvi9c9WH
         FdKk4YE7nuelMh0p2bWjvomiKvI1fj5rMne8o9qQwG3Sm61odmnPn85OLDQVm19Nb8gv
         7TThYzhlUg004/chJM9BQ0Z4a5xdBGTS2Hzvq8JE80DyEVist3afFCdJpv1n6/uQ554S
         ctLi3Pk7mnFa6k6MrqjJLyllkmmbOBjYMFtYh26ocUVq18btYdFZZPJ+qQEf683oWYFF
         2f4ivxEKgLQRt0DqaU4eCu9P710tTc12tt+ozSWJ0yC1sMl+28ziBoohxPuQ5narcu4h
         sCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GM+udl2LOBzkT17b8ClrEWLZEc0zz/AH5prkxpORL60=;
        fh=An8TtTKvZj+7ly6IPQ9GZdX1ZHXEU8WmhPzj1ghEr8I=;
        b=i4Q/s1fJIBC1nyer3CziAvAzk5zh7ABX+86vh4fYOskNQIyvAtB8Ta5rvM75si4OXG
         sS5U/LyxnoDMJTSWIXKVJf6kUyJ+lMdgMmqUfuHSstRLOb14CJjem5ySugsc0pBnHFxL
         wtFrt8Bou0F5y+ye6kT5cMM8JntL+n1fin16wCqSgh3pgZ+C3ikEQPzmB54lvkk04qgD
         794rjsSvppVhR4ii5dZEwhv/EI6q0R38EleXtakd5JQSslGKf9vfQ0uPooY7KwRnL2/t
         8H7sUSqmzV5hMw+l2vUzruc0eWBh8zeJRHnbuNsux6IWI/kWCoz+hC2HLh1N41Ve9DTa
         dBrw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987561; x=1769592361; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GM+udl2LOBzkT17b8ClrEWLZEc0zz/AH5prkxpORL60=;
        b=Xb+2txEsgmZ9x7UvSAGE4Mq+81miIDbA0IY8rxgIy7QvCqMWxT7W6OCrFCgnTJqypq
         iYGo6TXSnSkoGeEG0q4FFRXq1lIv2SbdWN0FC5qN73CH8z1pxYq5kvkcaC7CVul5PPGE
         6lUpKZlq8Ujr7NuiCjGDNTsgbO1LB2P66JAqaz7Wba4TDSxpw8z1qkOyBqPE+Uz2GERe
         ghR8GpY1jsGEiUjHDEOYtmPnPuj0o7W3u6NrxXSV37CUGG6Kgh3XapeXn1YLJNb77kwM
         9+1/r91X/HawLYH0S9FSWphpBHQRt1QDvCj7zROsSMQfT6N+PhnIsld/heO/YeBAO/lW
         EN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987561; x=1769592361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM+udl2LOBzkT17b8ClrEWLZEc0zz/AH5prkxpORL60=;
        b=UORcDu9IHISn24ThxhndBa1Q7DRCW8X9Z3Lv3YV/tm9IUbcVWBGG3nkr9VD/INoC5q
         W7cKcIYaT2wsZJUsVdB4PBfJA/Nv9cTP3cYLxOafNi8yAXBbs0c85luaOkCtLMk7JlBd
         JjgIi8PC++t6F7Tmu3A2ZS7y0MIaU7FOneNMyETK5k9uPZb2OKdfiHlPZogTeeF+Ge92
         KPy9Y0mPphlCt6r6URfDGsmOY3TxD8huXnddoUtztMuNtXYiskqyv2R4D85oB6hJLir5
         Q0nkWueDdiMAE4jc9erqLEWmy/VugJZznBe+Sez0uozeDT6AsCvEEMSjGKgdRjMqm+TS
         fROw==
X-Forwarded-Encrypted: i=1; AJvYcCWz+dcR5nT0UG83W3d15Ea0jXu4zo4it7Q79rYlTHSHoc/T3uqsX6mNSWlc7ngn+47/0N/O/KQg/wywITyI@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywv3f4/MxBVUR3UM3TTSq2WJSLLgJiLHZxvaj24fuEMI0mnC8SR
	enzhyrHLJ+7JO80mCbwWtx3hkn8g/yvCiBeZ7/PsbLRVCtq4CCAJjkSjs5BQ+Jvp9FKWMedt7ZL
	pVCEYkxB+hgZb3wt0MfLQgIAZmHbsSto=
X-Gm-Gg: AZuq6aJIzxM9FM4xavROp09IHBMDIk4ixNQx5odFr/zGpeHzvoBMM8/BgWpiNENgxQE
	llB71uNRjrIALjtc5r6DeUMn7fUSpc5ISf69tbmkSi1ClLesEyZMMWswCJD0lY7JmyHlCt1bIxS
	DErskIE8ODvUO0il8sPXivFRIhohvqBTCuXfcaUaR1IFbPVIB/sEJxvvvUZDg80lmyZ37aIMY/h
	ftXQj2IcgMFLposoOSxu5LvvjmWLFOOzLuB23K2txvaNWIiy+GFh23lR/ohildMfRnu4Ib0278K
	70oOkDEZXWpLaaKftwNMDXZFM1CYeg==
X-Received: by 2002:a05:620a:19a0:b0:8c2:3f3b:dae8 with SMTP id
 af79cd13be357-8c6ccdb0dc5mr590794085a.24.1768987561504; Wed, 21 Jan 2026
 01:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20260119073419.952608-1-adrian.freihofer@siemens.com>
 <CANNYZj9rLfTy2A7P-CbEuM4uEqOELqABCPJc_XQXr3W6R5e18w@mail.gmail.com> <daaeb2e7bbdd85c5ec6861f0129048b5e1810412.camel@gmail.com>
In-Reply-To: <daaeb2e7bbdd85c5ec6861f0129048b5e1810412.camel@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Jan 2026 10:25:50 +0100
X-Gm-Features: AZwV_QjccafDGwVxyzCFC0VASoV6bYnbW8oLRu2fVAz81d0Qz6uNiDSDvSkaMio
Message-ID: <CANNYZj_+2UuVqvOBaSAQ8XiRhH1uXnPvE6r-xtcEgePHddmydw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 0/2] bitbake-setup: Add VSCode workspace
 generation support
To: adrian.freihofer@gmail.com
Cc: adrian.freihofer@siemens.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 09:26:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18830

On Tue, 20 Jan 2026 at 23:13, <adrian.freihofer@gmail.com> wrote:
> I was not aware of the -L option until now. The idea for this series
> was to configure VS Code to edit the Git repositories in the layers
> directory. Now bitbake-setup informs me that I must not do that. But if
> I have to clone the layers manually, why should I use bitbake-setup at
> all? Not sure we can find an easy solution for this.

Yes. The problem is, adding a 'non-destructive unpack' to bitbake's
git fetcher is not easy. On the other hand, there was already one
incident of data loss caused by the destructive unpack in
'bitbake-setup update', and that is quite enough.

One possibility is to add a 'bitbake-setup local-source <layer>'
command, which would:
- clone a source from layers/ into something like local-layers/
- replace the source in layers/ with a symlink to local-layers/
- tell the user that they're now free to modify that source, but it
will not be handled in status/update operations

Kind of like 'init -L', but without having to clone the layer by hand
first, and done as a separate after-init operation. Would that fit
into vscode workflows?

Alex

