Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06FDC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 08:42:03 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web12.15789.1661157717229994226
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 01:41:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=FgB1927f;
 spf=pass (domain: gmail.com, ip: 209.85.167.47,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id d23so9902901lfl.13
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jBHe8TTuwa5m/cfoOHWA2pvh6DeuoV8XykUUsOQfcdU=;
        b=FgB1927fW1rzxuJa0ZmREgoiRFRrwWS2uHf146362lrDnH/IVN7PXMwTt6LnHNkiyK
         dK7tx8d8ucSrzKdG61uI8bKFWkkIYGFd+h2cOzdyM3XBckkQr370VFDQvbwPU7asn9P4
         /Csj7FX7om3nAjcNeNTmWROqPwJk5kmHD07LY/QNCPR3XG3z3gWl29UzemiiTIDmuIfB
         xsYzH/pvJqEx0XqUwEUX+G7dStKq9fWNGB+l4yix7e5ndAO09TiNr//UjM2fnT5QysI9
         ba2rzoMPxFY2WMygDcfKv4dXtX7tiwTSNcSry1jYUZp/Vb7mdFWZLvPdV2ieTyfvjTRv
         biRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jBHe8TTuwa5m/cfoOHWA2pvh6DeuoV8XykUUsOQfcdU=;
        b=WedtCOaklegUkP/dMB8xZzDNPhLmhur1DtnL5Xy5OA1+IS7QKszZ/Op4e2L/OaVlbV
         ENLG+uYs7RGQiXPESOi0tu5Mw3vjccFJ5lJdQDfv/+/qSE2jg8kqmcftu6haQ5kvihS/
         dcBZdAqdYbtpK0m9ksI11JDNERcFjVSPeFs6/E0DhClufdxQ+VE4ABXM2Gcr+Bdb5Y0K
         YX3dP2tWSEfUJ9mwYfjz4emu7/dSXTx0dneZQnEv9hEi73l4+3P03o6qd9hhP8EFuM8V
         aHYsxKl+J6JG1wCKD8X7ba1ulggiTbUyJUgPIUrqM83F22eghLFb4499GRgR/JvgRBB+
         y6Mg==
X-Gm-Message-State: ACgBeo06OFj6yNRRBfRDzBkRYICI+WEsmhrig/7KoZqAAhw2lQX8ZDk9
	FVr37DbpHRPzxx5inSkdwwel4XgTnCdK4Mw1C4Q=
X-Google-Smtp-Source: 
 AA6agR4E9mQIgHvFoAR6iY0jnBelrsFgJSpmX1EGzeTpeSHXZT6b/PpomRRVu4acptF2qrFgzaI2ndZoqwoWys+UEOs=
X-Received: by 2002:a05:6512:234e:b0:492:cfc4:c4f9 with SMTP id
 p14-20020a056512234e00b00492cfc4c4f9mr4646560lfu.358.1661157715334; Mon, 22
 Aug 2022 01:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com>
 <YwMR+H8KWePvpJtn@korppu>
 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
In-Reply-To: <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Aug 2022 10:41:43 +0200
Message-ID: 
 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
To: Marek Vasut <marex@denx.de>
Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa <Martin.Jansa@gmail.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 08:42:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13916

On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:

> > So maybe the easy way out is, if nobranch=1 then fetch everything, else
> > just heads and tags ?
>
> No, this won't do, nobranch expects the commit to be in a tag.

I don't think it expects that.

Alex

