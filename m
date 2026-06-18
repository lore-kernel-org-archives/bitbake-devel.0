Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C941DCD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 10:25:17 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16587.1781778307860405728
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 03:25:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=YSRChTWP;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so650070f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 03:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781778306; x=1782383106; darn=lists.openembedded.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RatqSgsFrM+87nN1pvGYBQB5EbdhQfWHaGfKfsyQRRY=;
        b=YSRChTWP6WT+1yoxj6+che343aGuQr4Gipe7ef/g6X9+5bTQ9rQHZBFFHEn6l+viPM
         U64/5KTew6dhCb+NnOvDdW2mCo7ZcOjvyS5V//EEE+eyvLLHkXW6aAwrO5MucVSOVSU8
         ZAcLceMda+DnHr1zPjF6JTataGdCTuUgO61dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778306; x=1782383106;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RatqSgsFrM+87nN1pvGYBQB5EbdhQfWHaGfKfsyQRRY=;
        b=RbSzQQ6sASFNXGk5RwjoKGlGF6e1ltMUcRKhDI8JM6Wrpg1VXPYk+8VZNNMgI75NJz
         6kkTTLixPHtLeeS4kKYxDFI4Io1UdGjgzmyrdCFr3dItMSsuuU6XEkzcFd6K09xx3khq
         /NEG7X9mK21r3CfFTPsmmobnUFuyl4kTu+Vjyo52XTFge2c/jzu0AIPJDMFuWEQtqfCm
         TAxAymRAQQxcKjfskimtv716/Xb4bmhE0cSHScDnCBjs0QTyffPBeLgOF4JRlZSmJIOw
         cSi7Ll7X6QlHGfU6Ryo4kbpjKtE2dd5kx7ZwIR/cIu7ei8pB355+3JjRsZ6lQInsWLa4
         4upA==
X-Forwarded-Encrypted: i=1; AFNElJ/mZU1vg6xJ9oQ54C4F8eknK+dxU4ZdZCp2jdS1nWgC2U7Zv0rGex/cwipCOMZJx3rOMqi80gzo9/SAv+nJ@lists.openembedded.org
X-Gm-Message-State: AOJu0Yw16anFI42bN6zNZ/ZVQiXOk8xfk5vGP7Nm0diMDgH6ysnI5Svu
	RfvQXf5mrToUO1NK8uaqZUXMs6v2ZShS6PhIzPO/8bS5gd/dyAPHdpFZpyWz0ZKPbaNxAFTw09r
	BhM2H
X-Gm-Gg: AfdE7ckNGfuUWRQ7o+ULjXDtba1fQrg44aj6f2o2rj2fODDezWao6pNSErl1BibXNSc
	xw+u9P0OV9B+MTg6ykahypS4HwY3cXS7t/13zNAfmoxvPfHvnRNgcs1b27+WDpm02hVzV5Tq9V9
	VboXxmwgCCBHcdzvFNk2uXOHesnWfObnjuD7WvgpP5sUo4/lpDYJgNaBwmilausfZrMG28Q/5Rk
	SjbfYPQs1VJFoV259siVwW/wxd0osLd9So1T5AtDvlhoGN7oIzSpM8+vQ/PyijUi015Xbw7Mq1p
	v1MC3IjT/mUH8wiwqLDJlUslg0rQwwajDqPQYFf7uWMFNlnB690hM+opNU73LFirCJNrVvZt3Ve
	fnsQXKU5r8wydrbACeUKR5yk2NlSD17+Frk8hbW6aHlxNPLzSRgcQMxaqEn99/zIbnEsoTm6aCj
	fRgRnxBUQZn9nlsc84l0dD+GNAEnFyxPc/Qj2qtljF0HZV0ZQ2uc2ov6EwO1LXYL5Bn6lvosSRw
	/T3zA==
X-Received: by 2002:a05:6000:2087:b0:45e:e3ee:98b1 with SMTP id ffacd0b85a97d-463adc929c2mr4759746f8f.32.1781778306014;
        Thu, 18 Jun 2026 03:25:06 -0700 (PDT)
Received: from localhost (2a01cb001331aa00e7e9bab757cf3530.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e7e9:bab7:57cf:3530])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm63842280f8f.1.2026.06.18.03.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:25:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 12:25:05 +0200
Message-Id: <DJC3P1EN3Q3D.3RX73DIHG8185@smile.fr>
Subject: Re: [bitbake-devel] [PATCH v3 06/10] layers.schema.json: Add title
 for subschema
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.20.0
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
 <20260615-fix-bitbake-schema-v3-6-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-6-8dbb07d8765c@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 10:25:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19735

On Mon Jun 15, 2026 at 7:37 PM CEST, Rob Woolley via lists.openembedded.org=
 wrote:
> Resolves the jsonschema linting error:
>   Set a concise non-empty title at the top level of the schema to
>   explain what the definition is about (top_level_title)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

>  setup-schema/layers.schema.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema=
.json
> index 2c192c8b0..afeac1869 100644
> --- a/setup-schema/layers.schema.json
> +++ b/setup-schema/layers.schema.json
> @@ -1,6 +1,7 @@
>  {
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
> -    "description": "OpenEmbedder Layer Setup Manifest",
> +    "description": "A schema for a manifest of layers to setup",
> +    "title": "OpenEmbedded Layer Setup Schema",
>      "type": "object",
>      "additionalProperties": false,
>      "required": [


--=20
Yoann Congal
Smile ECS


