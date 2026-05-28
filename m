Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5DCCD6E44
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:58:55 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8327.1779965933246990904
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 03:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Ak9NFdEg;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so7614401f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779965931; x=1780570731; darn=lists.openembedded.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pyRLpBBjoamhUhXINq+p7sqvg7htdxX//aH+ZkiShc=;
        b=Ak9NFdEgQ2a4as1vKb37s/yYY9W9AOSMob5zfZJ63DyTNvja7vt8NxE2seDCXOL4PW
         TVqETmU4DjFpREfdNmMyE4NucDOWw+c2h2Fnl5LuMqx6tW22GGEOvoTpFYxYq67vEMDo
         +gzzU4K3sAf5vRBBeSIYawKws0z440FX8V+xE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965932; x=1780570732;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pyRLpBBjoamhUhXINq+p7sqvg7htdxX//aH+ZkiShc=;
        b=pn8FU0VbgYfrY5lfa0Ay2Mkudtj56r4S3PKK0Iz9LjcYrPkBOdBu6RM6Vsc9tOZz1W
         wYt4ovBu4QvPxyp6glSgBj0T2paOgNQaeaOEYpS8OKKhs30otiPyDcH3U3J1huNObJZt
         miFxMmzm20Aqt0tjrAKhKqNX5MjkND3R+o52l7CQB+AsIxbdx8bm0/pbdU1a8w5wSHQT
         deLcC5Pf5rW3iZ/pO9rnyWTBwK832IT8T0cGXv/ZZp2ldCexsP59iIqaR+RMJS4tFdCN
         KzF516iVef2XQ2tEwFW3YyB73XHohR2MwFnZii2PqNCiF35F0arsXeRjZCitpNQ4AeHi
         grlA==
X-Forwarded-Encrypted: i=1; AFNElJ9tEbYHaNmPmclsRJ6c12o+X2eVyZRuVwmM74VouUZB1iP5EorJzZB0JcgYO75l0Icf8FkZwJbl3rO9Il8s@lists.openembedded.org
X-Gm-Message-State: AOJu0YyYqiGWufvny+Ky/xffv7zsIj2G0r2cBj9wV+CnqxyG2rUtGngI
	yixJ+6Iq76kXLi1KMBOhLfIjuXYu320eMKjpyvjeZdC1W7E+0JsRET4IdKmo5lO5nvmNxPXOkg2
	F3FoQ
X-Gm-Gg: Acq92OF6I4sjjOfbzGbDFzLQAyQaBExbhnN7LLtwiM7HKUiF4jMPQH+TZrp1Degdnnm
	n1LYraSgVTY4Sa2qpE+LZd/MwxMcJfNelHsfpsUBnCDzXGq13mQWkhqIRHvBBAgz5vdvV9Fwq/j
	umgwzoxy85qcnF14vb7i/I0JBO0jxtRlHxtz+rX6HPNTF+4vcnZBS4PygBAxh4neI26sdKRRQnq
	xXswlbbfCyXswqiGZD5yczPW+3gdQqL+vdMlAUK/j7CYWMzLz3Zl0fEqCS+nYig30EJAZPOjKVC
	V3GW5zZyR2XYZUVxQWQLblnFdCOL8CF8qC3hO0p062EbHPDXNiezRixKR1FeGDOSlyvs9lqWSpJ
	bVtaLQI/BIbb/hDKUflLiJqXQEZRQl01S9u/iHGU/t/ZsjNdvZsshu6OSzczOXRcQ3zNj095EFu
	jxNz9iwn6mk5awJUNaVMqiV77VEM2F5cl4MRcWHvjjJslJc5aVSjlRywlXwt4gGxvHit8BO11dQ
	ScCEQ8lzI3yhqQ5OcspfuxBTCZOuOHF445h
X-Received: by 2002:a05:6000:4308:b0:45e:e513:f451 with SMTP id ffacd0b85a97d-45ee513f5ddmr4026853f8f.7.1779965931380;
        Thu, 28 May 2026 03:58:51 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb557545sm13660322f8f.12.2026.05.28.03.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:58:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 12:58:50 +0200
Message-Id: <DIU99FYZF6F1.3157AOBK086WJ@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 6/9] layers.schema.json: Add title
 for subschema
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-7-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-7-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 10:58:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19556

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> Resolves the jsonschema linting error:
>   Set a concise non-empty title at the top level of the schema to
>   explain what the definition is about (top_level_title)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  setup-schema/layers.schema.json | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index 2c192c8b0..8bc74a533 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -1,6 +1,7 @@
>  {
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "OpenEmbedder Layer Setup Manifest",
Just noticed a OpenEmbedde*r* typo here. Could you also fix it in this
series?

> +    "title": "bitbake-setup layer subschema",

This is not only a bb-setup subschema, this schema is valid in itself
for files used in:
* openembedded-core/scripts/oe-setup-layers
* bitbake-layers create-layers-setup

For the title, something like "OpenEmbedded layer setup schema"? But
then, it's a little too similar to the description. So maybe the
description should be extended?

>      "type": "object",
>      "additionalProperties": false,
>      "required": [


--=20
Yoann Congal
Smile ECS


