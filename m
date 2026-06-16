Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC00CD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 10:07:06 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.150968.1781604420841528265
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 03:07:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FVryDzCi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c029505b389so296076866b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781604419; x=1782209219; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gytPknudJuztvQk7yrLXXqu+MhL5ya/uxX9xD3ukzU=;
        b=FVryDzCilbUtaBzUuKJHazsPm6NzDqfMZ5th6u2mAazkbdG502Uw88Wixv3b+akw3k
         qs3nEpdY0tm33dHtNgXhrQkg0oaGpHs1BCQiTEkPQoR0oy5LoEEXDK9EdgUaTDPu/idh
         /caWLx3nOkw0H527cBIwP6BLaquPa1om41Qsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604419; x=1782209219;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gytPknudJuztvQk7yrLXXqu+MhL5ya/uxX9xD3ukzU=;
        b=qRLwe3t1Zdcqj+NniL27ZwfdDJLLQKr0oFM9Lo80VQ57fFWIJxC5zH04oDlt6n8o/P
         4vlY+NzDn+3EaIDsavB8xGOFSsV0Bmioe4v6IFLytAPfP6FRT8hZYOE83TENL9oK14hG
         bzfx8yRm0E+fIDkUscRfz7u0l6s/NLWAuXZLVc1ChAZiwq7WgQ6ApoECaUfGEXNoSbBv
         Fn6Zgnkp1X4popSkhSKKZQtaZcYw+fIt2/R6jWhtRQlgbFlDp2yEn4OTdrfg8FdWa4gM
         qUEpsXNmo/vZqUM/TgqbM43o41TgM9mCisDO6+8j04uV+HyoBRxrIKBXsYc16CusRB3b
         Tusg==
X-Forwarded-Encrypted: i=1; AFNElJ86bynO4ltuyKzVN1hYA2KwyLDRcw7XKgV0X2oAzXNd4QzbC5kD0Aimxg7sI1Zx9CLcbPpPnIArK+aEe3qK@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw3K8i2xZn3x5MGvRJ4V3isiyQ+ucZFUu0CpSkNFowwi28hoimc
	qDZoIU61pWrx7I1It7knwzxh9KP/Ja3hOwkpoe1BWSmyqZgJahn+5z7yhPqxuXTRNiE=
X-Gm-Gg: Acq92OFYwAvcgWfBzYN8mTKWysVtN5gPrfFX1vXc5MrqHXhrSi7PlV+IYjkMSG+KGRV
	H25Al86s9zRgmgtqtfuY7DE4dZ3vY2E8T3crEK17dda/wIMrdthpYmeQinJj9trYURmks+ton5G
	QatJ5xrd3iqNWbUKmSdQtIgADLV7pB16kGYgoApA4+1C6+pUMeoi+cSTgyU2J7SjODgsxxpAM00
	nKWqQCuVV4cXtL/JRf+0u40Y5VMu6qvjMFp19v58AbZwx99xYwSHN90JYe2J3AAG7FE6jmlnHIW
	gt+GdfCIjlWlsF7Q4xL9TNQ9zoBWMBq344a6vrStr3/jY3Nr52F+ow8x1MsmaB7eJ1ztIJE4HK5
	5WEdnE0Zcwr/R6ns3/3U8nvLWRGprVlCQdNruRlrkp/Lo7jTA3mkhoIgEOY9sLmrUtJCpQrcekM
	Jo8B9yULslqDjAIhfysC/eokq+H3AHS7Dk3JL/QxOlwLJKG8LLbm1WN6pN4NWB0Y5Ga8w80dEFb
	EtZStQohcNOMjg/
X-Received: by 2002:a17:906:8a47:b0:bc1:c4d:cc70 with SMTP id a640c23a62f3a-c0416d0468bmr122170966b.2.1781604418840;
        Tue, 16 Jun 2026 03:06:58 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3fda:ff4e:923e:e0cb? ([2001:8b0:aba:5f3c:3fda:ff4e:923e:e0cb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb9013575sm628826066b.59.2026.06.16.03.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:06:58 -0700 (PDT)
Message-ID: <4beac8227f89f57e5ae0984a5163685132577583.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: pass install-buildtools
 options from config and CLI
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jaipaul.cheernam@est.tech, bitbake-devel@lists.openembedded.org
Date: Tue, 16 Jun 2026 11:06:57 +0100
In-Reply-To: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 10:07:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19702

On Mon, 2026-06-15 at 14:18 +0200, Jaipaul Cheernam via lists.openembedded.=
org wrote:
> Allow distro-specific buildtools to be configured with a custom URL,
> filename, and SDK name via an install-buildtools section in
> config-upstream.json. Expose the same options as CLI arguments: --url,
> --filename, --sdk-name, --no-check. CLI arguments take precedence over
> config values.
>=20
> This requires the --sdk-name option to be available in
> oe-scripts/install-buildtools from openembedded-core.

I replied to the oe-core patch, lets just remove the need to have --
sdk-name, I don't think we need that. I also don't understand why you
want/need the --no-check option, we should be able to tell if we should
be checking the checksum or not? If that means fixing the install
script, so be it.

Cheers,

Richard

