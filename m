Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F026DCF65CB
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:48:45 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16289.1769420919194002712
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 01:48:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gegpq3q6;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6b16bd040so494213985a.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 01:48:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769420918; cv=none;
        d=google.com; s=arc-20240605;
        b=Zfel5SlauSM7TRXEhmjb5eRIee5qE5nieSFHDPeBBjFdm9mRZHX6psJgVlMzZ9/6t8
         COogAPCwHYnODqU9MP5rVdox1/XifBMt3V5XR+16vdSJnP83Na1vt+Xld3LtEOjGQMa5
         9iZswvmzySChtP2n1I4W+AiSeBK0U2WPuz3kismonfhppaQLQhmltmZ+YHUb/6h7HK8p
         3u/riKtk5NWgeLv15HVgZLkni3ipIrWxfgejtTOjRb+WxH/YoChVahcHQEIJbtwS7Yz6
         cwA03cgMRqkSoehfWIWr4j0u7pnObSl8ak8li8XrLOH2Pbu/TY9JVwUjTXFAgTrgD2VF
         mq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yhqqxXt9fY286umIMGacNPfJbUPhOiiLrnW0XackTS0=;
        fh=CXP6ezNhZ2dwV30j1TErAxvqUUUhI3me3DSdqP20/oA=;
        b=IDDRrus48ah9H822Ra20EWkUgVxpRQBdjoH43p5U8zohEiIY0SBJBzFMgWDbQjHlWE
         rLjxwW9+iDVimaW3T/mpC8iZ8QVlDo4ukQerZC8+rJWHxtreXaqW8R1bIsN7yGIeWsgP
         nuddtrNfZ2rK22WvRqA5uyYheWTr2fWixpBAl5jTjgE2cuJss9kFV/QGNsi6tfIOuC7C
         BkH9vuaIi348oIDyVG7q/jbLurK9Qonn1zcGneWGOJ9dxcJsiijPj0cTWqpKKGq/TufA
         M6iEq/S8i4YykMOuclRpD/qdH56jGtE5o6FNaH+BBXITLss0G02LuhwuHM7V89xp/sm0
         c7NA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420918; x=1770025718; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yhqqxXt9fY286umIMGacNPfJbUPhOiiLrnW0XackTS0=;
        b=Gegpq3q612zd5HmHBUh6MUrV3BPkf0Txs+rVPivge2olOvpBEO/DEmXmYuoAyuRxUm
         0CXK1b27M02J1aehRQLp1jnyFxyqPGtQ+P/m90nuyFbmV5+RJvfjrc1CqDr82MafQt6H
         w8szzcH5pgIriqFUqbj1wiO87p4IVEVIQ9xqZNxL6mZCm9zg9Go2STEkcJ3AqUQ3HoGW
         sLgdWRq5e+0zXW7SvtYRQC45acRqPNKxEOWmutpISrwF5kX4UGxBW8rez41h1I33FrVZ
         dpmBssN3/Awa93yCl8EcP0S4Qnefsx+vcNYg5/0091uc+zYNmaYdcQl8+YQLnDQ1zRpJ
         DGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420918; x=1770025718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhqqxXt9fY286umIMGacNPfJbUPhOiiLrnW0XackTS0=;
        b=eTcAPWVYusdS4VEurWANAZivCrtqplZ9Gt1vxJvRxlwtqUWQHX3/18g2czErfk0hAM
         arJ9pHoprXy6+HSKwuYAAgCy1e9CWao4DA/rA+X87lYwcHXdBFXFAoHReictEEYnHze3
         xYQcipCzpCs0aihv2mdjXDmbvtvUNn6lhBqmhK+/qayvOfJVHnES1goXN2lZGzC9jsRB
         Now9xngh9Rz4QZN8q4UdyjF9uhhj0M5FPq7lCgV9VVa76ahDkbSy4FQrVL9ZdqkVTo+U
         zCsnDmnsSonNyLyZhliZBkjAXbT70sOeU4EuUCI7TXliEG5TSQxVuutgXDw0K6Ukc4Dc
         3BxQ==
X-Gm-Message-State: AOJu0YzE738TQCXHfBknVxPu8Fmd3UGK3vhJURoMDxeuDBuE9VrgDktv
	cmY1+aqGzE0XI3wzCqp8RHWdcDFrsHqt0MWgbcaY0Yi2Hy28XLhW3E1OaorK1NZNKPip/yjwRJy
	FD1rTLnhgjNBdauyK18jZAwtHcwWEZNs=
X-Gm-Gg: AZuq6aLm3FHh6y9rA+XNA/gMnVRGqE4/mz3pk7F7tmcQPz7r94ubKILhf79qpnzGycH
	6Ogq3pcCWB61LGbz+prBUOj6jnssoTkhUuxuAc3zaH57pJ7PH1lPg5FeqYy4FGOYql8HZ+SdhlJ
	2hLIwpF8d7rFDVnHSMQQHJX0J/ynjrwswwY8GhmeS2s+OFs6Y2b3T/Zh6XJDm48HTLV/VAZLDte
	I4FSNUlJFL7+tN4m0ANFLH9ivnc5Puwwbz4WbE1v9QF9a3ndKtsTujJTavhVWThDYh03IXpmJR3
	TVY8gMTdDqpZXqNbZExZoNLRow0I4w==
X-Received: by 2002:a05:620a:c47:b0:8b2:eab0:629a with SMTP id
 af79cd13be357-8c6f966832dmr489460585a.70.1769420918122; Mon, 26 Jan 2026
 01:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20260123172422.3304682-1-corentin.guillevic@smile.fr> <20260123172422.3304682-3-corentin.guillevic@smile.fr>
In-Reply-To: <20260123172422.3304682-3-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 26 Jan 2026 10:48:27 +0100
X-Gm-Features: AZwV_QiDuUXbU0PXJBTMdgS3VQtFwF4fI9dUqLYgkfc7O6_56RBwMj_9Afm3UyY
Message-ID: <CANNYZj-pU7BHRsBYG+Zgrxqqk=Z57CxbTcfqtkPc4VSk-RqGHg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v6 3/4] bitbake-setup: use URI shortcut
 for all configurations
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 09:48:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18869

On Fri, 23 Jan 2026 at 18:24, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:
>  .../oe-nodistro-master.conf.json              | 18 +++-----------
>  .../oe-nodistro-whinlatter.conf.json          | 18 +++-----------
>  .../configurations/poky-master.conf.json      | 24 ++++---------------
>  .../configurations/poky-whinlatter.conf.json  | 24 ++++---------------

In v5 review I've asked to use the new format only in master configs,
and this wasn't done :-/

Alex

