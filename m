Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA85C433F5
	for <webhook@archiver.kernel.org>; Mon, 17 Jan 2022 21:54:36 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.4208.1642456474908098888
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jan 2022 13:54:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bEvV5E76;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id
 g81-20020a1c9d54000000b0034cd1acd9b5so1104091wme.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jan 2022 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=XIWGeliWx/hOF7eabRv9bW+YnfyGmS1Hyid+tb7Osqc=;
        b=bEvV5E76X7X5vV3RUsUiWZvIiPFM0KSDtICeWyZ1s/6pVu3abiH1ZPNbgdP4TkGGEJ
         ZB/RfzA94Tz9eIJcRyui+AGS8ZEKbJqKUsbFYGlRXrkiWRIiMKfPO3LyxXEg3P7W72k3
         NGtUq8K+RWCRYM2TKEJKhP9+EKylUvG2nV40U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XIWGeliWx/hOF7eabRv9bW+YnfyGmS1Hyid+tb7Osqc=;
        b=UMbGBE+Y9ciOEh3nFAOpPjfHXhjZ/h2VNHUsDhwUVd5GjXYRt0deFUF0Ehbh4sCtnG
         3TEdFMckPJJHtgIiExfwD63eitMrVfhH01Y8ncQ6DToEaLDpzIqIQWJV6bADDD1xdOB1
         fbK6MWSBxe5vAuuoszG5ll2D9MNTsj6ag7m8HyQaVE/DAjxzrR/g7t0hoAyLhVxSNFZS
         8FLWAGrb/lqknl0OgLmMH3dk4yGEhxlcbMw3xrmffR5vo1DmPom4LwhJw25yTQ2LbWw6
         /pn3Knf7qXSkGORJev5GpAjxyZy+KAht38caPB22jm32nAqpH1nCAxve6Ffxog1hV7Oj
         gLOw==
X-Gm-Message-State: AOAM533LhjhfuEtNAJ7/KYuy5tj5Eyqga6CPJ2/xOZbDqOWhJddg5WTa
	4/TmvO+WgrygtU98WUbZAExXEw==
X-Google-Smtp-Source: 
 ABdhPJzueTxGM/5vXkgIB3yAqXrFtcIzv3eQVTomBX+45btTMGQwH0wLgpnH5jtNuqkZiNQpjNGa8g==
X-Received: by 2002:a05:600c:5028:: with SMTP id
 n40mr20944845wmr.10.1642456473193;
        Mon, 17 Jan 2022 13:54:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:cdb:ba2:df58:76a3?
 ([2001:8b0:aba:5f3c:cdb:ba2:df58:76a3])
        by smtp.gmail.com with ESMTPSA id
 e13sm14387975wrw.3.2022.01.17.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 13:54:32 -0800 (PST)
Message-ID: 
 <d245ff3277d0c4b28e20d724766b8b61d724cc9a.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH] doc: bitbake-user-manual: specify the URL to be
 used with SSH over git is different from `git clone`'s
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Cc: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 17 Jan 2022 21:54:32 +0000
In-Reply-To: <6f110600-49bc-b09b-f04f-5c132041ee24@theobroma-systems.com>
References: <20220117130816.104203-1-quentin.schulz@theobroma-systems.com>
	 <6f110600-49bc-b09b-f04f-5c132041ee24@theobroma-systems.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jan 2022 21:54:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13239

On Mon, 2022-01-17 at 16:04 +0100, Quentin Schulz wrote:
> Hi all,
> 
> On 1/17/22 14:08, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > 
> > The URL expected by git fetcher when the SSH protocol is used differs
> > from the one given by Git servers to be used with the `git clone`
> > command.
> > 
> > Add a note making this specificity known to users.
> > 
> > Cc: Quentin Schulz <foss+yocto@0leil.net>
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > ---
> >   .../bitbake-user-manual-fetching.rst               | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > index 0fc2d5e699..77384cfdc7 100644
> > --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> > +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> 
> Forgot to make the patch from a subdir instead of poky root, lemme know 
> if I need to resend a patch.

I can handle that, merged, thanks.

Cheers,

Richard


