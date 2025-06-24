Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35881C77B7F
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 11:05:48 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.5706.1750763144158045015
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Jun 2025 04:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PAUA1SLm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3712617f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 04:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750763142; x=1751367942; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s513IVT4tRvvQ1csjMD2f/MV1ylFL7UnDhHIVSHEE2g=;
        b=PAUA1SLmbVE7cbfgiySgPZMe1jZSstvsIty1UrCg7mxRdFVbKG5jV6y5AvVolR0EUC
         aOn7oi0nHcU+JbMT1Pdv8LlFYv2zLO/3WY4u0siXKKUQPgHO9I+asLc6iA6omCgNuDdv
         vL24+bPpmTSgiLRJrbS+e/3bYHQMDKDry2s7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750763142; x=1751367942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s513IVT4tRvvQ1csjMD2f/MV1ylFL7UnDhHIVSHEE2g=;
        b=XNVN3OQjL3R9inP1SCB71vSKrarXU+vw+xKiwWopfqXdQquF6TK7AxBA2SMySTNjp3
         AyjGbHazYogkbnKnH6oz7g1CM11VLxe6msd5yCaIJOp17TEjjF+o411s7rXkVjIZA9Fm
         HcFImjoDUtnVl60LV5cy37Q5a6dfmw8MNrEs38YG1ohTfqh3uBJhBGDnnhupH3YtReas
         vw9UlMqGHrT7/ZmQ77B9pKhEe5/1dRnWLmAmyLnKkzieV5ueUQQz2Tg942eyRIxVreZ0
         zaGlNBNxsBpzCo1qeI/Zwjxum8Mjtx2wYCWGMzE3KFzcBCLNloYil25v4E2M2d4BoZCI
         y3Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXxu0sBiloX0CE3IMCFUijElXhsTW3P3n+8+itehsABkNwlAQxYYb052NOg3H7jgIxl1ehEdreI25MFT0ig@lists.openembedded.org
X-Gm-Message-State: AOJu0YxS/tD5TkN9XDi/n6mPKZGWjxD/al5689+HjZNdnheixpppEI40
	xmYoBv06EKrAlhuX8uEaUrBwMnpOIrvsSkiEx/oH0iX76fjn2nKwEVZHeCkScB5YhBjfKWZlge8
	elJwv
X-Gm-Gg: ASbGnctT/iO3oXqAWAL4kvy6/pe8c7HdSD0VmRdGYUWkMafSeza6yevRTSQuXUW7c4K
	sM+a5bWmfJleOGiAe6/s7SzQA+G6lVq0gZfJbWHv7LRvU0Ex+mUkmpNGssHDhesuOAMO+itBQpZ
	Jt1yJiynw7CcN+hUCI60zSiV59o1zhNGQhpCOiz61yJJxIe++nUhwk7KsKfsa3weTg8N2D5/rMT
	CtP3uQAn1UxoVXdKQXd1WUvjTOsH1DllZn0PJqmE2O2cTqsepgrhPEESx8loHlT2M/Om8z0A2Mz
	N5c10TujN4hgBlUr3SNkKyO4mWscLKsO9h1CcATpOeLdbDAwvRfaB0uXYR3DEKPkV5qoo/W65cF
	8bHEq4QQI87AThdKjMCiXGa4jUdHQWs+0/5E/xEIFCSNRIxTNvjM=
X-Google-Smtp-Source: AGHT+IGVb4nKgcjygt/xNvAheN+a/9KwkH90ZSJT6Io62FjoQMJDhseVSWWzNjDeppR7cKB6AqHUxA==
X-Received: by 2002:a5d:6f1b:0:b0:3a5:3993:3427 with SMTP id ffacd0b85a97d-3a6e71e4c9fmr2567755f8f.26.1750763142506;
        Tue, 24 Jun 2025 04:05:42 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:341b:1360:3bd8:8ecc? ([2001:8b0:aba:5f3c:341b:1360:3bd8:8ecc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810010fsm1669169f8f.74.2025.06.24.04.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 04:05:41 -0700 (PDT)
Message-ID: <b6ef0f8ccd21241c70d3e9da4effbb052d49b5a4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] tinfoil: add wait_for decorator and
 build_file_sync() helper
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: ross.burton@arm.com, bitbake-devel@lists.openembedded.org
Date: Tue, 24 Jun 2025 12:05:41 +0100
In-Reply-To: <20250620155512.3838976-1-ross.burton@arm.com>
References: <20250620155512.3838976-1-ross.burton@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 11:05:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17713

On Fri, 2025-06-20 at 16:55 +0100, Ross Burton via lists.openembedded.org w=
rote:
> The bitbake worker/server IPC is asynchronous, but tinfoil only has
> functionality to wait for a response on the build_targets() call.
>=20
> Extract the bulk of the "wait for events and handle errors" logic to a
> standalone wait_for wrapper, which is the build_targets code without the
> extra_events or event_callback arguments (for now).
>=20
> Then use this to create a build_file_sync() helper that just wraps the
> existing build_file() with @wait_for.
>=20
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
> =C2=A0bitbake/lib/bb/tinfoil.py | 125 +++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 124 insertions(+), 1 deletion(-)

Talking with Ross, this looks like a good thing to do but we probably
need build_targets to use it to avoid code duplication. There were also
some comments left over which suggest we need a v2 :)

Cheers,

Richard

