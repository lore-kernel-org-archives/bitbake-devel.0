Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065AAC35273
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 19:49:24 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web12.1661.1649187258516957360
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 12:34:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LgS2ejCW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id p189so93565wmp.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=3f+naprLgolTKZrv5JZfAclXgPP2t4PZ5YOiplM+1GQ=;
        b=LgS2ejCW78PFj8H1NnV9xuFkW7HBVi0y8GVhX/YcW7qLMvxMLb5p1w+6eD2RnI+HFx
         Xtpf3jU2ASfncNsf6+StAqCVoNl7ZWUJlkiu3kRMYlJq+8dazpgT3rLpf2Y9AzR9cCV+
         DmjVhJvaKUXv4stfEmkrSh0LL0Utuz8z7vyi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3f+naprLgolTKZrv5JZfAclXgPP2t4PZ5YOiplM+1GQ=;
        b=he6xRnX5QcB+caI7G7JG3Yf+DND/ZPa1LDEomqhU7iYUhjyfV5JPJuuB8KrT558Afr
         4Q4oIyLulPcBCi1D58j0C1bQVfXQXZpkANEG962/GAbhmGvqvXd10rP3y95WntdIKhgO
         ke6rlLEPhwfiG1wtZ6gRtCx4CjduTNZ27yLb3Kav9TV6HDER6hajHKTUqF8rwBrsiYgH
         bCEGhKx82G3XvR0QiKnLQv0E/whh8hm5OwWx9fuGM5RHPPBnECfid2VMqbKHhaCpfRuU
         p4xLUGmDa2VtNxLbiBy7Tx5s2p8tJbUqoYFA/CfPulqB8WkjId+UXjD810Y0udAHq1/o
         ya9A==
X-Gm-Message-State: AOAM531OLz53uBds7hsC2n6GX19aXBDMway/KP0iDlRSDKQRIAIb0YTf
	iLNx/cblbJ0ZoGWM5EiCsBHH8Q==
X-Google-Smtp-Source: 
 ABdhPJwrhIeh7tz6zm4io8B0UaBjjOVH61aiy5BpQXKer6a1QDgwo7HLw/6ru6ouMbHbjKN01Wp3Bw==
X-Received: by 2002:a05:600c:2351:b0:38e:6583:4202 with SMTP id
 17-20020a05600c235100b0038e65834202mr4393679wmq.122.1649187257010;
        Tue, 05 Apr 2022 12:34:17 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ea8d:a311:bb62:cc91?
 ([2001:8b0:aba:5f3c:ea8d:a311:bb62:cc91])
        by smtp.gmail.com with ESMTPSA id
 i1-20020a05600c400100b0038cf3371208sm2972262wmm.22.2022.04.05.12.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 12:34:16 -0700 (PDT)
Message-ID: 
 <1c27961aa31d014024489f059efb31ad0faf6c5f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Added double quotes aound variables in
 bitbake/source to prevent gobbling or splitting
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Abongwa Amahnui Bonalais <abongwabonalais@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 05 Apr 2022 20:34:15 +0100
In-Reply-To: <20220405182906.57588-1-abongwabonalais@gmail.com>
References: <20220405182906.57588-1-abongwabonalais@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 19:49:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13584

Hi,

Thanks for the patch, I have a question below.

On Tue, 2022-04-05 at 19:29 +0100, Abongwa Amahnui Bonalais wrote:
> Signed-off-by: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
> ---
>  bitbake/bin/toaster | 65 +++++++++++++++++++++++----------------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
> index 558a819570..d98c4c69f0 100755
> --- a/bitbake/bin/toaster
> +++ b/bitbake/bin/toaster
> @@ -1,4 +1,5 @@
> -#!/bin/echo ERROR: This script needs to be sourced. Please run as .
> +#!/bin/sh 
> +echo ERROR: This script needs to be sourced. Please run as .
>  
>  # toaster - shell script to start Toaster
> 

Changing /bin/echo to /bin/sh probably isn't intentional? We do intend the
script to be sourced rather than run directly. How did you test the changes?

Cheers,

Richard



