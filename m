Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5828CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:41:34 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8012.1779964892378604100
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2026 03:41:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=f3/ktgyc;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4905e190c71so50863685e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779964891; x=1780569691; darn=lists.openembedded.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD9RaLEHKOahV2kcolT4assad0A+5jHTwDg4LsIqO7g=;
        b=f3/ktgycCfzzJYYwPwi16jRyy8ZbNJvZiNs4w5PQ9O31mCwd0O/IVG/3yq/n6FLPF+
         enbZxcc4kWC85LVSZRj5ZBFpD7Z++pCaZXNcy3vb7pMhkIe5TKPVMBQ7MBTsuxypSjV9
         TBk9uESQQArKrK0GtEz8CWAK+MVKkoWa4e88c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964891; x=1780569691;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD9RaLEHKOahV2kcolT4assad0A+5jHTwDg4LsIqO7g=;
        b=J/bbQWLkGJOJ04KgBxumTJsXewa28GCBXWUA65W3CuteMNpJHRHAjXeB4iLIngTvC6
         XKIIR21048PHtyAIeWXAIAtcjsfmUMT22eNB+GScni2WsbhpBtoMtRxA3cbisbIn84iT
         n2sWLjuE+NyZTRSvZzxAAlwssdOrT5YlsFy1ldSBKqdLcyjKL8USyf3WCRIeCUdmQgWk
         6x4kQl2VnEILq/BxpEuInCnXDGUEaCtU188g3kOS+Balea5Nr/xw+DEkG5x2InB1fl70
         d8FE46/JIcj8Ruhj3UN3rlt8jf2Jm/8nshE2+gHarWNztADlE0oGPNcgynFhCpAqUGUD
         JiCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jNQf2v2swe1VGBG0lBeybsxiR7VkWpCDOS8b3x4/PMM6b8JL99zLJjGWegoKWhH+7uJAW3r50MA6Q2bKr@lists.openembedded.org
X-Gm-Message-State: AOJu0YwGehqbBmICYupxi2pfVT56fuYrJrbuZUQ+GrW4Trrcpcmy3HWu
	SL3/eL27aN8G7JVg/1tjNCIE7sphiliYmfwZqUeY0nOtg/eEMROOz1n9IxLyAmbUy/s=
X-Gm-Gg: Acq92OGmd/IeTlaspufHAf4E3aoANYF+FsBhuUb2lbvNO1Gk3+A/DmW1Xwqo8CVVvFo
	bwyWUxneTOON3c6DevqWWFzF1f3e+CqyuJgEdgSQH0C2pJF5buoJAq7pvdoVaXF3YmA4ZWTbuZs
	px6arrI03vGo1ob7s7lRIhJ7mYETzXF7jMT+kCg/q2KUYNaX8w84I9TeAr0zgily4W3SeHRVMMT
	8Q0SVwQBxxlBLwy6O2nM9tMual2W61bMZqzY/Z0sPteclW/pyYZXawgl7ooXEDie36f1M498BV8
	I8KjhUg6MXWJZZqYgjK6ZZ1U69C1GRzxPxjADFA62dnEOGBbZuVUBH9e1JDjp0oe2DZP6YDaAPt
	Hye78qQKgBjhMTOGV3UPhHavsliDY3sLgjByLpm7iqhQjKkNB0L5+abMtgUy9AR5W91S2bvrmYQ
	FyPlaacSM57NkzlW2QoAGB71unod4d68G9wtUy6tKMUqSTktVqmC/tSiejjArunYeMs3zjrH8WB
	AvUzz1N8LFl/BoKtsQReBVcoA==
X-Received: by 2002:a05:600c:a402:b0:490:4033:d3df with SMTP id 5b1f17b1804b1-490426d7223mr321743545e9.23.1779964890650;
        Thu, 28 May 2026 03:41:30 -0700 (PDT)
Received: from localhost (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908b6a93bdsm14953855e9.10.2026.05.28.03.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:41:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 May 2026 12:41:29 +0200
Message-Id: <DIU8W5RSMQ0O.ZWE09D6FRLQY@smile.fr>
From: "Yoann Congal" <yoann.congal@smile.fr>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v2 1/9] bitbake-setup.schema.json: Add
 title for schema
X-Mailer: aerc 0.20.0
References: <20260407150250.104135-1-rob.woolley@windriver.com>
 <20260407150250.104135-2-rob.woolley@windriver.com>
In-Reply-To: <20260407150250.104135-2-rob.woolley@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2026 10:41:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19551

On Tue Apr 7, 2026 at 5:02 PM CEST, Rob Woolley via lists.openembedded.org =
wrote:
> Resolves the jsonschema linting error:
>   Set a concise non-empty title at the top level of the schema to
>   explain what the definition is about (top_level_title)
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
>  setup-schema/bitbake-setup.schema.json | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbak=
e-setup.schema.json
> index be8772db1..d340c9785 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -1,6 +1,7 @@
>  {
>      "$schema": "https://json-schema.org/draft/2020-12/schema",
>      "description": "Schema for bitbake-setup configuration files",
> +    "title": "bitbake-setup configuration file",
>      "type": "object",
>      "required": [
>          "description",


--=20
Yoann Congal
Smile ECS


