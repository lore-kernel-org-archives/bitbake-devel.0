Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF23CCD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:48:24 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8115.1779965301891157631
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 03:48:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=vJKGAXNY;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso70152395e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779965300; x=1780570100; darn=lists.openembedded.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjUbqTxSfwS1UE4/C+OXEUIKEfmClLG0QV1Fox3fvZo=;
        b=vJKGAXNYtMqh8YWwc5GWGizt6/M7j5yPtjXDQCbgnMp3WxwQMGBi84Fp7xpQNPqQJC
         Syd26vfAlTQqsCMbdZgCyzkSKTKHQ64yz1WbSmUVIRUPHzGwimUEhkofvWl1lTT4HjHj
         FKsSOyFnB3so7zxJpHy9/WWbnzUpXlAytYj5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965300; x=1780570100;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjUbqTxSfwS1UE4/C+OXEUIKEfmClLG0QV1Fox3fvZo=;
        b=j0Tz5sVmCT13y9daZt/DuTYCDdtSATeK82qJIASXMvsA+Xnznc8sc4Q2aolfBMiYIN
         dKwazGFYtbuASeQ38YA3tnMkX+kNihOBhi4NpOaYUVr51tEQ3Dr6Tt4HZPU3lsfd2eOo
         LFl87kkM/bwKvP/3F6+9uWGfv3pGlOPpO2wV4JbjPTuNBZVHulKG5tFPq/e5tXkApKT9
         VbaCrWzg+dh7VbQ3DFws6p/Bs6tApnQNVWDS5ZOpFkc7xwBb6bDPRpNyFmZynGYmRPjE
         yL7jKVvBYEhKIJ5XCYOzvBd45tCprZXSjC9cRFQ7aQaHnavJhfDHtlzu2ieVzjfHhqZr
         8lHg==
X-Forwarded-Encrypted: i=1; AFNElJ/N+/1kuqwI/h/xXEZr9fybio0HNfsethzPSKiVoAQI+NoGDps/SUP55n68mYd7S6qvoE0U/jo51dRwyzhe@lists.openembedded.org
X-Gm-Message-State: AOJu0YyBfE8M2ChmL2VwKv/ukbtjJtLY32aXXISgPXJjU96dL8gH2FBP
	HEGzxCCzoHlXWdb1W4KVcIXA9yJESdYHFXEuqWu1/eFnQ4CvJKdp4gc1nspk+KTgsuNxjiI7vkQ
	wxtw/
X-Gm-Gg: Acq92OGG2S+dknFRqwAObIRPzv5PySq/1OdpzOf+nHROInq9JQvbskgimJcNfQbahgq
	rG0XjUsMx8E/cZAC21AYTVi2ROZtQKNtLxSd/tKy3QWb7Ctv87vAB0zieDvJd8hFPfpKDd6GnpC
	IZ6db3xisG9Kpypx0Cv1kNpJUC8mgN2bs9BManbv89IsSMNS8hWIR7BrQIn5T/E/SaGTG8iVHId
	9q+CLcOI150EVawzWN0najY/Kog2OLCoF83PQX9vSHm5blzgrbo0VSJvi++byOIsLdIgt4aAshG
	rXR56jSHXGC0/7CVRABY2lDh7D++ECTnfCwMC6Bd1crcz2NN/oPM6/MWzOyBFqL4xjTYdLo/JWD
	qbXi9dEYWSS0AQ+7vcE+mD0Z4cmzov9yUjfRk5gLTKd6e5xFf3T5l3T/iJ7nWqeAJz0nNRaHJDU
	7zWm1ewOwNY9MmBdwP4RrXcCOe6spx/pcM0h4XjanvlZVSAgH6gNlsvurYCDf1ysx1GyJvmVDKC
	3XkecT+q0Ck7B8TsHQ5+8PJRg==
X-Received: by 2002:a05:600c:5298:b0:48f:e230:c3fb with SMTP id 5b1f17b1804b1-490428ddd40mr464858575e9.33.1779965300046;
        Thu, 28 May 2026 03:48:20 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490923613d0sm56409425e9.3.2026.05.28.03.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:48:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 12:48:19 +0200
Message-Id: <DIU91DVO4I2D.7TOWBHF1MWFJ@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/9] bitbake-setup.schema.json: Add
 examples property
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-3-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-3-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 10:48:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19552

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> This resolves the jsonschema linting error:
>     Set a non-empty examples array at the top level of the schema
>     to illustrate the expected data (top_level_examples)
>
> This example intentionally only references bitbake as a minimal
> example that focuses on the tool itself.
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  setup-schema/bitbake-setup.schema.json | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index d340c9785..3324546de 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -1,6 +1,33 @@
>  {
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "Schema for bitbake-setup configuration files",
> +    "examples" : [
> +        {
> +            "description": "Example bitbake-setup configuration file",
> +            "sources": {
> +                "bitbake": {
> +                    "git-remote": {
> +                        "remotes": {
> +                            "origin": {
> +                                "uri": "https://git.openembedded.org/bit=
bake"
> +                            }
> +                        },
> +                        "branch": "master",
> +                        "rev": "master"
> +                    },
> +                    "path": "bitbake"

For this example, I think we can use the shortest form:
  "sources": {
      "bitbake": {
          "git-remote": {
              "uri": "https://git.openembedded.org/bitbake",
              "rev": "master"
  		}
  }


> +                }
> +            },
> +            "bitbake-setup": {
> +                "configurations": [
> +                    {
> +                        "bb-layers": ["openembedded-core/meta","meta-yoc=
to/meta-yocto-bsp","meta-yocto/meta-poky"]

The fact that this example references layer that it does not source
makes me uneasy.

How about a minimal example with bitbake+openembedded-core and a
qemux86-64+nodistro build?

> +                    }
> +                ]
> +            },
> +            "version": "1.0"
> +        }
> +    ],
>      "title": "bitbake-setup configuration file",
>      "type": "object",
>      "required": [


--=20
Yoann Congal
Smile ECS


