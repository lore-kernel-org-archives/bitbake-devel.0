Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324BCD6E60
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 08:36:11 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23818.1780302966246213568
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 01:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BweYE9tx;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccdef9f3d4so33577196d6.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 01:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302965; cv=none;
        d=google.com; s=arc-20240605;
        b=dmlHibK3pLxhkwqWuldNM7I1WK8nAC/aXrGxFlhZM86DLhmW7/IFjiB96Tbr30GCbN
         wPY6+nTZLBNOGbqTH15CuHdWc0uDkvCX3mjtvUr2CxfnJgLkPcPWv7n6T6+rJ0djfEIj
         epSlBunycESXw8EfZVmPEKDO1Sn9XrzfI+tYNstGuliVq3SYW4ik92SxA4ejjeOhWW9B
         BywHodl/F3TnGN3wYIC8lDpKUFk+O4yeAIaFfvjelTO6EdnEhPJ66sIJlS7pFrVnCUjC
         0mO9EivcxUHiTmcbJp8OsCE1R5drXrU//CX6cm1Iy+9ep470dd+eNdqjFzkq4tMI0bup
         ydKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nya4qOLBPWuY/eAHVM/3IK0Zr9EPupFTo/Sd/6Svt6U=;
        fh=0DBWFpB7lTWNvHWXFZpW+VQXvRog3TSR01SqpR4+kLs=;
        b=li2R7bxqk5S+awduZZvYK+rPbpMv8LHK5MjN/zkbTS89BsYsN9mVIHIN4Ge72SW40p
         rIyZX9M+lQ1Xn/RmtMLABRaALclmfdt/46AWEPf9jk1xeSC5raWgo3MZqaEjzAO8DVle
         75CbFMBvTAd/1f7N1Nv+8aTa3lOkGz2/DGrnL1YjbKV5M21x53UjU63+mOs7xj+qgBaA
         4p94OghyrboNXpAVjvQVcALEtPttq29FtZk83yrcauXRYxNxPo+8eCPkHAiqOKdp2ipT
         FXqLNR1FrH3BaLf6D6yUJpwys5jqAitGci2iyr8nfbZWqSDPlUXIV6WNJYOBKQsvzU3W
         pd5g==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302965; x=1780907765; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nya4qOLBPWuY/eAHVM/3IK0Zr9EPupFTo/Sd/6Svt6U=;
        b=BweYE9txo1WeAWq8zVBGtM8LMFfs7eum9VjrlTDJiNPlwvKhneFWEIB/GygcMcY8oO
         QBXnbkb56wDrE9CBgita4por3Tee2UEY0s5vXC11ZxaK0BXZg4Q1PPc1hiVZ9KqPy0JJ
         lpZC0PJmNJX8OcUIOw2DWR3M+OAuoNO1BHUMnrwf9ji/wKSEKJ/O903IR5NXpvJhuGLu
         7DE2qBmfv4Ye8uyG1VnhH6GVUFj3wGrWBKVw9bBDjNNy17l2DpwTcePoS7pFWwte+C9a
         jsnMdWpIl1e3LIo1GQhrLa1E5GUf3llIRRt/WdVniWTodPefPrK1MfTGuDvMNwenNRR3
         jwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302965; x=1780907765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nya4qOLBPWuY/eAHVM/3IK0Zr9EPupFTo/Sd/6Svt6U=;
        b=I2g4L0ucwd1OLwL1ezU2ZD7q2a/6F1StiLbsKkTHDHHwfzPSktsfzCt0JuztfljnFX
         +N7VYq7pUVdKigDReZNMDbH6l1L1GyuFgAz8Tjd9h6NB7UUbo92S8DObmnUyy3gPyw+A
         E3ivGJEYWDq4fZMU8IU2aqxJSdqM09KBqCxPgIOqEBJyelYcCuCWQUr9L23y0DPxIICc
         9JhYnyZoKLzqVRfqFP/GMcMc6ZMakE1tWvbS9Aef1fZ2a4NN3mDUjvyCvMoBxbB1gdyp
         KQ4JdP11XLWfvEO/HnHDXWLG3hE8O9wKnKv9yzZBZLp0u+NqyVFv1qobA+6k9QHTsb1k
         23lw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yg5sBCCLQSlxtuEXQSpGRdZPWncZt07kj0Ey0Q0sf8ftG7J4lcCMYBpWCzTm3zLgcJCQdW9R47GmqCnv8@lists.openembedded.org
X-Gm-Message-State: AOJu0YyJPd40mTsQJ55BAyODXxbrlbBMZrLNCmXGHTlrA7386YV76KNv
	w3+mhzqUFKcIAI+e3/YKIMr2GcbOnvN2j738rLfQmPtLnwGFUv+QOBWuUyXO6KKu6VWySSZVFwO
	Jb8QkXhOy9mNCcMXlOpd7FnsqlQn95lc=
X-Gm-Gg: Acq92OE0dskOIpIzgqCRZbCAsGHC8y3d7t2obt5o77XUw9eIenIrfY7M67OkN1OVkhz
	O52WgxkKcdWPJI9Hm0ypnHmhaEbkyTXv+YtFT+uirOZKG4pBPgQHXflmK5lKbl0WFCFMFJzrkqL
	Rj37+IOZrYmpxTTlGhQzUq5IGpAs6HbeskVBMa41+YQzjaK4mTXkxmD4KM8KybONk5oRAHncYMw
	JETwDxNPg4izVB7yYg+pyx9NGlhbK3EStRe5UxSS6/PSZXyuil6w30gexy28Vzj+MGXN+tCPXnj
	R44uoPRK8+5LHdP9dLZKGr9uOGkpPUQ0P7u3bYjy45qMJDF1k8GC
X-Received: by 2002:ad4:4ee3:0:b0:8cc:e14:9594 with SMTP id
 6a1803df08f44-8ccefdc5725mr166037176d6.33.1780302964878; Mon, 01 Jun 2026
 01:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bb-setup-notes-v1-0-a251ef1c5af4@toradex.com>
 <20260529-bb-setup-notes-v1-2-a251ef1c5af4@toradex.com> <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
In-Reply-To: <DIXISSZ5047B.PSMH6SMC4CF8@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 1 Jun 2026 10:35:53 +0200
X-Gm-Features: AVHnY4J5ujaMfZliNCBdP9-RwoBGG40N0BQf_BtIaag8ECKXpfHslV_cQLy9400
Message-ID: <CANNYZj-CovuQxxi6XUo62LxKs-sMjEUzFoLC3UsfWmuGFJTqBw@mail.gmail.com>
Subject: Re: [docs] [bitbake-devel] [PATCH 2/2] bitbake-setup: write notes for
 generated build configs
To: antonin.godard@bootlin.com
Cc: ernestvanhoecke@gmail.com, bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>, docs@lists.yoctoproject.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 08:36:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19579

On Mon, 1 Jun 2026 at 09:05, Antonin Godard via lists.yoctoproject.org
<antonin.godard=bootlin.com@lists.yoctoproject.org> wrote:
> Suggestion: call the field "conf-notes" so it matches the resulting filename?

I disagree. It's meant for general-purpose freeform notes about the
configuration; that they also get written into conf-notes.txt is an
implementation detail. It's also more consistent, as there's already
"description" which gets written into conf-summary.txt.

Alex

