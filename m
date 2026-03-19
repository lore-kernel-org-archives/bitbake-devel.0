Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5231091926
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 21:25:09 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6891.1773955502540733950
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 14:25:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Uw6RJJbr;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso23381266d6.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 14:25:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773955501; cv=none;
        d=google.com; s=arc-20240605;
        b=kvlm4i03PMyCWt8EaBf8sIvtM0MZizCnTz88gJlmFy6jhgfQloVBWwEN4DJJEI6mcG
         sJtMVM2CYfn8ZZ/sWNkMtkmzyc8mqHjwkndocXPJYTiqxnTUycnrfr9aP5mgJ7/9bt8Z
         HyRU/VpDdgpOpdwWX3qE+xr6JUv/nJNcgSFzc2Qx34QPCKE2CYfIm4+8SL0Vo90e3q9s
         dsqVdSiWy4U1Ndmfu9m+FIJBYIPZ6QQ/krXZlL9LU1mV6KK2xtz1089IIVnQMsqgVAJq
         +OaI+3/JZC0dSKVKfvFXC5DQCUmavWzSPv868lRcmgTcs7gxEdEayCA9xmlF7L9SQwFc
         Ed6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=olw1WgdQxwtNFB8zEEugAG+rJlZoAokqGp78FwnosoI=;
        fh=k1yhGSfbC8ACgl7gRlbDMTW2hSa//jg7bNMfK6qiLYc=;
        b=ASSZbZgk/cFBrnFkVQMmw9/ZQi3UxfusxqFgOSCqt2uXrHVW35cp3f7sgYI1jWDmHK
         WUkyKLSkRrZXexRScp/RDGz3wW9pjBKYSR7olrBCP4rkEZu77x408sadFqojWoXvPf6E
         ltvdY3/3zXrktGBbi5PyDwDfpOLTdh1QL7N5Gahcm6ednOQ3fr/r68EQHJhrzUjgQ1kF
         1P18sjDma2EcM1/yTYZuEYz+w13/oC13o/amrwSj6ROMU6RKRLqLhvdvtOf7OlLwHd6M
         PSMkzZ2OjlkrRwHWAkpJL8FWxZSxYDnocWpIKbs+XkXcl/9zflp04/pkecGgCVfSOjuo
         65MA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773955501; x=1774560301; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=olw1WgdQxwtNFB8zEEugAG+rJlZoAokqGp78FwnosoI=;
        b=Uw6RJJbrvsqabtxzonzqCR5RoUoA7QBbnNOVuI7y4LIZkwNkEu/VlfxTJaJHxktAL+
         Sm4IFoUUu0RWBseTwU2pHQ9/DMzNpUMN8pon4E+b7MU8XFIR1cYz7FWKek/QXhk7ZKDl
         kGnUrRJLCimBEeJd1KpyskKfSJZLDcV/8JYpaBMxXD9ReTtwWr8LtVP7c/ToEAQpUZ6L
         +jzjWfUAfmAdk2s6Iojv3uYVKau7zRFRpygMbbQDBVgIK3BB+/NL/wbu9B0BfgPyE355
         R6tScWVHy9uzNYA1n+VB+ROD0FAj51T3Rzy7GsUsA7548TYTMMgLEQIDo4+sWQu55KoG
         CovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955501; x=1774560301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olw1WgdQxwtNFB8zEEugAG+rJlZoAokqGp78FwnosoI=;
        b=RUQWhuXALkOruty85UGcVnS6F75q0ZpBM5/K6pUwQ6vifwkqMLoWy+Jo53qJ3MsIT5
         1FPLkjoeeaDGSHt7dG8hCG8mBOYzKGTVi1dVDpg83wmlppREm7pxtl7BgN6uNxdMn2Ji
         UgJDwwCMpH/YZdPeGKtuxMNFFs7go70iitOsmiVuru8T5qXn6+DyPPfW2Oyo2IhKbPNM
         cOeSROD4uWPYD2YYusBDxz0ZMtyt2JzmDxZS7Sa6M6PFm8aces3Ju7iao5j2d1+2EQ0D
         WhF1xhV/AmWjtWbcBesDt7r0VD+Fb54MYYX2hvAgFQhKCrgCNLn0cxHIH72FYx9jgM5e
         xVjg==
X-Gm-Message-State: AOJu0Yz8v2g0S1ZQyXa+23UmEx1V9v4/fayB4ftdeOgiiaQa/wAVY6j4
	5UoOlHJ0cVMboGEeeLo/ROLff7pyCY8UUHJCZ/abQi+m+vKnTISnlviooJk+yQe4qFqnJu/sTgB
	INnX1qx+gjoYfLF1zKk6N83LqNc+JGRk=
X-Gm-Gg: ATEYQzwV16/eTbkv2r+XxHOwJe2n+ulM4PmoI6iK8ss7uf6c6lNV4cpbiLihuBrJq9d
	ize5T1RK0v59ay9v+n4VKdcjIaLEySGZIGz/4cHljznJ3kGul3UjDmyEZTa+vX7aXc6fP6XQu8k
	iAjNyNq8EPymBAF7LWNQGeUWoDRhIoI7KtIA81t1z34vrDZEm6NyDYrwm3tE9+0DUrYAPjL8K0P
	6zbM+LalNbV46tqgbHLtNVREm6YzSwAbFysXDX7s/QI2MGb7l0le4TRTabJBvEJvzCzdB/v8NY3
	RnHfy0XCBhLd+UBM5+cAlzKKm3ocyMA5v4tq0hmMag==
X-Received: by 2002:a05:6214:3a86:b0:895:7864:f69d with SMTP id
 6a1803df08f44-89c85a55f06mr10416726d6.40.1773955501244; Thu, 19 Mar 2026
 14:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org> <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
In-Reply-To: <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 19 Mar 2026 22:24:50 +0100
X-Gm-Features: AaiRm53yHu2fxw_z6vEnz4Jg_Nx8BwJ_M5DmXZluyFU2uULIXLfZ4VDxBRByyeE
Message-ID: <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode to
 the fetchers (git only for now)
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 21:25:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19176

On Thu, 19 Mar 2026 at 22:05, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> There is a bit of a debate on this line between Adrian and myself.
> Should we use:
>
> git status --porcelain
>
> or
>
> git status --untracked-files=no --porcelain
>
> ?
>
> The difference is untracked files. The rebase will abort if an
> untracked file is changed by the changes involved in the rebase so it
> will allow untracked files to be untouched and should be safe.
>
> I had thought we should exercise caution but perhaps that is ok...
>
> Any other opinions?

Yes, actually :) The bitbake-setup patch I posted pre-empts this check
entirely, by first stashing away everything uncommitted, including
untracked files, with a warning to the user. I want to minimize
various aborts and errors on updates which will cause them to
half-complete and leave the checkouts in an inconsistent state. I'd
rather stash it, make that clear, and have the user handle the
un-stashing and any needed conflict resolution after the fact.

Alex

