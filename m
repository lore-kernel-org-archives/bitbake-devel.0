Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837EDCAC5BB
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 06:40:34 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.3133.1760078432432207027
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 23:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=a9TwAFKm;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4dffec0f15aso17741671cf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 23:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760078431; x=1760683231; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP4WZ6ooiA4XR1NmxTatLcZ4v3/cDctdNyOHYg6o9OQ=;
        b=a9TwAFKmcY1t4PFv1n6I6bUHkx7KqvyiY4m4W8sD/IanD4BntStL1eh1emHSv2phqw
         guXDSaoTA415a8IsWrOKSoe3y4VGcZU9a6g5rJ6RIIrdET0Kbf1QVT4hWYIhvjzSivq/
         LIZgX0GM2f2NfWbBojur5XBRtIuttTGuuFOgt2P7Ljr+5yzjwSEo1+11ytMc+b2zQ/g2
         ZNgzroTh0tCXBe1xE283zZo4WSIbL3fA/doghHfPoQgx/VGVs8gfX5VV9SoNyndkDPw6
         wnyIZSh83DiyXaRM1YH7S/IVCfIwMulU2i0E2Go4zMdjbk4KmQEna0EDa5xqLZV9MLBC
         sETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760078431; x=1760683231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZP4WZ6ooiA4XR1NmxTatLcZ4v3/cDctdNyOHYg6o9OQ=;
        b=MLiU8HtAJDlpE1JkkkKiKsNcxUuGPEaROEUofXMA9gqVSHUAWxbQZaGezTpf0YNaE7
         KIlBnGXn4p0XrbPa4Mw8Chlrzv6GviNh1YvlS16x1SYG7/7LLMAc9V7yMjiDmJFT6M6W
         jJyVCwINt4/T3otoOdWDVyCDMkEJEGbqnx/SEUbzVXTs7cpVxaPISDFMTu3WMeTmpQ4r
         nl94FnOfWU/YfmajaDyS/AXOmPhFi0x6p05iYxxW5qob53mKOkTA9JjrrWfglCCtom09
         Gw7BuZ38MMN3Tbt2TEz1p0w7wr3xD9UUc64WmMihGsRRJkMFMl+OEwVEkefO5Qg1ZytC
         BT7w==
X-Gm-Message-State: AOJu0YwfMCMJX94dbZ46obUDT5K3j771dl+bKwNflxwDWQcaIt5bTOyS
	lTA7wdsXIAyxcy8jKKZfkp8aLtEapSM/GXuVUcZzYooPFf2K8sGcc8xJqwSvc7aQ89enWZtECFm
	vSDxW/86wa1GZg4SSW5Y1qTRT6trMrRs=
X-Gm-Gg: ASbGncuKfPUZKDg17d+11Xq1jF/SFwgrSpVcuN+TmGSxxDi7XGfo13vb6biCQNpiDIx
	6gHrTJCtAMWesRkiHDDpRRFpCVQaLHrEXLr39VjO0P/HnYwL47TV1AemjqIiKHiwlUAajhdnpvH
	6Vd0Be0E+PZWL8huAGHwONqrpcXibwHSfRWffgSe0hYHxVDSMssUuk2vshg011aMqs1EABk6ENN
	XYDfI7kzkKQwP9y6QBYdc2p7fTiAU2lv5pB0uN3Q40n/LkNCLwR+b+flGdEu1WNXrLZkvQxOqUX
	c9eSJGwkfwbTUAEXM1mNtWo4UhUa/AqiApYHcw1+7EbyRisJJvX9j4dSPfU=
X-Google-Smtp-Source: AGHT+IG94Av05PfM8IJcObZOcU989ih7HfKf0WNoARa+IHj3jDFxR3sQVNqab8209w5CQKdx8dLqTPRcpffiZMP5arw=
X-Received: by 2002:a05:622a:4c1b:b0:4b5:e7c3:1dee with SMTP id
 d75a77b69052e-4e6ead54342mr136497391cf.47.1760078431438; Thu, 09 Oct 2025
 23:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251009223552.2648331-1-yoann.congal@smile.fr>
In-Reply-To: <20251009223552.2648331-1-yoann.congal@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 10 Oct 2025 08:40:19 +0200
X-Gm-Features: AS18NWDnULbic2LC2yH0w9MdxP-TWCBcL80xaT9mKKe9pQInGQbjYsUETIEmyWE
Message-ID: <CANNYZj9JJ+tP68X9pLyie5a1xh7+3VMUui142eV50Rc_doR81Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] ast: Warn on multiple builtin config
 fragments for the same variable
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 06:40:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18162

On Fri, 10 Oct 2025 at 00:36, Yoann Congal via lists.openembedded.org
<yoann.congal=smile.fr@lists.openembedded.org> wrote:
> +            if len(builtin_fragments_list) > 1:
> +                bb.warn(
> +                    ("%s has multiple builtin fragments for %s: %s. "
> +                     "This is not supported but build will continue using the last value.")

I think the message should be:

"Multiple builtin fragments are enabled for %s via variable %s: %s. "
"This likely points to a mis-configuration in the metadata, as only
one of them should be set. The build will use the last value."

Alex

