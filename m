Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB90CCFA0D
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 15:20:57 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12061.1762356051323424753
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 07:20:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SsyQ6Du1;
 spf=pass (domain: gmail.com, ip: 209.85.219.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-880438a762cso30369636d6.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762356050; x=1762960850; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c145gcSGx3zmBTc0oe+A1CukAbxmWoLPCYMm5ZmlglM=;
        b=SsyQ6Du1lSuclac8e8gs2ebfLDJQ7AxDaD3h3xEh9lcbkVOWpTJbZnWCD4eInqRZKt
         5YF7+ms0OfXCiZzGvz9p7fOVh7ijnrexgOK+sNuMAthkTM41/pGjifp+SbYycvKoV494
         TDwMqLsMABkWnnEPT58YY2On8YYFfDehKMOarYbVs4UhP0+R6L4+Ho/2P1YOmnbFZLYf
         4xHTtr3SwkjFP7LjZxG+WUM4n9ejWA4awQwuROJPL7p5hlxuIBDtK4frRhc5VtmrZyaf
         RCNI5Co0/e8bgjW2Kz9vFu0dZvqUiuMdwNG/ZInPnXHR3/rmG3VIUApX5mNAEuePBxvX
         BL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356050; x=1762960850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c145gcSGx3zmBTc0oe+A1CukAbxmWoLPCYMm5ZmlglM=;
        b=oHdcRI3O+oDuq3mNoJP+BWMiMrXfbEPpu4f8nEFbeNi4kvhgzgVx1JMKDn/OVgU/tN
         y3gejG8mRx7RybuiCI4Dcf7ZbQwP96mu19YVwHXVtFV5w92q5GemeqUmYMXlDCKiD4qC
         XwtUg0XLlnfUVU/OLrpliBRdCXVZbjhcxY+6iwPdH/zl0xE0jTQcTt/rEUNJ4SfS2Dsu
         W3n2RbnLA1Slt0gclC9yGwQ1Yv27a34Jw6zH7cgB+CjZL4jqnzqWJKiOvUnsC6TADDz8
         SMVNQJ4JCoBx9RUP9aazlBWEj5c8/KNMNz5CAC5y6+p7ehvIXeshistwvyfv3ndrlT5+
         BOfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBZDM1GFotJQjDUaHEayx9xG6yXJY4qetBfhMph55M6HU2seDkF1O4frP6Qhk2eZRYxWLY8YG11VAdC8Ob@lists.openembedded.org
X-Gm-Message-State: AOJu0YziV75YO6Wy90ihjKJKjwKlRrL4WGS7+zaymd+YqtRFHl7Lt5ta
	v3sq+6hhfnKfTdXIfAaL4amBroTL/8pZub59f+pK2LH57NEQU4EBqx3jVUckCsX2tJI1/C6wOq6
	idhhZeeKt0UNxOHgdzSt9p84+XOaEiA4=
X-Gm-Gg: ASbGncueLmOo2wlNplvfIk9AB3m9gGhQyHpdJC0AhPNmjWD4Zn7A8KsHtEC0EM526Qt
	g8MmsOnyXKDTpWPftTFAGtfAIFUQQhgXfV1spH2KRe8YyXKvT810yxBgNqAf09yU+6GVjktk2f9
	3zFyc5QPYcFyirwGS/BmafoCFaxT06a9BMKD+5IKoBjp05pru7LVVaCAuM9KPYRIxQa6QIne4qY
	awLCcdshu/IskXtKPT7rBhOFz5m1xJPC190Gl8BXnQbkPLaYpB55w/3ga+aNs3leUCns/f4HEW0
	X+7SS0az3mscj4RsMOM=
X-Google-Smtp-Source: AGHT+IEyPbubrA49Jqssl80+r76o8zqmtABuRJvjok+iXzU+jiavn+G8PrWv+kRRsV+yotfBoeecLRZDtLuCMhKX5wY=
X-Received: by 2002:a05:6214:767:b0:880:486d:18de with SMTP id
 6a1803df08f44-88071196b59mr41820006d6.50.1762356050289; Wed, 05 Nov 2025
 07:20:50 -0800 (PST)
MIME-Version: 1.0
References: <CANNYZj8p5zTnzo3AO88_c7Q=qDtO1-QWaFNh+z37xLX4Y1H8Bw@mail.gmail.com>
 <20251104151156.3125937-1-johannes.schneider@leica-geosystems.com> <DE0USKLW9WXP.3MKV2P4AI36E1@bootlin.com>
In-Reply-To: <DE0USKLW9WXP.3MKV2P4AI36E1@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 5 Nov 2025 16:20:38 +0100
X-Gm-Features: AWmQ_bn5CGblQHrQXHWC9nt6tKW3-ZgwdImZmRkr2D3cLIKKRWLhqND56rH30BY
Message-ID: <CANNYZj_bTNkWmDLe=wmDOXfL1xWxSTx6yP2yqAbjLVaomXoVaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add bitbake-setup documentation
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>, 
	bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	thomas.petazzoni@bootlin.com, Yoann Congal <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 15:20:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18267

On Wed, 5 Nov 2025 at 16:07, Antonin Godard <antonin.godard@bootlin.com> wrote:

> Thanks Alex and Johannes for the suggestions and corrections. A v2 should be out
> soon!

Before I forget, THISDIR in bb-layers should be also documented:
https://git.openembedded.org/bitbake/commit/?id=b3153be29de8b8570b0c184369bd41f4c646cf92

Sadly it isn't part of the formal schema definition, in hindsight it
probably should have.

Alex

