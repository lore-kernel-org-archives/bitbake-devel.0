Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B8EC61CE8
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 08:18:33 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.web10.7767.1749716306286376316
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jun 2025 01:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WYhmQONI;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a589b7dd5fso11876991cf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749716305; x=1750321105; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2sN+i/yWO54BFMujQhXku6BYE+tN/88JDWm9P2nvFMU=;
        b=WYhmQONIbepVysdW897vxI6vBlQXpIKjvkCIB5+Phmo38HpQrxAXOznfc5PnqnOyqR
         1NXqQoytCyGGQgIt9oVPDlxgXFlX8G+/s0as1DxQ1wlVP6diUqpIYlPbyyS7KkUbpAKy
         zNa9ymrI4Sw0N7QMVVwNLCq0ti4TnBHTNFhtLftt50XYzz9YMMY2C2Wprkh+O3vzXxSw
         1Lw+/0rFrt0RB6jkdcsbsHaxLBBaM6JSPs1b3f6FNNYLdcpq2q5MRIjIqfLtxyzPjpU8
         WmWrrfC/bmRjkkvQ8WPjRJSNhUus3fd3NLqnYg2+w87ucHokMOML8YHS6m/g7WcgpMry
         I7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749716305; x=1750321105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sN+i/yWO54BFMujQhXku6BYE+tN/88JDWm9P2nvFMU=;
        b=mb0hoxLt691jCRXMN3Qm00SXCqogbjT6GpIC7JCixfAh+Piy8cO1GMb19lhodSsiEo
         utmpyeKXPSH+zqno4SByKWvNON+xVVjOAR0rVbSZdvRcycLwTF7rYWDqq9rvPpUam4nP
         KXfD0wuQbE5ekcIDHLs6yj9m4VICj/+BdzewO5npT4N20NSadZ6Y+8HRgKIKnSUwvRVA
         DzQ24ZJNwvAhtsXgvY8xkngv7Y84aDB9T/flrXxq5MVC9J4xEMJTolrwnV9WuFE1RnTL
         oVDu4P2B+7BvHK9QJYJno/ioazz0f7tpOMYwn+bU4VNB8zUazKwZd7ZgY1nXEwBEBAGU
         eEdw==
X-Gm-Message-State: AOJu0YyGk+eWg7XFWESRfE+uAdDi99BWzVhrDDL4MNEHJnIzfki+Jxeo
	pCrY7kyeLU1fg7eUtx/IhZJkhzPFKSIjCILL5kN2DYrbp38ULvVsen3ffEvyY3YvbrUuJ6UWMiZ
	n5aCcwVuEnR1tsRSvXe+GQKK6fKXU/qL+Hw==
X-Gm-Gg: ASbGncuKkFkpJLweReqIwjngeNK9tTlJiygg9Q+JHReykG+8x0oXQmqN5b+V6LpCpdC
	AXfx6bwxMgnMw+9Xpyx7kIo+fKoRTzFsaBLsOUU2nNUizB0lloeS7n9tPTvR17/c6XCByRZ8i6z
	rbVW2+JJVWKKx6wBmCI2O18ZkOSIrmuEod7vFWkwxcuTk0nYLZt1rNHGEAFMlpM0T/FHw/QrvfV
	F4f0w==
X-Google-Smtp-Source: AGHT+IH/0KPb6DNM27BIhqw7FRiWTeUwkrZBfufnZeLJsaCmHYUTKCBD1hq82Ao6DgIhcVTmqGAhLtBqZxoTMEy9Lq4=
X-Received: by 2002:a05:6214:d69:b0:6fb:15d3:7f3d with SMTP id
 6a1803df08f44-6fb34618e6cmr38591866d6.13.1749716294070; Thu, 12 Jun 2025
 01:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250612050709.3588563-1-hongxu.jia@windriver.com>
In-Reply-To: <20250612050709.3588563-1-hongxu.jia@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 12 Jun 2025 10:18:03 +0200
X-Gm-Features: AX0GCFukDNYq4lzP0chTgP2Sw5aR_0ZKAU6_aprUs4XNkXR5bcKkr-3GrON5ypI
Message-ID: <CANNYZj_XagBixFp2kLbXxmXiMVKf9Ek-G8jSBQA049GXEPsPKQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bb/main.py: skip noisy output for bitbake-getvar
To: hongxu.jia@eng.windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 08:18:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17695

On Thu, 12 Jun 2025 at 07:07, hongxu via lists.openembedded.org
<hongxu.jia=eng.windriver.com@lists.openembedded.org> wrote:
> Because script bitbake-getvar sets 2 or 3 to quiet level, improve
> the output of bitbake, skip reconnect output if quiet < 2
>
> -                    logger.info("Reconnecting to bitbake server...")
> +                    if configParams.quiet < 2:
> +                        logger.info("Reconnecting to bitbake server...")

Thanks, this is better, but actually, I think it's even better to just
use logger.setLevel() at the start, so that these calls don't have to
be each wrapped in a condition (with potential for regressions if more
logger.info()s are added).

Alex

