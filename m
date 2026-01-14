Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B90D29FF2
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:36:34 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8132.1768390593048718458
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Jan 2026 03:36:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=I1i/BBps;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so74308166d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 03:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390592; x=1768995392; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/XfkhhILS5Pn+/hgJCLd5EdWjJBHxDHASPFpSXQ9AM=;
        b=I1i/BBps/6CKzfN/Dwo79ADBcuM36Bvo56y9846eqosAOJlmnjBqYRh2cKo1QOvLbb
         xh+vxUBJnnsV1zPNH09kypvRilYDnw87j0P0bVJAGQoa+nEZ3IqJQ7F7NGHhLJcHG3Qf
         KuVRmmDYcWx59vJF98cPDBmq1ElJCLCyuMQd741TdNYO3qgayUfb7P8epfu2Fjsc2EXg
         qFBSTR2OfzlKGcnBNik6WEI+AHS2fgxxtHbDtJoJqG4RJQeCUmaUB7xRkAUa0d1Ciybi
         YzGoguDiFPgtfmyQJTLZGGPt/TX77S9cy8UJZV/0GSHcm/PzHLqHrSBW9ohO87ogXvHW
         rqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390592; x=1768995392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/XfkhhILS5Pn+/hgJCLd5EdWjJBHxDHASPFpSXQ9AM=;
        b=TVJGvOV+wDvx5WGvR/AGY+bPuPuCGtsEQxlaBjrAplM71NaxEibzt9vurQkobjPwur
         QLWsrdL97wjlzshYMdTI1M0SIEh9QYaxjALOm7xkUrxfVJUmFGeAFwf50V/G0XN8/bsQ
         BZvTxjDkSNReBWIS1doCcmJOfzihqLXj1GaonDm+pLLLTfxhV26LSNpH6xuZwApu3tsd
         SF2jLn2xXcoYYb2AF5T5lpc8LIFFPKSCD8qkWWUyveH3z5L1mfRUA9pEenyaPlT4giHI
         F65jD2whSIaBhQ0bjHQP4coaVaCc8QEozmJIe7YcZaYszKkvt0tOH/SVfQ5vmUsq2QzD
         si5g==
X-Gm-Message-State: AOJu0Yz2y4cNUKmD2fl2E67SC2JjKQgv48Db4XV6tj7Hvq2K9siwUhyo
	MZvAtyXqpxC6Ly9aOGVwMfDzHPyP3YJWZX4LVLSu15zHyTqNdesP2zNPUlYBc3Pf9+Ba0abKAI5
	UWXBKMfLG2Pm20GQttdLc9qVx/FwA5G0=
X-Gm-Gg: AY/fxX6zb3MkFAXO5vBNGwNRvn4uhVKXPwxLeilN5NsB9it4XAHKB+tnO4+Y7qoPkJE
	4kfGnQM8UlAm+9jHNHCgacIt9PMMn45rEMaw2XS4r+Uc65Ag5hed9+AuzPWxPa/FZHomKnxj6eO
	eEaOxo42vWry+JlqaxKlb2AFraB0Pge1etvcDotfecMj9rvY3kzn2oZvCqNWDGU50LBAym27qKp
	nypI+h8LCnkMxVs0O1UsM7LKUI67dS+SNh6iXZh2YjraSyWRMbpPqzTLutTId/8h9pXd/Ug
X-Received: by 2002:ad4:5ceb:0:b0:88a:529a:a53a with SMTP id
 6a1803df08f44-8927443262amr31611876d6.51.1768390592015; Wed, 14 Jan 2026
 03:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20260114080414.2927046-1-alex.kanavin@gmail.com>
 <0adf825db9501818398a9ef04752e4000bd3133e.camel@linuxfoundation.org>
 <CANNYZj8fqxz+jVu8_eWBaCCGCaZoWA5dO5foPTKWnNOEoH3c4A@mail.gmail.com> <31a6956818136b65783063d9b5e946fca25ce49f.camel@linuxfoundation.org>
In-Reply-To: <31a6956818136b65783063d9b5e946fca25ce49f.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 14 Jan 2026 12:36:21 +0100
X-Gm-Features: AZwV_QgwH8VK8VfFA23mNmwGB-IGzsBi6alRFxcoqIP4JbZXAv_87ZWh3UKycGQ
Message-ID: <CANNYZj_K36YQ4QvwxLUvaOwguERp_S54kfUZSpdSr1ejJ4CQVw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: use internal registry if
 run from git checkout, bitbake repo otherwise
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Rob.Woolley@windriver.com, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Jan 2026 11:36:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18753

On Wed, 14 Jan 2026 at 12:14, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> It might be worth a comment about the design intent here, something
> like:
>
> # If bitbake is from a release tarball or somewhere like pypi where
> # updates may not be straightforward, prefer to use the git repo as the
> # default registry
>
> ?

Yep, I sent a v2.

Alex

