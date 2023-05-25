Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE7C7EE2C
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 10:45:08 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.8765.1685011500032023970
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 03:45:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=YmQMjL1V;
 spf=pass (domain: linaro.org, ip: 209.85.167.53, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso2189153e87.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685011498; x=1687603498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsKdCG4J5ZoriypF/XhwYdG02ipCmanUemWUGUKzITs=;
        b=YmQMjL1VYaSS/5UVJBZpUAGYI0B6QNNH5JPI6BUG3VX8beMUzdybwY85QzclfrFtEV
         BDPHadNpLd4gD5TTI3Gwl/6DMGf0TYRdXHyWK0c/w6QBCPKcSGY/FK2eO3NUjDFSiXQ0
         NQiH56bobYZqMQFpGx13Ku9u9nl3RCzql+PG8E9rWwJl2YuQTbcEh+RSrOrPDYAB4GVa
         QdFZUJOM+a92v7awNjvxHYZfwGt+f1EG4o1OGMWAx80vzKXmm5l9DRzQqzONQaEwyS1T
         aNm7qNrQKtLy+kez/nngwJUTfZ/OzHsf6111pqk6Rj7OEf0aBku3zWHTV8Q07akTtzw1
         FYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685011498; x=1687603498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsKdCG4J5ZoriypF/XhwYdG02ipCmanUemWUGUKzITs=;
        b=F8xMSmpAQtWXg7k4TehYcIJz7jswkF3f+0AeP3wB/bUMfNCXN52OnmlPeBenOAugXU
         zocwHPiGK2DKwHs3y2ym+SsRQsxz6ap6Q3TTmDR5DakjOgcv10apVdSNLlzZb7tKl/XZ
         yJPPCMrjKLjktTy67uW9iShVUdjlc4Dvk5rZfLKSXbYfaVKhRhGywqeziMlLtZn0nj72
         QRUwn8miEufPLAouA8kShCDwiObX2CfjZ3e4gu6QQGs7kISfi5yonbt0R2MSr+KjOU6P
         dqSfbQBP6urEu/fEden3WVVLDb3OIy6WlNjkrtX9wF2cuSWgoNnuJZ4dc9g8F8oIRZrl
         cIxA==
X-Gm-Message-State: AC+VfDwo109GGN9nVKzExxkuZzO+Pb3Lcu8G9yaJ3QZ+Zl67b3XuAyrj
	laRx5JoMWFHgM4zLOeABxdbrIA==
X-Google-Smtp-Source: ACHHUZ6DC9g1HcSyWrP4RF+pYfiVcB0rmyfwK24Vw43NwO8M5p+isG74rPEI1EVCeCpQDEmjH2QYCw==
X-Received: by 2002:a05:6512:489:b0:4ed:cd32:1b71 with SMTP id v9-20020a056512048900b004edcd321b71mr5980665lfq.33.1685011497953;
        Thu, 25 May 2023 03:44:57 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id q18-20020ac246f2000000b004ec87cf6b69sm164621lfo.169.2023.05.25.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 03:44:57 -0700 (PDT)
Date: Thu, 25 May 2023 13:44:55 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Michal Sieron <michalwsieron@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>,
	Mateusz Marciniec <mateuszmar2@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
Message-ID: <ZG88JxkZkP4z3kR5@nuoska>
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525102105.1480610-1-michalwsieron@gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 10:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14807

Hi,

On Thu, May 25, 2023 at 12:21:05PM +0200, Michal Sieron wrote:
> By setting `BB_TASK_TIMEOUT` you can control timeout of for tasks.
> Using flags `BB_TASK_TIMEOUT[do_mytask]` you can override timeout
> settings for specific tasks.
> 
> This is especially useful when some server doesn't work properly and
> `do_fetch` task takes too long. We may want to kill it early instead
> of waiting for a fetch that won't happen.

Is the problem related some tools and network protocols? Which?

An alternative would be to configure the tool (git, svn, curl etc) specific
settings, or even the default socket timeouts on the running system.

I've seen this kind of problems too, but I'm not sure this task timeout is the
correct way to solve it. Time is too relative :)

Cheers,

-Mikko

