Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.876.1626992085985218086
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jul 2021 15:14:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ahh4TNjd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 9-20020a05600c26c9b02901e44e9caa2aso484333wmv.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jul 2021 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5ASO2MCLxnwincIOMIdR2QcScM/ynfA7MGtd4eB3c0Q=;
        b=Ahh4TNjdKbccWnpbZsKbjOC5FWFeqczO3jiYxkCP1J5pLe0xbHo27VVZ7VOq/zHOWt
         uidj38CNSj7NKj7rnjRDIHLGqKQAkWCwMqP5an38hs+0nzrOSzg5P+paHmaU9MoOGULD
         iEuwLxGE5qinGFzZLooVe0rGCEshilxO81Hic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5ASO2MCLxnwincIOMIdR2QcScM/ynfA7MGtd4eB3c0Q=;
        b=t8VPEdeX7QsobU4ALZ5L62UsO4MMBrcbk2S6r/M7FPlRH2ts4y92u0F/+wHv2Wxjcu
         H3IyKeKlLH0cyo0C59le+eh+Re5JtbjH42jaWF7IifH/dvU6+gRBDrsmqX0DceqPBurU
         uSPLIp48+hGJLmXNEkm7RdFtW4YZq+Gpdyn+2qzbcgOC2Hy7vAMdnDylsb1HpFEJb6TU
         ZShKkdJ+VA6MVMWtyewPAJUev2tvdBp+i3Sn8Nib4YZ39jKHKk58vYo+lJ/Weejwbgh6
         zPoEXNW6LXYrPoIrlzFiE8W3ifmDHU2WnyWXoNpFY6oQZjNGUokf8V1tyBqtx054Iz4c
         8OSQ==
X-Gm-Message-State: AOAM5336EHQZINewFKBYl99LCt69Ag1xtmOTA574Uu7ifxvFm8Emhpq1
	cOOL0SuCRUbEEIXgYF2uLboBnQ==
X-Google-Smtp-Source: ABdhPJx4iBClhKz2U+pWIboAJOEbJACwMyrfuV66JtqDQEcHOAk/JpNM8BzBtd5akqjDBo3M7YaFqw==
X-Received: by 2002:a05:600c:4f08:: with SMTP id l8mr1628301wmq.22.1626992084450;
        Thu, 22 Jul 2021 15:14:44 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:e1dd:b42c:9243:6ba8? ([2001:8b0:aba:5f3c:e1dd:b42c:9243:6ba8])
        by smtp.gmail.com with ESMTPSA id z11sm30830722wru.65.2021.07.22.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 15:14:44 -0700 (PDT)
Message-ID: <a7519c3f91a397c4e4259be88c0ccd76c3b2f037.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] doc: bitbake-user-manual: fix syntax in example and improve description
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
Date: Thu, 22 Jul 2021 23:14:42 +0100
In-Reply-To: <20210722171021.69225-1-michael.opdenacker@bootlin.com>
References: <20210722171021.69225-1-michael.opdenacker@bootlin.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Michael,

On Thu, 2021-07-22 at 19:10 +0200, Michael Opdenacker wrote:
> The previous syntax of the example was clearly incorrect
> The example and description were also ambiguous, one could think that
> it was "bitbake recipe" instead of "bitbake <recipename>"
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 20c330e6..01ac4d5e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -91,9 +91,10 @@ level changes:
>        Variables that are exported to the environment are preceded by the
>        string "export" in the command's output.
>  
> 
> 
> 
> --  For recipe changes, use the following::
> +-  To find changes to a given variable in a specific recipe, use the
> +   following::
>  
> 
> 
> 
> -      $ bitbake recipe -e \| grep VARIABLE="
> +      $ bitbake recipename -e | grep VARIABLENAME=\"
>  
> 
> 
> 
>     This command checks to see if the variable actually makes
>     it into a specific recipe.



I should probably highlight there is a new command, "bitbake-getvar":

http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=7bbeddeee1992d8c8fb71ba2dd49b03d0ae1ce86

We probably want to document that.

Whilst I'm thinking about it, the override discussions on the architecture list
are going to have implications for documentation too.

http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=75fad23fc06c008a03414a1fc288a8614c6af9ca

An example of my scripted conversion run against the manuals is included
in this commit:

http://git.yoctoproject.org/cgit.cgi/poky-contrib/diff/documentation/ref-manual/variables.rst?h=rpurdie/overrides-convert&id=9ac22a64a4c0ac4640552e90674e6459f0fece9a



Cheers,

Richard


