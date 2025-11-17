Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC897CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 19:54:05 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18618.1763409237470944686
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 11:53:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GhF+Vr0d;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed7024c8c5so34951681cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763409236; x=1764014036; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OewsRViwVKRflREe16MkJDT/GP+bYk/u8fPVjL1dbdk=;
        b=GhF+Vr0donHHprKEL6Ochso48XMPRxOV3ro/ADx1TC6A4iGUY4I4dtXoETjaUXx62C
         4AihjYGLoEakFIlUQ9RTNF3ayo1b/GPGNq0Ic5bumgB2J0mNrSd4aCtbaA0N+KZlvCkg
         krBXmsqvnWlj1ZlNW9BnQfX+O5dafLGC6KHce3qJlRmmE3wNb/OzRoBMit/6ZuEi9Soa
         MK6cv9CZWic89C1gu8Au1rwl3wLBLfzm1VNO+1EdQ27c0F9n6N+qQuIecdkO6FbS40sL
         mUg1aYB5o7Qpy4iRJfdIcPZTY0LtopDwZHMKJib+yQqTCBYMts3nkZ8eUN/XsaF5Bl3k
         r3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763409236; x=1764014036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OewsRViwVKRflREe16MkJDT/GP+bYk/u8fPVjL1dbdk=;
        b=OCtob5bgLiY4wHRBZjJ3r7xDJH/aKKR51mGse0M77gBg7I09JzmxQ9Zznxpt7WFiWZ
         Zzgo0TCqirNVrSflIiVTqaFRILcTN8v6NMg1TjFkeKeHP5oCZUalndqHzmz3uhX3EWOS
         VgrYd5BkM23JcCT+iDCIgRRimD6ZWLo1X6xNfMqZ36JzRftaYmKwpOvxVQj/9NK4IdlV
         j6c2IYJw7g/cmBAnWHPAgwu3+4faHyGLDgCtgbWHLjfhb9CR9QBUtXL7oOOYczk349fJ
         NZIGp86LvmYYhJBMTp0bVkz/5aeaAau29+CaSoHNSLiyRyNiK/WKfgh6BgsAL96D5sFD
         ScEA==
X-Gm-Message-State: AOJu0Yy8Rk/iHe4gZqb8VX3gbKtYliLPVFKUCf4Dg7Lo5eB/Bt+3Azl9
	Mhcqxk5eFD1wDLkn+RjGMuVAcOoSQi60qWvv2y9ZIM307DyszOn0k8SvF3Kn1LwY61sW3SzyuVe
	4BR6qQI2/6L/jn4qEJGgwUkF6N2vLpkk=
X-Gm-Gg: ASbGncvP0CSXQragN6ivAw7RfIiT8qYpEw+BILDRI1ufa0yWIMrrx6yAVVVuxkVvQ0b
	2+j08Gq10ibusJWwlGB3R7lJOUJZQM/5KA2TSZEukK/FfCLGwP0GZqA2NidV9pwgWjrwODnr2H5
	/Q5FR735QLFnvOgFEcTCsJ8pWjzoL+KUwXf2ghnvzpOz9EDijor7AGel2obE3CaziONl/f0KOCr
	ilDeFJvlbbJMbP1tBBN3VY//K8pocOuzVfEEdyiTj7HZT80ge8rjtzXXN18Xzoq3eDrWghq25jL
	3boZvEwOlleUOFmtTgEETYlgdrlgUlUqE6zU/fWj
X-Google-Smtp-Source: AGHT+IHFeQcL+68XoPopDyxeC2qastrmy+jOoVlIc6223aWZ9m1fsmR1nBrMcMial4SClnDozmro7SB1dr3DbZqSdYE=
X-Received: by 2002:ac8:7f51:0:b0:4ee:1c3f:ed27 with SMTP id
 d75a77b69052e-4ee1c3fef41mr64832641cf.17.1763409236410; Mon, 17 Nov 2025
 11:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20251117194840.2322115-1-JPEWhacker@gmail.com>
In-Reply-To: <20251117194840.2322115-1-JPEWhacker@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 17 Nov 2025 20:53:44 +0100
X-Gm-Features: AWmQ_bn47ZGUurTuEjSqypskG7snzfCL99v6uljwmnzWkgpPEBupkTMwpKmfGDg
Message-ID: <CANNYZj8Pbd3LntQ72p32tFkooWMxPn1YL33+yKQToNHica36ZA@mail.gmail.com>
Subject: Re: [bitbake-devel][PATCH 1/2] bitbake-setup: Allow setup-dir-name to
 be specified in JSON
To: JPEWhacker@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 19:54:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18439

On Mon, 17 Nov 2025 at 20:48, Joshua Watt via lists.openembedded.org
<JPEWhacker=gmail.com@lists.openembedded.org> wrote:
> -        setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
> +        if 'setup-dir-name' in upstream_config['bitbake-config']:
> +            mapping = {
> +                    k: v.replace(" ", "-").replace("/", "_")
> +                    for k, v in upstream_config['bitbake-config']['oe-fragment-choices'].items()
> +            }
> +            setup_dir_name = string.Template(upstream_config['bitbake-config']['setup-dir-name']).substitute(mapping)
> +        else:
> +            setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))

This (and the actual json tweaks) greatly increases the chances of
directory names clashing, so there should be a check for existence,
and a logic to deal with it (probably just fall back to the full
style)?

Alex

