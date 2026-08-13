Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B36C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 15:58:55 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22463.1786636729677370444
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 08:58:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=a6osdLda;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4998590d392so968095e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786636728; x=1787241528; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=A+NAB75HlfxDh6JfNyHqSHLgKhUKsBx3rXmkyRwuiks=;
        b=a6osdLdaREyu/WQUwdfYWFehIQ/jxb1cgyjUGHiUI/6vhPBL/E1WvEPOLmEMH8pvIo
         0qnCnyrQZvXIrTYHkYMiV7QJt4O6OZEoxczQmyPjb+iAzCFPb9qRqFdeTqtVMTkkFtZK
         sw9JZ59oVTY2Av7on4sz7uAtzdcCETwJg+QiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636728; x=1787241528;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A+NAB75HlfxDh6JfNyHqSHLgKhUKsBx3rXmkyRwuiks=;
        b=DRq34Xhbl+xWtdHNeBUj9/IsUmvrSEU1NAUe+xEDah/I+1M6E4FQyI45t9acUdLiQY
         nSK1NSiyi4lx8M0PHWKIaj+U+Z7sgcXKwN85mZ3oRInjPvA3Kmnw8zhAWs1d29nCSSVD
         bUBbrOJwkE3JXWTnwYYMSth4eofm14obdP212rocf2Mesuyh1gGr3K2cRSPIYtYgA7DN
         d8AoASdKav1RKyWORzylbGdquUk1zSFXidnwd8LbyGxDwQC7HtMmqpPS1CFjlmOZT3/y
         TRIL/o32/Lld+5XKlybCpVGnA7xgH8yhB5pCSc/VPVHs7uUa/5injTRHdgXKq+N5v59c
         VFEw==
X-Gm-Message-State: AOJu0Yy+FPV3pmT4iT+rtm9N5IoCUQb2TsQ6BLiT25IFQ+QPVNr8OC4K
	eWihlEW0uT9Lcd+gsbXf+KNge6qPbeGCkguLpAdBotElM8hLkVvtA0rD0OAm0gNrITA=
X-Gm-Gg: AR+sD12jzZVi2IovC8jrFxjiNXdZBrfOfay2IdfVeBep3Q4Cca1rUvoSw1AScM45o/O
	5rsgpxNKZdXI/wI58vr8dxWMG61//y3fUllixIRuFqG7UAZoxq4zk4C90WTt6TgUlpY0MAujkzF
	djp5cLEhdsmWCSA8Xm/C+IenHTRduaZDLCIqaRbrIbQo9difYHW5p+c+7cDs+n6n0s3kb39dAvD
	P3yvOvu9QSnYUx/BvHjDJN0aXQjy0gUd7MsB+wLC0dE/olAtYRcANCTUp0LeTEsTnXeLbmllX0U
	HAdqYbOI5CYh9X7jet7Ap5ACGJTtY4UKoODg5xKj6a5Gir74UmCZJ+LRwxe9o1iQuKWr3SMICIR
	gWW2NAFKr2tNTci/eW1ovosl3gxOR5Tr+29kip98N4izK+tq7tkZYnrgw3pz/jDqIIDI9WKFzYB
	S47HsbqClCYXQm1cD755n9d4Sc8FW9ziGvwmHWgpN8HRrePdDfeoO4y71Q7WgfVnNetIeY3oE20
	DyWPLoGrEMbY/StKIMK7qvVi6krOVw/CXvk+HHjoHjWctMdofsXcw==
X-Received: by 2002:a05:600c:3586:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-499821f5d09mr93122275e9.13.1786636727604;
        Thu, 13 Aug 2026 08:58:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d? ([2001:8b0:aba:5f3c:e77b:339c:e0c2:6c8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499820c2897sm139163515e9.0.2026.08.13.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:58:46 -0700 (PDT)
Message-ID: <fbc8c6306856f3be07a2e6aa3ec76b9070a35897.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] toaster: Add recipe variables view
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paolo Wattebled <paolo.wattebled@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2026 16:58:45 +0100
In-Reply-To: <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com>
References: <20260812150448.2343308-1-paolo.wattebled@savoirfairelinux.com>
	 <2434d54e4295573c9632a1fbcd0cef7ae6a0d413.camel@linuxfoundation.org>
	 <252742809.992447.1786635089054.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 15:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19931

On Thu, 2026-08-13 at 11:31 -0400, Paolo Wattebled wrote:
> Thanks for raising this. I ran a quick comparison with and without the ch=
ange.
> Toaster startup and recipe parsing were effectively unchanged (2m46.554s =
vs
> 2m46.835s). A cached imx-image-core build took 4m23.648s versus 4m07.387s=
,
> about 16 seconds slower. After vacuuming, both SQLite databases rounded t=
o 74
> MiB, including 598 per-recipe variable snapshots. I understand that some =
of
> this data is stored twice. However, I only store variables changed by rec=
ipes
> or bbappends, and I compress them before saving them. In my test, this di=
d not
> noticeably increase the database size.

This does raise a few more questions. I don't think you're covering all
the cases where variables change in recipes as *every* recipe will have
recipe specific values and 598 seems like a low number.

You appear to be only considering where overrides are used but
overrides aren't the only way variables can be changed as =3D+ and so on
are possible, or the value can just be overwritten.

I don't mind toaster reading out and storing the data but you may as
well just read the data, there is little point in changing the cache
structures to add/cache it?

It does also raise questions about whether you want the variable
history information too? (or will in future?)

> Our intended use of Toaster is as the backend for an MCP server for AI ag=
ents.
> Rather than having agents repeatedly parse and search recipe files or inv=
oke
> bitbake-getvar, the server would expose resolved, build-specific metadata
> through a stable API. The MCP layer is still under development, but per-r=
ecipe
> variable values are one of its planned endpoints. We chose Toaster becaus=
e it
> already models builds, recipes, packages and variables; extending it avoi=
ds
> creating a separate metadata store. It will run headlessly in this use ca=
se,
> with the MCP server translating between Toaster=E2=80=99s API and the age=
nt.

Thanks for the info, that does sound like an interesting use case for
it. It is reasons like this I've pushed back against deleting toaster!
Knowing a bit about your plans here does help me keep fighting to keep
that code!

I'd also note that your original patch is quite large and really should
make more increamental separte changes given the breadth of what it is
doing.

Cheers,

Richard

