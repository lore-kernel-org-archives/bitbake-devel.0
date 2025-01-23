Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC610C02181
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 00:01:26 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.1.1737590473617184073
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 16:01:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bs9Fzr7o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436345cc17bso2263245e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737590472; x=1738195272; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVd7kr2nRxj3MtjyHX48JoqvbjZEV5VKdVcxAjEn+aI=;
        b=bs9Fzr7oXk48fVkhtadMJ+ARLzWQkk2pAsUMp9CKG1g1VQt1SQIt1SapKW0hlHpCrv
         V1WyKqPN+Hl39u9MTYoCl1ReIU7jJxLUgXx+v2Hq1PVbnIgR65jh2rD2A616/sH/rQrt
         Rvz7hB9wg8ax3nHtSOGGvOmIBlgnXkTlZWOn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737590472; x=1738195272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVd7kr2nRxj3MtjyHX48JoqvbjZEV5VKdVcxAjEn+aI=;
        b=ogahK09fhGHBTpd7Mz8fRaPurRk+Y+V3vAmIC4YIpceuwlYB+U8WUIiGL4OfKeySXF
         K59voUyZhqT7csbzODmE6ZECiOcrdluH9cWD2nahE4fEqnzUsCYBdjjaIfSqZxjGTaI5
         +erh5vfbtEHHpK2wzWHS/pbc6khT5M18JdbW2kmURqT74zGDJ75iuMEa+R72PKmQW+VL
         M36skgVrpPq+dWbzVaa0apN4XBqvlnrRsDYDE9P1A37HQuUSOeCei3Wl98yTwDZDJ1KU
         lN7WYzjRV5TKPVBI1HzDANWE2vE0hHWgz6Whk0n6IWyhVdSZnk82Z1sPHqfc1Tl1sL9U
         +qgA==
X-Forwarded-Encrypted: i=1; AJvYcCWMvUH2AMZe5WOdWVXSzmGoW6+Cj0ZCKk9tr4fs1T8/ONThZrTdnC5iqpHU2tcLhOMjB6JqxbruuQTzf4kG@lists.openembedded.org
X-Gm-Message-State: AOJu0YwWQoR2/5tbDruJzC/2dTrftZPVCaZCa6xZ0ImO3huUdykb89PR
	z2XD6ttXsn8xpzrWQQIpWtFrRozhkauBSO47YvmQj/LDrqAufPrswm2uzCk4Uyj9T5noy8Qe23V
	I2lg=
X-Gm-Gg: ASbGncubdIdv6aaNAgUlUA+FXyGsLuBEHDfH7ncTcJmiGqD6WLc2N7XYhThtVvOo5z6
	nhLKNPLipptkI9+g8QnN2PJ4Jp6gZWPIfWUkN3I/X1n/o0kFSvOZ8kgoJ/CJpbkRajmB1mSyotV
	8Kn0Zd76yy1o9JxbP6DmaMuybYaqQFz47QVgXoPbgDsrsg2GV3JnZYjzESXJS00ycf/X9rmqYWi
	afdKI5OciSXqhjnSRBGnJWMoqaxnbJKxKUJfct93rtcOdV+VCJ/duuq+QQ34EA8SBzrANvpie0I
	YxhLzIoRYnpua/AClL+701rJy7BDUNLRh1LwdgqiSyHJjm8OvAIphsu9FN8=
X-Google-Smtp-Source: AGHT+IEfJC/csthx7UhST6w6ulvJ2eIq+KPCIPUDplRI6osDshV6WdSmD8AdbaE1RdS4UWZc9SdQ0Q==
X-Received: by 2002:a05:600c:4f48:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-438913cb740mr242481715e9.12.1737590472074;
        Wed, 22 Jan 2025 16:01:12 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:da76:a423:32d0:6ce0? ([2001:8b0:aba:5f3c:da76:a423:32d0:6ce0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b319fad2sm40806485e9.14.2025.01.22.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:01:10 -0800 (PST)
Message-ID: <4c4373f1f496cf2cf3cba8f1716fef7b21871d4f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v2 0/4] bitbake: knotty/progressbar:
 Optimize footer update and prints.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: egyszeregy@freemail.hu, bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jan 2025 00:01:08 +0000
In-Reply-To: <20250122232411.133-1-egyszeregy@freemail.hu>
References: <20250122232411.133-1-egyszeregy@freemail.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 00:01:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17064

On Thu, 2025-01-23 at 00:24 +0100, Livius via lists.openembedded.org
wrote:
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>=20
> - Check file descriptor in ProgressBar() class init to see if it is
> resizable.
> - Optimize printing in footer update with use a StringIO buffer.
> - Use 10 Hz refresh rate (FPS) for footer update.
> - Cleaning and refactoring prints in code, print() functions were
> eliminated from all loops for better performance.

This series looks better, thanks. I still have concerns about the first
patch and I've replied to that one.

One question that still isn't answered is how you're measuring this
performance improvement. What issues were you seeing (apart from the
frequent console updates)?

Cheers,

Richard

