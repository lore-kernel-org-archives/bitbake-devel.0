Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F559C9EC82
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 12:47:33 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32107.1768222052814904547
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Jan 2026 04:47:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NKo/Zd6o;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ee1a3ef624so38596151cf.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 04:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222052; x=1768826852; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Df3MmbOaYumXNQygaRxNvWEHmVq70vZxahjl+fhApQI=;
        b=NKo/Zd6oWovc1e3PDUxnkpcARWy8G/WxK/wbE4nI7Pih/Ahr6A1BDun9LP+MfnW84S
         e19LrfwPCgEbUUfwPTGH7jAb4QhRvVeOLFUJWkI8CbOjfSBLHD3n0NRaXWHc77A+yTqe
         EibkbEW0zDnUoItSVkIC+PDAdYGwMD0H76gB8FQpq1Qh8pD6RwjnUqTD9XPW5o/epcjF
         F+jq70KC3ogXLuSdYimfZxXLPYGON8ethGQapNzos6B35LKFc3hYgaab/v1FlppAFBtq
         buqBKAI63nrheGp855V9XCmuLAAJDibh1yxBI74TvfTsSCobL9P8RvMqfQ4892b/+JgU
         bD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222052; x=1768826852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df3MmbOaYumXNQygaRxNvWEHmVq70vZxahjl+fhApQI=;
        b=EQHuDKte86uPlxX20GLtLOzZfiSsRlMcUWnVOqhJnQdoLP6DAVK2LPM4o3TY9T1BDD
         izdTaxq7QQouMk3LyFiyAT1ITMcRKfVwA5Hh75qPRKnJAo5WffhG10EvUIq3wRW4pArX
         xGQt6kst8UeG4TBmRrH/0rDnzrdvD6BA3OehuZKtDgf/u23eCDv/oUh6Xm4nHiAJKloz
         90Wjh+aF7tlw7cdaSoFNo23OFYxvOjKbOqGn0KwV/03t2lkt+QwfPijmx7RFnUoJ19/Q
         gKi3mgjF0rmIuSXbGCGsoETpIcPp7cEFo6RSDKvjW0oR6rQaLzizLB8KYxW5Z18XWfHC
         AFmA==
X-Gm-Message-State: AOJu0YweF3GisHMGP8edWps8E/TU0uC+5X7fuhG9IOlrWwnTl8YP4PGl
	arkUezHe8jEOdWrQoxu3USjU0Rbz2bpDpTpiEwbzqr2f94mhNIaqRZ3eSkNfl3KW6p9uvyT/6gp
	J9wPHmTAczgzeM3IR96EoKLiJqIfMnHVmLaPh
X-Gm-Gg: AY/fxX4iKA+sH2dkOysfVrRwBtm6HmbJIWHt7fIr4hzjecmQ8UakQYdxhn9GU1voz5i
	mzAAe23O4Viuy/dzSpqaMbec1VLhvEdVmnjN+AdtOmyaRPmadV6tH4woY5xczWcJXbjy/FkiV2X
	wGssvmpC2P4Gb8aHm62qYyicV5/YuF/q7+rSZ+mIb0Ww49IDE5Ngs7gY8sXhGLFNuzSLVYt4t6E
	cR13HJ8FyEGwQ+j3CfaSfnC+kpmV6z5wDQ3F0PCbwDHZrRjG+EY2FuptxXd/t2noigFog==
X-Google-Smtp-Source: AGHT+IHW5fTAqx+KMsZqX+HdeMjAq/llI23+HZr6VHyHkKfveS5JBiuAAkNcmAqRDpzphHtJ1Edwf94zJjKiCW2sGVg=
X-Received: by 2002:ac8:7d48:0:b0:4ff:7efd:54f6 with SMTP id
 d75a77b69052e-4ffb48ffademr252800311cf.20.1768222051814; Mon, 12 Jan 2026
 04:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20251215145418.2680311-1-alex.kanavin@gmail.com>
 <20251215145418.2680311-2-alex.kanavin@gmail.com> <DF227D3UEFF6.E74AE0VVVWS5@bootlin.com>
In-Reply-To: <DF227D3UEFF6.E74AE0VVVWS5@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 12 Jan 2026 13:47:20 +0100
X-Gm-Features: AZwV_QhavwXrrbjVxO3hXqX08bAP4YxCtRpORPsMXuWvv1v-kCfXLH89ceLC6n4
Message-ID: <CANNYZj-k7KKSUquzBRs3kucvrpqFovz2zpWZtVE24BS1NWT9UA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 2/2] bitbake-setup: share sstate by
 default between builds
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Jan 2026 12:47:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18729

On Fri, 19 Dec 2025 at 09:44, Antonin Godard <antonin.godard@bootlin.com> wrote:
> Like DL_DIR, it would be nice to add a comment to explain what these variables
> do.
>
> Maybe needs some rework but something like this (adapted from poky's template
> files):

Thanks, I've added these.

> We would probably also need an sstate-dir setting, like dl-dir?

I'm not sure there's a use case for it. If someone wants to move it
out of bitbake-setup's top dir, and place it on a NFS mount, or do
some other custom sstate setup, they're better off switching off the
common-sstate setting, starting a hash server separately, and writing
the needed tweaks into site.conf manually.

I'll leave it out for now, but we can discuss further.

Alex

