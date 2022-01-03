Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE6C433EF
	for <webhook@archiver.kernel.org>; Mon,  3 Jan 2022 22:38:28 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.35918.1641249507300930774
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 14:38:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Xi9/yPRw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id t26so72391345wrb.4
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jan 2022 14:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4avB4S3bnu2YD5W00hRouhUHoAgYVTX7cUP7WKPqUww=;
        b=Xi9/yPRwUZFIjxQWFsKG15dI1MYiliPsh1ml2qNClHZX/gw070pyosy6sdPzMTF4O6
         qyLcf6/jpZaGqsIduUAEkyeKgLbr6Iyodu2uFlsHN6j0jNvdHYc1dMgIYlyUjrlOdEjy
         L1ge4gStYey6EwgxZuPkNgvqLwKqkewypVozw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4avB4S3bnu2YD5W00hRouhUHoAgYVTX7cUP7WKPqUww=;
        b=JNa7i9aJ0y8QHsMqrDHZchOIPFFUXfqL31p003618XOAd1W4A3ebU3NNbVwTzNgqiH
         MJZmCrwwLg98azpu3A6IAnSw+U2vtcKep+KYKSzkgvkBUbT/puw6DExIYX8zYgahvUFe
         3njMxgMqwhDv0nNMFxLhDVPYaxATwVGp4oKSdvlWqzJosnHxxfCCho9FJ9MRZKKwf0ZL
         6Rju7NXbBWP3kPYcqab8guUT+X+EzVvu8kLK9HP18aWTxnZc74kc6h8gfMLF9p//2CCb
         ho6nWwXwRpT+okwYK8kNZ8u76B4IOp4TaJaQKc1BtQrkCH/BQSisKLGduJ1GBFl0qHgk
         On0A==
X-Gm-Message-State: AOAM531uKIx9vQ+XFgUP5XRLGVpTE3KO8/DPEZT7hezl+ZsZG3A4AjUd
	KIasdPg88FdxhJLHbpFvqMEQOg==
X-Google-Smtp-Source: 
 ABdhPJy9GMYmxrWmRpDfAqJQyzF/hytD7QCEwSHVy68gc8S6/Vp//EWylJ/YpiCKeHLr1bCUhBQudg==
X-Received: by 2002:adf:f70b:: with SMTP id
 r11mr41591136wrp.496.1641249505722;
        Mon, 03 Jan 2022 14:38:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:da22:f51:54c3:4a4f?
 ([2001:8b0:aba:5f3c:da22:f51:54c3:4a4f])
        by smtp.gmail.com with ESMTPSA id
 a204sm38368231wmd.39.2022.01.03.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 14:38:25 -0800 (PST)
Message-ID: 
 <2ec888840075cdb4a9d9883492b3ebf62654c085.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] providers.py: do not skip recipes
 providing 'virtual/x' in world builds
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Mon, 03 Jan 2022 22:38:24 +0000
In-Reply-To: <20220101112911.1866500-1-alex@linutronix.de>
References: <20220101112911.1866500-1-alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Jan 2022 22:38:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13212

On Sat, 2022-01-01 at 12:29 +0100, Alexander Kanavin wrote:
> This is very old code pre-dating 2005, and the reasons are probably lost in
> history.

They're not, I remember this.

> Doing this skipping means that anything providing 'virtual/x' is excluded
> from populating packages to deploy/ in world builds, and thus, from reproducubility
> and packaging tests.
> 
> This issue has been largely masked until 'package_ipk/deb/rpm: Drop recursive do_build task dependencies'
> as previously recipes without virtual/x provides would pull in the dependent rpms instead of the world target
> doing that directly.
> 
> I have noticed the issue by observing that go-runtime is no longer reported as
> non-reproducible when it should be.

The principle is that virtual/XXX should only be built if something actually
depends upon them as they're usually used to denote things which can be provided
from multiple sources. I'd argue that the code is correct and wonder whether:

a) go-runtime should be providing a virtual
b) that OE-Core should have something depending on go-runtime for test purposes

Cheers,

Richard


> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bitbake/lib/bb/providers.py | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
> index 8c1c31a5c5..3c4462fbdd 100644
> --- a/bitbake/lib/bb/providers.py
> +++ b/bitbake/lib/bb/providers.py
> @@ -429,10 +429,6 @@ def buildWorldTargetList(dataCache, task=None):
>              terminal = False
>  
>          for p in dataCache.pn_provides[pn]:
> -            if p.startswith('virtual/'):
> -                logger.debug2("World build skipping %s due to %s provider starting with virtual/", f, p)
> -                terminal = False
> -                break
>              for pf in dataCache.providers[p]:
>                  if dataCache.pkg_fn[pf] != pn:
>                      logger.debug2("World build skipping %s due to both us and %s providing %s", f, pf, p)
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13209): https://lists.openembedded.org/g/bitbake-devel/message/13209
> Mute This Topic: https://lists.openembedded.org/mt/88071309/1686473
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [richard.purdie@linuxfoundation.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 



