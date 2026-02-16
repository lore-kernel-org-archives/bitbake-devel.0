Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A0AE8382E
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 20:03:24 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2816.1771272195013666101
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 12:03:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ax+YqXze;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb5138df1aso225771085a.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 12:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771272194; cv=none;
        d=google.com; s=arc-20240605;
        b=KLFlXinI7IvzjG8RRAwCS/Al2+EE/q3BBYmLI2kcPOi52C1ldHmADEtwVsWeEQfllf
         wnhR3yWhNZmw8K1LzSIfFgoGcXmJb3/5kpFHdhURsM+RJRtkFTNfZc/6PoFK+r9rabBc
         dMGOkOr7UusImjzmXNTFOSVSYxvJO88JuiLqR5VncDEhfDW+AElVCxfMLYxIK+s2oG4I
         dYEYPlNdfXST+iULRpWodUbC2rFUE+W7UxV8v5OtZUd/GFZq3Kw5Qi1Koi/e1qyn/YtW
         HG2PjvSJLisJ2pY8BEnWt4AtGasyUs6giFmwYz/n/RFIIFuJI86v8Nh5Ar4z40nHhe/e
         zEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gEl2rKk2shvf4N0MVYCoK7N+julht4PWgxyy9VYwueU=;
        fh=DwVe52VYCxRR1B2FQOg6Ya8UlKIEUaBVfXXsGfdy/Oo=;
        b=O5Vl0tJh9Ch67Fkv4FP9AfadfH7oqEdmeQpmhgfVqFzowd2ENNNG4aCRbA5x1RLuL6
         CZg5xmWAe9EeIQGE4OG8sxnwmeFuFlQcfGp81G/e06GSv/Gfd9amGUTnYgiUtb/66dbZ
         o82ZNQWsEPEerL9wby0dhblk7NQU7w9JEw+KgLtwwm3vgQFMuPJ6EG+RI3v86wa/FzX0
         ebqRM/SPDSjkNAc1tDUjR5YdJvUnT+2Ut5xfvmGKOqVcPe/eqGjTYME0PX4tVu3PuY0M
         8kxEmX70UsG1G2kMSbNn7or1AJZZYaIRM0AvQAr/klyxGJG478avI+dbMkVACnzlTY6H
         1MLg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771272194; x=1771876994; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gEl2rKk2shvf4N0MVYCoK7N+julht4PWgxyy9VYwueU=;
        b=ax+YqXzeOMKzRYGOxXHciT2gZld40zycHZCg4X0yDx4Dfl/dbMePnZhxGex2ALvegj
         wbcIALYVsY0nI0SS4Exog/Uo69N8v/wB5NXkn6Rv7RpDW10cYQQgLNeO1oTuKGEM5FNo
         1OtZZPzSvl+vKCXZKuVLKAv5wqunnz2Q2LIm4jwygurlrDfU/Jajp99hvBe1RumHGF3i
         O3ZS7XXlzCwB4A7l7Luor56XVJgFtPcQpkW3bnRiTo/mlOEZYWNW1E73wS8dQI+CVM+B
         drB3NXzn5DWDC5KIHRxb9CARKfFbTnFD+F0Rg6JTYmwp7jT99hmcK7YOKP8JqpYCFhRa
         a1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771272194; x=1771876994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEl2rKk2shvf4N0MVYCoK7N+julht4PWgxyy9VYwueU=;
        b=nDeFVY0Xnzn3m/lq7OckVjn1HZcx4mkJNG3TuC9zogLLGXdcJwvZHaXj58W2qpNgxK
         jdod8R9YGgAvsdjBkp7WvFt1rVL+hPlUP0HWjC+Lg8xrRL94qRI4d9NTix1EEr98pFw4
         skWgEh7jlly1oKZ9Yv/SnLQV9KXPz5bwJk14QNYCCIRLULxS28MTlTXIvYna+j8LD8pP
         FaXjZUzeGqoyLy9NHeNHer1LmWKeeOvEwCU5z5gKabYRRg8lbm957J5aKG2aFz+sF25O
         FoDK4kU4MnA74Bd7skBH0SK7kHRwOWZhzltRrcB/shznR5CosEVgDUT6+Cla9g3Qh24U
         sxXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJvpIMNwwiIGyJmPspnCW+iA4jiUk61DM0o9tuFuIR5POzJvp0wdc4Ogoqj0aSFMl7ZOsSZcXb1oeyLQ2n@lists.openembedded.org
X-Gm-Message-State: AOJu0YyHTIZ6pqedV94NSEzo0mbh/a+pYqF97tf0pvTzCU9KLeUinEiu
	XOzV1dN8JJ/GkJ4JoLa+7UzBjryY/w4iHXovalNkV9vC7/BA5K4T5Yry/1X6vSelx2vXwraDkgY
	oGOChyNZv2zOJsedY/pVVVxXrD9Y3YsU=
X-Gm-Gg: AZuq6aL+GzEX85NY/g6MX/OEtmGU8JyKsdzSQ8MbvrXOr5ZkMvH4EKIsNkGi6AmSIBn
	osmSqfjhfVMNPchlHvLXNh8NGEZXLXBLgOyceS8QRhsSOLtYWqohEqI94/LQqAVc7Trt1SMq6wr
	oiItNyhpI8P+DyZcQL1cgio+zQcHIQt1J2UIO9iPK0483CxqhU87G/iznNeGp8/5pkgSRHLy7SA
	aCkSp7SuTgIobdg9Pcd91MxMvFbIEcSAXgYrFnTuFZwh5NOkCdf4vErTP8RXJ5EolhoTtruXJgQ
	Tr0YQCK2atTqH31cdMamxM7hwd1F7F5aHdlh72qo2ToYOQ5O6oYv
X-Received: by 2002:a05:622a:14a:b0:501:4a4a:c233 with SMTP id
 d75a77b69052e-506b3fa5d59mr112464971cf.23.1771272193907; Mon, 16 Feb 2026
 12:03:13 -0800 (PST)
MIME-Version: 1.0
References: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
 <20260213-improve-bbsetup-readability-v1-3-41cec3b06992@bootlin.com> <1894D252853C99A9.200918@lists.openembedded.org>
In-Reply-To: <1894D252853C99A9.200918@lists.openembedded.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 16 Feb 2026 21:03:01 +0100
X-Gm-Features: AaiRm53EtLuSuTJYkmdLusCZrbU3Fq4f0sjWd7c18PKzS7cHHplgG280R21Qtq4
Message-ID: <CANNYZj94DXwkDaucq4Du2Pnvv+PD084SmHU+URb6djKFuUf4Pg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/4] bitbake-setup: print plain messages
 in quiet mode
To: alex.kanavin@gmail.com
Cc: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 20:03:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19044

On Mon, 16 Feb 2026 at 20:56, Alexander Kanavin via
lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
wrote:
> > At the moment, plain messages are not printed when --quiet is passed on
> > the command line. This makes no sense since bitbake-setup prints most of
> > the essential information with the logging.PLAIN level. Raise the quiet
> > logger level to logging.INFO + 1, which corresponds to the PLAIN level
> > in the BBLogFormatter class.
>
> Can you provide an example of e.g. 'init' before and after the change
> please? The idea is that quiet mode is indeed quiet, e.g.
> bitbake-setup really says nothing unless there's an error or warning
> that the user should know about.

Or to put it another way, does the quiet mode do anything with this
change? Is there a difference between the quiet and regular mode?

Alex

