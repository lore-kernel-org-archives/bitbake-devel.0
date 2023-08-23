Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA2C71145
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 21:26:09 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.197.1692825959487273665
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Aug 2023 14:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=atanQt/2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-401552a98e0so118315e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 14:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692825958; x=1693430758;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fH0kd2+AKsuzK4RDjtVZB1lwnowCSru9uIaSkYNuJSc=;
        b=atanQt/2vKsdUQI6fCLZ+WNLY9eulMS9G8f8Y3oGXVC30kWKnFrFZkr2fn4Ouv6VOc
         JdIznjOK0DpkGqrBmpXhtYEPqZWN8yBahEvsOAmUnZpeXnTxAov6ud5h07X0SVgvnb1b
         s5rFc2XPTMj0xxsAGj4OQSPqAWgnrecoQO1z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825958; x=1693430758;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH0kd2+AKsuzK4RDjtVZB1lwnowCSru9uIaSkYNuJSc=;
        b=aO9zbAiyP83+opXPNxVBRu74EVb1eysM4Y+oFKRau4HIklWtIu76UkvFXw5F6sylhM
         IxJlUAP/va6nLlwOIxyp7AArrxQTxqL89DrRSEFr5T5TRMtKeSmXlNzb0n+0WuyeUDHZ
         p+P8PrUIlEFcr9haK8uk76LQTCnmrX3stm7+nP8uhEOv0sByoxqUsTB7VetPqUzFuCOy
         EQ+7xZFwb7aarI1wu1+MVGUWHq/VfuBGRpsyAuRJNjjFIfsiasvd/zGSDge3rx3DcWgR
         fULF5ZfIysS+TwFqMlEtnjkSxpPauvhsSFN5oP5bn2UURHEQfYPb7C+m2RzqE48xFE8G
         ro3g==
X-Gm-Message-State: AOJu0YzUSbBbDYdYNMi4KzsQPKFQfTG1GBSZioyx2C4cF0Ob//tdWyx8
	oO8Gcg+ghTe03zQ008d0VWjb3w==
X-Google-Smtp-Source: AGHT+IGjkAW5yOeQh1F3hm2JvPptY3Ve/I5lBfszmsFkzycgV9FYuEuKyFP8qcgSadtv0oVUkmVptw==
X-Received: by 2002:a7b:cb18:0:b0:3fb:ef86:e2e with SMTP id u24-20020a7bcb18000000b003fbef860e2emr10398111wmj.19.1692825957953;
        Wed, 23 Aug 2023 14:25:57 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5461:c902:2158:9a5d? ([2001:8b0:aba:5f3c:5461:c902:2158:9a5d])
        by smtp.gmail.com with ESMTPSA id j16-20020a056000125000b00317e6f06e22sm20300459wrx.77.2023.08.23.14.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:25:57 -0700 (PDT)
Message-ID: <b79ef56133cb5c2275560936527d822a32bd80a2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: export_proxies if
 network flag = 1
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, rs@ti.com
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Aug 2023 22:25:56 +0100
In-Reply-To: <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
References: <20230823210438.2172797-1-rs@ti.com>
	 <CANNYZj9BH9i8z9XhHxX_bGSRkZBM+Bateb-i8jxqZXCFThGphg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Aug 2023 21:26:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14962

On Wed, 2023-08-23 at 23:20 +0200, Alexander Kanavin wrote:
> Something doesn=E2=80=99t compute here. How did it work all this time in
> tasks like fetch?

Before we had network isolation, we did ensure we only set the network
proxy information before network access code. This meant the things
would break for "unknown" network access outside of the points in the
code where we expected it on systems that used a proxy.

I've mixed feelings on "simplifying" things like this as we'd lose that
markup of the code and a second level of checking, even if that check
does need a proxy setup.

Was there a specific place where the proxy information was needed but
not present?

Cheers,

Richard

