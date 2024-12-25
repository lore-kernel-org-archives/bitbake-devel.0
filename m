Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF52E7718B
	for <webhook@archiver.kernel.org>; Wed, 25 Dec 2024 15:17:45 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.8422.1735139860436250952
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Dec 2024 07:17:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g1/XQpEY;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d896be3992so33018306d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 25 Dec 2024 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735139859; x=1735744659; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgv4EO2znCICRjDv/EMOjzgP3l0pVyq98o/V0uLikJA=;
        b=g1/XQpEY64prCAmcyBHlNnS0DGAq+tBITKQuqu5f6LwPM1qUGWnR9lSflz2R9Y5g1Y
         jKv3Q9laQOGMkmdqOCJYViX/xXpFMGqy1nIJ0R3eYCgcqRjWFZg5aR+P+vTE/7aK4r3w
         ZaVYpXSGPBQevWIdu5MSx8qebWN4ZUvr4a9VZEBXSA58W+STyKUPF4tirCP39ij5YMgR
         +DF/yU1466f49fmgGnp4F0UenBu13ad19+IN0+kpATmHAWjDKx+7qpn4bRGxGjKqx4YB
         k3Hd/okpUtW3F1jB6ahUBtx2C/m5cUe2TjaKv0vRAGL5heCd9VlTygZNZbMVBTWDZe2G
         9NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735139859; x=1735744659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgv4EO2znCICRjDv/EMOjzgP3l0pVyq98o/V0uLikJA=;
        b=d/dvvk7l8V7FLuY7+lcVGHaYvhyELT0E3Hb9y6ViXOlx6JqaGI2OjoUQxhjmHAHAvk
         Mz4Xb6X4fSNVsMlv0uhLKbIucUbmmk6UIN02jLx/3H/eainpRwqcf5j4ffyHS/vncuSw
         Ku+DJKj4P10QPlOXIAEJmFJQCK+WewrHSDXYRS4ksBw/sqsYKUcetft6qmHLwmUCMMMM
         4DQs4jEbPtKbn4kLi/z1M+LmOs8muhEqmIXicmoz7QUNLQ/gnqm4fntjPj5txE6XbO6g
         bZCTKYpNd/o1BmyItXinzuxpwnaROG/tGOEIxfX9A7BwQ5WrgtVnMX2HFdWrHhPbLOs3
         Basg==
X-Forwarded-Encrypted: i=1; AJvYcCXqOscPMIoMBeOu3YZtIXNKId9LakZfg1eh62t5w+6SSAXpH8OQA7Lkg9CYFKMTDYJI1qL7kcpj8QHPL6Z8@lists.openembedded.org
X-Gm-Message-State: AOJu0YzBpOoBjzl5ZXTcCjs6MivquRH7CDlsa77rZKJ8tN5ohMxVlTIM
	B5Vt+VxWz3n4xwMM7QruZH412qlgJ1o7QgAhBgDX/1XKCJoWcmGtTj5RUlnFDTfV2IkOeoeMYjr
	s/Z37TGc4B7DWJZi5tKkV4rBxNNw=
X-Gm-Gg: ASbGnct2+m45v+19uOw6DLww6QQE5ot9jdVNlqf9XIIxOg3wd6fb28xISQX8ka1bK+F
	OuYBrZu7BlYuHt/vOQGLVEE0Ze7WdF34RkR53bZ6UUv9DzrRuALN69oLNwjD7qzXuzeQ4Adty
X-Google-Smtp-Source: AGHT+IHl219OudZvtkGSd4zLQLti+1LbXImhHRjHRzgMVMVcxXH6b4i1s6AmXMb9ydvDt7SrPTaNb8TqREzsFuJ7g/Q=
X-Received: by 2002:a05:6214:202d:b0:6d8:ab7e:e552 with SMTP id
 6a1803df08f44-6dd23397311mr378924766d6.39.1735139859551; Wed, 25 Dec 2024
 07:17:39 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
In-Reply-To: <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 25 Dec 2024 16:17:28 +0100
Message-ID: <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: richard.purdie@linuxfoundation.org
Cc: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Dec 2024 15:17:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16948

On Mon, 23 Dec 2024 at 11:03, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
> Would you be able to check if this work meets the criteria set out
> there and if not, what the differences are?

I'd also add that this would benefit from a demonstration with one of
the real recipes go/rust recipes in oe-core: basically it would be
good to push a branch of poky somewhere public, and provide
instructions on how to see the new fetchers in action, and observe
their benefits.

Alex

