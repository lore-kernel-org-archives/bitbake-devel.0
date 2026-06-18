Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF36BCD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 10:20:27 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16302.1781778022484068065
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 03:20:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=vBClds8f;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4602e2a0372so600203f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781778021; x=1782382821; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnfsD5pTaP7dVI8NeTINLZtxhcBYmGWvxOWUrUfK8kw=;
        b=vBClds8fgA/GnD2yAspsZiWFYiffEUBKTYhTeG95dCJcccWzKHfN+ltUQv9LddH0Vu
         P5oJRFhT4NPGDEOWKXFDpEy2n/aKxg6vmdVtreDWPZNam8UmU+GeVY5+IQRb5xlp+JB1
         DdXqPsfHz6LyqeWLatnvRAfxLbt8YNpYhgeMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778021; x=1782382821;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnfsD5pTaP7dVI8NeTINLZtxhcBYmGWvxOWUrUfK8kw=;
        b=qv/dvdznR+3X2Ay+AlTM/MGsQKr4vfdHJCcfXvZfnsbDJB9/RLKV0GwgZPBgs/V/mQ
         dC7lAmD1376sL2y15JUP+kZF6oL0Lx8pshPBvZ1B9p0nDcNUFTfzdY2QaK+mvDddXH5n
         wbbYTRqqU2IMKKxSGlqvZoPH+MYewWpBTjtQY5kXltOEoGEKot+502Pdn1GVXhLC0Cxw
         QCjDyBqEZcCNsm5leVdQ2PTxv4NCIksDY3jqSv3YIeKS+gHy+pGTh9w1DtHXwZargKZU
         mx/43C8tM54T24Rp9a2svrJLzfLdPrha4gbyZ2ge/KaxIbU0ilD9ao9b/3OSrwHXGmir
         N5Zw==
X-Forwarded-Encrypted: i=1; AFNElJ8uoANiRbJXGPd9E7N50Zc6TxnJ5i/h0Qm1IfomK1f1bHSSAVYEMQ/+I1HG68mWojS/uMY/884B4InU0o7M@lists.openembedded.org
X-Gm-Message-State: AOJu0YwmagC0HzJUoJZeIkyoHRK1jzsw+qoXrfIPUxN6z4cKMsZS/AKU
	zkXFy4ZeZhOdiEkyAuT5WV/Tv1yj1jxh/oNylLPl73bJOOcUve1fKLLjoU+10vb7KC8xCgjH51C
	Y0Fl8
X-Gm-Gg: AfdE7cknZrRcmjWMdAxddPxyIEWzfWlLYYfv5Fri56nouJcNBKngN2ZNiWIySFyl77M
	zkXqhZQKe1eS2aHCRGltnzg3m0ngBOHdIE6wEjMp4FGdjKkCqxRsUnZ/u2O6DFRd5HsbkObixLy
	hlF1rfpTa8bz76FBTQWbLGhqMDT72CnNoi9C0zZoQJJ1OIoAkBjQsnsK2gzxFdUtRzSAdheUl7Q
	c3Iou4d4Z86vV2Cozc+v3bObxBQJqas0Pv33v6ciROOdt3gtEitUxSsOzUX8hkaIiS/INOp7qBe
	MVNEBoe8WX0tpFVIAOCoUHVR9ba4ilu/JCPqcGLhtviQ7tb3oKYNlXcL342i7KHhpqAHCpI/T4P
	dglXertf9+AczjdcnknfPvr7KjJXJBS6N4LVcCOkp9YcwgblYOKmlg+5RZq179+XsfjLkngZImd
	Lds4hyk9rXuhkteNLefA2rJ0/GA9lANsktWcGE0AWeSQLWm8QYGS2QMMejvOKgeV/S6m1Hs9L5q
	6WSWg==
X-Received: by 2002:a05:6000:4602:b0:460:70d1:c75 with SMTP id ffacd0b85a97d-4623f3e0a31mr12204940f8f.13.1781778020444;
        Thu, 18 Jun 2026 03:20:20 -0700 (PDT)
Received: from localhost (2a01cb001331aa00e7e9bab757cf3530.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e7e9:bab7:57cf:3530])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619b9b7750sm33988422f8f.6.2026.06.18.03.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:20:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 12:20:19 +0200
Message-Id: <DJC3LE7K3NQ4.37FU3ZR3DH8PT@smile.fr>
Subject: Re: [bitbake-devel] [PATCH v3 02/10] bitbake-setup.schema.json: Add
 examples property
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
 <20260615-fix-bitbake-schema-v3-2-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-2-8dbb07d8765c@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 10:20:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19734

On Mon Jun 15, 2026 at 7:37 PM CEST, Rob Woolley via lists.openembedded.org=
 wrote:
> This resolves the jsonschema linting error:
>     Set a non-empty examples array at the top level of the schema
>     to illustrate the expected data (top_level_examples)
>
> This example intentionally only references bitbake as a minimal
> example that focuses on the tool itself.

Nitpick: The commit message does not match the content anymore.

>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
>  setup-schema/bitbake-setup.schema.json | 33 ++++++++++++++++++++++++++++=
+++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index 309088348..1830d16df 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -1,6 +1,39 @@
>  {
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "Schema for bitbake-setup configuration files",
> +    "examples" : [
> +        {
> +            "description": "Example bitbake-setup configuration file",
> +            "sources": {
> +                "bitbake": {
> +                    "git-remote": {
> +                        "uri": "https://git.openembedded.org/bitbake",
> +                        "rev": "master"
> +                    },
> +                    "path": "bitbake"
> +                },
> +                "openembedded-core": {
> +                    "git-remote": {
> +                        "uri": "https://git.openembedded.org/openembedde=
d-core",
> +                        "rev": "master"
> +                    },
> +                    "path": "openembedded-core"
> +                }
> +            },
> +            "bitbake-setup": {
> +                "configurations": [
> +                    {
> +                        "name" : "qemux86-64-nodistro",
> +                        "description": "OpenEmbedded 'nodistro' build fo=
r qemux86-64",
> +                        "setup-dir-name": "oe-nodistro-master",
> +                        "bb-layers": ["openembedded-core/meta"],
> +                        "oe-fragments": ["machine/qemux86-64"]
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


