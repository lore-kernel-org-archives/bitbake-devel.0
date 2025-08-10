Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71695C87FCF
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 14:26:19 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web11.26858.1754835977168439428
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Aug 2025 07:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qi6tRj7V;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70739d1f07bso45530426d6.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754835976; x=1755440776; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yl0yJP/UD156VDwdPjcl8LHEtrAAL8MPOC5LTeEqoJg=;
        b=Qi6tRj7V8M7blT2dFvebRH4TQejTzEWiWLHafNIjtjk35HgXUNLkm87w+GCt0/swEs
         Lg+uP7Uw22kKwoqTII2qAzk0ZE54olAZzZLOapKSa+F4cqJwVcmvaZEzXy50irhN57ET
         tHXvQlwVh2cHva2UxKV6va16tAVqOzzFwwBALCpIpEVXRqPfyTLronobYjDNjFa+VlJE
         zyzsSXvOsaRa4Amk0y/fJoVZT3zHCChtr/mOQ3p+J41/Mv6cVL/KzDX1sn6WwNrcr/2S
         5k52Q4lf2/4BHIuGGP3y/CIf6ZN4B8NyfqS71enBew6sDPISxUsom/KmCiVscN5N5wSX
         FCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754835976; x=1755440776;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl0yJP/UD156VDwdPjcl8LHEtrAAL8MPOC5LTeEqoJg=;
        b=HzrQbPbuJWGVJ36Z5CE/X0zbD2x09mWp5b7lphpzpjQq8aS+IgTvMoHAuqOzVRvTBH
         c9xamZ9qu75N6kriIqgEQDsXMGW3iRzp9DbF1Je0wFtabOGdfok/C1rtBHkLIM07vXyJ
         Qu3s4KYdU2bilk8fbJUSjF3Gt+WOyHeY7yPNXji2MkaGvjUAmJCXne1wT0shRlhqpL1L
         Jrcpcx0CaGW8gFlbS5c1XIwqNbHK3uXQC0A3fXpkxYfmdbZMVyghwgJqBNXIkwAHjmI8
         GdEYXtLrR5joIYwBc8CvwtKi4yv3XTlhPwZCZnkSjPweHAIPllkbqu5EazKdZ1j69+Ve
         Z+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuvql+LghfvFob4W99pLrIyGUEpPQ1yzwBDomghbIfMyjTeMeDAFyzCYXDnQHPv288uZfzEFZWfNjJviwl@lists.openembedded.org
X-Gm-Message-State: AOJu0YzHN3DQ6Yx0wTcqEDZIiiLbi8B6EIU51l8vbfcMjlLByJhFs9DO
	bNt/4Zv4zai8ALpzICXljFRz/DbTqXlngKHGH+shBxeMme4zC5cDWTRDRXKlpVcOLIimy47+tAX
	cdyVxKGpIQmRSCUKXl2z78Rg4zVSibvI=
X-Gm-Gg: ASbGncuFLRIODdS9wslVMbYtC2ma/ayA2FMEYTB0goY1JhTbgqe5gSlmm6hb7Kg+wX6
	dh0ryeIHjbkJ2dJzMU4fetsqFp+6cVojnD4YhZ1Z2MOG+SuHJWiEkqJWBCt+9k9WlVgMdepUaX7
	WnIwiL4rWhGVqmBd6jp/0vuHeT/729icWaW4rdxYYK4F14vZUugCSQn55PIEIzeWjnLdqtgaxvU
	8i5r7Po4p2as3mQ8JLdDev9Qau7TDKk9li9ki4XKZXB0MbHaRaW
X-Google-Smtp-Source: AGHT+IHSkAWmAzgz8w38RxhOtzmlFoc8dih9wUJLElSHZXVdu8iDbOQPsM2VFxs5mW1MBs2d6Fjtl2CrZdd5vG8d6yI=
X-Received: by 2002:a05:6214:2302:b0:709:535b:5857 with SMTP id
 6a1803df08f44-7099a4dee62mr122913266d6.43.1754835976169; Sun, 10 Aug 2025
 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250729144906.1665908-1-JPEWhacker@gmail.com>
 <CANNYZj-TMk4ktaPqC2EbS-k636cJfr3hyeZXp5rrEESi-ovZjw@mail.gmail.com>
 <CAJdd5GaNH=gP+ypmV31MLwYgF-xdT+e-E9rfW1JCgQis2PJtyA@mail.gmail.com> <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net>
In-Reply-To: <DBY5WKIGG9UG.3DFOCYWME1YVA@wolber.net>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 10 Aug 2025 16:26:05 +0200
X-Gm-Features: Ac12FXziw3X8V6kD5Lhb3i-Xj6jxLens1yi7OZrsPGYJ2D33gQMdUB1E7PrNRHE
Message-ID: <CANNYZj_7MebKw3iKvgRdKkpQvBW4a+4kdP8QZX_yWoY3DxN6TA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH] cooker: Add layer-specific ignore for
 dangling appends
To: Chuck Wolber <chuck@wolber.net>
Cc: JPEWhacker@gmail.com, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Aug 2025 14:26:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17849

On Sat, 9 Aug 2025 at 21:59, Chuck Wolber <chuck@wolber.net> wrote:

> > Branching isn't an option for us; we are unwilling to add the maintenance
> > overhead of dealing with that.
>
> You are not alone in this respect. Perhaps we need to find a better way to
> explain this to the YP community? I believe adequate consideration of the
> problem will improve more than just the plight of OEMs with long lived
> products.

I am totally listening, but you (and Joshua) aren't actually saying much.

You do need to explain with sincerity and clarity and full details
what is this 'maintenance overhead' that is so burdensome that
branching becomes impossible. Pretty much every community layer
manages this, so why not your product layer?

Alex

