Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2AFC433FE
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 08:21:36 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.21330.1637914895348218587
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 00:21:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cao5232v;
 spf=permerror,
 err=parse error for token &{10 18 _spf.google.com}: limit exceeded (domain:
 linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id r8so16851021wra.7
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 00:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MKt6DQA/gisK9T78d8hMzomPzQTV8IqzVyfDn93BghY=;
        b=cao5232v2mcgnXDUBE4K1mJdfGKcBOGhuH4uKv1YIOhsbvLMEBE+adgGyCVdOauPrL
         9XAILI5qBiJOIvfVtFtLmMSQE8qI3dOjmJot9PUQwzKt21Q2vMTWAb7XBefy6DLxL9dn
         6P85t9yQtxCn3bOUhjRQ9Lnmg1dzWFZIhASH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MKt6DQA/gisK9T78d8hMzomPzQTV8IqzVyfDn93BghY=;
        b=gsxJtHSxjQ+3doOBAqbFcEdpZtfICGibnXz3V+B+VKKScWIT854+UXqmO9KvXx0SzY
         GVUc1b2yuRWuuBC+oJoHFyqh30eikqletJT3/ZqEqIcSCUpRZBIpft62U/fFZWOJyYEw
         ByolKEKPkqS7cztPvabNHMdR2CuFxmygrqrTIpAhVP+t6KqTHMrGSPLymt3ZPYe7W0FL
         ovlmthRG0+BjJLpvC/e8Ef+sEtg2iLmeNw2bOL0Fyp80cBQmNcZdgvPWFDpyv4mgdZJU
         Wef4HHkpRZjQc/5hmOjetIPXkNJHlUEbHAyDqDNYffNUr7KjC8ZA2LIKX+teBpt7CbCX
         seSQ==
X-Gm-Message-State: AOAM532+Pcb6RZwruw/1dR16TMnO6iCYDbHATeaJ4OXbf4YsZWVQJuy2
	r4lJZsnNUlPH9Av2bMmT0pqPaA==
X-Google-Smtp-Source: 
 ABdhPJwcJgl/PZUt2mqQaMAp48FnPVg3vLNA+qWW1WHW0OExt/Q5V/g9A5FJRMiboIN4pCaTQEoNXA==
X-Received: by 2002:a5d:66cb:: with SMTP id
 k11mr12611463wrw.253.1637914893781;
        Fri, 26 Nov 2021 00:21:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f21b:9c01:debb:ef34?
 ([2001:8b0:aba:5f3c:f21b:9c01:debb:ef34])
        by smtp.gmail.com with ESMTPSA id
 v6sm10131176wmh.8.2021.11.26.00.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 00:21:33 -0800 (PST)
Message-ID: 
 <4cb1cfdfd24814d29dea9308b9bceee6f6054f99.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/version.py: add from
 distutils.version
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tim Orling <ticotimo@gmail.com>, bitbake-devel@lists.openembedded.org
Cc: Tim Orling <timothy.t.orling@intel.com>
Date: Fri, 26 Nov 2021 08:21:32 +0000
In-Reply-To: <20211126051800.2364615-1-timothy.t.orling@intel.com>
References: <20211126051800.2364615-1-timothy.t.orling@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Nov 2021 08:21:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13113

On Thu, 2021-11-25 at 21:18 -0800, Tim Orling wrote:
> In places like sanity.bbclass we currently use
> distutils.version.LooseVersion, but distutils is deprecated in Python
> 3.10 and will be removed in Python 3.12 (~October 2023).
> 
> The recommended replacement for for distutils.version.LooseVersion is
> packaging.version.Version, but this implies 'packaging' be installed on
> the host. It is also not the same functionality as LooseVersion.
> 
> [YOCTO #14610]
> 
> Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
> ---
>  lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 347 insertions(+)
>  create mode 100644 lib/bb/version.py

I'm wondering if we could switch the usage of LooseVersion for
bb.utils.vercmp_string(a, b)?

Cheers,

Richard


