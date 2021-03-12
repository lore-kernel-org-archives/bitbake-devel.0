Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web12.5983.1615541261504306527
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Mar 2021 01:27:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gIftgNXZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo14734523wmq.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Mar 2021 01:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=BJjTuXhcZP+3kOJPL0Ef4v6d9NAimoklkyY6wYUK5/c=;
        b=gIftgNXZXlVnVfYfgu6FxP1oTbaDy0UhDV2KH+IAPpObmxcoF/pUStj0TDdYXIk1ug
         K5NWj5JiDKwMOn1hSkXoBe4HFr9h54ajWLBqknaWmrlY/fNu3GBJSsxHUIo+WJWsylEt
         dK+mlFda4Jxkh7ynCMMUHKz2N72PyUiP59HvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BJjTuXhcZP+3kOJPL0Ef4v6d9NAimoklkyY6wYUK5/c=;
        b=tmxis/1i8flaF/qPzwn8q89+dHoTvjAQU+/GjRjNTz/UegQeNuAvO5ESdjfdbOfNC6
         a9pOA0cLRf5qMHAEe0GOyLke117+y4Who4SZlqd+NBOLBQ0+nDiXUplZXgx8PDJKYLVY
         I8+XvaNe0Wo187MCsIAyA7Hbmsr2zvFIan7Jhqy3csCVGOzsouyICRI7gRtJLH6D27Ra
         XSj+L+91StYZVeraJmYe8WaKvh4eRD7GhyV3zSaIfof15p5zcIwhhDB2alSmFTf/NO51
         w/5G6+qHPGO3rcKUjN1HrPpzxUimmPYR+451PdAEKVUr/w0J7rUsSTrs4A9UTWRkDour
         k16A==
X-Gm-Message-State: AOAM530Uk6Y/WgClZOLL48Q8VdHBliCMWFo2VOQ4MJCfsKXPwWgOxWwZ
	RiQYawkXVJSdaJjVz13gaQNfzA==
X-Google-Smtp-Source: ABdhPJz94qON+XAp92G5vyB+l/QLGUTtKoUSegiMRCasGW8UslVjGH3z8Hima8FcA9O6TBZ54NABog==
X-Received: by 2002:a05:600c:2512:: with SMTP id d18mr11902805wma.55.1615541259559;
        Fri, 12 Mar 2021 01:27:39 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:7cc6:73c3:839f:86be? ([2001:8b0:aba:5f3c:7cc6:73c3:839f:86be])
        by smtp.gmail.com with ESMTPSA id n6sm7280404wrt.1.2021.03.12.01.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:27:39 -0800 (PST)
Message-ID: <32cb4fa991ed76b6cdaf145894af6921b8c9e17e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] license.bbclass: Improve parsing time when INCOMPATIBLE_LICENSES is big
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 12 Mar 2021 09:27:37 +0000
In-Reply-To: <20210312032022.7783-1-pkj@axis.com>
References: <20210312032022.7783-1-pkj@axis.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-03-12 at 04:20 +0100, Peter Kjellerstedt wrote:
> The commit 08cbf1748 (licenses: Update INCOMPATIBLE_LICENSE for
> 'or-later' handling) increased the parsing time considerably if there
> are many licenses in INCOMPATIBLE_LICENSE. Reorganize the code to get
> almost all the time back.
> 
> Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> ---
>  meta/classes/license.bbclass | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/meta/classes/license.bbclass b/meta/classes/license.bbclass
> index bcea0b3cb5..f7978e266b 100644
> --- a/meta/classes/license.bbclass
> +++ b/meta/classes/license.bbclass
> @@ -282,16 +282,15 @@ def expand_wildcard_licenses(d, wildcard_licenses):
>      """
>      import fnmatch
>  
> 
> 
> 
> -    # Assume if we're passed "GPLv3" or "*GPLv3" it means -or-later as well
> -    for lic in wildcard_licenses[:]:
> -        if not lic.endswith(("-or-later", "-only", "*")):
> -            wildcard_licenses.append(lic + "+")
> -
>      licenses = wildcard_licenses[:]
>      spdxmapkeys = d.getVarFlags('SPDXLICENSEMAP').keys()
>      for wld_lic in wildcard_licenses:
>          spdxflags = fnmatch.filter(spdxmapkeys, wld_lic)
>          licenses += [d.getVarFlag('SPDXLICENSEMAP', flag) for flag in spdxflags]
> +        # Assume if we're passed "GPLv3" or "*GPLv3" it means -or-later as well
> +        if not wld_lic.endswith(("-or-later", "-only", "*", "+")):
> +            spdxflags = fnmatch.filter(spdxmapkeys, wld_lic + "+")
> +            licenses += [d.getVarFlag('SPDXLICENSEMAP', flag) for flag in spdxflags]
>  
> 
> 
> 
>      spdx_lics = d.getVar('AVAILABLE_LICENSES').split()
>      for wld_lic in wildcard_licenses:


As far as I can tell, this changes behaviour since the variants are no 
longer added to licenses in this second loop over wildcard_licenses. I 
think this means you get the licences matching from SPDXLICENSEMAP
but not the matching licenses from AVAILABLE_LICENSES?

Cheers,

Richard





