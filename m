Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F0C4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 10:50:50 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10175.1784199050065757208
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jul 2026 03:50:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RHh7HUfI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so2400806a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Jul 2026 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784199048; x=1784803848; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9gknItkcddTBOgep2EV31K2NLWaewHyqNjGpNB61cWE=;
        b=RHh7HUfIZyFgMsvevxjBs+aS6jUxa6PYGgTQCAhWsJ6fXtmM8TbW3CbCxcIdFWuvlp
         u1INi1YObbQ6MZAYE+ICXdOOdm9fMbulysJFVvcvPjId5TzQAIB3k7+YMPjEeu9ZHNxa
         vBhWhKuE4n7cKkLBpsNbA4GwYmy25X3rQslVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784199048; x=1784803848;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9gknItkcddTBOgep2EV31K2NLWaewHyqNjGpNB61cWE=;
        b=XSCkW9+ssESOxGDZrOcYsxOWQEtSEKIgv2lzyd4N5Z34epY78fOI46qNlz0mrrbQyG
         Y4kwK0uXGbdCj6PSNeIiL1cbuXb2VQ8jViJMJIQnJ+kGkksZ3AFr/q1vXeZv6CaWH7/t
         zth0pdQHdWJ50ZorLWx3HMaOMe/6jlgzyc5vghBiaOhYQmxoHi+iemCwiRWjtiY+Plf4
         oNHyUn4A9SFt2fzJ/3y+Lyo6lZMN1Wav06CLnMaopFKaO/Wg/48yWDy8y399PUEf9tMn
         xN50arsRSt7VsOjVvN7Qq4f5mD9/VjzyaP/Y2jNxRZzoPIpKso4TU0KAIRdZhDRF36rQ
         Jtcw==
X-Forwarded-Encrypted: i=1; AHgh+Rqq2p/5DgJ5SYxYM49etEt+zJBQjSXZfJ9Xt5WOJ+ieYgOhsNe17ReSGwSyMXVuEQWtxA5sB8f0+9rYCBk5@lists.openembedded.org
X-Gm-Message-State: AOJu0YxWxwufifjgLo4CgR2zP1sDGkObG0vshUxP4FH49+AQooB25exU
	sH0T4czcIEuYTeyI92f3dl76ytdeSt2jDKyXCGxo0HX0f0LCs/xkebZMf7ppOhWWU0RfPRXmzps
	AShEdsJA=
X-Gm-Gg: AfdE7ckt8MoR25kXjmgi3GTKg+ydeqPhnD06dFjIOmyBDadmRiuuV0uHwtOhghBBmEv
	KkTUP0xnZLh/HHXOTkHTA3uHNKyHgXHNnHafo6EYNKm8o952UZqHMGWui2dn3x5pzn1omzr3ySQ
	f2rX+s37UJ+HGRfR/0JGSXYkCWexI/HnymnVRTbeDvdA1J9cGVl2ZIm0ur5VsjUe3cQOg0xCzwn
	uM53I5EqTqtM0A3P9JYxT1tBCU3VpmXDux10EOHjofosZQB7GH5nBfApO2feH3/u124Yo8AfeRN
	rEcE0ZaruUssdTM8ZyphZE0iIArKKvf+3y8cafN9Q1uF3UiJUUa+pMHlXCwSuasRV3MCusZcgKl
	aFcyMXDdbAF1P59e2+YoRGyifowXm0JLMEGTc1sdy97In4jR1Hf/YF4vF3wIONHP/qFBnAYil6/
	syclkHI5oXWAwqR/EUAuqd9kw/FNdKfdFnCqPIrqpVpevxBjo6nxa0JiXBs9BQteY4NwU=
X-Received: by 2002:a17:907:a708:b0:c12:1c2a:16e6 with SMTP id a640c23a62f3a-c16791943d2mr316149566b.23.1784199047916;
        Thu, 16 Jul 2026 03:50:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a03c:6417:d88d:c21a? ([2001:8b0:aba:5f3c:a03c:6417:d88d:c21a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871264c5sm194753266b.2.2026.07.16.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 03:50:47 -0700 (PDT)
Message-ID: <c478045e04d75850787d48e821ee6e27a9b28555.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/gomod: support pipe-separated
 proxy list in GO_MOD_PROXY
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: tengf@qti.qualcomm.com, bitbake-devel@lists.openembedded.org
Date: Thu, 16 Jul 2026 11:50:46 +0100
In-Reply-To: <178367645337.2070338.3995116335029500655@qti.qualcomm.com>
References: <178367645337.2070338.3995116335029500655@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jul 2026 10:50:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19838

Hi,=C2=A0

Thanks for the patch.

On Fri, 2026-07-10 at 17:40 +0800, tengf via lists.openembedded.org wrote:
> From cb7d8f5176781eb441ec83241f05ab272d4611c6 Mon Sep 17 00:00:00 2001
> From: tengf <tengf@qti.qualcomm.com>
> Date: Fri, 10 Jul 2026 16:54:20 +0800
> Subject: [PATCH] fetch2/gomod: support pipe-separated proxy list in
> =C2=A0GO_MOD_PROXY
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> The Go toolchain supports GOPROXY as a pipe-separated list of proxies
> tried in order (e.g. "goproxy.cn|proxy.golang.org|direct"). The BitBake
> gomod fetcher previously passed the entire string verbatim as an HTTP
> hostname, causing fetch failures in environments where proxy.golang.org
> is unreachable and a mirror such as goproxy.cn is required.
>=20
> Parse GO_MOD_PROXY as a '|'-separated list and try each proxy in order
> in a new download() override on the GoMod class. The special token
> "direct" is silently skipped =E2=80=94 direct VCS fetching is handled by =
the
> gomodgit fetcher. If every proxy fails, a FetchError is raised listing
> the module and version. A single proxy value (the existing usage) is
> fully backward compatible.
>=20
> Add two unit tests that exercise proxy-list parsing without requiring
> network access:
> - test_gomod_multi_proxy_uses_first_proxy: verifies the first non-direct
> =C2=A0 proxy is selected for ud.url and that the full proxy list is store=
d.
> - test_gomod_direct_only_falls_back_to_default: verifies that a
> =C2=A0 "direct"-only value falls back to proxy.golang.org.
>=20
> Signed-off-by: tengf <tengf@qti.qualcomm.com>

I wanted to ask how this interacts with MIRRORS/PREMIRRORS? Those
mechanisms are meant to be how we configure builds to use alternative
servers so in theory, people would expect to see mirror configurations
set there. GO_MOD_PROXY is providing a different mechanism, native to
go, to effectively do the same thing as I understand it.

I am a little worried about being able to configure the build to use
different urls to the ones it would appear to be configured with.

Cheers,

Richard

