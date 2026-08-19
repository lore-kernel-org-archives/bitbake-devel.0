Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72BAC5DF85
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 08:32:43 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2534.1787128359313453459
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 01:32:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gVj4DC+d;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0cea8883so5507241cf.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 01:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787128358; cv=none;
        d=google.com; s=arc-20260327;
        b=HR23RmL0uMK9XNPR1ls6Hql95lsiwcvKUf5/v3cBj5lbJKlL9pfY0u2Ew/MNuxXaWE
         ic0InBuj+3FH4xKdV+anN6qGZzGD8tZk8VlU/hom11g9IiQRZq1fIz9e1AQO1ZNAYla3
         9cME992Hl+rzjS9R4vxayxXHK4ZgJuN52GSaRl3biCQ95s+lcUmnQIcrob9xhJf13fAP
         W2Gg2hPsG3AHOYLgVSFwgPfr1OwlfXyEoN+tTq8ZS61ND0yUJ/nKgCp39Y07LOAjO/Bv
         eTJYEfhhGinyiz/1FwfeVOZVJxSeQNTEB4FDYg/p08i1MZRiEjaDW23tMzrOU7RzXz+I
         jALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oqCt7A29G4WouiAYdmCW9OV3LbCwuKUUwLwWUUUguqA=;
        fh=ny6PMxHUNo4++t2P141t5Us7uiJHbbzKcxITfHQgk+Y=;
        b=ZVJRv7VmIU0I1gWH6cnv/nYOF0l8pmutV4O0eYVDi+YQBvD4PBzGO9M4CeaGd5JXIk
         F1+LFSES30vgRfeqGS2Tta0L2qFuFpvPCx9oyBgLwfucGJnYQsrLlcOk46FInCmtAqyb
         MhjDtCFdt/MigaFNhY8NetN4V1WhADWXEnZwg8e07xQA5qflPb5eeA0wI0poWXkicYPD
         ugg6Vbw3sl+P+1VvTdmYxQXVVaHVxHg3VvIIEM+tcdUghkJ+WoyJXr4HSdEQp63duTsL
         8+1mmgX+ggL4TGfw8Wpq0b6EfjF1u5L+PYJ0ccIOvdj/oQex3hOYPih3M8A8m4rUgagG
         bfFw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128358; x=1787733158; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqCt7A29G4WouiAYdmCW9OV3LbCwuKUUwLwWUUUguqA=;
        b=gVj4DC+dh96M6Jqiue5zBEFfx+AIM3ha6Y0sVuccx4ya0LzYtjgMrPHTMT3POeeuXt
         p37tU8KrYw1SClTm/jaVFj2qNKceX89DBgorun5OT48zz9l2oQgPT0jmRAdPGPn7aHT8
         zNRw5CWnUHX00RybHJfafMUefvh0JKE2Xfp6hnuirsYTqXo2eZ/PtjfFO+n2Pe9+sQLi
         lW5pmuhqmJCAeB8yNVmHsmTxODpOUMMrZ3v9bZ7YfXd0+mvJ4paAihtiXgBj1qX1dxAF
         QR7xcTfxPzP7NST+x8qGvBtKH47q5ZS2711KYZpFgT60MvOCp9a9NHdCYfpnOGujmDib
         s5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128358; x=1787733158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oqCt7A29G4WouiAYdmCW9OV3LbCwuKUUwLwWUUUguqA=;
        b=rNtdBm82siEdgdGTmrWUdIsgl6pRnicwuvFeSV+2akremGtyFISni+vb+TSsehdYYq
         OX0huwANAKoS5RBf5+hFriK4P8K9Ivz0J5/hXbOe6XoHQx1hCyLYqoDRa6j6CnxcxOSq
         KPtbUkeivc0QVaAyDRHSluX3VcrO1zzIARXNypV7G6EgJDaEjwOZZvLg6two/9wlPYn2
         Hlu+CPoMfPm9hIFM3Uwzl5MJx3ibQJONuMeyIeDBR9cqRwXCA23N8E0rfDU8BcmGZmqB
         F0g2dP/C7/9ARlLv9KTGBFGkBJFcmHBRRwZ1T10hMh57pr/d84PbQ+i3vjmyp82U8b0h
         KTYg==
X-Gm-Message-State: AOJu0YztemGjNMxkd1FpOxfkJNzGGOPfVX1j2x+soc+VwIzQO7eiWqQp
	vK5yvAfW3cbGMov3IKhpMLnvz7O+d47VKlbcevPX7gJiu0exOmRITe5acsYGb4eIiLrclVs6Utz
	qfcG8V+Kjbga8hC2nnwln5eu/2omc0e0=
X-Gm-Gg: AR+sD12gtxSSZMcgnHn3+DUdLKaCx1IwWiF8GAjCcBjwBZfnr+aNlYEpEdI8GgaLjDk
	8zGmnr7pIaS1n9Xm7S6l6dHq2DwDWkuJhYOJY84DKPUw4VeZVV5AxEWIMue4oqnfLin7mMG4ien
	4fcZQ/+F+pofEGw27wHbwCSHnIikyzokoKWPjE3386iMH4LpBp9DLuYY2UcPu7J3KpsyqJF93LR
	z5fawdrE9+OKgrp5UQx2T6UVEd7mp42FtYN5NOmFGVwOmJ3K9I/QkhDeIrt1jPKRzhKjW7eGG3m
	iPxMB2I089tFYYB4obw0HB+dn4LXF3mQy5Um+ip6A6IItBydvLKKoejyFIAPOLWynlD+H+2vhQs
	JZ7c=
X-Received: by 2002:a05:622a:11d0:b0:51b:fb5f:b263 with SMTP id
 d75a77b69052e-52dd43e24aemr24109861cf.4.1787128358137; Wed, 19 Aug 2026
 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260818203658.90975-1-giancarlo.cicellyn@gmail.com>
In-Reply-To: <20260818203658.90975-1-giancarlo.cicellyn@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Aug 2026 10:32:26 +0200
X-Gm-Features: AcwNN1Wrfw7L4ap3SM6NIGPlYz_WnWbJXTXFwIqwTzV5Eu-H9g6mPNGFwUQIgIg
Message-ID: <CANNYZj9S=CZzqBFOBdGzSZvyaUMA_+nsDDhf-3siOGxMNVBAdg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: preserve VSCode extension recommendation
To: giancarlo.cicellyn@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 08:32:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19989

On Tue, 18 Aug 2026 at 22:37, Giancarlo Cicellyn Comneno via
lists.openembedded.org
<giancarlo.cicellyn=gmail.com@lists.openembedded.org> wrote:
> configure_vscode() initializes the Yocto BitBake extension recommendation
> when creating a new workspace. When an existing workspace is loaded, its
> extensions section replaces that initial value, so the managed
> recommendation can disappear.

The existing workspace was also created by bitbake-setup, so what is
the scenario where it doesn't have the yocto-bitbake extension and it
needs to be re-added?

Alex

