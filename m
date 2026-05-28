Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBD2CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 11:06:24 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8445.1779966377392941866
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 04:06:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=l548IZsv;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so66794755e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779966376; x=1780571176; darn=lists.openembedded.org;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrl2DGl6jPJmtnNuB702JAIwNZSkjX577HBYmGbY8TE=;
        b=l548IZsvbZWrhFcHX4DJvXgexAj1mtQzDNhYqeER5J4AIn/Hmf/7qvoNxYOYX5rupC
         BxITNXjWlKB0PakpvD2v3qZjUBE4jjd2nuPY48P75QdpxZBlrKV40WpvY5IRY1ybin5q
         QHPKsWNkmzFrnynA6uZCoGGPkp/t8EgBNFXc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966376; x=1780571176;
        h=in-reply-to:references:from:subject:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zrl2DGl6jPJmtnNuB702JAIwNZSkjX577HBYmGbY8TE=;
        b=VNvesN90XuN7G2qm4GCvLJJCSQYcNID8hOyyCxMv6JIBFoEo1136ZA7o2xfIIwaIXJ
         2c2iYRvsAiHxIpGOlJXlapRc11b2o8gIQ4V6uVGVuknG+HMcIMWB4UcZxss0OGWuiYZl
         EKdC1oqg8EeDtG54J2D3FZpd4nxDI2yHEtkPfNEiKB63HROXZ1w55OvW+GEXn1s69eRO
         ov+k7H2SPWrrkcB8xzSl3aZRZoOxziGI+HjVK2NX2cEaJhlIaBZy1znto5EwXAxCccBy
         C+/x7jFrUP/ZQRe/erKeEJD17S0wn7f9h72sLh8CL4FOWbE2V46WLVA3qUNmzxFa8S3Q
         FO/g==
X-Forwarded-Encrypted: i=1; AFNElJ+yzEFG92dCMa2Qdgw0zhbt6hp+dT7gnxah5LNg6bpYfCW5Yf0Z8tGdnF12b3KRoRzF0EhWAKcau0RY5sJ3@lists.openembedded.org
X-Gm-Message-State: AOJu0YyER9ZWroK27uzQTWl8W6MHyh4+zhvq1p8CdT2wZ7ADDmUPK1mx
	AXrpeASY4wFNCio97el8/9iUniG6/eoFcFl1nqV/LoJnKeg1mVOFt8QQCKbaPm9WdpoAZcO1YkO
	AB4yC
X-Gm-Gg: Acq92OFYXeyZumwpua7IXHtTULKpYKppykUmoaOwVpDJ6OGRM1+VZt3Vv4voQOAFZbQ
	59lQr1JAs5WEKq5HEyZLllQ4g/ypbdi+NvvYOqiwJFrjlUHn8KWLmEJcHfReHCeCahBrwlaIhhh
	buGKHU88z3C0H06m05KV1+rdWY4blfpIxM09jWCQAjs3M6o8jRA4nlgQI8Bt5HJ4KKt0y5ED9qT
	scpfqWKiUmPiUXJ7xLTC1rnGg99ITE3ne43fICmuQLOYoU9dRUmRr2jaS1SnRpRPQ2HFMUUZlHH
	LgwrYLFdO/Odiu9X188bf4jZzKIR1LMLUhBQdrhsfOMdCj+1iuLTQaHE3EucVrIeEDVTfXo3ytc
	EA4jQ/2WVQajvzbb6TdHxsUe9vy+sLhsSGY+nnvjdeRw1x09JAdjASYVLV239vfl/FZhecprMo1
	WhUQ0cVpPHF8Kf/I1lJg2Il93H4JvYohLgD5UGmXIJERLPGYGJjTp796hhJKZFDN8YzV5Rjk1Kv
	aVVulYjaCumdx3kJ2j7kWSZAg==
X-Received: by 2002:a05:600c:1d0e:b0:489:1abb:5559 with SMTP id 5b1f17b1804b1-4909479e30emr15119745e9.5.1779966375611;
        Thu, 28 May 2026 04:06:15 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908ecb5238sm14905875e9.24.2026.05.28.04.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 04:06:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 13:06:14 +0200
Message-Id: <DIU9F3XUHNC6.1TID8VD7I9KDW@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 9/9] layers.schema.json: Fix typo in
 property name
From: "Yoann Congal" <yoann.congal@smile.fr>
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-10-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-10-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 11:06:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19559

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---

Nice catch!

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

>  setup-schema/layers.schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index 0ab679a6f..8b46ca08c 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -77,7 +77,7 @@
>                                  "patternProperties": { ".*" : {
>                                      "description": "A git remote",
>                                      "type": "object",
> -                                    "addtionalProperties": false,
> +                                    "additionalProperties": false,
>                                      "required": [
>                                          "uri"
>                                      ],


--=20
Yoann Congal
Smile ECS


