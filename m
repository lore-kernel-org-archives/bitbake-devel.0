Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7478DC433EF
	for <webhook@archiver.kernel.org>; Sat,  6 Nov 2021 09:43:13 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web12.17170.1636191788268790187
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Nov 2021 02:43:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NRjzFwX3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id
 z11-20020a1c7e0b000000b0030db7b70b6bso11287287wmc.1
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Nov 2021 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=jzxWsN5zAHi9lWS22PLL1Vuyv8cXhnUvjn+nMV8bxTU=;
        b=NRjzFwX3o0uWlAfraAMSY5h7/phFYVXo8iaKIhKQHefAI1NgZ0X+Hlq/fheu4xgVFs
         zAFYLi4Lv+doOHvtlY6HJJHF7w8RaqPA8tWP4BW2R1DDfOLQYmg9eCQhcJGicyegqAk8
         a6M8NXyCCn/J9oiqYZAWZHd//gRVIgu64UghE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jzxWsN5zAHi9lWS22PLL1Vuyv8cXhnUvjn+nMV8bxTU=;
        b=3ceJnTsbkbM8jEF0JchxWjueX+0ew1J0WIMQwfJaJlViyaJAUS6jfdUfYb5PhQBBc5
         c3wTW7PKlGArHev4R3xNHowBMC8FIJakeGGpe6wW3OsD1XAvlVe71RP2ZW2iGuF0pXeY
         VLH5Fb14hpicR5JwZz8IohCOxxQ00UCjUNl08byBMyaxhKze4+nsH/qupQZzGxOZxfcS
         g12ek0/bGfarRsPdno1JI2rayJTeMatJl4/sfS559Un23OinfioIr/Js69JIFXurlmXM
         ZJ5LxMA7XY8IolwrcdyWgaWxfYgKiqeyvfxMZPEBO+OEZ4nju1BB00CtJHPqhJPq99yo
         pAHA==
X-Gm-Message-State: AOAM533B0pfpCPqJwCZInRuC2T2f1TF6lrCiQrHG5aLnOww8MFd1nJbx
	MR6m6ViShA8ltg6FlcdpIMf73g==
X-Google-Smtp-Source: 
 ABdhPJziBYQsXSpDOVROxWt9UsAVtDKJ/bcFBABU+YBWN0KHxA4QYTmdrwQNMLN0pLUC1DCWSfc0Vw==
X-Received: by 2002:a1c:7ed3:: with SMTP id
 z202mr36681323wmc.110.1636191786606;
        Sat, 06 Nov 2021 02:43:06 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:23d0:3dc5:c03:c6aa?
 ([2001:8b0:aba:5f3c:23d0:3dc5:c03:c6aa])
        by smtp.gmail.com with ESMTPSA id
 r17sm10317944wmq.11.2021.11.06.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 02:43:06 -0700 (PDT)
Message-ID: 
 <029d18fa589265e32476c7cc45c9977f7b4bb9aa.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	"openembedded-core@lists.openembedded.org"
	 <openembedded-core@lists.openembedded.org>, "kweihmann@outlook.com"
	 <kweihmann@outlook.com>, "jasper@fancydomain.eu" <jasper@fancydomain.eu>
Cc: "martin@mko.dev" <martin@mko.dev>, "Daniel.Baumgart@iris-sensing.net"
	 <Daniel.Baumgart@iris-sensing.net>, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sat, 06 Nov 2021 09:43:05 +0000
In-Reply-To: <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
	 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
	 <b8897c8a436f384ef0a41d708816c2f61f9e22c7.camel@iris-sensing.com>
	 <d87ff011218f55d97e5aa48ff9b06d216f6d477a.camel@iris-sensing.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Nov 2021 09:43:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12922

On Fri, 2021-11-05 at 14:09 +0000, Jasper Orschulko wrote:
> Actually, I don't believe this to be an issue for the following
> reasons:
> 
> [...]
>
> 2. When using repo within the yocto build itself (with the repo
> fetcher), the repo binary is only ever called during the do_fetch step,
> which obviously has no issues with any network access.

This is not true. The system may be configured for no network access and is
meant just to be building from MIRRORS/PREMIRRORS (see also BB_NO_NETWORK).

One of the reasons for the fetcher abstraction is to allow us to support
features like that. do_fetch is where network access should happen, if the
system is configured for it.

I guess the question becomes whether the usages of repo when using DL_DIR as a
cache will still touch the network?

Cheers,

Richard





