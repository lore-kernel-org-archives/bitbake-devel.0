Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8D7E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 19:41:03 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.1692.1736451657371206225
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 11:40:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hAellIaL;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd15d03eacso11921446d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736451656; x=1737056456; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nwdPWsAnqP5Q9LwwmN4tCn8YztGiBVRf/B8Xm4YLyYw=;
        b=hAellIaLwmvewOQiXnV9w3plXLv/C5QEdHCwOhaNJtiV6r9LArXO6lw6LTtF7xF8m2
         1ScdHpHzAH8UzQOyDYN/PcVcrly91KHiyoAft9ON6dyiEPlxyaKLgCG+Fen8H2Qi5o5S
         fXC3PgFAxYvVsD6L9hnaPMuZg18t+CIEheeM3BAScusIc1EVUehK+1/fAxix4I+DbemM
         1HyajvMNwzEG4fUm0NeCcEgifCuYhNAqJocsa9fyYRwyL2DXB7s50hOieDcrI3M7d9et
         qY1orezVqSRmBSq/i9WD0mD+4Q6MmvGSDowJJsbi45uoMw+2x6OJ5IWTTl8cAzPo0MtN
         HyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736451656; x=1737056456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwdPWsAnqP5Q9LwwmN4tCn8YztGiBVRf/B8Xm4YLyYw=;
        b=JiCFoggi2ndbl5F4BUt5x+BuuXdW31AdShNNfRaTvNmcdjXRltOlqz0rgNaePfcXJP
         QwCu9nrae56ry3I1NQ1fB5/bdik7fFvjDHznlQLRb+YaSp8Dz5Pso4hnjYQoxfSL5Q7B
         8ISeA6aBlWsYW7EMkL83vnkyf6GTzp2/fZZRrTY9rL5N/Ns6AyBmtUMxZR+epNyIBZvS
         hszAU3X1T+fCNK3cR2OblULpnNTgcLv+MZttSJV7kD/FMoo+uAlt+mpNsZFXBItOWGQF
         iyjouUtJwnhFY8w0/bFOOdyqJltyEPuMhQ/axt9WDEfDlqJn49mf/JgUb16Hrabk00JF
         Eo/A==
X-Forwarded-Encrypted: i=1; AJvYcCWn1syNBGwg0skeKvApcnTcjvFI9JkWJ1gKTyoFw4ApR556n31mqZA1rmyKHgbvV4NKZVNa3zG226EDz2yM@lists.openembedded.org
X-Gm-Message-State: AOJu0YzuWBafipx1xfew2w/cAA+iyS8Ki4SoJyEPMgLMuiI3XHpMzxqR
	+auPnWI/dvHcbT0J5+esItyJ2RDE1OlTp9A4cEOtWgJ4owzTpVtb2otANZwHbfl8mc6z2m+nHbA
	H8wWd+08IrGAvlosx0AB6ALAtx+4=
X-Gm-Gg: ASbGnctkOVaJ3zs1xKqRQJF8fy68KbhJRKAtCRYfIS6iVCLL9mbbHdem9aCBMVfeSBR
	y17PM4PeJj7pQzOV01P5reiJjL5qxsklgvn9pu93LLE2iqHkPbgBvmsy80N7P48uaIv/+6//t
X-Google-Smtp-Source: AGHT+IFTYDBVHeVwTc4qxDbCbcfJMi36aP0Wljk3kLCQs/CiVjttmq1Q/g/lGgw6+ZXu9SLkC96Pq5IYsQjZ7O4a5Pk=
X-Received: by 2002:a05:6214:e6c:b0:6d8:7a85:59ca with SMTP id
 6a1803df08f44-6dfa3ace7a9mr68800186d6.16.1736451656372; Thu, 09 Jan 2025
 11:40:56 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com>
In-Reply-To: <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 9 Jan 2025 20:40:45 +0100
X-Gm-Features: AbW1kvY0QDWEFS7XKUgxa56jWld2HVZlNVgm40QOc0VH6FPcLYfQlsRgK_WcotA
Message-ID: <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 19:41:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17000

On Thu, 9 Jan 2025 at 15:00, Stefan Herbrechtsmeier
<stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
> I missed the appropriate function in the dependency mixin in this
> series. The list is created on demand (see archiver or spdx patch).
> Every derivation need to be handled in a package manager lock file.
> Therefore you could place a lock file beside the recipe. You could use
> an editor or the language specific tools to manipulate the lock file.

I'm not sure, is there code I can try that does this (and if so,
how?), or is this code still to be written?

> What is the motivation for that requirement ("just by looking at the layer content")?
> Why can't we use a SBOM for the vulnerability check? Do be really safe you have
> to scan the code because of embedded packages (vendoring) or git submodules.

That's right. I don't disagree with this.

I do however have another concern I want to express: I can't convince
myself that the 'integrated fetcher' is an overall significant,
obvious, major improvement over the 'generate the SRC_URI lists in
.inc files via task in a bbclass' approach.

Just a couple reasons:

- the 'integrated fetcher' is not trivial, and notably increases the
complexity of bitbake fetcher codebase. We already struggle to
maintain bitbake, RP is overloaded, and very few other people have
time and knowledge to look at bitbake patches, and understand what is
going on. You've already seen this with your patchset where getting it
properly reviewed by anyone else than RP is an ongoing challenge. On
the other hand, the .inc updaters are fully contained in oe-core
classes, they implement a task in well-understood 'recipe python'
dialect and thus benefit from a lot more people being able to take
care of them. They're also safer in the sense that any bugs in them
are only triggered when someone needs to update a recipe. Fetchers, on
the other hand, are fairly critical pieces of code and they must work
regardless of host environment, python versions, unforeseen corner
cases in source trees and so on.

- we might be able to remove those long SRC_URI lists by migrating
recipes to the integrated fetcher, but we won't be able to do this
with the licensing information (pointers+checksums to licenses,
license strings) for items that are being fetched. For that, you still
need some way to write it into a recipe with a tool. We don't do this
yet, but we really should.

Alex

