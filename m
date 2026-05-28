Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE549CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:49:04 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8184.1779965337309929515
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 03:48:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=oz5/AKou;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso70158365e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 03:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779965336; x=1780570136; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKrXJDANmL5jC56GreMYDQshFHsZR2oSctTQs8PdGb4=;
        b=oz5/AKoudYN5B8g/oJH/patwBI5tAN9yk20X0NdbB46A6+4xwMHq6AZ0m4N3spXZ+s
         9JnRLPYLuhe7gbqrvW1YV759ur/Zwn1bVq6KZPTRmagxARImbWe5dKgT3RzYbQOu+CgE
         3wHCgiOkHiBsfewzVIDoIx/Ll14pd5qhDZNvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965336; x=1780570136;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKrXJDANmL5jC56GreMYDQshFHsZR2oSctTQs8PdGb4=;
        b=VVG8aa9VTj4aErxRc41xGCnqwlYH7JSespEvhkVQYXUu6Djsg0UXnb5g3o/CgwHqDC
         fNDOyMed0g83kOq7WGW0OHlOpSQnw+hV1+8PuYoyjxJf/Ctg+DCmSTVFX9z87dl4aE72
         2yZRc+V2BeBPpkOrUPCzaVI2yVdOAQuHZoKYrN8WF5CE0tyWnPo7OM1YCEJXftX0dvyb
         HOrpitH19JEFZEFafxlar9NbxDp4BgiRopBQlU4qTnLCBk8CP7vsME07fmKUv5/ijJdb
         FdcRzH5ikM0UL/XANpavOi0ylxBg1L9jRL3jrXgDIx+V1Oo0pyv/ufrwhktMSIVOnjoH
         ieUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0yvcMXRus+OID0DErZvmoQHHSrWsm6jI0a+HXiVWs87Xq8XEtB/v0FMMqGRjUuSFTkAmc1YcZMiAZQqmG@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx8LxzLVwu21WI0f0ac46oOv6N+qjYfMzMTLCBBvdw3ZwWbOxW5
	wP0vP+F0okeYJfqAWpSNHS4X4vcrUsQJM5BSTVsguQSBL3j8bOlRfYX3UGYhqNjKdDI=
X-Gm-Gg: Acq92OEiRRkyXsf3uWOEep3kPLNSQDSXDJIdj2ymY/ORuL/hMePa5NwgwzTyW/2zsKc
	7rTalC9kavU8xL0CK8zgCDhwe2Xyq4Ha6Ya2I+xXA6h85eQhEmSB/4NFM2CSIr9A36z7/DmfHiE
	dAV4+dXx6oUDD3qSi1Z6yftTZo3tDe7ovjV2sI/WqoCSAoYnbp3Sw9LcAF/R4j2+Bdv7lX8ILaO
	2LkpskRlNodq+9+SxY4cxpDb49QK7MWR+Q5D0EJSVCixNnKMaxHkSY4UDdkKO6hn6gnLpI66YFn
	kUZpKA1iMJr4jneRPDwKtNzNfkMkT2x1jP+ZUBtwwqHs/m9Eeg1GGODeIZEB1CotNt4/G7MKGB5
	hUZKi1qT89XxhS4dJ6HUHTitc19hsH0dXwI4XmT4LJFso8vL7yFX+ul0oi/zFWf3DasRgc8w3u9
	KKnKG0QGSksqiV5YSjxt5+zGHOgSIPXd0bLfbjFCmF1gV1aJVDmug890vSdyH+Mmnr2cQlbh7wD
	nuoFV6kdjkaIMg8EEJSSHJgSg==
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-490426d3319mr337037235e9.25.1779965335526;
        Thu, 28 May 2026 03:48:55 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909236ab3bsm37077685e9.4.2026.05.28.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:48:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 12:48:54 +0200
Message-Id: <DIU91U8DE08C.2GAPI4WD0CCLR@smile.fr>
Subject: Re: [bitbake-devel] [PATCH v2 4/9] bitbake-setup.schema.json:
 Remove trailing period
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-5-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-5-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 10:49:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19554

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> This resolves the jsonschema linting error:
>   Descriptions should not end with a period to give user interfaces
>   flexibility in presenting the text (description_trailing_period)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
>  setup-schema/bitbake-setup.schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index f2e466c9b..896b0ba4a 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -150,7 +150,7 @@
>                              },
>                              "setup-dir-name": {
>                                  "type": "string",
> -                                "description": "A suggestion for the set=
up directory name, $-prefixed keys from oe-fragments-one-of will be substit=
uted with user selections."
> +                                "description": "A suggestion for the set=
up directory name, $-prefixed keys from oe-fragments-one-of will be substit=
uted with user selections"
>                              }
>                          },
>                          "additionalProperties": false


--=20
Yoann Congal
Smile ECS


