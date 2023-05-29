Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547D1C7EE29
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 13:43:24 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.49688.1685367797736168291
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 May 2023 06:43:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=iTV1oPm8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f611ccd06eso21717535e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 May 2023 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685367796; x=1687959796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vU72c+o26H/c6+pu0hO/lpiACoZ6ivs+Iojcp0Ekm0=;
        b=iTV1oPm8QHUNeFF4Nt5HbYBrc39gbErGDMssd1QNpLFNCTlwOGoKBXGfMoGMokMIy7
         /vNSQ3RjKz1xqBu824o1VDy4BXNLdYVjrfN3VA0dGaF7cXPF8FY4WDLc9MHickNJH7+y
         x7EYs2mtlMxrDivrxYAYqohlHFVN7PfmmaB7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367796; x=1687959796;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vU72c+o26H/c6+pu0hO/lpiACoZ6ivs+Iojcp0Ekm0=;
        b=Xuzlg+bTvNYyGPcHJR71zqhitKUpXkourl+lBqUogp/zMRTBUgJtDie4QOBFbTbpWX
         BPvo+MzX27PtOUJf6aKtzKKGK/QQTy7rvoU8w5xVtOnqruOvntpPpVwapi9SDyHJGkDN
         9hfkUbAd6HvnjBeOrnn3CXrsLd6G1DyN4YcVIeFclA+yuKSL7W+RBiPdWBN8gR139LyI
         Ell/rGxVs+2SKiznbYelyeH5JgzryUk0lhJ/T8a0vPd3RgVTW301UAKcIpx+jaQWl/Sb
         PQo706NgS1ZN8jbngEtx9mjXxcKBFe6DSnXiZwAdaVkOi4Y4TfSoyBA2d3F8Oy050MxB
         MB9Q==
X-Gm-Message-State: AC+VfDyD2YeYeEiB/fVojGdgNzovWcE8b2xn9K/33bG1gjxHybGhDiHG
	KC6Eh1fDqtgPT6CgMGZnhaQSig==
X-Google-Smtp-Source: ACHHUZ4/nJPjmLdBvTpk7AdOGeHOX0TH2qC1Uqzq2hzTbgq8gpbP1QZGZaZ1ENNfoTv8PrqgcMYKUQ==
X-Received: by 2002:a7b:cbd6:0:b0:3f4:fffc:add with SMTP id n22-20020a7bcbd6000000b003f4fffc0addmr7842105wmi.27.1685367796159;
        Mon, 29 May 2023 06:43:16 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ec8d:e49e:8d5e:e7d5? ([2001:8b0:aba:5f3c:ec8d:e49e:8d5e:e7d5])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4585000000b0030796e103a1sm42706wrq.5.2023.05.29.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:43:15 -0700 (PDT)
Message-ID: <780970d8e09c0319c34639f0d3a9ee40e3aeefe9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] reproducible build and yocto sdk
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: kenth.eriksson@infinera.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 May 2023 14:43:15 +0100
In-Reply-To: <MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9@MW5PR10MB5713.namprd10.prod.outlook.com>
References: 
	<MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9@MW5PR10MB5713.namprd10.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 May 2023 13:43:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14817

On Mon, 2023-05-29 at 09:53 +0000, Kenth Eriksson via
lists.openembedded.org wrote:
>=20
> I'm having issues with reproducible builds on kirkstone when
> comparing a build driven by bitbake compared to a build driven from a
> yocto sdk. Can I expect reproducible build between bitbake builds and
> sdk builds? Some produced binaries have minor differences, but larger
> c++ binaries show quite huge diff. One common difference is that the
> ELF header seems to have different OS/ABI between the two builds. Can
> binutils on different host give such a result?

This is probably an OE-Core question rather than a bitbake one.

Offhand, it looks like the linker is using --hash-style=3Dgnu for one and
--hash-style=3Dsysv for the other.

Cheers,

Richard

