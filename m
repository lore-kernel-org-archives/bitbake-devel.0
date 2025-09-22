Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37143CAC592
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 18:27:52 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.web11.60013.1758565664158351697
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 11:27:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WsjwWtMI;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-79ad9aa2d95so40912636d6.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758565663; x=1759170463; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHpA3TgSg207Uc6YBlriHJk9KtXu7idDNBFEL3VHaDQ=;
        b=WsjwWtMI29ZQOPeJRdecasPQ/BZ7W3Etg765oWGT2eqjiDyxFeMJTbOq7cyo/6c0ZL
         azAb3SfRZLlFBfuL5QrPWJpL60K1sWRW3lkTN9Pr1cGiFAIJfFzmIVf692Elg+OSQHec
         h2DUZk9BNGPQOXByDT+YVTKfUD3wKIthv3d+4Fr9AQNn3QtQkC7SPHoyCVODPKS86tUt
         4JcKXmIGmegKBU2jGIfzRIMIgZ5BhcoL5Rr1hzWBluzDecX30w7LVFjS7/B6p6AvFDvs
         dwNwDJsTKQHSlb8XuJLOsTttVvXQ6efSR6eoOuF88dpW8PKi98+CaO9IZMQxMKOHg/ph
         yugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758565663; x=1759170463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHpA3TgSg207Uc6YBlriHJk9KtXu7idDNBFEL3VHaDQ=;
        b=Cx4L3m6DdYiu4li01PPTRUQKprV2bb+hudXUyuVoierVdUbHzgbUAx4IFOA6A791TE
         TNQDgs1DljzWQU0HduiLsRhntpJYKXFTq4zjJNKuZDcqFvT8bHZgiZHy3E1wPKkNGb+5
         w2aJEAQwW8DmeF7fMD7LnijeP1/BA5izvpIcipKILJo30jHKNFatUvq31bTPO3FCkJCw
         Uk7fARNOcHeIFmtJzsA7WhyRk+lZyvBN3DeS8H1dHQreoFTq331RgC5DOGRmKPxOcrss
         4uSBX41nRXfCGN0XkzkDiOzCgOg3N2SGqbBH/EERUIJDQnPO5CzIdWziVz6eKXElr7xE
         rLkA==
X-Gm-Message-State: AOJu0YzinpJzWS5RbwuXeGCpYbrHhexprqAHYI+NF/zp+uoAon4NVaGe
	aLzlCJcVdZmcG32/PNIeJakVJdwPeoPOLGgeFmBUT+nLRiFNeJQT9HER8QIGA4KZL+iXUAOmNy6
	bAB1NhEBWl0QMHyF5pTjE6Qw7uRjWcX4=
X-Gm-Gg: ASbGnctJFX4Qh71uhrNsY9XHVPZs5CzU8mS3h9UyrFkMKt7dbgAtPpQkegiQ6wjzqO9
	j+cU9WA4kQ3I6NMh24WAj8b+pbPOc9XbIX8+T91TQJXazF9iwFAGKBJlOrr4pQGU0RrQ56q/lKd
	DLVGReZwl34Cwh/3SOSQXvsiDWYuD+xTJX1gxgivMNRgdcA0WI5+4w1Y4CIHPkdiQEHLysIxypY
	CSwQtPHLPlx06tPD7bOf1H4Y4rxgA+P3oBJa1opbmgawjjqKwyS7rEp7rkCftCHihqfE+b5jKCQ
	6+39iY0hMXkGC/8vnOetzVKfcOOw8aUaH/uICShn
X-Google-Smtp-Source: AGHT+IHi7f8+mGowjc9k3hFwuKf2ZiKhM6J8VtZGqGF/Tu9PlzNRfLMZL5l+ZQFSC5i6vbChn4ZkYkfUqiMRxM4quf8=
X-Received: by 2002:a05:6214:cab:b0:7bd:c360:a4 with SMTP id
 6a1803df08f44-7bdc3600310mr74145276d6.27.1758565662889; Mon, 22 Sep 2025
 11:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 22 Sep 2025 20:27:31 +0200
X-Gm-Features: AS18NWBTKweFzDbOBmaqgQvoHL8t0b9Y3ILv_u6CY0_LR0DgctKxH9ijqeExYjI
Message-ID: <CANNYZj8H=_sZnaGUQCjzCttrC2xkE6hvXVA92JZpt9G5w=qQNw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: Allow local registry paths
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 18:27:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18073

Just to be clear, all three lgtm.

Alex

On Mon, 22 Sept 2025 at 16:07, Richard Purdie via
lists.openembedded.org
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>
> It is useful for bitbake-setup to support local paths without access through
> the fetcher so that internal data to the bitbake repository can be used as
> a default.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  bin/bitbake-setup | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index d6509500d86..b07bf2eb7c8 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -509,10 +509,15 @@ def do_fetch(fetcher, dir):
>
>  def update_registry(registry, cachedir, d):
>      registrydir = 'configurations'
> -    full_registrydir = os.path.join(cachedir, registrydir)
> -    print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
> -    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
> -    do_fetch(fetcher, cachedir)
> +    if registry.startswith("."):
> +        full_registrydir = os.path.join(os.getcwd(), registry, registrydir)
> +    elif registry.startswith("/"):
> +        full_registrydir = os.path.join(registry, registrydir)
> +    else:
> +        full_registrydir = os.path.join(cachedir, registrydir)
> +        print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
> +        fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
> +        do_fetch(fetcher, cachedir)
>      return full_registrydir
>
>  def has_expired(expiry_date):
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18070): https://lists.openembedded.org/g/bitbake-devel/message/18070
> Mute This Topic: https://lists.openembedded.org/mt/115376054/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

