Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19839C433F5
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 14:49:12 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.6471.1636123750650078145
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:49:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=drb0HHBJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id d5so14161623wrc.1
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lCwOUgOQg6i6KGsaIEqc8NzkCg9XR+kQWSiJZuY8fhI=;
        b=drb0HHBJ22OqpcasKPc56FnsmYu303ps5yrQBHh3fo6/lEthbrRaYnWkBgQQOBxEZJ
         iwZZAWy1vNfl6HSkvzg1jWd8n9ilu5nKLzDMuqmhXYEZfU8ltaEFE0/Leeb0TzG5LLeK
         BOBflFyC68QOf9m63WSFuNMnVaNoVe6g+yG64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lCwOUgOQg6i6KGsaIEqc8NzkCg9XR+kQWSiJZuY8fhI=;
        b=UqNtAT2S5VOzBNBMF8GaV1/pG5zILW0a0LL2dHZ0BbFd1gMHXc5s3MjVmEcClJZL0V
         9I0wUiurjdJ+EvYWDJ9YirjtynfX6UtxjxNmaJdczCyFzttmRrS8tgZWQRdo6rY7STjM
         X9OIBNs0dygfSwXv+riF/UNoQg/+Pzas4wIKNkHyNIqtG2oWu30NvP7W+ZMjNNG39g6H
         AURxm+z5efYXl8a+v2X0ZctLAW8TJ5a1XYQBKifog9M6/JpQ62QccwepbMwDPNI+hoj/
         pI3d5boqZzo3lC9bhP10izN6B4kbFYTwH/dr0Rd6x3Tico0xXDF/0BJRtcC3m/SqOTGK
         rPig==
X-Gm-Message-State: AOAM531yHSKIO9Ax031o3deoxCTQvekjXwDHzbHJpQ0bebOXxtle1pB9
	HN64ayrLrAeEOi+vNlkGUL2CjA==
X-Google-Smtp-Source: 
 ABdhPJyAXrvxLcI1D7jnfrspN2uuHYCKYIJvxWO8ZniXeJ27ErHM5acCMbCXQvxnVSuOnT+3Qtt8Yw==
X-Received: by 2002:adf:da44:: with SMTP id r4mr76320727wrl.180.1636123749112;
        Fri, 05 Nov 2021 07:49:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:38e6:15ea:3134:28e5?
 ([2001:8b0:aba:5f3c:38e6:15ea:3134:28e5])
        by smtp.gmail.com with ESMTPSA id
 u2sm8377830wrs.17.2021.11.05.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 07:49:08 -0700 (PDT)
Message-ID: 
 <8ade477af55c3fe2ef5ba23b3e6d535ad671e33b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] doc: bitbake-user-manual: add
 TMPDIR and WORKDIR to the variable index
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Fri, 05 Nov 2021 14:49:07 +0000
In-Reply-To: <20211105144238.27679-2-michael.opdenacker@bootlin.com>
References: <20211105144238.27679-1-michael.opdenacker@bootlin.com>
	 <20211105144238.27679-2-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 14:49:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12903

On Fri, 2021-11-05 at 15:42 +0100, Michael Opdenacker wrote:
> This allows to add references to these variables
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  .../bitbake-user-manual-execution.rst         |  2 +-
>  .../bitbake-user-manual-fetching.rst          |  4 +--
>  .../bitbake-user-manual-hello.rst             |  4 +--
>  .../bitbake-user-manual-ref-variables.rst     | 28 +++++++++++++++++--
>  4 files changed, 30 insertions(+), 8 deletions(-)

There is a small problem here in that bitbake doesn't actually define or care
about either TMPDIR or WORKDIR. They are variables created by the configuration
of bitbake...

Cheers,

Richard


