Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0934E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:07:30 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.web10.22521.1736525246289512895
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 08:07:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I8CVImqT;
 spf=pass (domain: gmail.com, ip: 209.85.222.171, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so293712685a.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736525245; x=1737130045; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAlru+87w4ns6CTTuvtd0kBYJvP/7O6lG7VfDvGZqxg=;
        b=I8CVImqTA3J0BqaDtEhykgC62kUvxISY6E3IoAge68su4T4M8akkUhxD73B2oFgDWP
         nNP9VRyXidX2spL+dl3HFW5gtYdmP4hFiuuBI5FC3ZONh1fxruoIJ3SZDKLlVD0RW/GE
         aJmK4YALD4HibKWAyaSKRT7okzavo1CDv7ILhehc7zo0ZVIBitVy3l/1dANnDItCvaNd
         EbAqKAzR1NUqVYAukE4azChJMIUrQv/11yymaR/KgMiLSd7KKWsLmlKmATZAFEoC9OmX
         gLgdAvnH4008qu1qWLUe/w01E8aBqKJ5amDrovqcoXnkJg9OA2bFCz2qzlNNmpEedvSy
         ZTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525245; x=1737130045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAlru+87w4ns6CTTuvtd0kBYJvP/7O6lG7VfDvGZqxg=;
        b=ELoI8/h+oZCS4TToNDAfT/Q2/CDDl9IaqB542u5zdaSRA2zv1Em8d02AGuV1zQ4Z4V
         6oFgG/qnpZ2YDXa71IQ5WAlab9NWIPSsx9fNEd3ps9A0AreJP27AxAZGWI5OO5Yycn9q
         RpvEubr/xfDtHALyxPmYW8i01JxSvCwa98CMtYB3OfLowm0McnUDeB5fpKTPG//JBHP3
         St7FIqpQX0y+s3EMKVQW0qFcM8orhM8qhxNLzHLn2hgD/+3fuv4YaWed5FLqKrb+4N6F
         UTFb/XR0RvB6bQBTPr5Ot9FSRNmlmzQm60hLOpinTHUTVm1GUoilk7DF6aROHYK7PuOY
         VdFw==
X-Forwarded-Encrypted: i=1; AJvYcCVI9rYdbJ1x8nkrG1mw0rAB/PSB2qDZXIKD3s2CWDRayojNzSkloaCNAevWW4L4A1AxA0fV2ONpWq4aifU/@lists.openembedded.org
X-Gm-Message-State: AOJu0YwMAruCowLj1LbJkgw6E847Ab0WSS23OesC8e87jRA9nfqqPJ+g
	nGnmQHZBqnqTxuBF3PTl6MQviFVfYaiK3NClMNBoLnagN9PB7iUy3S1wUx3WzcKSn9b7rowOtrq
	AUtEp8ZoFDCnAz2VM2pSF6b2qUR1d2A==
X-Gm-Gg: ASbGnctd2hIZAD9pHqyYKSlNiEwdE1KgepdOwmTrXomV/xAmRSwemQPfahblWxZoy2b
	FdnQcTniRLbGJ4R3axrmDH42nadt1HapzcT2ADE5J3cXpg5XdzXZiI3aSjdaS0OzG3418PLLt
X-Google-Smtp-Source: AGHT+IGV99ByFA9Il1ZtqVwMgPTipdZZllDe0pYhKIfqqrYQhLBwBIf18a3Q+P2vO1r99RCbrxzLYTCMs9Er11Pvw/Q=
X-Received: by 2002:a05:620a:4556:b0:7b6:dc74:82a8 with SMTP id
 af79cd13be357-7bcd9729af4mr1652855685a.9.1736525245267; Fri, 10 Jan 2025
 08:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com> <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com> <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
 <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com>
In-Reply-To: <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 10 Jan 2025 17:07:13 +0100
X-Gm-Features: AbW1kvYwVS9NXVXJyW4L__4MmQrGAb0hC_mghwJvcpNVE8kymKWCUoOLFv82mXg
Message-ID: <CANNYZj9s4JpEYH60vjEBPFR6YtU-0Gv4tjt6aHejQ7osLOz1bQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 16:07:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17007

On Fri, 10 Jan 2025 at 16:04, Stefan Herbrechtsmeier
<stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
> What is your opinion regarding gitsm. Should we remove the bitbake fetcher and use a update task to generate a inc file with the source uris and source revisions?
>
> That ship has sailed. We can't remove gitsm, it has users, and they
> will be very angry.
>
> This makes it impossible to fix wrong design decision or remove code with a low code quality.

It's still possible, you just can't be heavy-handed and dictatorial
about 'removing' stuff you don't like. When the existing thing works
very well for a lot of people (and gitsm does), then the new thing has
to be obviously better, you need to do your best to convince as many
people as possible of that, and it needs to co-exist with the old
thing, so that users can migrate at their own pace. And some of the
users may never do that, and they will get annoyed at or ignore
deprecation warnings or similar attempts to push them.

> Instead of an inc file the generated SRC_URIs could be saved inside the work directory of the recipe. This will eliminate the noise and avoid a manual run of an update task after a recipe changes.

I would be very interested to see the proof of concept that does this.

> Nevertheless I will move my implementation to oe-core and add a task to generate an inc file as starting point.
>
> That would be much appreciated. The more I think about it the more I'm
> convinced we should have it standardized in core.
>
> What do you mean by standardized?

Standardized handling of embedded dependencies, lock files and various
other aspects of language-specific package managers, so that adding
support for a new thing would be writing a new
extension/plugin/subclass for the existing framework.

Alex

