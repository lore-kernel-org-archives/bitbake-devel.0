Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24364D767F8
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 11:52:59 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15168.1766145169045475705
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 03:52:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mUY993MT;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2d56eaaceso202530085a.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 03:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766145168; x=1766749968; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=588A2nSku1DgHARVJNHCuUetFBc/341fdvbiz9+35y8=;
        b=mUY993MTzcHoxNnbxvpR3haIw8A5ajMczaC5IlD37qrTRWcw1ivtA4yexXIqwBK1LN
         TRaMYiTMsEKz5uxulwDOrOTLJNcop5yy7mTUF4422tv/ZNLzXAwGonTJacG3DPAlYApY
         e7JfE8GMt6ke/CvHY5Bphq+RGgiZBNQNiXNB3V7NoOJQKqTa/BDGMLnw07hJrfEIoTGk
         ZqqrepoHyNIPBfDVCGOFU1CpLFse19JqyEOU7m+rV6rOkGkbPu4zHds4tGI1GFoaHLzr
         eQbi3cHDNHxXtoQwhKZCHS1KsFqAhNJlZV9v1LRvoLkze2tWFD0dUfy32BDhwCLTnwnr
         hg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766145168; x=1766749968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=588A2nSku1DgHARVJNHCuUetFBc/341fdvbiz9+35y8=;
        b=CIJi+3mK0P8A19NVLigU7zDooHOPoOXe9CR1PJmhDNOh3vGqg/m1xTp5IlYpNFHSOp
         MSujUJk0mSfinKIkbXrnIzxczhDk0AxM8VCJ4G8PSLztWRsLQyu8RGIr2Ig0sGKP0Ec0
         aF3qfSUHDIdeRHDm3HEG0uPvMdUfZi58VrJ+mdArihOJzJPsnyn/88BmNIsdcJTNcCji
         3RKoB0gTd3PyBX7yvDpg1oA7msf1+vLHAOrlWpp8apOdh5sC0g7HWqMcYo6PsSbwmKUs
         brJrujM0ol198WyCrokt0hhsDO0Q35zHJJEagYMG7cq5gfGD7UWh8FwbAUKuBSKqxX/g
         QSZg==
X-Gm-Message-State: AOJu0Yxc4buAhVOkaDQEODqOVuq1iI9x4IVBq5BJG7+dqGfS85Xwp79y
	pHTru1x96eHDopuBLqXJOrsB9E2mPY62Dbhb2BLNjF4zxhdI8GG/BwahKIGBbiYopwPkwTqi5xB
	gbGmdAnRMTw6BUJFog/YP9wytklHsnXU=
X-Gm-Gg: AY/fxX74LCOSvvo1DwMrMQGXhtpTrVY11rzpGTjB4iuHjIm1D3rXxdWAHGzeFiDgFhp
	xgZWfQNftHJq3leIv3PkxD3O9OYWs/L4sq9lt4J4ke/GywyAexDhYWrV4Y7iZyEV5/vyknHvC+h
	GxkPYsyRbM5dXgEi7Xy15YaFroKtB+tqovTs4LpH1Sk+61nkpo93C4gSsdfAP4MeBJo7gYICqFT
	iucjFMfPK8cvLeQz86zIUKs/adKQ765D5xNB1svzZCg2oVc/SGrzF0FkB1PNlZlGPxwQSdyRLmE
	FDYq9qvCCiy1IJpUyz3bbDa+GOL78hp6elsdQnEs
X-Google-Smtp-Source: AGHT+IE7Ji5HyI6er6jRRWQ/mQIi6dHw8g26h4sbkQG9houvaLvsSCwcw4txPjaJlw7YfshDbELM17saW93O2ErcCj8=
X-Received: by 2002:a05:620a:f04:b0:8b2:d56a:f2f1 with SMTP id
 af79cd13be357-8c08f650ef5mr432289685a.12.1766145167872; Fri, 19 Dec 2025
 03:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20251219114258.1574787-1-corentin.guillevic@smile.fr> <20251219114258.1574787-4-corentin.guillevic@smile.fr>
In-Reply-To: <20251219114258.1574787-4-corentin.guillevic@smile.fr>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 19 Dec 2025 12:52:36 +0100
X-Gm-Features: AQt7F2oDuKKOEa2meI7PEY8qfa_i-A0R59GQLKL6EVUFkgbHZQdfBR6eihsWl-o
Message-ID: <CANNYZj-vY7sjKHqbi7yRY=hL1GboOdUSvUUY1=_xKS0afcL4-g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 4/4] doc/bitbake-setup: document "uri" property
To: corentin.guillevic@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 11:52:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18620

On Fri, 19 Dec 2025 at 12:43, Corentin Guillevic via
lists.openembedded.org
<corentin.guillevic=smile.fr@lists.openembedded.org> wrote:

> @@ -716,6 +712,12 @@ They contain the following sections:
>        -  ``branch`` (**required**): the Git branch, used to check that the
>           specified ``rev`` is indeed on that branch.
>
> +   -  ``uri`` (*optional*): a URI that follows the git URI syntax. Can replace the
> +      ``remotes`` structure if only one URI is provided. Despite this, ``uri`` and
> +      ``remotes`` can still be used together.
> +
> +      See https://git-scm.com/docs/git-clone#_git_urls for more information.
> +
>     -  ``local`` (*optional*): specifies a path on local disk that should be symlinked
>        to under ``layers/``. This is useful for local development, where some layer
>        or other component used in a build is managed separately, but should still be

This doesn't seem indented correctly? It's a property of git-remote,
and so shouldhave more spaces, like 'branch' just above.

