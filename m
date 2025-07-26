Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A9C87FCA
	for <webhook@archiver.kernel.org>; Sat, 26 Jul 2025 22:24:45 +0000 (UTC)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.web10.50117.1753568682798325881
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Jul 2025 15:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UJjaRbpp;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so25296056d6.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 26 Jul 2025 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753568682; x=1754173482; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ai5ofXikZKjnfXa5gSPgliYXeXzCkACQDrMwPtPWrrg=;
        b=UJjaRbppS3xh/KF8VsIkdoOuTpddpFWy1jKVPiTNP1SkmFktJBYsoiotnd6ZDkOYjx
         IpYU3HIOT6lfxk4grm5/6MNUWotdzDqaoLRSe+dqaWunDrz8VGiAIB14xnBEUwGrd1nB
         tjp6eGGFK5qr1fWRGAUM+3G0paEJI0y+faCwoYh/TLGAl2noF4p7P/nF6fAeYfOkRhOa
         el0Wp/+17i6rXoMLJMhqGgLY71py9r2ag9h0MT0g0jqpwN0VrOMyo411zkPtTU1K30EL
         IRl7gfkwkz7iukPqvPHfB2wHzDJEgjSJHiioKJ5fkKinJK8iBF0kSAVwQaca1ZSKBOp4
         bIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753568682; x=1754173482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ai5ofXikZKjnfXa5gSPgliYXeXzCkACQDrMwPtPWrrg=;
        b=D8q8V8D4Gsi+7f+BflacoJM9FNrFuh7Iy9jXs8cmFHMUiHsUsmZdU8rhOCuDOc7VG8
         dRCQ5W/vdH/u1jkc1Ljnrx1oxNSePa2962Q/YdMErq3OqPJgS8GQpt/MuL8w3L44ydIO
         /L2mwl9f0IUr9QPQAHfjy4BQWQT9amUGn/zGpN7pfrLHt79ly+oNNUxqLTqPzgfPOB4H
         zYHPXDaPLVBZ5THsloYBiLlz+crqheGgn7ltwngdQQ3ulqU+rwFuMySnm0AMDhbhW3St
         ytCH4WQpKsi+I7iinoax7mGuHqJOT8D+hz8kDZ6ayb7VfGFx18RTjiAPWIxTh/eIxf5I
         R1cw==
X-Gm-Message-State: AOJu0YwvwAsVMhfkPTyRAz1GgYDMvy5QMj+Wvz3v7wlpmvMd7oA0bRad
	BoQSmUVoOqwllFPcLaDjqhMw2dCF2G50QsryJnIqx/qHwO6W0voM9M2qmD9qfvcj9ZoRmdisPEt
	9oc8cRCIw0vPPWAjzWfZm4pR96vf9BBI=
X-Gm-Gg: ASbGncsABclopDDeuVmfWQpI3WkF3VuHcs3Ug7azbFeS4KRfxSG22Op2eMa/rNqlV1T
	xpdpCUKH6UaVmJT3w2nFI2aIzGfg56C+vWtroulyCyVgwzZpwFkW4NWhoki5N+5NTGxQNqEOBC+
	szefcQ5/a7ZyO5g7fwAa+nNOQdNGx8lvjRv7Gel09vGLVVKU+VHe/i0+pYkAX9qf8x8KGgyV/Ki
	0Ukw0nz
X-Google-Smtp-Source: AGHT+IEFV6+SeFxsyhe1FvMErzVKKS9xOpaLfIkZtrPAsJjenudAPdgMe5C6MfXlMyLu52ANIy0VnKkn/Ey5Z1iLZpw=
X-Received: by 2002:a05:6214:4107:b0:707:3f4a:719e with SMTP id
 6a1803df08f44-7073f4a787emr7433566d6.6.1753568681611; Sat, 26 Jul 2025
 15:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250725111347.1812105-1-alexander.merkle@lauterbach.com>
In-Reply-To: <20250725111347.1812105-1-alexander.merkle@lauterbach.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Sun, 27 Jul 2025 00:24:30 +0200
X-Gm-Features: Ac12FXyGhDNos_H47WXdJIzuMGX_dMfUgUbyMxS0H-do1sZEHfxV7up0cf1axb0
Message-ID: <CANNYZj9xDH3ua2fEgnSMthAihpW948K4a7Ow8quL=WMTmeW44g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: forward proxy env variables if
 network access is enabled
To: alexander.merkle@lauterbach.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Jul 2025 22:24:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17810

I don't quite understand. How does do_fetch work then, without having
to do this export_proxies call? It also relies on do_compile[network]
= "1".

Alex

On Fri, 25 Jul 2025 at 13:14, Alexander Merkle via
lists.openembedded.org
<alexander.merkle=lauterbach.com@lists.openembedded.org> wrote:
>
> For steps that set `network` manually e.g. `do_compile[network] = "1"`
> the proxy environment variables should be forwarded. Otherwise the step
> may not have full access when corporate proxies are used.
> There seem to be various examples around that use e.g. the go.bbclass
> which downloads modules while the `do_compile` step.
>
> Signed-off-by: Alexander Merkle <alexander.merkle@lauterbach.com>
> ---
>  bitbake/bin/bitbake-worker | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
> index d2b146a6a9..4012a1a1fb 100755
> --- a/bitbake/bin/bitbake-worker
> +++ b/bitbake/bin/bitbake-worker
> @@ -292,6 +292,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
>                  exports = bb.data.exported_vars(the_data)
>
>                  bb.utils.empty_environment()
> +
> +                if bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
> +                    bb.utils.export_proxies(the_data)
> +
>                  for e, v in exports:
>                      os.environ[e] = v
>
> --
> 2.39.5
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17809): https://lists.openembedded.org/g/bitbake-devel/message/17809
> Mute This Topic: https://lists.openembedded.org/mt/114335899/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

