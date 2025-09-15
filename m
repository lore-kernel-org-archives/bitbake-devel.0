Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54475CAC58E
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 09:57:16 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web11.28932.1757930230288422393
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 02:57:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mskZpZnC;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-782ba4488b8so8248106d6.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757930229; x=1758535029; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8HQzNTFlEBA9ntrnSbSRp7g4OSw1JRnKw5ofaJTO+w=;
        b=mskZpZnCzHsu3H0OgZOaG5dKqJt41obxgzodonsSPAB6NQVfCT27Nrjh4Cnh0ZANVt
         kwJJ3zheJwtg2sOCksOM1V6sKGlI1kEOtLGKPok5cQZJeLXI0u1z0lg/q0F+Dx2whP3c
         BUIV2bnr3VYTifvqdqNLSEqRb6kmKa6fY+WgcI84i1I3C4fg1VwlMPcf4nioYuGrGLTd
         /B2HqmvqIFiYL16uPmgX9seuEKAb8sNTxJBxeh+ScoNxyQRzUS7is06LctV8C6Zjd9yr
         t69HvLrdOfhnQ1LelStgvUY6Zqv83FvSxL1ZOoKR58Yhc71R7OMXqkUL+om/obXNbHb3
         HSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757930229; x=1758535029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8HQzNTFlEBA9ntrnSbSRp7g4OSw1JRnKw5ofaJTO+w=;
        b=hneNdreprj0xER3FHpRal8Ey8GtMu6a9Z1qqc8rse61JGmP336wKohPUP/L0osnFS8
         TD0Xgogrshn16UhNt1dxfy/8+46SMTEBoIwQbJlmyync5ICgQR4yFawOX2PVUcvbQinv
         2Lyb7rDg6tJ/ir0tQASbevBzVdQJP+ze/tJpoW6ENWMMeE9hdjNFIhos8p/FNlhmA6TU
         mFxcACOX2G801IoA9u8fs58HS8S5suMHOBbgv0XFoP4dmuaZlSlPwAxALBzu93qdAtDS
         0Oz+JuvEEHeGO8dPYr4DzTNXxMHj3XqFjMQdKPsWHyATy7N9DE77Un4/vopjuqpTOCwQ
         DLpw==
X-Gm-Message-State: AOJu0YwhmcDkyDmJLPtoeP3kdxkgzb6RPlHisueNMt85Sr2FNPP0KyHQ
	DKD6/nd01ANrY7OJ2gzxpzz2OZctHGLsUmwPUZPIBGjauqZtoP5zS/6VjuYJwv6s/jrVLdxjgaJ
	OdVPaSd2yTIIAYH3Z03hHqkows4nlwqc=
X-Gm-Gg: ASbGnct+b7tEPsbd+9jRlGI42SOc9PW4vBWbOA7ZJQ8TkyLENYuDuCOaoqLdRP3BlDi
	+wQgPy4X17r139yrHT/VIYpsPHwpsFcixmkRI3MB4w6TQ6JTdqPAAMS3LPkS8GsgsVNvvUd4QOB
	mWcUOp9kdI9gIm6C6C7GWexnJZqPA0Q34JX6RmIByMfrJzDhKMZ/FEwSNbLf/zPaXS/Si5gfCBp
	D+1HgFCqBoGS/lcgOA6anklhpOQCLwWgp5hOzuIzeZak0WBzSJa+4frbHapXp65x6q5APmJ6wml
	UQV1
X-Google-Smtp-Source: AGHT+IGvRiWZXpMhHV9HmYiD/D4/z+L6SHPtuWyu0xk7F8OcZD0hk8Xl/SR3CVL+yik6JZSXO9IxaVSnwxEIdnNQZKQ=
X-Received: by 2002:a05:6214:43c4:b0:779:e6e:e384 with SMTP id
 6a1803df08f44-7790e8d6a4dmr68594666d6.62.1757930229197; Mon, 15 Sep 2025
 02:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250912204559.10360-1-reatmon@ti.com> <20250912204559.10360-3-reatmon@ti.com>
In-Reply-To: <20250912204559.10360-3-reatmon@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Sep 2025 11:56:58 +0200
X-Gm-Features: AS18NWCWtv_LTduAS6nR5mfYdytyg37pu4PFL4Vs51O_LaV13bjNzBN5bLql5xI
Message-ID: <CANNYZj--Ujc4S6Tzi1TVOWMFd_0C8sRxoi1HCbiVY9VfCS7n7w@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][PATCH 3/3] bitbake-setup: Add
 --build-dir-style to init
To: reatmon@ti.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 09:57:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18021

On Fri, 12 Sept 2025 at 22:46, Ryan Eatmon via lists.openembedded.org
<reatmon=ti.com@lists.openembedded.org> wrote:
>
> To allow for user control over the name of the build directory, add a
> new command line argument to the init function that allows you to choose
> from a list of options:
>
> flat    - <config>-<opt1>-<opt2>-...-<optn>
> hier    - <config>/<opt1>/<opt2>/.../<optn>
> config  - <config>
> options - <opt1>-<opt2>-...-<optn>
>
> Where the <opt#> is the sequence of option choices configured in the
> json file.

I'm afraid it's not quite this simple for the hier option. There are
places elsewhere in code that potentially assume a flat hierarchy
(e.g. site.conf linkage, finding where the top dir is etc.), so this
does need at least a bit of testing via the bitbake-setup test added
to bitbake-selftest.

For the 'config' and 'options' styles, I'd just replace them with
explicit --build-dir-name=<name> option which will just let users
specify whatever they like.

Alex

