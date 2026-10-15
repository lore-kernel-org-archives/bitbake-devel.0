Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75223CC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 08:58:33 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34909.1792054711130954851
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Oct 2026 01:58:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WRlnN/s5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a02753c04fso27001075e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792054709; x=1792659509; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=60tDC3+nHLRJo6a9aMzE0GDdGGCgpbqW0tTFylI4gjs=;
        b=WRlnN/s5deQILJGXDDHtBYxTFU47PRdJ1HrMG4AQHhxVbOwtXcRatE8jRoLUxgkhfJ
         +rDn9LFhRk6Onmy2hkvsF5Ulx6x5XkPQpKe22rk9HuAw5GTXEyV8aIzN6LCL2I3SUHFb
         IGwmAmEGWU5jETrcp5MCpiTzafzwS4LI7vUCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792054709; x=1792659509;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60tDC3+nHLRJo6a9aMzE0GDdGGCgpbqW0tTFylI4gjs=;
        b=Ua8ugvq5fPGLOOSA2+y1+DI0FI4INe20TUqfGetAnke5igCpGX1zXjH8meSbtxI2JS
         Xelkq3InwOu9WKT2F547/WkHMlb9nziFxZJ/s3i6JaA1HbQynBUBhYDCp6gIza6D13HT
         SwHVx7fhOt8SnjNWG8ZZ4iFV86B6NCjCmmr2v0kJbYL684ZnDlTVyNh5lvzm5Rtv51xt
         jljF3RZM+sSIifjFtuwz8MQ+lefyScDQ8Nl30OEOOgL2Na5xkgP6Z3PumvUAK45DDi/X
         +5Ec/ss1sEUb69h9ZoO8m5H9ddxIFmxxJA315+Gwm+ky2r4vxzTfDMWT4UUF52HKt5a7
         H5ag==
X-Forwarded-Encrypted: i=1; AKwUvBxO6/3kp3dbGnVaG1Vrqc3FfH228etmkTbjH9D37b3BgDOOH/xk/9lvnY7lsPq1JI57mqcC2im7o0ohS/Ip@lists.openembedded.org
X-Gm-Message-State: AFq9FYJzWuCt7fpWo3YX+0VIUjSIDWTK3SF48t1F3CzCCBsd+xjd4QeJ
	ml9nfW25fkXHuzJ8PxRNUjQXSFoR49ktxmEnM4rX49Q023o8Ma5cq6fyqrLnDx75b7g=
X-Gm-Gg: AYBFou24fkDUZQMajTDIbHcg195Qmm0Jbyrq1u4bFeG6dDELT/7bKGY3+PsM0R91t4m
	LzMuZ9O/jLGt56UCFw1F1VX0RvAl/6EEYlno4qvdeBvddUO/ow2BQb22m1n7V0ZgQK5SFPxcnmh
	htujMRx1hmsTAzbbhVf0/JZHwJP4zGUQj+GcXlkv9i4BRAq7C9ij2p01kADJbbGg40oLNgra+/+
	i227NzBl+xBEeo7fEUCh5XGpv9XvXHI5F+jxnT5PZLMne0KyUYLUs7l2KUrg25YnG8fs4IC9rTa
	huh/1bnoVlH3A5YawN0heEDrgDbCiS0XVo1+a4BUfJIR/hu4BREMlCPUm/f+/qFBo1C5YQfQs8K
	kn2iOpguaWZVJRI3nC9Ae5AR6UUv2e3KU26y4dbHPsqZbXb82ShOnI2TuKuz/Yxjc6MiwyNK41o
	lHZtCKf/eAThuXkdL5pal5Zh+5oAbkrUYV5wPJI1hqWnrR2X05uh/4V9cioHuUIiLtwM1C6draR
	gukIA/vd1Zs16Im28wMQG7TZJqHnRiwBmrxQf+DUBER0cCxr1fCvHXWP1ujF+8=
X-Received: by 2002:a05:600c:8b09:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-4a18e4a95b7mr398190995e9.14.1792054709143;
        Thu, 15 Oct 2026 01:58:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8627:1727:8a8a:57f5? ([2001:8b0:aba:5f3c:8627:1727:8a8a:57f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd97ef4dsm61569165e9.4.2026.10.15.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:58:28 -0700 (PDT)
Message-ID: <5d6d74ea44bf61549823ccde83e4c4ed1e274dc4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/4] knotty: convert warnings to errors
 when -W is passed
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	docs@lists.yoctoproject.org
Date: Thu, 15 Oct 2026 09:58:27 +0100
In-Reply-To: <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
References: <20261013-warn-as-errors-v1-0-ab3658758ceb@bootlin.com>
	 <20261013-warn-as-errors-v1-3-ab3658758ceb@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Oct 2026 08:58:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20343

On Tue, 2026-10-13 at 14:13 +0200, Antonin Godard via lists.openembedded.or=
g wrote:
> When -W is passed, modify the handlers to show warnings in red and set
> the return value to 1. Add a summary line informing the user that the -W
> option was used as it might not be obvious when looking at the bottom
> the end of the console log.

The trouble is this doesn't make warnings behave exactly as errors and
I think that is going to confuse people :/.

Specifically, if an error is encountered in a task, it will error and
fail. The warning will show an error but continue anyway. I also
suspect the warnings will still show as warnings in the log files and
only appear as errors on the console.

Cheers,

Richard

