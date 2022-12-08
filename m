Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80202C3A5A7
	for <webhook@archiver.kernel.org>; Thu,  8 Dec 2022 16:04:27 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.18149.1670515458310264746
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Dec 2022 08:04:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=K3/BHqxd;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id a19so2067262ljk.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8yk5JcXwRAceOqoIVvQQt22xh13dQAFKlMrHQJpm49E=;
        b=K3/BHqxdGQFi36r6jsii49/kQB8LX5p1sZpt0qYDMsRv/PvIoq1G5JQTyqxx+0eF8D
         1DnvP8l6lRn8Ly4z0ItyZuirRWYqSRyupO57MDu1qx0IQ8gg8nOAEOodjvPlmQ05u9f6
         VMQaUq7dFax5OaVY9dnKgNNiu0rXpmDwR6Wh5KDw6TrvJeqIoit8HeZTpxPGxHGzbB+V
         cUUojMWS5/ro5jrtIwlns2u2NN96PuuAvH00+BS+Tdm7YKwjQ1tAg61w7RN1EtNa+Ras
         wY3V2hZ6JCxP/rlN0nRwFvYt4z1RFod0hdA0+FPKGembwpP5hJL8vGh+4BXhYae69DmN
         sTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yk5JcXwRAceOqoIVvQQt22xh13dQAFKlMrHQJpm49E=;
        b=ZzaiLfH+4JSfSR9r2rZxGaEaPUlj68Ib736KI4GYCo6dlD8hLchMLV0fymtMJhVYb4
         h7mW815ucNtT7Ew4Blql7j9M20TNIauWka3Jzi5frcAr2DPMeIK8S7z/wiHTOYNN81Ws
         oNwWM7AIkali9KrO/DN2eeclkA11ulRpfriYEFQk+7WBGzcFE6MAx/YYC3eDNErNN1xz
         S3I2U8+XJgpcari3nTVPTBQmj1P5E5F2yG02IU0WcGO8M5ZSgPBHMJ9ES3J1hb5HNUBa
         ZQX6dGarAYiuFoswHcZseJXHBq//gODfDexmnaTlPhK+3CiTnKXaYQbLOypGVo9v4OqA
         7cOw==
X-Gm-Message-State: ANoB5plXBbrSPbcK+O/OKs2rqUX1xE/m79ebGQLBbR/9eWq4URRRIuUT
	Uj9nfMFVw3jrUS2vgRDWdPDiD/sH7ovu6JT+bbM=
X-Google-Smtp-Source: AA0mqf7D/MTp+94XTff613UsIh5xxxPWA4ccyUt2Y6UfwcSiZVi/k0AvfyNcFT4oC1VN0FZX+3iZBhcRnMzDKpL7w24=
X-Received: by 2002:a05:651c:c8f:b0:26d:d196:d04 with SMTP id
 bz15-20020a05651c0c8f00b0026dd1960d04mr31065092ljb.403.1670515456507; Thu, 08
 Dec 2022 08:04:16 -0800 (PST)
MIME-Version: 1.0
References: <20221208122131.2455528-1-alex@linutronix.de> <609ec123425599c724285de7c56b2150ec491d71.camel@linuxfoundation.org>
In-Reply-To: <609ec123425599c724285de7c56b2150ec491d71.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 8 Dec 2022 17:04:05 +0100
Message-ID: <CANNYZj8_L+f5WO_R7j5dqrOEeOEfyQ1dtDv65RTnU4Q9pePvuw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget.py: correctly match versioned directories
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Dec 2022 16:04:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14153

On Thu, 8 Dec 2022 at 15:59, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:

> There are tests and examples in lib/bb/tests/fetch.py, could we add
> something for this case?

Added. I completely forgot they exist :)

Alex

