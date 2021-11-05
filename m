Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23925C433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 09:17:48 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web09.2947.1636103862233506726
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 02:17:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eREMvdMW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 133so6526895wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+iXRsuoH+x85vneMd4SsD9d7RF8XTD4QhhN047k6iTY=;
        b=eREMvdMW7U8qKLYkISSO81Nmdi+EjXLgdQOQz28Pp2zImd3nKwg5qXnb/nJGgqyWPm
         oc81A7/xyiVKTmoEXR/mvSKlbqfZ08HHLp9JgpyyhUC1VsxkLnrU81001bYfYwLGyoAl
         S8MSN0EuU4hHo1wt9FMRamXmcX31VE0a+tbvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+iXRsuoH+x85vneMd4SsD9d7RF8XTD4QhhN047k6iTY=;
        b=uG7WtPAZzPFx113eWH854uCqL3G57N/ZrQ2RHCU+IZYI1MBA4XdMBLAKmBNAm6lcE3
         EgzECBNmRY9DvkkQ5YaCd25xH3WRjLsLRJ30V55cej6A43nx8tzaBQPnj29IWN9/K/a+
         jthVlc4T821w6JHnsjk2yfOQPXnL8cmRdP9KPiILzf+cAX1UGLDUYNfVGgMlxCBVNyF3
         ewUnKERgpXUUCTQoOwujUHKocNfVeuEU6oQZEV/qYZ4b2xe38fD/EOTcM/IAV7NAE1Bs
         sAR1JWcKEuTgYjVkXjp8JepYyTNbsHgkIJLKAWfdG/NZnEObMwxrY6lrcCTprObDRLID
         IjdA==
X-Gm-Message-State: AOAM531doPFqXkjCLOl4071hziR9NADUUTq8YDtFAYjkNdWYxY//uLtf
	2jaM0q356MXSnMyECAcXUFjGfg==
X-Google-Smtp-Source: 
 ABdhPJyRXtYS3KWkXti5JRM6ujg+x2E54qZ3d8g1jkHPJ4+HI5Ox44F4PxS1FK5wxOnHx9MMazotBA==
X-Received: by 2002:a1c:2d5:: with SMTP id 204mr29304929wmc.47.1636103860486;
        Fri, 05 Nov 2021 02:17:40 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:38e6:15ea:3134:28e5?
 ([2001:8b0:aba:5f3c:38e6:15ea:3134:28e5])
        by smtp.gmail.com with ESMTPSA id
 h18sm7950482wre.46.2021.11.05.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 02:17:40 -0700 (PDT)
Message-ID: 
 <8f1edf5ab98a5cf1f58574a46ce41d84f6a2c0c2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] parse/ast: Show errors for
 append/prepend/remove operators combined with +=/.=
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 05 Nov 2021 09:17:36 +0000
In-Reply-To: 
 <CA+chaQeU31hZp74hHtjAF044B5wtVi+iwjaghy8HkeY8gShzOA@mail.gmail.com>
References: <20211104135848.3621936-1-richard.purdie@linuxfoundation.org>
	 <CA+chaQeU31hZp74hHtjAF044B5wtVi+iwjaghy8HkeY8gShzOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 09:17:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12887

On Fri, 2021-11-05 at 10:14 +0100, Martin Jansa wrote:
> Hi,
> 
> this seems to be merged in 1.52 branch now and not in master, was that
> intentional?
> 
> I think this should go only into master branch, right?

Correct, not sure what I did there. I've reverted it as that was not intended
and I shouldn't force push now.

Cheers,

Richard


