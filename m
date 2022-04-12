Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CF2C433F5
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:42 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.8272.1649751413896300587
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 01:16:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S0t9aODn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id
 m33-20020a05600c3b2100b0038ec0218103so1099525wms.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=u5AJf4xc31Ka/kVbnC4zDjZ7H0rhRXxj9LllUegIPK4=;
        b=S0t9aODnO1HOhJTb54cKpMoJuMlZVahCIRl25ZEAsUX0w+2EN0Y9gaK1stQiyLwFmG
         Jex0x5GqU5n4NvFFVEsBZtVdCjtMlSJbBiB1fJ48IIJzzy7FotgK+r9Gr1iXChn0tzBW
         e6SsM//TeP/clYzuSj1Na7PUBfPyh2aGTl0WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=u5AJf4xc31Ka/kVbnC4zDjZ7H0rhRXxj9LllUegIPK4=;
        b=T0ApjnI42HRS4TyeR3d7eehmevpfUUo2jCUOBHfzGjvhrBCBf1gRuvcrt39oEM7MS9
         23qglsPjTLFKKWyBcfFxEs5jSqs330E9O3A3o7n7NgQnALWiOfP2ER5rN/hvqmWz8kN4
         jTy9QEavGQGfVllM7V056WGv3tGTJw+0ZQgh20cyBrUKqu5+Va+sKobWmfspOywfmWID
         y1SLwxxPRPG+M0E7sCc3j1NikI+UJ7qmBFZHxJVyzKNZwBsaELntEk35Sb1nB8lppqOa
         S1kSuW4iIlY+zwyqRGEgrcqKPR0d8BxiJFAML49OFkBUKuK3XJke2m+yynHyJ2EfDR7G
         Of4w==
X-Gm-Message-State: AOAM530tOc/6m/LWrhFlnXPdAnDiBOVNfJ5DfK7rCONSkBSZIczcuRbU
	jpV1RU65LCxx+TKRICNCnyfMgw==
X-Google-Smtp-Source: 
 ABdhPJx6S5DSVAfQ1VuM3V+BwfTkVEr1uV9rXLvfuH79nGm8Blau554Kj37YOufG5pcPgPjEeJqLHw==
X-Received: by 2002:a1c:7415:0:b0:38e:bbbf:52d9 with SMTP id
 p21-20020a1c7415000000b0038ebbbf52d9mr2903227wmc.104.1649751412232;
        Tue, 12 Apr 2022 01:16:52 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b168:4a11:27d6:cd01?
 ([2001:8b0:aba:5f3c:b168:4a11:27d6:cd01])
        by smtp.gmail.com with ESMTPSA id
 f15-20020a0560001a8f00b002078f74ccd2sm14230379wry.36.2022.04.12.01.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:16:51 -0700 (PDT)
Message-ID: 
 <0c0ac7219af162a0c5df048370f66fc4dc574f0d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 12 Apr 2022 09:16:48 +0100
In-Reply-To: <4044fd64-fe74-6ac2-7747-e8351a766258@gmail.com>
References: <20220206134507.123558-1-ptsneves@gmail.com>
	 <16D17908BC3DCB81.25014@lists.openembedded.org>
	 <2c7698c9a48dcca849b964b5cd5076c12f5168be.camel@linuxfoundation.org>
	 <957f9816-d2d8-b43e-b77e-51a64b9d984a@gmail.com>
	 <54bf9bc2753e4b91adfe1efd2c5aeec382792dfa.camel@linuxfoundation.org>
	 <4044fd64-fe74-6ac2-7747-e8351a766258@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Apr 2022 16:46:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13605

On Tue, 2022-04-12 at 09:51 +0200, Paulo Neves wrote:
> Thanks. I see that it is [1]. I would not have come up with the regex 
> fix, so your patch looks much better than mine. Still it looks like the 
> whole logic should rely on the url being passed around in encoded form, 
> and be decoded only at usage time. Is this what you mean by the code 
> refactor?
> 
> Paulo Neves
> 
> 
> [1] 
> https://git.yoctoproject.org/poky/commit/?h=master-next&id=450878eb43f378431066d9e9fd6ae2ce5cc70565

That regex is also already used in cache.py so at the very least we should
refactor that code and merge with this new piece, probably in the form of a
generator.

The issue with changing the encoding is the number of callers. You'd only
changed a small number of the call sites and it was going to cause problems
because of that. There was also confusion in the patch between the decode and
encode points. The data at one point was not always an absolute path leading to
"False" for 'exists' tests when the file did actually exist. This is why one of
the other selftests broke.

Cheers,

Richard


