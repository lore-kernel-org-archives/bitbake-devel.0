Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC54CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 11:05:24 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8428.1779966321262431785
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 04:05:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=1K3qq/W/;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso60083965e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779966319; x=1780571119; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHKkBeMeu7QOAcgeRldbH+yS5OY2UtxBzVdAxfIU5K4=;
        b=1K3qq/W/k/2H4Zcd61QBWPLUkQpQf5sXqzDT8SdSvcKRy4LVaV/nE6Q+19gExvx7+N
         ARaB+YALI+WmKCn5TodHZg4g0HzZiRP/nkAWG2fjkZJiKox1AhBR8DI5PVGG1t20hsjI
         pZAvL+sCNUOW/Nx+/l8U6rYLNVjBniN/+9y5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966319; x=1780571119;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHKkBeMeu7QOAcgeRldbH+yS5OY2UtxBzVdAxfIU5K4=;
        b=fWmJud+9jlFDIbCcq8L4/QU3JRKTM8get19CYT5TdUioQtFw9qFSPlXGadmBxL+wzs
         MnSjFEQxw33EiK3HZVeLakckWUoxchUBiq2Yk2qKC8xIwbBItrf0ncCd2zhpG8CE1xjx
         8Yn/LI+ZflDlonVAuo0BG75UncJQRdHb9hWTxrNtS0/NGVNudgkBR9kD3yTlImKjFh04
         lSxaSq1W5yN7Nf1w2mVEi6dJSnHiOHycHsoe6sMQPMlw+0an5WGpJASSDUjcaMIutXHh
         kp3hbnWP167pTyhEPYy3QdP/JK5HWU3tCldIV8OSguLOiuxgHVa4B6UAzqjJg9mr9UWt
         Rlgw==
X-Forwarded-Encrypted: i=1; AFNElJ8g57iKhpVjYfU6+hFB/6jp4JSi8T3cPZw9dd3oSGDErM3V/O7XjzAPDBK7X9n8+AcMhYa25Oy+CasmlHly@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz0uqlvuKN+3bmCCGOoIH3hVY/b6S/TVebJbjrlRz43WuL7LEy3
	DYtapWSk/uwbEeTYegaaXawsZblCuesqqojvTfLIhvgqKI3xIMGCJPAME1aFtbONqkVDuizXHqH
	GrmVu
X-Gm-Gg: Acq92OE7cTdSKvMKDSF1AsuT3St+YqZcXWK/0Cpz3YqV/w+CXJ+q2MkvVz+bXeFxGPv
	LUIPLz/8He7p2gn+NwO3JJ09rqMX7Ce5/X22g3QiPBDd/Z4+OVFfxGnLbbdsCqvQNPcIVusIRIN
	T3hHv8Kiy0cWyjrFeqXesnVmeVjUxvfJIyfnUm+qG+m5SmqhlXVBRJmLiPvil9UOmkd/1DWOURl
	8mJ5FdCbjuDfJHAW2R07J/4hWuX1K0cVjfLNdAqKv2vkOpqbCMcr9heGAIb31LUTDYNqWxJd6eE
	MymSzg+mb6Fp4CLElSwbuy+5ZJ+9hGxxCh1krBCelCqrIgg6LhbCiXudl6Gdh5/bWKkuTQdDtqb
	BAZVubtPpROHVQ+Y+ECZnpkeY6mbkIzqtyZeJkIAAflLw/oecZy5RZ/4lqny0Im66c+JsYg+dVl
	Khn9mqiXUswJVuyUuD/eqdpqt+024aTOaF9oUoNAc01vHGH8193rGstFhA42GXjmHKVwIyyMzXq
	yIXW/9vScUYbiOZr7BXOcko7w==
X-Received: by 2002:a05:600c:818e:b0:490:58f4:ba23 with SMTP id 5b1f17b1804b1-4905c60ef29mr301538815e9.30.1779966319456;
        Thu, 28 May 2026 04:05:19 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909284a895sm30344185e9.8.2026.05.28.04.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 04:05:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 13:05:18 +0200
Message-Id: <DIU9EE5ETLZF.14MEVAUGWBIFB@smile.fr>
Subject: Re: [bitbake-devel] [PATCH v2 8/9] layers.schema.json: Remove
 trailing period
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-9-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-9-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 11:05:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19558

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> This resolves the jsonschema linting error:
>   Descriptions should not end with a period to give user interfaces
>   flexibility in presenting the text (description_trailing_period)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
>  setup-schema/layers.schema.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index 5c715f08e..0ab679a6f 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -44,7 +44,7 @@
>                          "type": "string"
>                      },
>                      "contains_this_file": {
> -                        "description": "Whether the directory with the l=
ayer source also contains this json description. Tools may want to skip the=
 checkout of the source then.",
> +                        "description": "Whether the directory with the l=
ayer source also contains this json description. Tools may want to skip the=
 checkout of the source then",
>                          "type": "boolean"
>                      },
>                      "git-remote": {
> @@ -64,7 +64,7 @@
>                                  "type": "string"
>                              },
>                              "describe": {
> -                                "description": "The output of 'git descr=
ibe' (human readable description of the revision using tags in revision his=
tory).",
> +                                "description": "The output of 'git descr=
ibe' (human readable description of the revision using tags in revision his=
tory)",
>                                  "type": "string"
>                              },
>                              "uri": {


--=20
Yoann Congal
Smile ECS


