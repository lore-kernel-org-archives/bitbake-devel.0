Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887DDCCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 17:49:15 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2713.1762796946784455177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Nov 2025 09:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AzZfmPML;
 spf=pass (domain: gmail.com, ip: 209.85.128.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787eb2d8663so162737b3.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Nov 2025 09:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762796946; x=1763401746; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7phV5vJ/zm9GzEuSZZONPmwsbj5R0TUKCV4jnT3XqhM=;
        b=AzZfmPML9Ep4crRx87OW5OQtqrZw4MJa0mppC7Qppe54ntq2lrZKzMCjpmE9UNtj/X
         sdGjAmX9cF1MNL8iWiUgEA6m+MLcAuqHWkD7Pi6mUczGyt0/II8BMmWROXNE4m0SLRIG
         KKZ5e0p9rHd+++cu/RE1oKhcOz6X+7lIMW7zJ9+ANUEq6kUpJ51c8wFvvzVMQiU1Brv3
         aL9i4Oq4HXNhr2L/x3YIRtqcmtuMLmpAfQUL74aXd4NNpXGSJn/NNio+12sLvAa1oT/Q
         nGwl5/n3Pr4gmKkxVFqx/acNrD2w0Q0n0YuV/UPhRif9u8jVsvqgcQDbfWAa0JAHHbCm
         /Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796946; x=1763401746;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7phV5vJ/zm9GzEuSZZONPmwsbj5R0TUKCV4jnT3XqhM=;
        b=FPf0HnxC9TKjleAJazu1CMc6sdR/4/KqE4qew9mPckRJoqWJhQdeAtM/7LoS4kMiGB
         ETG2wGcFfWXkMN4NB1/PuT164NTC7ho9mPzxHV7EJR+PkUWwAH0f1HetcX8GBwuuUnBU
         kpYfJcdu4g6/APPbfZ+0t7SpY74Aer63tMhxZMIDeISJA0XMEn/WfY3VDHxWwNcQXG/V
         H0AyHabpvTFpWpaKWOA31eWtOVdZ7VpQEhn7HxnIy2B5a8vsORf3lUN8yfyc+vuxw91m
         3EUzv1z6ZqYyvRgzEBQHqsbpCvfnU917Jbl9A5PrAZjwYCpV4mr9jJYl1at93GM5ycuS
         h9Ag==
X-Gm-Message-State: AOJu0YzUva/X9rdKYFDaiBq2zANoUufF2eOE3f/VPbCnRzW1uHGmqtOP
	TC889kGGtsTLD9b4rIbFdeN7AjOKmh3XpYB/bOuixr+O53MakL1bUZryeGJ/5rat/Gw/vx77QZ7
	cSLH2VsJV+lKGVpOH4oPX1sizlzERA+xflH9K
X-Gm-Gg: ASbGncsUtfHUxlqoy1OnO0f73VBzKuWJUfUif1EMNXa/R2zC+Fx/AQ2dqRH2bCtR6Yf
	v83c8tI56OccaKzM49N+uZHt20EyXZ7JO9ObGaGk5Sg7yHgz6y5elPRNtFd61rfToY/cuzXVJ3s
	ZWRnibtPcJs2NoJXyafjCBVl92N1L39/8Ibn8gZb4XcqqhsQzN+M0oHRad3gyEpe6k4uXxgmzEp
	s1cHssUcytnsqkkSEKagELtyLGcQZbsjJDR73HMp2h7kMn2ZAcr4QHL2leUWjq9v0oJGkL50LVi
	AnwwDxBrldkUtyAH4Dcc
X-Google-Smtp-Source: AGHT+IFjNQoFInZjb5h8GPPYwMYc06+yiAnCGDR1vwP4Bjx6fBkKVE9nE86Wu0P+fyZgnVgZBuQHze/So2qSUfSjtSI=
X-Received: by 2002:a05:690c:630e:b0:785:be06:1d54 with SMTP id
 00721157ae682-7880361bf2cmr2012527b3.18.1762796945796; Mon, 10 Nov 2025
 09:49:05 -0800 (PST)
MIME-Version: 1.0
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 10 Nov 2025 10:48:54 -0700
X-Gm-Features: AWmQ_bnLNCCNMVKT_KoByD-TdHGjQZiXn91O3hI5zfITA7RtD6LPQWgFjjRhq98
Message-ID: <CAJdd5GZAzk8DS1UUsOjr0QbOpkpU7XvXCb-9kforSRv0MZ65FA@mail.gmail.com>
Subject: bitbake-setup topdir setting
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Nov 2025 17:49:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18317

I was playing around with bitbake-setup and I encountered a particular
UX  problem that should be sorted out. In particular, I wanted to
change the top directory prefix for bitbake-setup, so I ran the
command:

    bitbake-setup settings set default top-dir-prefix /my/prefix

This end up being a bad idea, because after this, `bitbake-setup
settings list` kept assuring me that top-dir-prefix was /my/prefix,
but whenever I ran a command it would continue to use the default
top-dir-prefix, much to my confusion. I eventually realized that I
need to do:

    bitbake-setup settings set --global default top-dir-prefix /my/prefix

in order for this to work as I would like. Based on my understanding,
I don't think that there is a legitimate use case for setting the
top-dir-prefix (and top-dir) in any context other than the global
configuration file. Since this isn't really a valid option, and it's
pretty confusing if you do the wrong thing, the tool should error if
the user tries to set these options in any context other than the
global one.

Joshua Watt

