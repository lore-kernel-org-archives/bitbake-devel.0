Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224CAEE49A4
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 20:16:32 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.43882.1694376982767750520
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 13:16:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=ks4cPiSv;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bcda0aaf47so58441351fa.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694376980; x=1694981780; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4rhGzz8+2/cGHoWrxMXtNGhvzEF2OM4FJIqUi/o1Dhs=;
        b=ks4cPiSvhZukOiuxtIbSy0iEqzmTCZHr+KgU0R/u7+yF5fo/0nnySn1fPIXt92dL73
         OlSxosGrdLpC5zN4U2V2a6YtiCncjePcEuf2CTAVXEa8rbQKyqlTKKAOwgcviwm2mRv2
         FZgYgk7qr7r00OClVm7h38qz2VyyXbYymxlLK5yxwzCwo/MtthFtFIkladBtWZ0s/7hv
         RibIVXtjwBddVJsd4lrPd6s3YkBf/LdUzgJru3uL6IvcaAo7t00j6QKFQTT5LeMyfSMd
         OupW6xHSjMfz7luL0HyTEhtHHCho2LxceNFOfcyiOgDp5Yh9rzkLf195JwB6cdrgAiOG
         8jEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694376980; x=1694981780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rhGzz8+2/cGHoWrxMXtNGhvzEF2OM4FJIqUi/o1Dhs=;
        b=EispY08dYX3SxHoIZ3a2ZeF+LCt649/9mJJ6PkmMUINJjCDki4LYORde59luvXr227
         MDM3kzGrB7CTduc6aIA9jONADXekf0cNGl057bslUoWPe01i9A0xYcT8PpVBg5dmB1V9
         nxUoLcKstNgC3cFxitjsGfWGbf3BngyEQCCLT0kFHekejQ6bU9AoxOsJTqH9rpFsjRyu
         OTcwMTgZ9DTAWz1h9wTzpuNVavBZomim55r9x2ZV3RvC0HfiIecSQjd6n5Sdnh17VCNt
         NNADcVrinajPFVf3xy0a3lyfUnXxPuiQJayRefNXa/XmHx162Zj1c2ZVpg7FMY0R/DD2
         xEFw==
X-Gm-Message-State: AOJu0YzL6WXTxvEfVClp8AcgcYxB3+EDJwZlfhLCDZIovI7jBuNWvplD
	Ecp0soTFWFrmzDl/HDn2olcq9HsmFldcNvaGlog=
X-Google-Smtp-Source: AGHT+IHnaUD7BOGvaxswY0unPleHSElkUExy0y6j4PRGGUD6uyIJ/gyktqCGMFQj15+WeGk0FWgTe21vx8mylglkoYA=
X-Received: by 2002:a05:6512:318c:b0:501:bf37:1fb3 with SMTP id
 i12-20020a056512318c00b00501bf371fb3mr3785945lfe.24.1694376980190; Sun, 10
 Sep 2023 13:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230910194648.942409-2-rs@ti.com> <CANNYZj9innMGasLvCuZBEvB8Cr65AwRW+wyRK_mUaU8MOmJjQA@mail.gmail.com>
 <208a2844-9ee3-4e51-afb1-5de1255bfac4@ti.com>
In-Reply-To: <208a2844-9ee3-4e51-afb1-5de1255bfac4@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 10 Sep 2023 22:16:08 +0200
Message-ID: <CANNYZj8BVr0RRiWZ+ssOTwEeLq6sJ3tqe7Db7cLomZ5mjdXzwQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2] bitbake-worker: remove the network flag
To: Randolph Sapp <rs@ti.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	denis@denix.org, reatmon@ti.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 20:16:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15027

On Sun, 10 Sept 2023 at 22:11, Randolph Sapp <rs@ti.com> wrote:
> Seems like people like the current behavior though. That's fine. I just
> think this should be documented somewhere if that's the case. I can
> submit a patch for that documentation update instead, if that's preferred.

I've briefly looked at meta-flutter meanwhile. It's generally full of
horrible things such as AUTOREV, and does abuse the network flag, but
the issue is it's a badly written layer, and so you should take it up
with the layer maintainer:
https://github.com/jwinarske
https://github.com/meta-flutter/meta-flutter/issues/new

Go recipes (not sure which ones because I didn't find any in meta-oe
master but nvm) need to be fixed in the same way we fixed rust
recipes: by listing all items in SRC_URI, and having tooling in place
to update the list automatically from source trees. Patches welcome.

icecc is probably okay, as that's the kind of thing generally
accessible without having to go through a proxy.

Alex

