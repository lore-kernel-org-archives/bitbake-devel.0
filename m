Return-Path: <zhangfei.gao@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5579E9A755
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:51:15 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16220.1774345866028467800
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Mar 2026 02:51:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=DECYwwpI;
 spf=pass (domain: linaro.org, ip: 209.85.128.169, mailfrom: zhangfei.gao@linaro.org)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79ab0e9c724so12338797b3.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 02:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774345865; cv=none;
        d=google.com; s=arc-20240605;
        b=WJpHJTXEE+3b286qSS8L6/MVXc2N3oCg8iMXfE5JbsaAPTKoYvnGxXSy1UpWSxBfBa
         l7IV/CarFq56cTM2Ms5xq/1D/eKO/hHB8a/8YUsbXqrIsDs3XYDhdEc/NelSStPLfIDx
         SrSGuu7RBVD2TTbWa9xS03Zj2H9Un15ytBsFD4aSKMX+hZFj1OxDjAOnyktNcdzqvykZ
         ES3Sz8StTEWwrv0AADEmEe6YSf+FIYQgsvXGdE8KEIkqCAFDOjlulzWud7tKCRA3m0cQ
         a1MmR7+ERxuhJecFWbSucFVDw+RDFfq33Ie6Dnaly8uwAL/Q4ntfJAwsIiiyUf3Gia38
         GIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=cuDbrua0yFZotn5hdK04poyfzvYg2VjKyp3W8hAQl0Y=;
        fh=khSXsbLRHoN+BlxcBQl3HLVnzQtvEgisVj721t+OlzE=;
        b=KpAes1pY516bpG76AXFtELaA0zSnYTqmC7RYzObNirXaAvFIWu8I4ayVNRoEBEQ6Yy
         LIRypki75eHEUEIkES6SEE5JXfd4uh/5T755iI6BEJauFpjNQjZ4z2DaTjsuw7XUusI2
         UNmiAyuUoUdnzWekFsW42yATATWlHALX39TW9YOyL0uceJGkDUnaVt2mSwr4kUgs7AB7
         luuIpU9ucFYWxzDEbR0b95JcC53v35BwMp5MVJNaCBUvqhPjWqN9Gi/bjFE0oMkQ/m1Z
         A3Bw+sXSCS5oTpHMv9+/t0atu0LhphQXSqMTniOYfciS+cgRE0QeM5aD8EXJyX/Mb4GR
         Kx2Q==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774345865; x=1774950665; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuDbrua0yFZotn5hdK04poyfzvYg2VjKyp3W8hAQl0Y=;
        b=DECYwwpIl5sy9fHycE/B5NwRyYRSxSxp0n0TgLI4+u8OiYYaQWrm4at6xp1EQgN000
         txBaKxz0wPNYnDPnhs8locOcjmZEWe+sx0y7FhgiavnIsYpfWESKkw51QOOW+01jJRYT
         4gYHsC7iuIXlzDjEKtWeF3RZxB9kemrTygqntWYzLeZcp8Yy8FFDPwVVx74HGJXnx9cr
         dq+zwSOlKKKSpbPsZrohg6k1HkHn6BfmsS2Y96M+noJZmYr2MHmqvhGVOfu5/meNeWwu
         4n29mgNw9av9kFoJiM7EDWi0EYzolzEEVcwFMbtzQbP2IIXe/8MXHLdr+PpVmahiB0+/
         C6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345865; x=1774950665;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuDbrua0yFZotn5hdK04poyfzvYg2VjKyp3W8hAQl0Y=;
        b=f4s31gLpOwuhkAMupIqoB3XeRWKtsiyLcCTwnnbgzYwS3gVh/ZiZVfb4moL5A0MeoI
         r0pAtLsMwbkxGBWxKXPKbSbOypZG0kqWt7FfWTc6OCi43LqdLb1qmTALJD5W45wSRyf4
         Qu5Bly/S84x/1nxh0i8Bgocfvhc3PTmxEXklQU4RyJTFvagU1i9SnYsWDYAItso8AAoV
         pPkwPqnb96Q/mu1oRy7N1ubHHWE1iZKB9QUsIU7UFgHr4OfYlclwFxbp4DtRsQ45dRrA
         ZaYmuELawfK/r1Oz/SNzu+ji8SOL+/5PWBBzz1+6m+7dQ2WvLoUUsLBV8l7Juzgf4Noj
         tYcg==
X-Gm-Message-State: AOJu0Yym+Pe6ZFFMDR2juGZTwaV220GiaHXm7l4qXSlVslTuhq3XhlSl
	CgjDAu3QgGKVn1wuyzeXMvXLASc7t71r8dwR2DjQRnOcbAUHauE5FqQ/XLUJauvZi89sQU7Xo+D
	2c3vzn1HE46AgM2uYZ1j0EIth+OtwFVGAJuonwCe/PuPj6xHBE0LucIxFfPwchRw=
X-Gm-Gg: ATEYQzwxyE22wrvhLlw+LtzKt//8AMYgH8HoP2DgbdXvbySoDCKwH2VWHVFGYR5cDSp
	Ddz9CciwXbTlKsBPTGkaG9UHL02m7LTqFJ1X70FRUzqGRXS/H9Y7221hbHC1+6qyLSGehMDmg1h
	7XocRjrjbvpUxoVPc5/xgvnT/QxUFY4BL2vr/bLENS3gRS0pwmfO5SB3kENblcSFVyNfhcEVG42
	iOCCjVs46QgfWvX9rR4APyEH5taQduOadUVEPIKo+gT8VFp5hDXfQ+VboSEKluDRpXe2zw8/F5v
	F9zJwW2hAhCljEZ9gsc0UWUH7QChEDVbR7NaXa3G
X-Received: by 2002:a05:690c:9204:b0:79a:4558:b95d with SMTP id
 00721157ae682-79a90c32bbcmr132944137b3.56.1774345864844; Tue, 24 Mar 2026
 02:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260320094407.4169544-1-zhangfei.gao@linaro.org>
In-Reply-To: <20260320094407.4169544-1-zhangfei.gao@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 24 Mar 2026 17:50:53 +0800
X-Gm-Features: AaiRm53emfZRXH45Z-xz4Bvw90lQCdNEpv6_h1NDn2v9qsj0Ki5l8ukYCSIyUY0
Message-ID: <CABQgh9E7kLETKA8obFb5uAYGSy4T9LhYqpzNKUxBEpbEL+o5QQ@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: make DL_DIR in site.conf overridable by env
To: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex.kanavin@gmail.com>, Christopher Obbard <christopher.obbard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 09:51:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19214

Hi, Alex

On Fri, 20 Mar 2026 at 17:44, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
>
> Use '?=' instead of '=' when writing DL_DIR to site.conf, so an
> exported DL_DIR can be reused across environments.
>
> This keeps a default value while allowing environment-based cache
> configuration in mixed workflows (e.g. container/host).
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  bin/bitbake-setup | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 53dbb6221..9d08f3a1b 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -947,7 +947,7 @@ def create_siteconf(top_dir, non_interactive, settings):
>                      # wiping and rebuilding you can preserve this directory to speed up this part of
>                      # subsequent builds. This directory is safe to share between multiple builds on
>                      # the same machine too.
> -                    DL_DIR = "{dl_dir}"
> +                    DL_DIR ?= "{dl_dir}"
>                      """.format(
>                          dl_dir=settings["default"]["dl-dir"],
>                      )
> --
> 2.34.1
>

Would you mind take a look.

Thanks

