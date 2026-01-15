Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83807D41179
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 11:58:33 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34056.1768478306450663398
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 03:58:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A/W7lwTW;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6a001e3bfso41155185a.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 03:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768478305; x=1769083105; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JV3ydSiyfUdFLaeArivvx3Hnt7wDBSdw0yPYwwOUlz8=;
        b=A/W7lwTWbC7bCtL610SIE1ZrRJIlOBnWup2DrsPDlATaoKLAc/UFn86FSHn3H8RN4B
         gzR7c4wLRkWO91KxAb/CUrgUnmO4ggbpHp/EzyR/JJtMylA8z8V+4IaUzKoIqy9dhw9f
         nDxITEzNu4aH92piEJUBuRC6d6ts/IfJqZp3YDKnilwOl/GQjGd/hO3QwqOL2U4Gc0Av
         WvH6D+uV5vqF7MSgvtmWK6R0heZ1fZv/1BU0iXo3zG7lQomiY1b7P8Ph2y1dPjSUjdv1
         0/pCi4p+NXIYl6Tml022BQEDMecoVvp0+FTawpgk3MbS7uHa1joZYCHrJrFlX4Yl6ZxK
         AO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768478305; x=1769083105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV3ydSiyfUdFLaeArivvx3Hnt7wDBSdw0yPYwwOUlz8=;
        b=p6MtTR62KNoMLMibEI666yjEC1WMIfhR2kppSSN5n3o0Lz2FkJkvDpMe1/ss7Sel/Q
         zoMffvRCcMbxx7eWJtamgdAV2CaKNXr52ZwhvX5Cp65IPGFMzPLb7CzVRevSXo5RWqqi
         +M4Ifcbl7VEAfmpJcKESx4ARlEfnTDEEaCCvKlWfoDKSvKJt9XXxtwfFr3RMKi6pz2Hg
         Cj8XBliP4uLvJtV2Nkoacz1jb1qFRcftwRfqpN9p5PVjtCpyXQWCa4uG1y8ogfQ8qeAK
         iN3gSYTIxLJtx2Qs0zLwxD7Hkmed5SuQugIS8xJ5ZzeXsyIVeyX7nKxvLEmNuJwlHPF9
         ZWBA==
X-Gm-Message-State: AOJu0Yz4RaHV8rAz9lZfHKTjLh3/R630q+RE2D3os8asv1bcmxtS+9l2
	60s57Dvy/8CfqMRewkVWc2d/4vDO+Dlf64MzRbLWllSE+UWYywxhEr7BAPkiG+doPcKNJ7afzHg
	nVcSIpaKSz+jtNSf4IkhL2aTAOO2GrUg=
X-Gm-Gg: AY/fxX7lcEpawPB1SdfLVK8aiD9uFB6gugwV+th0GMTx4WUWE5+8S3rR+/MSx+ZxjRr
	4/l181TdvWBn/tHs3qiS5VIahcwyAXW1L+B8GxuRf11PVV7cXwE2YLFids7H0VoMOmcQzvpRKee
	d+ekZ/WBTCrZ2DDhqcGv3yGB0BqCZlU7rhPCqrYNiHSxPgNzPIgBmt6tKjZjLPOJh2HGnk2DeZu
	a3rGjeNjvSWAscFFELPMc4X8gGhZQYi0xTkBvhHhzJkhdvTNPRoPGC7H8Gr5R6i1DKqsHfFrScU
	Ybnck7Os3g77XQOTlfdLXC/V7MQI
X-Received: by 2002:a05:622a:5c0b:b0:501:3bdf:f0eb with SMTP id
 d75a77b69052e-50148264656mr72573181cf.39.1768478305169; Thu, 15 Jan 2026
 03:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20260109132000.2372791-1-alex.kanavin@gmail.com> <842ad162-22d4-4ff5-916b-7c8a4450f650@cherry.de>
In-Reply-To: <842ad162-22d4-4ff5-916b-7c8a4450f650@cherry.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 15 Jan 2026 12:58:14 +0100
X-Gm-Features: AZwV_QiSsrZKITqAHHJ5LcoWg_9piIdxtlHlSBtkztX6N1zlXEj-uk1osU_6GNk
Message-ID: <CANNYZj-rZUjYpE_ZnjpkzD_NquFh__tdzchq48tUj6F_h4k2sQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/5] doc: document fixed revisions
 override in bitbake-setup manual
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 11:58:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18774

On Thu, 15 Jan 2026 at 12:50, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> > +Fixed source revisions
> > +======================
> > +
> > +:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.
>
> Will the tag be refetched every time or once it's available locally, if
> the tag is moved upstream it's not changed locally?

I have not verified that, and there's no specific test for it, but I
think tags will be refetched, same way as branch references will also
be refetched if there are new commits in them (for that there is a
test).

This patch has already merged, so if you can do the fixups in a
followup I'd appreciate (you can probably go over the entire document
and check for consistency).

Alex

