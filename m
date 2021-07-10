Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web09.20344.1625885310100911731
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jul 2021 19:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=jN78LwyP;
 spf=pass (domain: gmail.com, ip: 209.85.215.175, mailfrom: jiladahe1997@gmail.com)
Received: by mail-pg1-f175.google.com with SMTP id h4so11792781pgp.5
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jul 2021 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=VabalatMFqyUnba0c42rDlwOiZGEXlqBV9Ruk5CRRZk=;
        b=jN78LwyPqpaiT5YzRdBAk0/PBsKCFnlfjzTEtHc9lPDEgj/9EjvMFacXOYL7qcl27Z
         q2ZY8VeXzHKcH3U4H6HUQV+IX5c8ltOwpdHFuV43Jaf+hlFcfn0z9FTwh1snCCHzdpoN
         DxauFyb+hmZJGd+QsZB8fOuViP5g9+mHwJ0DVO4bOI9bn8tKJzWjeauAks6zqeq38F8/
         H/kQaMiz410eHNSy5jZbAOc4Tr6ek6nZOZ9YqPyHu2+Ab+3GnD3RGgF6+TIhejLQQ6GH
         AOrUcYUHCUMue5IQ/9SflgqnXWqPu5n5Fks/7j35SxUdRpCfVqb6EqI9IyH5SLCWU5fz
         XpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VabalatMFqyUnba0c42rDlwOiZGEXlqBV9Ruk5CRRZk=;
        b=oCgjX7RHkug59dfTQP+ZHneQ0ARZKKUJV0hlAwKfAJVmwqhl8BvLFWenRhjquTKutN
         YaVZ92uvu4mMNsr2iwQDNbWPGtn/Ry6R/YjlGRHEfCBldeKIMMR5A9ycNM2aomr4vSy0
         kLrHIlDPKRUERPLuB47QbyU2CYtB7QEFy2gpHZWydrvNfKfoPQ4KpnTbxMxJcnAF5wRD
         zKyWgyB+pmUljkRMboL4ZX3G5nSDmv5sqMm+VwE4eS6C/viiqmz142kcE2jWN1cJmtsv
         88bVwznSGc3isUTRiIZ+tYhs6UWVLqvFTG5nHrcYiDSLpVMZVNgEhfYhzNveh4DU1G2F
         j2iQ==
X-Gm-Message-State: AOAM530uxoR9xcEk9Jp3pmD9Xxq4zPxIrWQahG1Xb/MNq7A4cLvYO0zu
	KqbaLAr99sr72Huu2wZExKh1//1ULb6CNVDae7M=
X-Google-Smtp-Source: ABdhPJx5oyLbebWhcuiL2Osc+ay3FhkvliK0Pzt00nm8UQDAjDpEhnIL9NYsZw12jQo5p/bSKFUexQ==
X-Received: by 2002:a63:5414:: with SMTP id i20mr42049485pgb.5.1625885309417;
        Fri, 09 Jul 2021 19:48:29 -0700 (PDT)
Return-Path: <jiladahe1997@gmail.com>
Received: from [127.0.0.1] (n11923637190.netvigator.com. [119.236.37.190])
        by smtp.gmail.com with ESMTPSA id s20sm14738972pjn.23.2021.07.09.19.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 19:48:29 -0700 (PDT)
From: "Mingrui Ren" <jiladahe1997@gmail.com>
Subject: Re: [PATCH] Add a new variable:'FETCH_ENV_WHITELIST'
To: richard.purdie@linuxfoundation.org,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <202107090944160361815@gmail.com>
 <d72c3eafc5e4327d97ab16382b66dc6b97b51a2c.camel@linuxfoundation.org>
Message-ID: <86779697-b733-4074-1ea9-465db33f3a5c@gmail.com>
Date: Sat, 10 Jul 2021 10:48:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d72c3eafc5e4327d97ab16382b66dc6b97b51a2c.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for you reply,


在 2021/7/9 16:50, Richard Purdie 写道:

> On Fri, 2021-07-09 at 09:44 +0800, jiladahe1997@gmail.com wrote:
> The patch looks like it was generated against poky since that script is in
> openembedded-core, not bitbake.
> Whatever we do to address this issue really needs to match how we fix the
> existing BB_ENV_EXTRAWHITE.
>
> Also, since fetching happens much later, we should be able to set this
> variable from config such as bitbake.conf or local.conf and there 
> shouldn't
> be any need to export it to the environment.
Yes, BB_ENV_EXTRAWHITE must be modified to solve this problem gracefully, it
seems that needs patching both of poky and bitbake.
Should I send an e-mail to both poky and bitbake mailling list?


> For the patch itself, I'd much rather add something to extend the list
> rather than replace it entirely which would make backwards compatibility
> easier.
About backwards compatibility, I have considered it, But I'm not sure if you
prefer cleaner code or backward compatibility.

For example:

FETCH_ENV_WHITELIST = "HOME PATH HTTP_PROXY http_proxy ..."
exportvars = (d.getVar("FETCH_ENV_WHITELIST") or "").split()

This code is cleaner, and better for forwards compatibility.

FETCH_ENV_WHITELIST = ""
exportvars = (d.getVar("FETCH_ENV_WHITELIST") or "").split().extend 
"HOME PATH
HTTP_PROXY http_proxy ..."

This code is better for backwards compatibility.


> There is also an issue with the variable naming. We have adopted a policy
> around inclusive langauage so new variables need to be mindful of that.
> We're in the process of trying to work out what to do with some of our
> older variables names.
>
> https://wiki.yoctoproject.org/wiki/Inclusive_language
I'll fix it.


thanks,
Mingrui Ren


