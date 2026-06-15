Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A9CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 13:32:12 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.129696.1781530328375496050
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 06:32:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=g6Uuuf6r;
 spf=pass (domain: gmail.com, ip: 209.85.161.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e59978deeso1327600eaf.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 06:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781530327; cv=none;
        d=google.com; s=arc-20240605;
        b=PDTsoSIs/1noOgxoTw4wEvE3ITelSuRCIH+HV8y4KlipNuYLg68g4PYt3hZ6Bdd1PL
         uxnGhVOh14WuVw6Kn8gaDxmY5T0VDdgxU2QLnRMIdwae1vttvOgyPZqIx9dZxUVzyGsb
         M6tmIFVabb5CJo/sfSHO6c+m6fjDjazNV5rtSVjWOnCaGgJviZHz/x9UsjfvM4KxzG17
         LATXPQbIsw/jKPdkg2/5rZkiFyym170ytBP+4MtRe2tidUYMLUql3VKUHYOOubpHOSgJ
         ofz8BFmgezJML7SVzqYHaXKgcmlno7sULONJcKJQGI/PeaNyEMpUHCrzMNzl6dlGme+b
         bJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AcYesSQCcO1U8HDvKT/pK/iN42tQKpSA91BO1vl5HJE=;
        fh=1sPeGJstHoXKVbb5/jKcge0GMtYJBQA5lpzd8iKNszQ=;
        b=D6ovF1cpStxfTAsgwVxz4uCDK05ljg0a+YeIwfxeeE7+ti2wAAken5KbOCm04XZbEu
         5+RsBFhPQdrblhXvJCR2XHgEZ3d3suQd6PI5raO2CiR4NScW6X4lv/tYR2g63KW+LtEe
         tuy8L5gOiLmoguA0/3c/6ijfmIyB3wKRZhymNf1TJIOlJUa1Ptm7FsWdTEKGYjPiwB/i
         o14rAarS1RIoLkrQPZN1K7HzwPhxFBKUie+z4ND8OldI5av5vwh89EzMSyJTGFCKxUAL
         1/4CIbRbXI6Z4O4uFMMhlIORig1RWuD9pCNfhOunxO4gvrDPUJJCS2UAX/JvHkO6M4rZ
         jdzg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781530327; x=1782135127; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AcYesSQCcO1U8HDvKT/pK/iN42tQKpSA91BO1vl5HJE=;
        b=g6Uuuf6r3FD7rC/oMN426FpmoUxbwmaiK1NS6ckmruQpu/e9FaPauBXbgipyYh29bF
         IAsm+OsezsVoyD1/nOMuO5RaKJhbVqgs1oPjO2ukN0xPvAColVMduzBrIDeWhgL29nRz
         AiHOzJjzhHfGuuhCzJ//l4l/KUTfk7m8Yea/oW3XtCV3m4UEy4gcLDAjI3z5UHSquns+
         /jxca3tWMgVMiKy+jBiSPJC6rNFjRIzLJyRF6uCIciYZvNGCrWhIFZldJZXlHlIxJAtn
         iGKQqpM+qtsPPK+vM+pESk9q2fJRsMA3aSKl+S2kp+e9M3/vvLZYzomWyoe9LdJwL220
         CkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781530327; x=1782135127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcYesSQCcO1U8HDvKT/pK/iN42tQKpSA91BO1vl5HJE=;
        b=F5AbBj9mJ9X0q7Gim/RirljbDO2h+NRIBxxwmZSX2woSN28daZlmoOn+hsBshTlrz2
         10yfW/TTk5s4OyCYuwCQxLhEQBa3FjjGdUxtdhuhgmr8TIWyNz11MmTh5cRWDCPQPa9n
         Y79AwgDcG6/wSJ2UfXvojYJ/mfaQ/KdZ1zafJ7nTwQQUoNdCIC8CJQw5z9aqdRXh11P/
         V8K3ZtjxXi1Q+guDeyu78d5LBSwDhoYQqKpYwFn3TRWBQI6wC2F1fWBoiWlUGzqD4nv5
         w9wAQfRBeWDLyyg/yp0oM1lCYt3SI7xCP9+6jgoJ2RZsuHYbEbV/8BA7q8PTVzBtFtKV
         TqkQ==
X-Gm-Message-State: AOJu0YxfHpnqEeAGwTzkMD1EuvzphNx1GWTNTkbWdVRsoRUa6XU6sr2K
	+vPtlRzGgBVmMbyM67QzKCa0RKBBcf7HbYXWV8KL/YlM5+vdsol4H23NsPY83uvCYCUKC5ID8TO
	DuffuKGNpdxp0IP8csEdWw9vmx6dziyrj+A==
X-Gm-Gg: Acq92OG2aM4hr0D2O9+//kVvcMgme38OQ4RSxjxVP2D6sdFaz9MLpMwwc7hnwGGsf2v
	mSneoAZODICO8hILFwakoSabJ2ZAnBOjWczfm6SI+tnN7NbR6SI0stthBgjhLan4H+VGmCxy6Ye
	DG1mMcG9wpC7kPs2T78K23B4DTCd0jh6eD/GuB6NUvd5iCNfiytaGRl3cHE5stoxW1XXjdPsPzS
	LOrwIsKFXPYBEOldZc1rQ+fTloj9QG1QPbHeEnzSKZNuVbLOPAnpt5CujzELvnijUD/Fkr1RnBe
	h8cSt/2elzLO3XvVekyoQRP/2DY5jkDnCKPAFwiLew==
X-Received: by 2002:a05:6820:1621:b0:69e:3741:541b with SMTP id
 006d021491bc7-69eecaa0d80mr5897762eaf.51.1781530327401; Mon, 15 Jun 2026
 06:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
In-Reply-To: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 15 Jun 2026 15:31:56 +0200
X-Gm-Features: AVVi8CcM4t2KKZ4nN9GXJLxgflRe8PCW4v9dIhVFq-tFCXYjzGR0WylXqjKHtAU
Message-ID: <CANNYZj8ggqRPVgpnnX1Qtn5-c-b6=xE=FbdSsnrPt-hMUVKGng@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
To: jaipaul.cheernam@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 13:32:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19686

On Mon, 15 Jun 2026 at 14:19, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=est.tech@lists.openembedded.org> wrote:
> Allow distro-specific buildtools to be configured with a custom URL,
> filename, and SDK name via an install-buildtools section in
> config-upstream.json. Expose the same options as CLI arguments: --url,
> --filename, --sdk-name, --no-check. CLI arguments take precedence over
> config values.
>
> This requires the --sdk-name option to be available in
> oe-scripts/install-buildtools from openembedded-core.

Can you please describe the use case? Presumably this is useful in
your environment, I'd like to understand the specifics of what you put
in the custom buildtools archive and why it has to be there and not
built via recipes.

Alex

