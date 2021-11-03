Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93B3C433F5
	for <webhook@archiver.kernel.org>; Wed,  3 Nov 2021 14:13:26 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.8302.1635948805288813977
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Nov 2021 07:13:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OYypnZF3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id d3so3788555wrh.8
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Nov 2021 07:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=Xs99ofJmY4f6WfiCmwPMSZo7FpzCN7fJ9tvzsCQp1XQ=;
        b=OYypnZF3wXYdVavEeGiEn7Jpxu/Hh3q1q6KYUfGDXSNCqdBSSIbpUAqX3tjPeoCchG
         sszpwct3WnMAA9aw8RnQ2+lRs+WZQuzaApfC2iHGr3z3oepWZZWbgBjV/LKIND4l0Qr1
         jYo7FINzSQGaSUxhxLgTuB/VTc/wGE6Pu79+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Xs99ofJmY4f6WfiCmwPMSZo7FpzCN7fJ9tvzsCQp1XQ=;
        b=ZrYzZDIhQW0Au5IiYtv4lBiqRaeGfI0dCXHBteYb6oW8cXOjewSEVix3Ag5ELRsRsf
         NZMUwt8Eya2/BiPX8nXsfpH9jZG9IQbracC+rys6Q21aNF+rj8W7o4leIUvbTeN6Y8Z5
         M04DElV8KuKB6SAjSbELWtQJOD9VIYx0zQiuoj3IZkIMvnxzB15p52jop8XHfwjac6Y/
         n8UP2Isouihty1MRyu1crErf8mQBuNiG5NDCXXirwD8vDK+3CNGzcEiaNDdKacuyFS4Z
         KyqXHgx8qaCPtDrcJTMB4o0buFfkOROYDwlePzjNYVeRFhnrAjbSILFK0ZYJgwjc00O3
         DjsA==
X-Gm-Message-State: AOAM532SxldVgXsI4LdZFizbnBjMoFQpyGYoLc5rvhdTevAH2o5NBBTg
	i/IP2AU1ktZN1BVp4deXXvAzFA6q548Mbg==
X-Google-Smtp-Source: 
 ABdhPJzaY0ay5ztu595FZPbDgn6aMda5sdOqD3z8FmVTLeyEOajXD384JwweQXC6F3AHTB3uSCUgdg==
X-Received: by 2002:adf:f44e:: with SMTP id f14mr55636265wrp.37.1635948803284;
        Wed, 03 Nov 2021 07:13:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:52dc:b819:4029:149f?
 ([2001:8b0:aba:5f3c:52dc:b819:4029:149f])
        by smtp.gmail.com with ESMTPSA id
 c6sm1669668wmq.46.2021.11.03.07.13.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 07:13:22 -0700 (PDT)
Message-ID: 
 <6a5db3389ed956233ca71f9b72b2fc051386ac34.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 03 Nov 2021 14:13:19 +0000
In-Reply-To: <16B3BB5E65837842.31260@lists.openembedded.org>
References: <16B3BB5E65837842.31260@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Nov 2021 14:13:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12872

On Tue, 2021-11-02 at 12:44 +0000, Richard Purdie via lists.openembedded.org
wrote:
> github is dropping support for git procotol iun git urls. Add code to remap
> this to https in a way that could be used in older bitbake versions.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index e974445fbe..f5be24d6ab 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -142,6 +142,10 @@ class Git(FetchMethod):
>              ud.proto = 'file'
>          else:
>              ud.proto = "git"
> +        if ud.host == "github.com" and ud.proto == "git":
> +            # github stopped supporting git protocol
> +            # https://github.blog/2021-09-01-improving-git-protocol-security-github/#no-more-unauthenticated-git
> +            ud.proto = "https"
>  
>          if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'):
>              raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)

To make things a bit easier for everyone, I did backport this to a number of the
older bitbake branches back to 1.40.

Cheers,

Richard


