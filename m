Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3305C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 15:46:20 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web08.28029.1646667979406738102
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 07:46:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S1Ixhse1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 19so9176739wmy.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 07:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=j7j+7982WtbpLkTQqICXQgPdgLgozDJ6C6SqnJKOlzc=;
        b=S1Ixhse1NffT36a7nW+tsZ+QrutAH4QOCnhLuZoIN5CmTCHD6aGVtBXDI2OK4lnTJF
         eCpBxtUej6pvBEGv66ctw5WijyqrK/ZYaIqLj/TRhweKi6sGcc1cienM8/PrNOXA/PWD
         /Hsthto0y9aXhmoobJ8Egh9xx5Kyk/L7zMP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=j7j+7982WtbpLkTQqICXQgPdgLgozDJ6C6SqnJKOlzc=;
        b=zBRdSf3imt9LE2x8P63wXGvLYFGxWkUw3FTA4CCBDkeFeqcdh2bJGcXVIpgbuNZI1B
         wMkv0iPXgXj9e3Xq4jjdM6fd+ksTHEj2FmPdPi+B7lS2nmFTveLMTxQECCLEhyV6jINB
         1drfS937GFklJ6ZJLHPLe6owEMXGIXAQaW/uGGYWNPwF8EXXA04SBIkFvFIBuiN3kkIX
         dJrHIHuCbznhh3HH5TMFajQPmdNb7KsD+hPlE3Ta4TEDcizc051CMGWG3gAC00ZV6APO
         GyNbl6vleDRHT30RbXmgJ10KpEBKdiV38wXcEk7Cn7LLDKEmxgKsY85W6db2kZpvI+qD
         MjZA==
X-Gm-Message-State: AOAM533VwjRW2tRrArIf0iAVCCbjl0Ve2hqtXYQ9rY5/Wm6UMQaof58u
	z2zd6UcLmdTB+LyS4a0pn/pcKQ==
X-Google-Smtp-Source: 
 ABdhPJylsejB7ZXGqceefM+hIXD0tmk2nUnpd5Ak3Sfa6H4cEp2Ri5zhYHwDV8d+/HDnWXNUuSmVYQ==
X-Received: by 2002:a1c:a4c6:0:b0:389:7269:5044 with SMTP id
 n189-20020a1ca4c6000000b0038972695044mr9785799wme.129.1646667977818;
        Mon, 07 Mar 2022 07:46:17 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bb31:2700:8490:fdf8?
 ([2001:8b0:aba:5f3c:bb31:2700:8490:fdf8])
        by smtp.gmail.com with ESMTPSA id
 v6-20020a5d5906000000b001f0639f69e6sm10330922wrd.55.2022.03.07.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:46:17 -0800 (PST)
Message-ID: 
 <de7c81bffbc020841e3fd956f64288cb1a91297f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] knotty.py: Separate the display of
 main tasks from running tasks
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 07 Mar 2022 15:46:14 +0000
In-Reply-To: <20220307133620.12404-3-pkj@axis.com>
References: <20220307133620.12404-1-pkj@axis.com>
	 <20220307133620.12404-3-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 15:46:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13431

On Mon, 2022-03-07 at 14:36 +0100, Peter Kjellerstedt wrote:
> From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> 
> It can be confusing that the count of running tasks shown together with
> the progress bar for the main tasks also includes any running setscene
> tasks.
> 
> Separate the display so that the message for the main tasks' progress
> bar only includes information on the main tasks, and the display of the
> count of currently running tasks gets it own line.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
> 
> This should be considered an RFC. With this change, the progress lines
> for the setscene tasks and the main tasks (is that a good name for
> those tasks?) look the same. The drawback is that it adds a line to
> the display.

I'm not keen. The progress bar only relates to "real" tasks, not setscene ones.
I know some of the running tasks might be setscene ones but that was a
compromise in the previous patches to keep the number of lines minimal. I wasn't
convinced that issue mattered that much in reality.

Cheers,

Richard


