Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C4D4335B
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 22:12:33 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22.1765491143557066416
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Dec 2025 14:12:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mLyeyayN;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64979bee42aso882020a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765491142; x=1766095942; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yG+PtX6wHYrpY0oeOpcxpiHsuDaBWiYA2PUUrXejCwM=;
        b=mLyeyayNp2G5I4b+pCznPrDKjjoi3jc/IwnyU0L0SOFmBx7OHa/LQuVHok0QIwCHJk
         cSOIHTR4fNCJL6kNXnV4c/oIycS6PWg6REegB5+YDqTarDctMnShdBNm5cHYIvRd0MfA
         GX7wWYUrnMURIEkEJMIpfmbwt3/TBNsaLhlajZf2UeynCCOs1sZI/oS6LioMafExls8A
         oT1N06f+K+3yXFX60dRiUxALSLn8Pz6jOwK8jR2ZBbvnYmDozRPRldkc5ex8CJTNKJp2
         v9ZMf+uiDX8uT9jrxk+VRwWMieZiqf/y4vY2qxUJo3MBGgoWPvx7tR94FDTHFLam8kHK
         vTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765491142; x=1766095942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG+PtX6wHYrpY0oeOpcxpiHsuDaBWiYA2PUUrXejCwM=;
        b=q04+45+ENg/YBUCy3TCPSSn+xwGff5ro/nRxxpNv4PauWv84IOlmDMaL7Vf8dVD/Hm
         Qva/KcBrzpu78VXZ49aCIA8GjYHKLz79EiLczHejqPi7zPOedPeK+mfTLPOzfa9gNsFh
         O+/JqulTrlqmlIkxsTtYoQyXPKwNrIDpZhDfluEoJLRN82GURIYJZ20JOzBspWwp9Vel
         Rs/eJWnbXqBvaT37bmqNJq9vZM8Np9Bol7tp5iF/b2aBEg1sS6im8ygza5ezt5CU4QYV
         nwoqYk/M2gs+qSr2Gg9mLmvd08IjMIqr5tcaZnG/iw7YQ36bfurfoe/6TsQuRl7EVig8
         7Axw==
X-Gm-Message-State: AOJu0YyyFGUyIHr0R8nzKmeI7dSp3bxmS12uh9OXTfF2TeuaTkT2zd1d
	0eNaSho3JmgDO2kYiJ7PdObJIM7vyGQELH5YmWQHTys0B6pSIoMzPDJ8
X-Gm-Gg: AY/fxX5GNOAkXjY73kY0sEHNxCMO54LKr+ripvxivc8fPUCly0mSivJVWaM2TIbjWXe
	mpNz+nNlJUvMvK2y/4g3nWusdK/jDC8guhQ0aoZE/upGcDzd86JT5Q1Cd5h0AthqxtyW9rr86KB
	gsZ+rWJhXAGtxH3vd88pgdqarzj/V9NbwujQ1r6IBmgYSjkqNI2AtHLR121NnhgDuKQWNG2yCjf
	qU9o5hwdhkbsG124CYe6VPAR6Y1FYArWvva+cJR1DEU3RbSJnHBY2JszI+yNZqaOh+Sh3zkWdPI
	KhBRgLZV586x6lFQeTObLwHz2zp9fxj332yVVm2hX7CoUxcNrZ4l6+m8v20mNJJw0iTxUjmwILa
	qZSA4+jcek01dZ4oDQjriVEn6vxZh5sNk1nAhJApEbu8i6wc5mYcmsbWcqPk/5lUpPH5Gn5LD+t
	GBCG8BPgTgA8nb
X-Google-Smtp-Source: AGHT+IF0tb+15414DhHJWfdIDE4wIURubMZwcwADz2oiTEDY3eLA/ld86h4o61Qf8QoUzYMpXipt8g==
X-Received: by 2002:a17:907:c1f:b0:b7a:1bdc:aab8 with SMTP id a640c23a62f3a-b7ce84cb1bdmr672489366b.65.1765491141611;
        Thu, 11 Dec 2025 14:12:21 -0800 (PST)
Received: from osama ([2a02:908:1b4:dac0:ddc3:acc0:61f0:9df6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2eb9bbsm383091466b.25.2025.12.11.14.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 14:12:21 -0800 (PST)
Date: Thu, 11 Dec 2025 23:12:19 +0100
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake-layers: layerindex-fetch: respect --branch for
 already-configured layers
Message-ID: <aTtBw7g0_Cl6kmSy@osama>
References: <20251101135651.26560-1-osama.abdelkader@gmail.com>
 <8d1e305bcbc688ca77aa88284bb8be982554971f.camel@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1e305bcbc688ca77aa88284bb8be982554971f.camel@pbarker.dev>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 22:12:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18571

On Mon, Dec 08, 2025 at 09:40:05PM +0000, Paul Barker wrote:
> On Sat, 2025-11-01 at 15:56 +0200, Osama Abdelkader wrote:
> > [YOCTO #7852]
> > 
> > The layerindex-fetch command has two issues when --branch is specified:
> > 
> > 1. If a layer is already in bblayers.conf, the command exits early with
> >    "You already have the requested layer(s)" without checking if the
> >    layer is on the requested branch.
> > 
> > 2. For layers in bblayers.conf (cooker layers), the branch checking code
> >    added in commit 138dd7883ee (2022) never executes because cooker layers
> >    are skipped entirely in the fetch loop.
> > 
> > This patch fixes both issues by:
> > 
> > - Preventing the early exit (fast path) when --branch is specified, forcing
> >   branch verification even for already-configured layers.
> > 
> > - Adding branch check/switch logic for cooker layers when --branch is
> >   specified. The code finds each layer's git repository and calls
> >   get_fetch_layer() with the requested branch to perform the validation
> >   and checkout if needed.
> > 
> > - Fixing the branch detection in get_fetch_layer() to use
> >   'git rev-parse --abbrev-ref HEAD' instead of parsing 'git branch' output.
> > 
> > - Fixing undefined 'stderr' variable (should be 'completed_proc.stderr').
> > 
> > This completes the fix started in commit 138dd7883ee, allowing users to
> > use --branch to switch already-configured layers to different branches.
> > 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> Hi,
> 
> Thanks for the contribution! Apologies for the delay in reviewing it, we've
> been focused on finishing the 5.3 release.
> 
> This looks like a useful change but it's difficult to review in its current
> form. Could you split this into multiple commits? Based on the above detail
> there are 4 different logical changes here so we would prefer each of those as
> a separate patch.
> 
> I'd especially like the completed_proc.stderr fix to be isolated as it
> may need to be backported to a stable release. So this fix should come
> first in the series - best practice is to put patches that fix bugs
> first, then patches that add features.
> 
> I think you'll also need to apply these changes to the bitbake
> repository rather than the poky repository to remove the unnecessary
> 'bitbake/' prefix on the file paths.
> 
> Best regards,
> 
> -- 
> Paul Barker

Thanks for the feedback, I'm going to that.
Best regards,
Osama


