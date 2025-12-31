Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2373EE57FA
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 09:27:40 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.82611.1767173257674059030
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Dec 2025 01:27:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EdsFtYfh;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b1e54aefc5so952855585a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 01:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767173256; x=1767778056; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5QAJboJ4uNsncXB2PeaJxJubBp6MT9XQUCtd6a0ibmc=;
        b=EdsFtYfhVMUFRDqcpIqnaCjZcBd9+q/STfTz5F9pBVLSGS+MACxVNr/raPT0ONK6AK
         lm5UW8tlDLq4tHVHL9MJW1iiIuZbI69qwvyRjKjOqdnqss5n3C6x2JBorjJaYqJv2fBB
         yE54lF0nwRciOo3wk8lCWje0QcjPWBbcj5EaFWqZncfeSsFOJN1AqOU/G3gx4JUmq298
         SZRuzSsPe0WBOstWWeIF5RIP5pPdTm+HZgmK+tfUtwdJOquYFncK8QtKRYXTTYXUYM/I
         Y0BbWQVQtAB369IzRZfSfpO72uYIdOFhA2EVinZEFuOoosV7SzSP1e5QVvLg+HovDBsP
         +Svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767173256; x=1767778056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QAJboJ4uNsncXB2PeaJxJubBp6MT9XQUCtd6a0ibmc=;
        b=vD2Qg/3njPyGY3lmf6AXf3qn1nQhAyeOgofzsgYA6YdIAJB9arn1fa9YQuIeZsaJ8p
         pZo2IC/gdTrp10gOnSYN1N8NHLTXI5fqixfpwdYKqDCGxTYuUgt1RsmpD+wSP6JzEYcL
         M7XD8gehjFPLEPxlt1eBBKW92orcnoCzFrP2ILGoxhZe6/WiJf2PS6xu2FU1tLI860pk
         swjN2OuZo0kBWkS/VAusFfMyYYpwlG8s6YtE/pHQfesYusGpfj7mo4ms0FmQdszVPV6K
         cEnxuJGM5kXSRsJgZH8QbgqGwaGddqVamOgHqA7a39Y4EOGovgU8cm8/2+u5I40BRXGR
         FMTw==
X-Gm-Message-State: AOJu0YwI/l+x+Cbq979gn3WdZ9c29ojcFugMrbD9fg85JlaBKkOTW5pN
	USuTLkLHg2UmIjAkC/kpE5E+Iz6VSiISMQpk9hXQJIq0PjWvJahKrwJuA/k0cqJdg2ywR2skq5m
	/u9oXeL9S6HSJWnYFMQtbxwU79gmWdAQ=
X-Gm-Gg: AY/fxX4mVtNJAzdpnMymohjw0qK/t23GX3lb/QitXPD2G+h6EzodVr5ek6ECOFr48/b
	oL+CIJA3Gw703op0mNDmX6t8s0BjoMWA/xbJx5SHB+yNs0M3BegebAXDD0+8jGwjFxO/5HEePA+
	i9e1UJAgyij1DWrXZSH0D6aljegSa+oo5c8OJza/GQZI3IHq11avOwBLjN/fM/HZeXVxVbCcg+K
	AFYkOR6Qt6Xs8IGYFvAR4O9zq/ZoJA8ddfCoYS3nu3C2rBxvDFv4ITNT4sedqYAVOoUeJpkatiP
	rkQyvwrYe0i2t90l1UTU0XDvYDpINQ==
X-Google-Smtp-Source: AGHT+IHYvMI/mn5VA8xnkrh4kwDH21XuSRHxZ7uR0nIWTNxcSEYwAuCUjM+O064Y86mloJqzG/6KlJkMZv3SOPrtwwQ=
X-Received: by 2002:a05:622a:5c97:b0:4f4:f834:44ed with SMTP id
 d75a77b69052e-4f4f8344763mr270329261cf.64.1767173256544; Wed, 31 Dec 2025
 01:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20251222181527.2424323-1-anibal@limonsoftware.com>
 <CANNYZj-=2r9VFg4AGfKiYbOp5Eh57uvVQt11UTT0xVWPhfxbhw@mail.gmail.com> <CAOU5ZMthyn3+Y9axBKSdVy3qukFo2j_eU0VnJupTZ6pX7PoPag@mail.gmail.com>
In-Reply-To: <CAOU5ZMthyn3+Y9axBKSdVy3qukFo2j_eU0VnJupTZ6pX7PoPag@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 31 Dec 2025 10:27:25 +0100
X-Gm-Features: AQt7F2rkNpbpj7LOfQ1omQiTs8rSMYHsFllRRam_J7x44uObtVHG_hZXDIjsCPE
Message-ID: <CANNYZj-uV4ob-aCWH9uQGCnmMgq0p1RCh3qeBo_fp=a6iUtqBg@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: _symlink_local fix case when update
To: Anibal Limon <anibal@limonsoftware.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Dec 2025 09:27:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18666

On Mon, 22 Dec 2025 at 20:53, Anibal Limon <anibal@limonsoftware.com> wrote:

>> This and the previous patch expose a gap in testing, perhaps
>> status/update tests should be extended to cover local sources?
>
>
> Ack. I will look at the tests and send v2.

Just wanted to give a heads-up that I'm working on a more extensive
set of fixes and test coverage improvements that incorporates both of
your patches. So you don't need to complete a v2, but reviewing my
patchset would be appreciated. I'll follow up with a link once I send
it out.

Alex

