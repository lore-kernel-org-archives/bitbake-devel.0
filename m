Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FD5CD98F2
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 20:14:24 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50871.1781900062386108372
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 13:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JLEesQ0k;
 spf=pass (domain: smile.fr, ip: 209.85.128.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49241896317so5575155e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781900061; x=1782504861; darn=lists.openembedded.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnkcxK4tAUdjcHxLqPiaOYoU68MX9ccOi22rt5HiI/A=;
        b=JLEesQ0kQjEW9h93i7hWeTQouIRkf/4qGP96Hywi0EnkrtL/KFsEtujCFU3OqgG8By
         m0Y9RA0JM1HZu/MAwcTzf3vOaObcmFu6yrUyd9DIE++fwiigeiiWGC3PlzoSCfGxl7Ks
         ImR1OlLMICRR6Iqumik2muQGUlM97DUYYN2ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781900061; x=1782504861;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnkcxK4tAUdjcHxLqPiaOYoU68MX9ccOi22rt5HiI/A=;
        b=CH29HCOh+5i85xHWuU+ACRXvXqca7UpXOnfauCyfmyETFNLmmJ0jTsffzbVw0VQMeC
         NpQJ0l3SAGjJ7zIeDl9ov58T5sZP99p6/Lcs2arLYC7txIlVxcgh/P1C7KLOUZ71TI7Z
         vThf0H0geNW2UNGKVCwOvwZDJxO302UtoMkQimK7J+kUyCSJeOYPMK0BeUKvK9seQuhh
         uKWbrJWooyvr8zIzXYu551XNqgT5+orUgbYrzugtfcgHo/+ejWj7UCzCRBhsFyDeRFqJ
         bLjiLziCz2CpXeZmFF7S9O30xh6U2ruZM8hrF3FtMn3wBqXkiJsiHh7Bj+1TINwRfm75
         V8uw==
X-Forwarded-Encrypted: i=1; AFNElJ+Oq9q8IrWxTbBXrV7QhX4BpQoeY5wpKB7svbc3N87v9Rr4NGKCjE07B64DJDiMcNvfW9NQF4LLQNiO8QBs@lists.openembedded.org
X-Gm-Message-State: AOJu0YyQAbjC3khYGYOwrZ8gVEtoVHSR2q3bFMibKTfPlHPawISUKVg6
	ewicSor1PHyxBhDhL04eTsyCc5vhiFxK8ToR7O/cv69U+wkRDQ+BmPVZW58YW0/0N1gXNxlfTYg
	Hgg4t
X-Gm-Gg: AfdE7cmNBiBMsapix0FQ4ltTVYou4VAFtrn/QS6J9O2LlFnFr1dfhcWLQYkSuBsmm/7
	Jc3KsMc1/Lad2s7Hg+Mp7X0WO7JggSdNKW/uxrx5xR86Ro2wV9tnHthUa98N3j1oI5Jvj40TWmg
	knoFIpMK54KOmGNacCS9/Paoy1+922GQlRQBdq5CW24Vp5QxyBbwxXybFuo9TeachgYyYHMY80m
	pGAz+b18bT/oo0O+f3JwN05rBmXVMBQs7CZGOXRhGp9bSIH/BAmJDVfLkSyhFrc9sR1RV+FmGEf
	ahfFoXX18r50i/toZqbTtypoKCyajD12wWPXyhQUMxkkxnbZWEIgKuMrz0cLG9aHAoft+AqHnbA
	yXV6HneeL58S/601lBJ7znCyrfP8NMRuyDDRb2bf5K4OqgWXi+qpW5fa74X8mwA2XXVXqFlNOuf
	akdGoAp7RbgPL/Mb9Cx+GboHGW1UXfzaIRhga/hacTMT22vaXwOk3fIf9UKjzdXXdMPiX8iX8XN
	mfwV5l0jxRSXi4=
X-Received: by 2002:a05:600c:3e06:b0:490:aef9:aa3b with SMTP id 5b1f17b1804b1-4923f5a8bb9mr93731365e9.32.1781900060550;
        Fri, 19 Jun 2026 13:14:20 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466643f4e9esm1512117f8f.1.2026.06.19.13.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 13:14:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jun 2026 22:14:19 +0200
Message-Id: <DJDAUQNN1HWE.32PG5PLQDOVWK@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v4 7/9] layers.schema.json: Add examples
 property
X-Mailer: aerc 0.20.0
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
 <20260619-b4-schema-v4-7-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-7-1e25a4651b80@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 20:14:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19762

On Fri Jun 19, 2026 at 7:39 PM CEST, Rob Woolley via lists.openembedded.org=
 wrote:
> This resolves the jsonschema linting error:
>     Set a non-empty examples array at the top level of the schema
>     to illustrate the expected data (top_level_examples)
>
> This example intentionally only references the bitbake layer
> to provide an example of a single layer schema.
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

Thanks Rob :)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
>  setup-schema/layers.schema.json | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index afeac1869..26a0f842a 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -2,6 +2,20 @@
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "A schema for a manifest of layers to setup",
>      "title": "OpenEmbedded Layer Setup Schema",
> +    "examples" : [
> +        {
> +            "sources": {
> +                "bitbake": {
> +                    "git-remote": {
> +                        "uri": "https://git.openembedded.org/bitbake",
> +                        "rev": "master"
> +                    },
> +                    "path": "bitbake"
> +                }
> +            },
> +            "version": "1.0"
> +        }
> +    ],
>      "type": "object",
>      "additionalProperties": false,
>      "required": [


--=20
Yoann Congal
Smile ECS


