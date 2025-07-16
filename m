Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF64CC83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 08:37:54 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.17301.1752655067039237022
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 01:37:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dD3WE4Ol;
 spf=pass (domain: gmail.com, ip: 209.85.219.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7048d8fec46so7552236d6.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 01:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752655066; x=1753259866; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/cRmCqeRV8DIyMZuvjO7dxSwnbX38/+FYX/uTS4pEc=;
        b=dD3WE4Ol5PunPjeIj/F89cCdpLEA9q74L/6lH2HgGMWviQivZfEpF5qYQ7XamLO+uB
         8pvE+A6Exijxd2hERY2S8JhLvhFoAr8jdlm4KojNokpTsU7cZStQZ1xgqvsQB2GAE01J
         RjtKayTZJDJ7JKkppkK7UMsOhGC6Zqh6f33hyiyVXoYLyZmcCDAsNzALQdxbLdUZAiHs
         suWozJ6hgoiGKheoOrPorhN36EmtFE7RjDo+bw+GdABrHq/D57GFmciZvqhboLulVi1h
         msNG1OgVvDeffJzjanaHEndHrTbkKmQrmEG1zkWybHt4MBSDA70XP1g/0hqQVbSRJxSe
         Q6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655066; x=1753259866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/cRmCqeRV8DIyMZuvjO7dxSwnbX38/+FYX/uTS4pEc=;
        b=VdYcXmqfeprSu59HqyaRGOy71A0SGUWqCfjT6YbhF0k0QsKMuSpjODO8bShUwcRQZd
         9quxYdQ+zMQixAOxIAoTWGO5E32Ljttd1nyaWlLv7sUeHYZrwUKa0DHIFTmlQ1lVghHU
         RC76ZHGgUCeFFNxQqyFP4uOnScBhXe15eaQRBPc8tnI76mwUQcHWWyAKOTQh1VyOH+Yy
         HQwmlRrCG88VdUBS1h5qAYOgXx1lGp6J2WSbrB/AcXR/fEMy7RUFEk76GTAZH15t9YU9
         4BZ4pLkiaizY1aFD3uwmOgbuFBSv9Mct6UwVSOiO8gP7WRTgfvpr4S+0+JtbXptwxFPZ
         EUPg==
X-Gm-Message-State: AOJu0Yyv0VyKmV60bMyQyTsxN5P5b6q48ro0IS+UIAU0NNFbeSyn14si
	hTx9n5LqAXLMidBlcEhVhs1JxXtbXgef7Tfyg9SDDKBYH/nwgEjXeaD+/9TdnQxoKoToPUiN/nL
	UInJx+E34ZYWiUErALGYjU3qEcVd9Au0=
X-Gm-Gg: ASbGnctFNe09XibbepRJQwhg6UNbs38Is0NR/j3Z/BiO9JeGYg0+ITbireJ+lanRCki
	OoLAy/eGCZxp86Ruu7nPygSKXeKpO3whc6ZnmmgLP1hxQ+iKYDYvbvs2xz5ZxPizvZdbcuqNblU
	QGuDVO9QomZC+1PGVFB0pUuACNEza1keN1DV0R4GMw8u458XBM0yWMIRGuCdbHkP98LvL7s09ic
	c53pxBgSihYzNsH/gxAzs4hVZHJQy89TRAnfAiU
X-Google-Smtp-Source: AGHT+IEHziNda11p6WPT1bFLecYYA9WlDqB87IKiYu7GHrwayzeGnabGJTJwhfwPpI9dkU6wmphwixHPPjhiS04gwBM=
X-Received: by 2002:a05:6214:e82:b0:704:a92c:2c10 with SMTP id
 6a1803df08f44-704f523212emr33421896d6.2.1752655066030; Wed, 16 Jul 2025
 01:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250708124711.3541367-1-martin.jansa@gmail.com>
 <CANNYZj8zpTF-hs2inMOcJ0mJnYKCijgD0VopeP4-_F0NM6rG1g@mail.gmail.com> <CA+chaQfrXL8dcSMvprRGUC-X5BGsTBCQyoYQKdoD1q0-K5EGVw@mail.gmail.com>
In-Reply-To: <CA+chaQfrXL8dcSMvprRGUC-X5BGsTBCQyoYQKdoD1q0-K5EGVw@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 16 Jul 2025 10:37:36 +0200
X-Gm-Features: Ac12FXxEHrjPcT_lphN1-2YtySDJZnhivzgiAvjSMpZ2rWH-MRvQF24XGBNhQss
Message-ID: <CANNYZj82mZdmfi839jKZdd3dibPGvdEao0wj0BoYQ4HHYWaVoA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: zstd: use --force to allow
 decompressing symlinks
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:37:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17776

On Wed, 16 Jul 2025 at 10:16, Martin Jansa <martin.jansa@gmail.com> wrote:
> So we're not going to fix the known issue, because there could be
> unknown potential issues?

That's not what I said. I said we should seek a better solution than this.

A patch to add --follow-symlinks, submitted upstream to zstd, would be
much better received. Or some way to avoid having symlinks in the
first place.

Alex

