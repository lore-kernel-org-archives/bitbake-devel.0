Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF49C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:34:02 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.43012.1694374440145023436
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:34:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=F5ceWAMb;
 spf=pass (domain: gmail.com, ip: 209.85.208.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2bbbda48904so62497461fa.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 12:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694374438; x=1694979238; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zokI0xUGRQ2PRoDJHFNv7BA5tbKL+sr/YV4Sntp4ZtY=;
        b=F5ceWAMbvhlbKhSQceRrzM+8KGnWMxoNjh6mQYozQe0t8dULubDwPn/sowyPV1RF4G
         A/wVyUft2dj6dk482RrdUAiUZmDggRrt2c4H+rru/Jws/Gj0c2I132T+Wsx5oIYN/xOs
         /2QQ5VSpvY7aoUcyY6RT+tLuILPMm5JgpTpsgc0eNFbKwSbPLEzltEaZanjIP52rkaaL
         O8KmiIsKil8aqn1IM+O+JJ/UA4BrCANAFGsWpvIbd24wrOVtbEZy64CFRXTW4g1ndDTw
         rr1SMd5c3ASPnt3RmsmP6K6i1WTupW4jnc/EpnY9umFSGy3y8XEW7zfBUnZMZuHSaKNc
         b+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694374438; x=1694979238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zokI0xUGRQ2PRoDJHFNv7BA5tbKL+sr/YV4Sntp4ZtY=;
        b=lymqfAU2jkrxaiPjPNR9sifbl7FnxmshaiRPWi+H/disuyFvIqrGrx5HU3vPzhqUbD
         R7mPjxpYX/F8y0xa3j4Xg7rs6VN8+8QEsGOOK4AnD8yLyplCCAgjFLtXbvv+dhAWV24S
         taKUSLGwDnLC5Kxh05jaYvA886MuJ7BndJHvPSt3GWwq3WRPgjBAZ/JK0kWo5T/H+taF
         17D/RV4GeVWm7IKTqNfZj5s2fPibTjKhCI+MGnBHkkmzk4YWsM4TsjY0gNwjRzDJvK+D
         qHAKbeEF5zdy1kTr7gJocVJwwEDj4I1NaWhvZ2D9HmegoVMG8YIIiKtk3keQLLNVntQz
         G+sQ==
X-Gm-Message-State: AOJu0YxK3ZRSH8/Ow3qV9sBz3tYWvzpv1bcgK0Vz1kl1cegCz0VbB+M0
	15IfW43s4U4qfaw5TIA+nnlMAfqouiUxt5/tQms=
X-Google-Smtp-Source: AGHT+IFb8UYtYPEdZKaQh0C+X077iSWSgfwCIEdG5CSa35qzrHBqLNnYzt/kJuUEahIQmqm2BGgMx0B0JpkNB1ss3EQ=
X-Received: by 2002:a2e:9d54:0:b0:2bc:c0e3:4a30 with SMTP id
 y20-20020a2e9d54000000b002bcc0e34a30mr5773347ljj.26.1694374437989; Sun, 10
 Sep 2023 12:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230910191445.564413-2-rs@ti.com>
In-Reply-To: <20230910191445.564413-2-rs@ti.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 10 Sep 2023 21:33:46 +0200
Message-ID: <CANNYZj_SNEM1yGkF28vv=oa+89DKptxTJmVAA_mb8qCwBtYUdA@mail.gmail.com>
Subject: Re: [PATCH] bitbake-worker: remove the network flag
To: rs@ti.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	denis@denix.org, reatmon@ti.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:34:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15019

On Sun, 10 Sept 2023 at 21:15, <rs@ti.com> wrote:

> --  ``[network]``: When set to "1", allows a task to access the network. By
> -   default, only the ``do_fetch`` task is granted network access. Recipes
> -   shouldn't access the network outside of ``do_fetch`` as it usually
> -   undermines fetcher source mirroring, image and licence manifests, software
> -   auditing and supply chain security.

These reasons still stand.

The only correct solution is to write a fetcher that can be used in
SRC_URI. This was communicated to you previously. So please: lay out
what is it exactly you're doing outside of do_fetch that needs the
network, and we'll try to figure out how to engineer it with a
fetcher.

Alex

