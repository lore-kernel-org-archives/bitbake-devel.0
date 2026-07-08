Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A3C43458
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 15:26:52 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11092.1783524405199926389
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2026 08:26:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=pKCH6tkd;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f23e851626so6647226d6.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Jul 2026 08:26:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524404; cv=none;
        d=google.com; s=arc-20260327;
        b=R2/25EvDKLgDJSI1bcOzOnmA/jQPELbvU4AN8SWdvizOkfdsFpRZY4BrM63pM6cjbS
         CwGdHwXVJSXfSlkqDrAwJto56G5KeVjWTN8+glFc7KELFmmj4uxVsK07Zg3ph/y6QA/m
         tFY/C+MdMGWxRkPAPhyyddpv/finoYf0P3vcAIAKr0HKXLHBBPe43mxYPB6N2Q1zu9Ic
         2VUqWQ0AB5z/Wiqu/DBB6sdZ45AQyRsfKTOn1Xj84Nu6PPw7T2N0YzlQG4CqMMUhbatS
         5H0abSqBoYqu8k+mznuX8LZc4glbdYp0xeSpnHIvBHX6stAdZw6MDJkZzAMoXMCTlZMt
         EIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H11hyAY6zSWEb0VxIKZS6AtVRiU4K0c2dcrVXLey+N8=;
        fh=1sPeGJstHoXKVbb5/jKcge0GMtYJBQA5lpzd8iKNszQ=;
        b=qqH1ZR5AqctiATN7vr85U4eSyVIKG7LrRobrbz9ngpCxXOY9q4h8gCw6EocKtD7/I7
         LKUQiAVPTz0tPZL6DqqI2nWe+OrmtzGTKhZmrbCt6kTnUqaEPCzrbrti8O4IzF90+QQN
         oTyehasTeNXSspFOPGaIyrtZ9InlMgNsao+dAgNyKYqAGneb13Qo5Y0gJN6S6FTJWAiC
         6dH+ADkz4QowdWJRaycWEV00rPr/QSyzPD3VsI6h+Mf/N2BR/8Hel1L+ULx4t+tF8P64
         qgtc9wqj46r45KgPfOZ1M//ZkxHDiMDNkwpp33c7QLKNavlfFiv6UZ02apSaTSxJzU6X
         Ggxw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524404; x=1784129204; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H11hyAY6zSWEb0VxIKZS6AtVRiU4K0c2dcrVXLey+N8=;
        b=pKCH6tkdTASIx6hb3yLGQK8Ydj+i5lmTw19mdVIBz8qlnYOkMplhEG52LIOW3bh5BO
         L1jjPeD/ax9f1TITsk2ea3xD34111Eh3Lv+liVoBJes4mk+kEgq1csAaXK+goBWchhtM
         c473+ieC/0zQgu+Cz0Jbl0YdAhB51z//vQCGoBdE52qR8ITpZfx0aotl22R1zzKBQ1Yt
         YKoeA7lI25I4KUf180dXvxvPlzDfcoUctH+nfq8bZs6IDxenIv9/wGeCLJQPaBIJSFnn
         LU6uiKYPj3y674aenGk2SlRnJ6h52ydZVI2YPqzanRdQ+IZqXCYyIFo79oaqUm6Cm+OI
         fBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524404; x=1784129204;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H11hyAY6zSWEb0VxIKZS6AtVRiU4K0c2dcrVXLey+N8=;
        b=Bkinhre05tQip6qDUvI/3Bx7OZ3WyUiCUtUeuSJoLCFMQkRYaP2b2q6MScnod+BzM9
         kY8YOaMnhCmFVUA/0HScFexDx2YDJxSOWCeSnT6vK7xUclF/K/jpl76daBxKiOrsZiB0
         f5oWGppWVENORgS3T7MFv0K5TQYIzjcOZRgqRT0aSJRwSONbWTcIjJBYXCZA0ByqMpIp
         8PiE8sU6r3ZlJPNU8PJk4lDN2sUfUewlpwh39noWXS/wC6MuOnFF+Q2+f2anOJMqmqVN
         A3nAV0BgQXyfkjFWGfMXPk/GDZP0BIquJr2xbYOnd6WXj3rbWJjLqcF4nMFSibM+Mlv8
         GQlw==
X-Gm-Message-State: AOJu0YwHBcUj3zH4sziBEPGLZx/SIWU1KoKBk04DczsbaKtMk5g2lzN4
	eEwqOQGUAkBCLOArFKBzyK3rFdIm3Y9kVSrbTNh72BlDQFlpEHwPdtp5MqzMNaXBVQz49bOALQD
	TbyRe3vQToxhQXDPJD5HafqSCxJ8R2IQ=
X-Gm-Gg: AfdE7cnyQhpBe+imqHeMETNKxY1PF67SJua8uacyLxyR9q41Gki5BKvrwYYtiQxxTAn
	84Qtjpu75mfS4avWLC1pX878SJBhC3UUW3ywDRLTsv2I020u2F4ghqIRuQWehZebm0EVjLT+B2w
	a6kel6eBuOKnbGIZhQXpk0cUxbqOmqzT1PmfoYGqFXu19J7aRAHKDEP2PolFwshsKYFkUdxBbXo
	2tAGWn7J5ye/58RyJN2Qj7t7bUFcZRAd/IoEx58o+y6KXw9OEB8cxyQVfWMplT5ogw/lkJwGZ4h
	atTw3bC5dbCQgoCDBn70hrLOFapWWWw3slyZrPK4yg==
X-Received: by 2002:a05:6214:1d09:b0:8ef:b23a:d741 with SMTP id
 6a1803df08f44-8fec21799bfmr31057996d6.28.1783524403824; Wed, 08 Jul 2026
 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
 <20260630120221.1560-1-jaipaul.cheernam@est.tech> <562226.1783523796689358265@lists.openembedded.org>
In-Reply-To: <562226.1783523796689358265@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 8 Jul 2026 17:26:32 +0200
X-Gm-Features: AVVi8CchQQKRdj6eQWC8Lgh3vL74_VE9jGPuZG5WMBoDJCO4sLSQ1KI5prq2inQ
Message-ID: <CANNYZj__v9snkFZCUPpng7f7BKfMyspo07mcARLTVpRO_j33TA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v5] bitbake-setup: use bb.fetch for
 buildtools installer download
To: jaipaul.cheernam@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jul 2026 15:26:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19823

On Wed, 8 Jul 2026 at 17:16, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=est.tech@lists.openembedded.org> wrote:
> Could you please share feedback  on my patch ?

It's in master-next and due for review. If everything is okay, it will
be quietly merged.

Alex

