Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F466C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 09:16:43 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web08.8286.1639646202158659432
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 01:16:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gR8dKuXt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id
 k37-20020a05600c1ca500b00330cb84834fso1227590wms.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Dec 2021 01:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=H5cosC5zaceoJUWMisZ8n+OnuAmL3t3Zomezff2e9i4=;
        b=gR8dKuXt1xydk8SpwOd4A2PStYH1NoxQCmjocN1SrWIQ2pOgEV5d42i0B4YlAOYsVW
         RfD/8EsOYUT0e86v0VOnzSA5ioTyjeKwECT8La9duh6RVsTg3irdVKVRunZYO+BLGl77
         e1+rB4z10Jq0XeMENlkxgSAy4er9etNE0VIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=H5cosC5zaceoJUWMisZ8n+OnuAmL3t3Zomezff2e9i4=;
        b=TVn9l2jrepK/0N2JKO7WR67epnaMxOXbd5xsDt7jxWvHMdpRe6EO9AWbeenEIdtbaF
         pBmjHTopt11K3MucU9moZwVS7hZJGzOAXZdpnCDnHVC2tccBaPOcZGRnej1xyWk+idG/
         RjGf/Irca1SLd/VP9SNDQ+BK9UhUlliMfwiFvg0V7Ua23U99q8GVkVMDtuolSwmQ3DPl
         alA85Zhbwn+xCQ3cVV4Cg6zLhSRhZ3ZJiwNYke0A2r1+G9gUJdq+1xmpCak5Gvn7c4U6
         DX/sZ3rNlUEDZq7nTsKe6AYDQIu3HLe7sf9kzuZTWPnh7dSqXExME4Nqq+EtpjZuex3K
         Kurg==
X-Gm-Message-State: AOAM532zRQurEN3vMWZl2H853s6FSOv0o63DxJR2rfIvjHZx9rhnrNf4
	iR9rG39RAP6ExqWc6RxHhboLmQ==
X-Google-Smtp-Source: 
 ABdhPJzhhh5Moy6XP2JPKTrBjhFXw+/2b4utilo2jIrCfiK/ZvrtQ2BsoUMfwn+tByXDnbu1N6seeQ==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id
 g18mr4046241wmq.25.1639646200626;
        Thu, 16 Dec 2021 01:16:40 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7bea:ecb7:80b0:2828?
 ([2001:8b0:aba:5f3c:7bea:ecb7:80b0:2828])
        by smtp.gmail.com with ESMTPSA id
 k33sm1047474wms.21.2021.12.16.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 01:16:40 -0800 (PST)
Message-ID: 
 <6d3f11fb30f39fd9d0f933e92c71d94a59592bbf.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC] Implementation of a submodule fetcher
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Pontus Jaensson <pontus.jaensson@axis.com>,
	bitbake-devel@lists.openembedded.org
Cc: fredrik.gustafsson@axis.com, Pontus Jaensson <pontusja@axis.com>
Date: Thu, 16 Dec 2021 09:16:36 +0000
In-Reply-To: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
References: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 09:16:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13175

On Wed, 2021-12-15 at 15:24 +0100, Pontus Jaensson wrote:
> From: Pontus Jaensson <pontusja@axis.com>
> 
> This patch consists of a Submodule class which inherits from and extends the FetchMethod-class
> for retrieving, initializing and updating a submodule directory. The main reason for implementing
> it is to make it possible to track the version of a packet with git instead of just a recipe.
> 
> The submodule fetcher is used by using the following syntax in the SRC_URI field in the recipe:
> SRC_URI = submodule://<PATH TO TOP LEVEL DIRECTORY>;localpath=<NAME OF THE WANTED SUBMODULE>.
> Where the submodule-keyword is necessary to use in order to call this specific fetcher.
> 
> In the download-method the URI is then parsed and the relevant parts from it are extracted and
> used to find information about the module in the .gitmodules-file in the top level git directory.
> The final thing that happens in the download-method is that git submodule init & git submodule
> update are called and executed at the right location for the specified submodule.
> 
> In the unpack-method the empty directory, that is being created during the process but contains no
> information, is removed and replaced with a symlink to the directory that contains the actual
> source code.
> 
> The code has been tested and so far it seems to work fine.
> ---
>  bitbake/lib/bb/fetch2/__init__.py  |   2 +
>  bitbake/lib/bb/fetch2/submodule.py | 123 +++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 bitbake/lib/bb/fetch2/submodule.py

As others have said, why do we need two different fetchers to work with git
submodules? I really dislike having two ways of doing something, it is bad for
usability and suggests a problem in the underlying code, particularly when it
isn't clear when one should be used and when the other should.

Does the fetcher meet the design goals in:

https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README

?

I'd also note there are no tests, not that adding any would change my review
given the above points.

Cheers,

Richard



