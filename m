Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCBCD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 10:27:57 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16622.1781778467432222579
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 03:27:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=aAv3D8UD;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490a76757e5so4432095e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781778466; x=1782383266; darn=lists.openembedded.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9+bw6NnITTGs5d4FgNqszp1iN4d/XneRveCLxSCSE4=;
        b=aAv3D8UDr3dj5VYJ3XGXv21EjFVtd1LAtzTsPhSx4hg2X1j8jYTWpmAOf29I2bJzaC
         h/zA1jSfi+WpRCPeZFPbf8iMW7DITjWtgjFiuN3vFxnoWzVtTwGV4DIstO48SMokri3G
         pdjJviKVvsff9p2g9R0kzA6SYGrG6RptOhoxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778466; x=1782383266;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x9+bw6NnITTGs5d4FgNqszp1iN4d/XneRveCLxSCSE4=;
        b=ETTRO5LLpjkORyaK7smRW1UxjxdjDZgHNO4gfAYwPy7Jwflp5oTlHP7ZxdnEyTls3K
         rW/IOuLqG122ZI0HHsmjmsyBJME3USv8iDtmmtnVd6JN//HhCh9rcwk6O5zL+Gd6S+/8
         NUN/lICOOyI0f2aKcpYrruAKIJUFU4+AVvFbOE1cNQUQYd+ZdZPuSNTp/VQOpCV7RxGn
         yTmLZIW+UKrkvizbxKn1U+kGC/aKWQRV30UzYUn7ICwRJFcychDAOjtARDYwR8wUkUBv
         W+fADapMQUTSUn7g+gD+oWUFSAxYtUGIzuFbQwaE32nt+Zn54viT/AV+kpiX/5xu80Ho
         wyzw==
X-Forwarded-Encrypted: i=1; AFNElJ98X9MNSwoDi19R4VJFZbwp0TOvFNb0s/5m79CAJ+17Qy28c5tRdruvoKkPLn6eq0N8v2QmDymNlvLZeqgT@lists.openembedded.org
X-Gm-Message-State: AOJu0Yy/M9xMhFufhoudlCNzo8LWwzLHQTC37BMyH24HqsCPtRhccgYc
	7CAzGQt9hSd/9q3SUivH7+litCKvGyDRm/jKIkqtVKo+IDcsXHF+rYUSj1opPL4a5drfFd2gfxn
	OolQP
X-Gm-Gg: AfdE7clfjuPqEgzDB1kvgdG7QZKJU5alFq7z3MYSvXB9MYTv/lcBTkqerM0uYMT7kjm
	os3iJ80TRvQ3XDZJYLJdrlyJxYTo1EmWPMvT07Ykt4e8ghTeJjiY30ycODpoHwhJzeKflSKtNAd
	Aj0RsJsgKURLZnHW4WD7914kjpFifRz/anUOWTQbAnNWrSr0LO/oeCGqlkxpnBsXkKN88tKIdhx
	TFc4gWsMbjOtF0Nb9gZ6ZPfu3vCQBxS5Iys+YxxoiXUmT1tHnj0BqIWZpYr/ezRAHdwMfUa5RUM
	nD6MX20dQ0jmYmn5gf85UizOTn7BI9EeZiZ3/bpDMsik9YHceOLGCEodgauUQRKBLBAIlDycDsu
	LOccSSTCETXbNByAQL850SdVaV4a6BZpOOGzzCvZ5Qm/fR2Ec4YGyhOGQ15UltdO6k7V6Fokcot
	0tAO0XHbCyG/awqEp6U/MrKaWopor0TniE63Kuq1gTRXY+YdLiJe9XgUlr3u8LyGkyGjaAMgpjG
	ggCBHyy9aFDxiWW
X-Received: by 2002:a05:600c:a48:b0:490:bd66:e523 with SMTP id 5b1f17b1804b1-4923821be5dmr48097555e9.20.1781778463203;
        Thu, 18 Jun 2026 03:27:43 -0700 (PDT)
Received: from localhost (2a01cb001331aa00e7e9bab757cf3530.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e7e9:bab7:57cf:3530])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49234daafc7sm117856425e9.10.2026.06.18.03.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:27:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 12:27:42 +0200
Message-Id: <DJC3R1NSAYIC.5XB2Y9OD2AQK@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 07/10] layers.schema.json: Add
 examples property
X-Mailer: aerc 0.20.0
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
 <20260615-fix-bitbake-schema-v3-7-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-7-8dbb07d8765c@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 10:27:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19736

On Mon Jun 15, 2026 at 7:37 PM CEST, Rob Woolley via lists.openembedded.org=
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

This is the same as v2 I reviewed here:
https://lore.kernel.org/bitbake-devel/DIU9DXKA1WVE.5Y4IC0UA8Y53@smile.fr/
My remarks still apply.

>  setup-schema/layers.schema.json | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index afeac1869..e75380be8 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -2,6 +2,25 @@
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "A schema for a manifest of layers to setup",
>      "title": "OpenEmbedded Layer Setup Schema",
> +    "examples" : [
> +        {
> +            "version": "1.0",
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
> +                }
> +            }
> +        }
> +    ],
>      "type": "object",
>      "additionalProperties": false,
>      "required": [


--=20
Yoann Congal
Smile ECS


