Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4BC44502
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 10:08:00 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8544.1768990080104074416
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 02:08:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QLiFteyH;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so48651926d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:07:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768990079; cv=none;
        d=google.com; s=arc-20240605;
        b=CYNLl8kBbqEO+czAeO/QuQs5F07tJ45CUK+fCm85od5HR2wdZQKyRd+zYJLLHLkkAC
         Af45BxRee/pLDhqZ57T0gUGlQHSuui4fyT7EzNEivVuWPnR9fc33eHnZxUH8ASH88/sZ
         nZLHM4OYwk7J/aV2w+TyLVvbbQBUpd/3G7g/vR0RN2Hdn00pxPpkUqZppN2+n8NCo01G
         5pJD+ojJaeoCHWrXjumCfV5IJQ8hwLcyseuAvPtKCsTVhKzM11aBdo636orVQ/nKk4xh
         Ni1Eepcl8KL37qcG/Iwe07/zYve3ugKWF9BsqV2UZsdnmp/Ac3i4g7oaKGN66r0kv/DL
         f6hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YsCx2qectGUR8sfZtJiK+MAluFxFyExGfDiJw+r8V3M=;
        fh=4X9aOLK886Nj0++W09S9K73urF193/tVhjbV3bq8LAc=;
        b=Scc9o75fhYFYWRC9iQp4okxaNGDt+0bCHw2EyZZWvPEIkTaX33G05agYnP5uvoI1ZL
         iQix+AgmoZQ58NqCUnxxvk52f3r3MVuqtg/Mcy1C+MGKi1EwG9P3NeCzwn6hTc8QKv3r
         yiRq+erPbZzBQHBanexpu3hmb5LHNXEnzaTqKGqvdbxwP2qOy0y0bGmUnDhQv1BAe+6V
         nBYeficOPR/C/YkQuLU9FB8UnQexOAzArWTcd5wOhnl1OKrN2Jm9DwWw/OBKx7gxdW7F
         74WY5OmFFsWbQAE/wHWmsFWsP4XnjfeHDwl78ia9C4SJ/9EmGQXq74piCfl1gSZHxTWD
         hE5Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768990079; x=1769594879; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YsCx2qectGUR8sfZtJiK+MAluFxFyExGfDiJw+r8V3M=;
        b=QLiFteyHZyOCK7HINpYu5yMhwrwzeXrSeaz1gVZY/KWfSINDuwPoJlaIZMZS4pfGoS
         YbrfIGgOPKc0MvNF/9KsoCulCZvXbo8yEV+1JxcdJMeJQqwZ2fMrlbo9Nmgevgpf73Y/
         kkPjpMDqFtnPi3NJwUFdPZipItW382A8DI3zJSRvn5n4mlQSZUqxx6IMKljojDldNklc
         BNaOs/zqIDEtD0BY9bhu/Z9ZGw3q4vvy682FNxcUnJpHmRxxsebGOjfJHrcoJPCwfsLu
         gLJTHSY2CNw3uLFtJPR9lLqR4PoJjS4dIL4+E8yq8KvMhPJcEFHDGPmW+h108zkh6f2i
         xzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768990079; x=1769594879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsCx2qectGUR8sfZtJiK+MAluFxFyExGfDiJw+r8V3M=;
        b=n2NauQoXHTsfNO/BPpYMoi8gWgU5M7gSY++ctvpvmCEZHhJdNsTNZIRehZMzdtnUIH
         O10NzFlNHJPglgB1mBnrnYuAw3lBa5usFo1xWJ6Wk/7X77g+ToROHSVyFSBqm13PxEFt
         N9UH8h5hda+xLe3j+yeFYZE3mcMHRe29Gw4yrvhRJv1bwo4q7EF/kzG4N/LKPfVj90ps
         Ahh9OgTQLgDIR8BScuTjDTwT7S/lHTHI/1m7eYTULn2RVY61Kl4IXEuEryhfabss+kk1
         dEnxjsiLsMcqy/jLitUs8iu37TROx+T7MVWMK8q4NTddJtnLXs3fU0ysB11ehEfM6ejY
         pJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCU1G/fw0/sVayDIIRrY+u8agPnCOX1llXMmhwn8Sgr87KuuQTeJjTsGs+4M9tNhPYyxkbZxet0gCsOGJkpt@lists.openembedded.org
X-Gm-Message-State: AOJu0YyMOFTcg57VVa4K++NRr3pnZKUC7nvsWJobsaK3U4nmJXtWHez5
	5YDHADbsyEdql0QTYeVdnCUdVI2HXZrOYjE54YHPOC04YbiPLYBrncjxGDLaOp8Jz1M3Ftsxo+8
	bfNjhu0IMqkL0I/JN0eRsQyDxhbr7ccU=
X-Gm-Gg: AZuq6aIxwX7aVV2c0PP8p18NhoKWZwXZ0cIyP6IzO6uGN+on8TgByFatBI7Q9jMTav6
	wOa1BimUwOGl65hZ8t5qxNIOmU73L72XSoYJZBbWJ/5otZsVnZ5gjTvFJxc5kxnjRyiz1iM4VR5
	s4ZISq1PLFPFO2/ASntcrZVjD//NzuKmTZpN74zZv8TT2REvxeGaZYSam/qdqYRkWl5nVKDIJhK
	M/Aq6JV9w2FScF/iZ2nZCzy8tngNBJKSRO1Ww94k11TG31ryF/WvsK1JRnpNn6PDaxL8MAdOU2A
	uIxUtHzooXwweLHaRmJL8n3N6eLjXg==
X-Received: by 2002:ad4:5def:0:b0:880:2a49:7047 with SMTP id
 6a1803df08f44-894638fe70emr70630776d6.35.1768990079017; Wed, 21 Jan 2026
 02:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com> <CANNYZj_DjeLtLYLFNdwc=_RjagYAkdPuZznP5+QRLpc8bdE3hQ@mail.gmail.com>
 <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de>
In-Reply-To: <4e1605c1-7f20-45d1-8291-399001921ad8@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 21 Jan 2026 11:07:47 +0100
X-Gm-Features: AZwV_Qgt6aMWCX0fYvXfh3YNLT52nZsrOEiG08gqgmTdKdYl_kTo7tIPjVhduzk
Message-ID: <CANNYZj84JvmiTpb+pajy2F4NVseo89ATqM13EEviZeSdD7jKfQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: quentin.schulz@cherry.de
Cc: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 10:08:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18837

On Wed, 21 Jan 2026 at 11:02, Quentin Schulz via
lists.openembedded.org
<quentin.schulz=cherry.de@lists.openembedded.org> wrote:
> The next question is whether we're planning to upload bitbake itself to
> PyPI in the future? If so, we need to be careful about the layout.
> Building two packages from the same git repo isn't that straightforward
> if I remember correctly so if we're moving things around, better
> anticipate this possibility so we don't have to move everything around
> again once we want to publish bitbake itself.

The answer to publishing bitbake itself is a firm no.

That said, bitbake-setup packaging files still shouldn't be at the top
level. There should be a script that moves them into right place
before doing the packaging step, or ideally packaging should be
pointed to use a sub-directory.

Alex

