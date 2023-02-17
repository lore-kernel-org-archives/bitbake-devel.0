Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D424C636D4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 10:39:43 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.3850.1676630377495028118
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 02:39:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gZjRTH9N;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id ja15-20020a05600c556f00b003dc52fed235so513960wmb.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6M1JCZ3ubkblOkdNAKzkVsZ4w0M30frxIYS1y7R9wk=;
        b=gZjRTH9N0TAnE/P6MBPwnIdDGrlPHHnFJWgtgfz/pNIOogXQkLxQKr6V2BngrEWF5E
         nZMTSx7Bk2bpjJMzi3Vd/0LPLCg9wrjLyHPO/aBCKCZ5m9KnYgfT1i2pRoI8V2bOGJNF
         lZqm5Mhs4l905oK9o+d2bB3tnshQpXZJlW7Xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6M1JCZ3ubkblOkdNAKzkVsZ4w0M30frxIYS1y7R9wk=;
        b=rm0Pbm5TYvmxDCYZxF0jyfPS1z0ZnUxX2K5TbwUpZolhty37+MwqXDdZQ7eNXov/+T
         4swCYsouv6LtKWtZUthyiqL89x1lPzg8LzkNAaeuvoLUAtNmIHgFqORtvmnHGo97JcFI
         D7GAgJ/vp8+5yIHfoNVavgxDyqWgJ1mib9Kk7jILFsqlqDeUpyfkzjEV+LFkkU1bPrYE
         nMIzNTX9tct5TtOiP1/3gZEE/G8uh44n6PZmVR88Zp4iahcDvqKWy7uY8bkEBHztmKjJ
         MLXYsJqvkmaS4JyFP8u8arYIKc/aUdu8x4WUNV3pz2h4IYv5VCOMzvbvhtQKKnW8wcKP
         ZRtQ==
X-Gm-Message-State: AO0yUKXuB/US84nG9r8cZ26MiTSmWTw9sfu+Zo8tF8/Y724ifwWZzmI7
	5roetoNatqlhtIsbkWB7Pk5ZcGGinYjCz4Id
X-Google-Smtp-Source: AK7set/1620DifF+Wr5Emq+j7PGAK0k4HLD+o1n4mUjVDCQLtAL1q9DqFPmkoOexxzKPxMItoFG+Dg==
X-Received: by 2002:a05:600c:755:b0:3da:fd06:a6f1 with SMTP id j21-20020a05600c075500b003dafd06a6f1mr640418wmn.31.1676630375809;
        Fri, 17 Feb 2023 02:39:35 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab? ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c459200b003dc4baaedd3sm9309660wmo.37.2023.02.17.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:39:35 -0800 (PST)
Message-ID: <2a98ca787e544740c2e09413ba215f08b4664822.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] ast/data/codeparser: Add dependencies
 from python module functions
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Feb 2023 10:39:34 +0000
In-Reply-To: <CA+chaQc28ET-4g5RqjLy_2DdgiNYd0JJq7FfqgYtDejnQtVLZg@mail.gmail.com>
References: <20221212160334.54431-1-richard.purdie@linuxfoundation.org>
	 <CA+chaQdrzVxHjKGPGSaoWxkr_pYShj5z9o8QFV5b585cG-9Z7g@mail.gmail.com>
	 <1256aaa44ee27adace8686a37393d68d75cab1f9.camel@linuxfoundation.org>
	 <CA+chaQc28ET-4g5RqjLy_2DdgiNYd0JJq7FfqgYtDejnQtVLZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 10:39:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14447

On Wed, 2023-02-15 at 17:45 +0100, Martin Jansa wrote:
> No, I haven't seen any error in bitbake-cookerdaemon.log, see
> attachment (created with this change reverted and the same syntax
> error in qa.py).

Which makes me wonder where this error is actually ending up :/

Cheers,

Richard


