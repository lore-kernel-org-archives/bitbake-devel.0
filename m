Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F2CD6E44
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 11:04:55 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8420.1779966285590360818
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 04:04:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=TtSzzywZ;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49039a8851fso71114905e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779966284; x=1780571084; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb/uIZl+AyWdVA4USW17VfUrSMBSgu1ncPwBADbsHuc=;
        b=TtSzzywZj/ZznQMm8rSazJUKtA+xjCoeNbdrda9fXIBn8JnxE0t2vyR+cWpaTQtBKb
         m6NgegMa7Vl/mqvnh6zHtr2OYNO9/4KVfzgAwfMATSKb9WHBinjpjiQlUi2srk5Y5JM/
         EFM7YyUuTYUvLXnpVu74lgNBPoCHE0a4Ded7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779966284; x=1780571084;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hb/uIZl+AyWdVA4USW17VfUrSMBSgu1ncPwBADbsHuc=;
        b=cpjYQeA2oU/Y1PMaogWwos5qcKJGnFUhbrrnXTmhPhLRnB8I+68Whx+Wy9bKsrTyEr
         A6pWElY5IRT7EGfj1/V396sQ3tLdHmUdOj7e06mzpF5xsCnlf5ASBB/Pi/ZDig/oVftG
         Dd+SUGHVL8rCxr0GCN4CvmTtESH+jVjdBx5u3CKPAyx5JSaVwenV1HatrRzDvtG1Lg8L
         IicYys9Aohfmz5ySIiN1kDE3+0+bd6oNKw4IAF0rymPnghUSZ4cWBL1LiAUWxUz/mCv7
         Lpg8h8IA+z4+ucVYVNFZ+MvjLW0+8tT5+atKYAxM98fIgXwm2bJo2cJzLDzt3oEpoFNh
         F67A==
X-Forwarded-Encrypted: i=1; AFNElJ9FOmY7xkTTufde1Lvn5bprU847P8VgV1URM8H55NZwsytzcospPl6MbJffIv9OzT9zur642E7EfOuEoNn+@lists.openembedded.org
X-Gm-Message-State: AOJu0YxCMUQlev2CnQJX9tdP8z4UD8II7xV6UgGa5uCHZHzr0J9eRxEh
	0NHcq5NMqybTWsU8jb7g8SvXv0Am25aH8QYUwdcfFq4iYBq5suupmJXmqew7A5PDJzie63H7+EI
	J57+R
X-Gm-Gg: Acq92OFex+d9t5fLygTpqEV52YcolW/RjC83pDFkNpnKTlyasNDxYmf9zZt/Qi/BIha
	S/UhFmguG9sCElkLFm0+F51F3CFuzkxGWvhg8GG9bhTdzGh3kN612dRckcgTrMxS334pLWznxWP
	LJgdI0pLVOmF8kYnhWwi+N9ay9nqQvM373WQHKqPpQkkUsdG9tTvS0Stmxn1lOIumcatEcK6xHj
	izx81Ize1woxB8glfYmTbLOQrGn4Tj0KzY4U40cKNiWJ46y3Qww91KhW4XTDCdbjQp42D5KGCoQ
	R7MFuW8X7M9Duq/2n1Usp/PCBqLY+FUBqI3sW2tHCxGni5aLa2SwpuWuqA2geH6/Il5j69C79+k
	W4+du67ef/fyeQgzpYxVCVWJjXw3LG/S603KiJFyUQ60KYmDZQba4JOxbZixFo5IEq+A73z5Jhb
	JrvVIPce+jxXDVFD1MUsNP5j0ofBA2yNyQQN5F+czHG1Xl3Bz4h5Jfbu2rhnN44RDj+UEcMq/tS
	KV91uTAdPpYIi1FAJVIA07BKw==
X-Received: by 2002:a05:600c:821b:b0:490:845e:3a6 with SMTP id 5b1f17b1804b1-490845e0467mr99510875e9.25.1779966283719;
        Thu, 28 May 2026 04:04:43 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908f0a3c2dsm14609505e9.31.2026.05.28.04.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 04:04:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 13:04:42 +0200
Message-Id: <DIU9DXKA1WVE.5Y4IC0UA8Y53@smile.fr>
Subject: Re: [bitbake-devel] [PATCH v2 7/9] layers.schema.json: Add examples
 property
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-8-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-8-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 11:04:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19557

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
>  setup-schema/layers.schema.json | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index 8bc74a533..5c715f08e 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -1,6 +1,25 @@
>  {
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "OpenEmbedder Layer Setup Manifest",
> +    "examples" : [
> +        {
> +            "version": "1.0",

Can you put the "version" key at the end? (Like we do in=20
https://git.openembedded.org/bitbake/tree/default-registry/)

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

Maybe use the short form here?
  "sources": {
      "bitbake": {
          "git-remote": {
              "uri": "https://git.openembedded.org/bitbake"
              "rev": "master"
          }
      }
  }


> +            }
> +        }
> +    ],
>      "title": "bitbake-setup layer subschema",
>      "type": "object",
>      "additionalProperties": false,


--=20
Yoann Congal
Smile ECS


