Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871FACE8D72
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:25:26 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5140.1763144723487488356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 10:25:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CcsOJzPJ;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8826b83e405so32030396d6.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144722; x=1763749522; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iBlwtgFDPCH9MoEkw1XWGjBLzellEhq4nHkS/D2H7fQ=;
        b=CcsOJzPJigts7O8VbuL+Y1oUMDjRSqJqo9thhs1am4Bb6keJP7qoPvEMdUCzQuH8QV
         FIDmDDqZ0qqH5tlitMQ1KIF3mPxxN3LtlDlIr3wuoNPPcPZUrtK+kt+hEqy31gX7AADv
         VmnMde115ubAyZfU2G6WYTGLpd9nxwZ4TQRoq+IWOaeHTQ8aF/zJaWB2zcxPyIsNCzLs
         3ZZMLR2og3N6fp6w2XXFtXlpVT9AkcHFdQ5cat7OSxz3n6UyLDxpmMeAnvRIDdcDxYL9
         mjXCJwXbG4uFad2gEb+9wUHgGDiiYdNDsYicuFhDZFfy59Axxsk8l/9ZTG3ZS31zYQIn
         JoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144722; x=1763749522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBlwtgFDPCH9MoEkw1XWGjBLzellEhq4nHkS/D2H7fQ=;
        b=f1/DL4sdeN9zTf61ZAqsUJ4mD4kkshlm32g+ZWagTJWVyt2OjmoP9oc3f5DC+hwiA0
         R4Hl9+AKXhGVlLYboPYNbmDSQtIQFvDwc+rl3YnKlzruL5U012bN/0+D0fUpHihvY/BN
         aDKekQiU9PMiDay7X5jhK/Lp68FTvfWdlIKDUD1rPDU6zhR4wQEy0E23tQR3w/Uuv/iX
         mOIpM2CUtRUEEgiulgT01+nN1cr0fTqXUb+enj6+I3xbQNBCHaT6L3IX1WDcxX1/LJIv
         alPOUMe7jOp/uHiLJQkuYI2Xo8/cz77Mu1I5ERUdPnJiwkBQW/4PUydbuuiA8szJXBkR
         dFuw==
X-Gm-Message-State: AOJu0YwL8rJbtlvssoerjE1s2dwqu1iR8RgEIt8g06zw+uCNvLOYG33e
	LqPzo8YY+x9p1wPy4oivbe8BbTqg0N5LZ8PejZgBdGKAKmvxHPYbnGMp0uzEWlOZmiy0sjOCaVt
	ZMDYcNmgkkQri4qgjs3AMQU8HMfBkXfQ=
X-Gm-Gg: ASbGncuC1m5WVYXqhU0M3Yf1Ny+9665UUDAm6ziqBESSvo8vEm6ZGwhaDOgBka/FM6e
	T0qR0mQGqB0eWDxqapDHGz515HsZibYFVqb84VRlZ8vmOY+iYHOymR038tJYMdP3PL2e/iEhIFu
	JtNpomqvxW/Ee+dZ1Y0LkO83IYQxzwm9f+285bNidbQqXtAHp3WAqgmiZDacENLYZvk4/iCkuMy
	Y+GaYyzk85054QN2WOS5OTJvawhAmTEzLDrD/eMQiekpneQK4Weq27HtCSkTgSYopkaxg==
X-Google-Smtp-Source: AGHT+IGYC+/R8KI7Um8NvE5t+yW5N2o1d5Yr03X/xshrc+cZA6w9fVf93Ex38hQhAFGEOAqT7acm+SR7msldN/AxusE=
X-Received: by 2002:a05:6214:1d2e:b0:880:49f2:38b2 with SMTP id
 6a1803df08f44-882925bd9e0mr63878086d6.14.1763144722457; Fri, 14 Nov 2025
 10:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com> <20251114-bitbake-setup-abort-v1-2-d2f9967df3b1@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-abort-v1-2-d2f9967df3b1@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 19:25:10 +0100
X-Gm-Features: AWmQ_bmfaHAZkvSCYExZO8rrQjiLfPGC5gijRzVoB9etskzlKxpiftjjjYqj2E0
Message-ID: <CANNYZj9v-dSaNN4_Px2CN9HnoevNmioNZnODHr7ihTAOqteQ-w@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 2/3] bitbake-setup: create top-dir later
 in init
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 18:25:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18409

On Fri, 14 Nov 2025 at 12:07, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
>          print('Bitbake-setup is using {} as top directory ("bitbake-setup settings --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
>
> +        if args.func == init_config:
> +            init_config(top_dir, all_settings, args)
> +            return
> +
>          d = init_bb_cache(top_dir, all_settings, args)
>          args.func(top_dir, all_settings, args, d)
>          save_bb_cache()

save_bb_cache() isn't called anymore with this change, so needs to be
an if..else block rather, with save_bb_cache() coming just after?

Not sure if that function still does useful things, it's been there
since the earliest prototypes so I no longer remember what it does and
why.

Alex

