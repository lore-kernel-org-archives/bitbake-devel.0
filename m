Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8752C433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 17:17:28 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web08.357.1649953669296693648
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 09:27:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EaSDbvey;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id p189so3458344wmp.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=CyrZ5WZpywkXRiNSRA6zO2NK/U5IyNcmjRXNYsnkkXA=;
        b=EaSDbveyAAmAfc/H+6fqkubB02TLFWPSel7Eko2gC4UTVpOwpVydfj7z+H46Thp9d8
         FRDyMKW+ymOZPygkEpv7i4DUvhHjkHGPNKsGftwxYsRBPXOL1peuDUi4SG+Gkkslpr5X
         WR3X+gwVN4D/LWuIhdu8tU43gn2lXvG8eQs28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CyrZ5WZpywkXRiNSRA6zO2NK/U5IyNcmjRXNYsnkkXA=;
        b=TCEnsS53/RJRKl9i3UBkIdXx8EN1ePadhLdqeHdj0tD8d/y51gyeAmVUyItQhqS+bH
         ep9Z8OHK3ms/t0AiHRlifjHGYebqExoOchFafw+iibITB0kyauOmFwIVNOfE2Tu2Dg4z
         Z6/LyqxCwCgRdgL29d8qeBoMShKtbqiN8o4SI4dfC8sTMSS3YtbEAhDZf78hk4CtCK7w
         yBdymB7xdHXBdLl+GuTYWUrWnaxgCOt1YPlBdCZUlPOGA8RhUua8Sx9pbw9MQNGOIwLu
         La6m9faLV4w2woYVg5ib7KJyXHRaA8PE6WQ3BrPVBuo1jpquFZYwoCp59xrT2u5j1BXj
         4TWA==
X-Gm-Message-State: AOAM531XbN1F6Ne+4i2qvmn94dxaCEABMZ19mHqTY921Akzh9KxqVbJT
	AM5dYwxGxMMn0FOa773JBZJDyQ==
X-Google-Smtp-Source: 
 ABdhPJwsG4BusS8tRPMHwR23978BAUzTeC4j2ZDwbWq7s9pbu544smFNO4zOua2Oi8xHgf35hxYr8Q==
X-Received: by 2002:a05:600c:5024:b0:38c:a426:8ea6 with SMTP id
 n36-20020a05600c502400b0038ca4268ea6mr4375951wmr.193.1649953667734;
        Thu, 14 Apr 2022 09:27:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:353f:5203:2a56:f190?
 ([2001:8b0:aba:5f3c:353f:5203:2a56:f190])
        by smtp.gmail.com with ESMTPSA id
 61-20020adf8043000000b00205e1d92a41sm2163945wrk.74.2022.04.14.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 09:27:47 -0700 (PDT)
Message-ID: 
 <083ca178f3da30a8f3f21c641606a7f5267b41b3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Simplify the validation of
 SHA-1 revisions
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 14 Apr 2022 17:27:46 +0100
In-Reply-To: <20220414154207.25999-1-pkj@axis.com>
References: <20220414154207.25999-1-pkj@axis.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 17:17:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13622

On Thu, 2022-04-14 at 17:42 +0200, Peter Kjellerstedt wrote:
> Also correct two comments.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index b3eb8248d0..90104ac383 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -248,9 +248,10 @@ class Git(FetchMethod):
>  
>          ud.setup_revisions(d)
>  
> +        sha1_re = re.compile(r'^[0-9a-f]{40}$')


re.compile() is expensive so in general we should cache that or do it at the
module top level...


Cheers,

Richard



