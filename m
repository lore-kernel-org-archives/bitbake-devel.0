Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B363ECD98ED
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 10:32:07 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16675.1781778723959472745
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 03:32:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=U4ihM6Kn;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b9318997so4863605e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781778722; x=1782383522; darn=lists.openembedded.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uExczA2mXI4pE6R1O1mXdbdRUZTDcmim6ByjzSQaXTs=;
        b=U4ihM6KnmDzoC2SYgjQNJ3lkGD5ly7Wdy+OK0hCQhqyLdciE8SzH7HWXWRlpgqm+g8
         il10VvNSI68K20vN6ImPBEJE1vZGrNkPVYcT/vcMwoCyWQEUrGkTOGauoBcwHi28KqkL
         HvKNjUOrGLqrmdjWmTAoxgcPp+G9JeTja3PoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778722; x=1782383522;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uExczA2mXI4pE6R1O1mXdbdRUZTDcmim6ByjzSQaXTs=;
        b=icIQiq/gM09J5eizkOh5MJEjjSf6pmi6bZi8VhjojGvfjkOWERhfRWvctyQQrvP5/I
         36tSqb8JuVAaF6+T+9tDSPQDJbTZpoNe5z4NMvqlNzYI28AILZOvd+DJPyhd5YNWIGnu
         PsXqzSWilGtWZgTvQILExhVjRGvKxfqCQeR4eZqUwStYDudoGcYvvzeV9iPzBTWpaqgm
         civNQktP01FhFEgXFYRhKXAVB2TiNQ95zxPxWJZ56dsxtz00bmf0xPtFk8dAKDN/nJWj
         6ImR7EWLEsTJwryMIwDJigbt9ugldkjOrDgIh7N69p0mEYXzpn0l+XQ1zp/a9SCEf8Oz
         1xJA==
X-Forwarded-Encrypted: i=1; AFNElJ8I3colqTeJrOe8nWfyiZb9iO6ipRXw284VZIkjB5+RG1xQ7pTWRkeg7TNA4VO0LiYa+vOKfDC9V0vG2qJe@lists.openembedded.org
X-Gm-Message-State: AOJu0YzkoA5hQv11gO+s/fWTs4RCm1b3iEolT/ZXSKX+xLPuo5OhDYVq
	rAiTxWsNdSZArbnHv07OomkCgllPYRSJe1wukTQ8MrW33PC6A2l13j1nyW2q9EpQ7dQQ0TnRivT
	pcHBQ
X-Gm-Gg: AfdE7cmc5aTmbEitgbnYuUWQqMw9D3uFhJFjtcb163YDofTbeKlgZgfkIXdJXLPnmuh
	pElBxqY+yfwBZdGP3WiN79R5WSxtVXW5fX2QsuKuw/2ebwBrgvb7pmTfaPaUB01u5pyw4YGTZPC
	VoD4ItNyA3dVJkU/eHEmvVWMRG7UKHIt1zy8jsL+DX1AWaVvmh3azqzeBe9lbQ+6R/Q0+v9zmNO
	1mgUCfuiduaDPAKNSye8CxAfYSpt4g5/LqP4gFUetqvOjhfkt7XmjZIQozyQQQIqDka3inthUfJ
	PpZ7DRH5f2hBPpHDmXUpq8dj3zns1y2sSR9tEIja8/6u1F7x4SOQrb/jn5m5ybvVvDRHPPLfFqU
	DI/Qda9AT542HhhpufhENi5kQgiZMxvgbULOv8JHdbyJbE57Kz2Eu4QPF8Vh3gyU8A+LG02Wo7d
	j9vKaWeM+e/HAM+uQwrD10BEhe/MsgaJ2XV/sdPZUn0rPEBBWPWKH8ugWZBmf1la/Pm4pqdBdtK
	MiGaA==
X-Received: by 2002:a05:600c:4f84:b0:490:d354:bd0a with SMTP id 5b1f17b1804b1-4923822a867mr50891885e9.31.1781778721711;
        Thu, 18 Jun 2026 03:32:01 -0700 (PDT)
Received: from localhost (2a01cb001331aa00e7e9bab757cf3530.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:e7e9:bab7:57cf:3530])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa97a07sm400329545e9.14.2026.06.18.03.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 03:32:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 12:32:01 +0200
Message-Id: <DJC3UCDT5RYP.7B1TFMW415O7@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v3 10/10] bitbake-setup.schema.json: Use
 anyOf for non-disjoint subschemas
X-Mailer: aerc 0.20.0
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
 <20260615-fix-bitbake-schema-v3-10-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-10-8dbb07d8765c@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 10:32:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19737

On Mon Jun 15, 2026 at 7:37 PM CEST, Rob Woolley via lists.openembedded.org=
 wrote:
> The oneOf keyword is for matching exactly one subschema.
> However, the branches have disjoint types so it can be safely
> converted to anyOf.
>
> This resolves the following jsonschema linting error:
>   A `oneOf` where all branches have disjoint types can be safely
>   converted to `anyOf` (oneof_to_anyof_disjoint_types)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

This look confusingly similar to 3/10.

Either make the title more precise or merge the 2 in 3/10 (I'd do the
latter).

Thanks!

> ---
>  setup-schema/bitbake-setup.schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index b724dbadc..177a8dc8c 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -76,7 +76,7 @@
>                                  "description": "Human-readable descripti=
on of the configuration"
>                              },
>                              "notes": {
> -                                "oneOf": [
> +                                "anyOf": [
>                                      {
>                                          "type": "string"
>                                      },


--=20
Yoann Congal
Smile ECS


