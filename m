Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CE1C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 16:48:58 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39469.1782492529456509556
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 09:48:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=R5q2+D8D;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8e3d22c38a8so13467456d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 09:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782492528; cv=none;
        d=google.com; s=arc-20260327;
        b=nidbhsVnOtPHH/TyQyW61oNt2NsJpLpTELVQRxvO7Jus/A5eipbA0TBVJIFy6dq7jz
         QYA4QYjgmr+cpZlF21CbnqMeCj9LtfdyG+TL52Nchg7snjhVr/6VUim1I1ABe5CczQlu
         5kfNCvhpdrUz1CFAKnLkon77Xu4F8XoXTqQvKswos/Otprh6HrzSKtoZ4qY1cW4nAZA/
         uZMRKvhbgAjElNJ/28aHBkOo+JC6bncACUB/iDfKlt2UHxVF0PRE1fDlMKEViCUH+JLS
         L+WHiAxTIWGnoLVPhytyDEjJjucRQW196D5wCQb2gJ7Kwm8DxfElrYqnPFN28VJlsZwl
         kthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3CcFLq9R2GRcDHOnUrBvOwnCm7J2safkg1z3A/DKjjE=;
        fh=1sPeGJstHoXKVbb5/jKcge0GMtYJBQA5lpzd8iKNszQ=;
        b=RaAcb1HfAlh2KAOCPtbAl9V6Fsmk0GcGnqBhF3jEnUm6o585GR3Y14iFOE6OA4sbL3
         h3mYSuOv3ocMZtUUnrEJLPtIL609ldW7B8eH3BALyKVTZBrFAIWjhgjjdPKYYEs3jdLV
         CzpoMRYs7TvQXaferP08+qwzVMYsK9ObXgR0qQToo5Csmtzeu8dimuz/f1StzZNC6loa
         V6ML7wRLjnLa5uwf59NZuCzABrxF3kgfoXIam0HLIfCQ3ngrwOZ4MXtpOxwOZ8/P7BAD
         qQKoWuTzOEycRa3r4QaKW7en/sNBlYZQuGMdNjJA5TyWMImkmBWTe/UfidiB+wqygrLK
         dKyA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782492528; x=1783097328; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3CcFLq9R2GRcDHOnUrBvOwnCm7J2safkg1z3A/DKjjE=;
        b=R5q2+D8DhyfimbReHP9lOrHx+xQ7ZVPAq9A48DyOfmvcV+4V6dj7wOE16G0o/NbCLI
         YSv/7ukEMCVo8n4cVrimr+trTJSu49Ck060KtvcuOcg6x9gCNHHTX/VdlEz+w+fiJ3ss
         PFGffvRR3MwHKFPq58v3IE1Ug+2DXth8hMChIl6KnIjRj0PCy3LKpU6TWd+LLLyr8g0C
         IXUCIaDeRySg5K6r+nqejdMZSL9TiEDQtxM5AjAIdOX9QLTRpVWCsoXjuTq4vF1KoMbU
         URZd5YPLKJSmENx/FEVSHfNbpd5SWqOFV4MaEmneFAAFZhjE6qY2z4KKprx7F3QwtUDw
         MVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492528; x=1783097328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CcFLq9R2GRcDHOnUrBvOwnCm7J2safkg1z3A/DKjjE=;
        b=eDzCjEtCQv9X/TM9kTOMO7tut0E1dZUINEc1QZq/kmflmd3vKKEfvhYsN+7NwXB6s9
         DQO0xcJtG3nMlM5fCR4Gm+onEuj0xUlubqwhDzppcpfP9G+xMniPKeKNzlzTOLwgZg06
         tdQ87edNAnodSqku6xIXtFGZYTv1Oqw2/0zhUPTelOJVBgZyP1JCRDbHNQnPvnSmgMIP
         1ZTKZ/AZk80W2ijc2fm2K2IYbr/Z0v/AV/p2vp1ukfKA8cCkeBB7c2b2RtoMoZN4P5Iy
         nzvEDn6g8TR4Fb7Tc+CfXsLVdoaYj5aw7hBr2AO+BDfn93Fa1LD1iayh4wuM28ldDpy3
         GHGQ==
X-Gm-Message-State: AOJu0YxPVVYEMjGApBwUxkoN1eRDceYBE/1jkSG1WzZ7mJuyfRZy9Qor
	PBUkA1pvEC+tnMXvrpMG4cczHa63sL8LmFSDlTqnER0bva/9EGVqgeoe4s3IQU5WMM/6OSwvLL0
	qOric4TpDrcBDVZTf34UXxuFUaDGbF7c=
X-Gm-Gg: AfdE7ckfAnG5CX6DYKhugBDD+I4ZtSYcD17M6mC2txaSyeYAp5LYtQKZMTG5Xb717uG
	gYoVE2P9B/iVmhgmQ6NhK+8kePnlNzQMkRHmclzGjNZ2H6nEW6/bbPSH5epNKn67IFcauifrEAa
	FGSlKfASW1UmTqvQsKaAj9IBoVtgRfGuIeeCIwxGEW944ZRMZdhoq376mXfPvZvGrxW9tJjI1iZ
	MsA7qahIi65J93vkwK2TpsrlC1+GnQAsRL2yDrw6n5ptQMjlYgVZzD0tpLkp8LMOAOOJsz2Dw==
X-Received: by 2002:a05:6214:3a8a:b0:8da:f605:745e with SMTP id
 6a1803df08f44-8e6d57c0a94mr138790176d6.29.1782492528164; Fri, 26 Jun 2026
 09:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech> <20260626134320.36433-1-jaipaul.cheernam@est.tech>
In-Reply-To: <20260626134320.36433-1-jaipaul.cheernam@est.tech>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 26 Jun 2026 18:48:36 +0200
X-Gm-Features: AVVi8Cf77z3fy4TMQ3sy0KsgpegIM9JV1ce-PQHRHQVarOm0xkZulI5Wrz181Eo
Message-ID: <CANNYZj9buYV07NENuJZQo3NTznrVhhW2T4pruhrEo=+xyiH7Sg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2] bitbake-setup: use bb.fetch for
 buildtools installer download
To: jaipaul.cheernam@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 16:48:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19791

On Fri, 26 Jun 2026 at 15:43, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=est.tech@lists.openembedded.org> wrote:
> When url and sha256sum are configured, download the buildtools
> installer via bb.fetch with checksum enforcement. The file is
> cached in DL_DIR and passed to install-buildtools via --local-file.

Thanks, this basically looks ok, but I have a few review points.

> If no install-buildtools config is present, fall back to calling
> install-buildtools directly (preserving existing default behaviour).
>
> CLI overrides available via --url and --sha256.

I think there should also be a --default command line option, which
would similarly fall back to getting and installing the default
buildtools even if config file specifies something else.

> +    # Locate the downloaded file
> +    local_path = fetcher.localpath(src_uri)
> +
> +    if not os.path.exists(local_path):
> +        logger.error("Downloaded file not found at expected location")
> +        sys.exit(1)

I would rather use fetcher.unpack(), than use the file directly from
DL_DIR. It's better to only allow the fetcher to touch content of
DL_DIR.

> +    # Verify checksum explicitly (file:// fetcher does not enforce checksums)
> +    actual_sha256 = bb.utils.sha256_file(local_path)
> +    if actual_sha256 != sha256:
> +        logger.error("Checksum mismatch for buildtools installer:\n"
> +                     "  expected: %s\n"
> +                     "  actual:   %s" % (sha256, actual_sha256))
> +        sys.exit(1)

This I don't quite understand. Why is the checksum verified again if
the fetcher already did it? Why is file:// fetcher mentioned? AI
confusion?

> +   "bitbake-setup": {
> +       "install-buildtools": {
> +           "url": "https://example.com/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.0.sh",
> +           "sha256sum": "af76648b..."
> +       },
> +       "configurations": [ ... ]
> +   }

I wonder if the 'install-buildtools' block should be defined inside a
particular configuration. Configurations can be nested, so that still
allows defining a single buildtools for all of them, but this would
also allow specifying separate buildtools for particular
configurations. I'm not sure if a use case for that will arise, but at
least bitbake-setup will be ready for it. What you think?

Alex

