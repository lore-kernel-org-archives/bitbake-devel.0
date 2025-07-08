Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F052FC8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 22:01:09 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.221.1752012069310590778
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 15:01:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B9NixvAH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so4455854f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 15:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752012068; x=1752616868; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DgKTRmwohJKqtCGSt3LXktFiocCdtoU3t+FvlxaCNAA=;
        b=B9NixvAH1cHMdNwpmvWckoD3N7JJyxMMkt2RMhvUcv4T03ovGomGrS6UGpg4toBrFj
         /ZfbCPS/q2eX3Dt8xl5IZNNtr2hXDqJrrL/u14FP+T/m8NzMZxUejOubzo6PDF5E8th9
         kCqTpEGqpZxcA5B5io4B7ZqiUl6XcOnJ036PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752012068; x=1752616868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgKTRmwohJKqtCGSt3LXktFiocCdtoU3t+FvlxaCNAA=;
        b=oOCT2KM74e1+hkJVddvrQ5lHsDUvHjfDWq1klXQRbFvDIsibYjoQ4MBgkqFZB1xcK6
         FaQ8dZEvQJC0cGdb3cg4VfbGWUqCp6yjwEtNTVlVcNvVZ9xYvJR/ON4HjfAqAgHcclue
         fvAd80WKva/uUIkWlDLZk0K6KSAEvTlsBcO6eMypwg3kZRtGxuma2Ay2JxU03+UNo+wc
         XlkyDTBsWjtUEqDJlEMcoP72LA1gF8tNTe8kpmpNb9Hk1X2HuA5NwXPXXGgrs6W38iJm
         5EF5Fp5BvPDfgzOkPm60BPl3PDpzgqwCKw184iMVmykeNpqQI6p25eY27uB7zj7zUq74
         QCxA==
X-Forwarded-Encrypted: i=1; AJvYcCWDCTJmtuDSa32X54c8KrjzvpOqurkbCpS9UlbFbtOtA6qsoUZAU9gWQ8VLl658vqhKOKeDwikarnmdQk1K@lists.openembedded.org
X-Gm-Message-State: AOJu0YynEuTrDJj0EFuay+Xnbz2IrzDX74ci+8u8cwRBRx2XXaTOykmb
	6036lYOAyVN72vmHfSgMcDLgDmFtQDCf/6mGe6vYle4jTIJWyMEhX5NFydsqwjoJgZY=
X-Gm-Gg: ASbGncujM8dgXi1/W+qshGGBkZogSoZTiWTVj/AapJVaFEC+EycTAh5aVZEphK1VxXB
	VRfx5ZHRmERPJPcZDAIfc/DxmUhu+fLEbX3unXDnjI/mpMWepVfoKfZsRDc8M/e86FR991ANnp9
	rMrvHmfzhBRQXR1XJMp1dozMtrhhTnGuGfnz+Lli+W/yP0l7CGr3xfs159H85nv4IAUJCsW/s8k
	M8V1iNPRI5gPloYmTj0nlSiC8vx45NmFEOlwbUrsEh/PXVV1/kDvQ6DGWjo8+lOu5x81sEzXe+n
	xmfQLdpyKSYozMON7CT3nimWJouSTDgjIYmMGAXbgPOnAQfYNdRB7+cRVijNL/VWnOXTxn1Pdfp
	gb8Pe/Ojvu8Ra97G0uegJsM2eDflvzFI17QhokrFZCjWQ8MLpcTc=
X-Google-Smtp-Source: AGHT+IEXG/TKjRz3vfyaZYWnn0bfntPmhWs84P1S2OLySgSLbX2fMy/rGD4jcOK2x0Q0VXnKRqZ1Rg==
X-Received: by 2002:adf:9d8c:0:b0:3b3:1e2e:ee07 with SMTP id ffacd0b85a97d-3b496626856mr12884063f8f.56.1752012066252;
        Tue, 08 Jul 2025 15:01:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:14f0:8cff:fd74:911d? ([2001:8b0:aba:5f3c:14f0:8cff:fd74:911d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97515sm14197213f8f.62.2025.07.08.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:01:04 -0700 (PDT)
Message-ID: <6c975cb4af5e61400c615ece37b14081b6779e8d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Speeding up Checking sstate mirror
 object availability : Add async filtering SSTATE_MIRRORS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: sider123456789101112131415@gmail.com, 
	bitbake-devel@lists.openembedded.org
Cc: gavrilov.andrew1999@yandex.ru, tinyakovx@gmail.com, 
	denisova.olga.k@yandex.ru
Date: Tue, 08 Jul 2025 23:01:04 +0100
In-Reply-To: <20250506131751.93175-1-sider123456789101112131415@gmail.com>
References: <20250506131751.93175-1-sider123456789101112131415@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 22:01:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17764

On Tue, 2025-05-06 at 16:17 +0300, =D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=D0=
=BD=D1=82=D0=B8=D0=BD via lists.openembedded.org wrote:
> As the number of addresses specified in the SSTATE_MIRRORS variable
> increases, the duration of the "Checking sstate mirror object
> availability" process also increases.
> This is logical, as the number of addresses to probe grows. However,
> it was observed that the "Checking sstate mirror object availability"
> process time increases even when SSTATE_MIRRORS contains one valid
> address and multiple unreachable addresses.
>=20
> A patch has been implemented that, during the parsing of the
> local.conf configuration file, immediately after reading the
> SSTATE_MIRRORS variable, attempts to asynchronously establish TCP
> connections for each address listed in SSTATE_MIRRORS. If a
> connection is successfully established, the address remains in
> SSTATE_MIRRORS; if the connection attempt fails, the address is
> removed from the variable. This ensures that any addresses
> unreachable at the TCP level are excluded from subsequent processing.
> These modifications are activated only if the FILTER_SSTATE_MIRRORS
> variable is set to 1 in local.conf.

I'm not sure we want to try and add this kind of support. It
complicates the code significantly for what I think should be a
minority use case. Can't you just configure the build with the sstate
servers you know to work?

Cheers,

Richard

