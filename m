Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA1ECAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:41:25 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.52680.1759149680151582595
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:41:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P/Bb1gIr;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78defc1a2afso54007866d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759149679; x=1759754479; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ogCzYMfcfkp3qKhVyybhnRvF/J40d1dArTa0cw0RB3s=;
        b=P/Bb1gIrQ+y/K9QDTLJrj1N1+k08bDulMf3cjhZzB73SfQSCh8rs0ng+YW+bZwdAXW
         VXf49Nf/limt7FLEovQYBo379GueiBBtiDWgEUjW9jGw3Dv+qwFbdZZXW1XoGPSlTTFZ
         vme3Eb74cVDz+rzE7hXetHeS6BkO9Zw5EhI/yZQgY8xCgTc+FXNNvJjmFEw/5vw6MTYV
         z44DGX4GmdeV+Q94Loi3IWIVijybn3Z9RytmG0fJwfSiw4aWYRL53A+zK38pd4579aO/
         qhunCLMnsIcjbiTvxbdroaon3EEHsSf5+O5xMlcdhkfFz8zGmIVYbHNJtRuTIor4eKEz
         qo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759149679; x=1759754479;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogCzYMfcfkp3qKhVyybhnRvF/J40d1dArTa0cw0RB3s=;
        b=vo+M66c5Y4Rr/QHROHGwBjphvKYy1L+a55xjLoBY/I0OXk5ff3HtPB9Y0R/wIFESvV
         uRc7ZmHj+0ijz6h/OB4cnnIbmVk2uMeDS+FT3KpZmDqMfUj6TfY7Acy+8lv9NVDDmEap
         K7/RqRVKb0uJ0CmdiQLWnF9T+xIPOjveiDAW2cBomRh0412LRMYOZptMHZ61FfnCvNwh
         QyGSvBS9StBc0j7v6XgYqo0fWYK8hsJN9fnsUk6gxaJDDuUgi2CWIMX7+eLvYCa56tVU
         cePso5QkrhsNIwgcI3Acc0UWA9LfmP9mXv4OI4joTl9cZ6AcXAAOem/pALsTxpRCGkKL
         VZfQ==
X-Gm-Message-State: AOJu0YwZI5Ys1vLyAz1fb5EtheRWu7P45Xd0sf22zF4pfP/7ngsx6cTX
	cAvasf3K1HEGBI7jwKrDRGIPyxHp89BIBQJb9D3PgrtChV0EdB42uGOZCLCq/z9X9W3Dii5rF1H
	AcCfBrgeg0Sw1koZHgAaNW955sidUp0wYYw==
X-Gm-Gg: ASbGncsewmowkXa88g0nOxfqIvncjgnwRP/bTEpsB1XMxdnuVDFMbzN8WWmZljJG6ou
	i+/d35j8Z2zwXrS0O5BlaTFTJH45zuWpLSl5B9QYxr/XOuPumPryyY5zpRc6qXxpGQnFy+Hmra1
	mAFHZz/nX5zmCYrQprLVFmMgpjSz7mEOQugUvqRAXZc36S5cXUg7zEAdmIkwflXUr2LXL93ti/t
	x6h7caoyZL2V2Vs3R5S/g8vFNFMN3eWQ3eX9rXRBn34owmDYhhPHtcqaDgGW5ONMN3tihJwKDZ3
	w/6D2rcc0RDSJ9NCINAdVB3iak5jJMst81rROq+3
X-Google-Smtp-Source: AGHT+IGGzFbW4g5jPVlNDS3C9PVwphcdf1gobJzuAANAjfDQykvy34TuY+VEHnDtU7JtOu8/8nw3pyH1iCx1HBqhPec=
X-Received: by 2002:a05:6214:19cd:b0:812:dc64:e8fb with SMTP id
 6a1803df08f44-812dc64fc9fmr153424286d6.3.1759149678902; Mon, 29 Sep 2025
 05:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250922092731.1993813-1-alex.kanavin@gmail.com>
 <5849b9f23a3782c7a4b4eb32a6797454336ffcae.camel@linuxfoundation.org> <1868DE06ACB3E9E9.31368@lists.openembedded.org>
In-Reply-To: <1868DE06ACB3E9E9.31368@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 29 Sep 2025 14:41:07 +0200
X-Gm-Features: AS18NWCLr9TeRWXl8c2YVGhuhoMD5yhXit9p-L0EWifIIhjTM0t21T0G1QoYoJg
Message-ID: <CANNYZj-_btNkFQ+O_AGABuy8qeFZA7cxBRqZ7uiAsOBjVx7+sA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: add the initial implementation
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:41:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18098

On Fri, 26 Sept 2025 at 17:16, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> > I know Alex has told me the "nobranch" approach was by design however I
> > can now demonstrate why this is sub-optimal. The reason being that if
> > the branches aren't used in the fetcher, the build can't work out which
> > branch it is on. In general that isn't a problem but there are two
> > cases where it is:
> >
> > a) the autobuilder was querying branch information to report back to
> > the UI. This could be done differnetly.
> >
> > b) the summary output at the start of the build. This is a usability
> > issue if not fixed.
> >
> > A bitbake-setup driven build prints data like this:
> >
> > Build Configuration:
> > BB_VERSION           = "2.15.2"
> > BUILD_SYS            = "x86_64-linux"
> > NATIVELSBSTRING      = "ubuntu-24.04"
> > TARGET_SYS           = "aarch64-poky-linux"
> > MACHINE              = "qemuarm64"
> > DISTRO               = "poky"
> > DISTRO_VERSION       = "5.2.99+snapshot-07747aa7390e98bf2853154e5fd473e4984a1d3d"
> > TUNE_FEATURES        = "aarch64 crc cortexa57"
> > TARGET_FPU           = ""
> > meta                 = "HEAD:07747aa7390e98bf2853154e5fd473e4984a1d3d"
> > meta-yocto-bsp
> > meta-poky            = "HEAD:db24e48498b2d40131b871f6eafeb7a67da343f0"
> >
> > and I'd much prefer we didn't have HEAD in there but show the actual branch.
> >
> > Could we improve this?
>
> Yes, I think so. 'nobranch' was simply the quickest and easiest way to
> convince the git fetcher to do a checkout when all you have is a
> revision. I need to think for a bit and do experiments, but I'll come
> up with a way to specify branches in configs and passing them to the
> fetcher.

This has been fixed. Patches coming.

Alex

