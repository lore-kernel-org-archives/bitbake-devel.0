Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F42DC4167B
	for <webhook@archiver.kernel.org>; Fri,  1 Dec 2023 08:23:25 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.18444.1701418997349820658
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Dec 2023 00:23:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eKwsD97W;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a185fb3aa18so313934366b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 00:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418996; x=1702023796; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8bUZA4ts9D73mZhlQELDbH6vGtf0mlAmQ8yF1sUoXmM=;
        b=eKwsD97WLvTreXgH3eLHCsdlWRxAFsXJhyifvcYmO1OmoQU4EJQpI354cUTqeQbEMn
         OhyYE7p0wXpFIqihT6fbwIEiM3SH3wWZRXQMD6jhJJWPfsNYUb10EnUwNNcduQdquCH4
         qdKYJVz1oQz6plhD4Gp5jBhilunpE5mNTy7iDRQGNgPh7oaRqRjS2rI9QqWNUkObQl8L
         pm4wfEGGg2Wjuv/XA2dIny/j5LeoY4qh0yOf7wJKJlLYQPBBhz6b1ksK3x6TRHM8Gire
         WojBden7OegxA0hX5UYpi2Q/1fOxZVledx0AHQwTKzviz54ZEgNlzGRkAjUXwwuuOPpu
         cCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418996; x=1702023796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bUZA4ts9D73mZhlQELDbH6vGtf0mlAmQ8yF1sUoXmM=;
        b=kADjecu0e/Sm+BhIlSMUwtujoRMYGUKDgVEFvcWcBWTwLyGKflHg88F8J8+y/flAo5
         2o8yRjleqG8ipZnZBucuS+4NowG47J6o9h1mPvpRzQiJRaenRAdFlGGTXqyCWGSybNwc
         WrFQnGKtQts/c6TrWUxJnsRsEo9rbRuhUQetytWMoaTkvFFcyGvI+6M1lxQ85xuFGZIF
         oBk2URSm3IXNQZIH0/zvxAE9fHuvS9SVXytlIhwBLsGhV4NVkDjxHexHPlelIOfv+lUM
         z09ZCrdWCV3U5ksZsH5A9TP9ml5f4iw2pDys9IxC7mau5Na3QXPGMACzO9QheEDf+wHp
         q31Q==
X-Gm-Message-State: AOJu0YzSTAcweyP8suMRby7rTgZbhaYF+Zba039JWA/f39v/54Lqsi+W
	KJGdXGiUu0YV22ALUAmscng=
X-Google-Smtp-Source: AGHT+IGupOsAeqhB5WLXpZ9KKAcRee42c/FZ4NWYopP/rMLQ10/YTlydZtBr6Sg/aUMQ0g0CMU1NTA==
X-Received: by 2002:a17:906:714e:b0:a0e:3ba4:4eac with SMTP id z14-20020a170906714e00b00a0e3ba44eacmr1029072ejj.27.1701418995337;
        Fri, 01 Dec 2023 00:23:15 -0800 (PST)
Received: from ?IPv6:2a02:169:59a6:0:5488:f785:9061:cf6c? ([2a02:169:59a6:0:5488:f785:9061:cf6c])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906501000b009fc8233fb66sm1622130ejj.36.2023.12.01.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:23:14 -0800 (PST)
Message-ID: <d5f51dfcdb0a4eb377c80a7084c80d71977bf9aa.camel@gmail.com>
Subject: Re: [bitbake-devel] AUTOREV, PREMIRRORS and unavailable upstream
From: adrian.freihofer@gmail.com
To: jan.kiszka@siemens.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org, enrico.scholz@sigma-chemnitz.de
Date: Fri, 01 Dec 2023 09:23:13 +0100
In-Reply-To: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
References: <5628c725-4b70-4db0-8db6-254d344b1e70@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Dec 2023 08:23:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15595

Hi Jan

Recently there was also a discussion on IRC about this topic.

Bitbake evaluates the tags and AUTOREF at the time of parsing. This
means that if the Git server is not available, Bitbake can no longer
parse the recipes. This may look a little strange at first glance, but
there is a good reason for it. There have been open source projects
that have moved tags in their Git repositories. To handle this corner
case, bitbake has to resolve the tags on every run. Bitbake relies on
hashes, but not on tags.

My conclusion was to use only hashes for SRCREV. This solves a number
of issues:
- No denial of service attack on the Git servers when parsing
- Bitbake works offline
- Quicker parsing

Adrian


On Fri, 2023-12-01 at 12:16 +0800, Jan Kiszka via
lists.openembedded.org wrote:
> Hi all,
>=20
> this topic has been discussed already long time ago [1], but I don't
> find a conclusion that helps when the original server is unavailable
> (like github.com for me right now while staying in China). What is
> the
> right answer to this?
>=20
> Jan
>=20
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/72112230
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15594):
> https://lists.openembedded.org/g/bitbake-devel/message/15594
> Mute This Topic: https://lists.openembedded.org/mt/102909320/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


