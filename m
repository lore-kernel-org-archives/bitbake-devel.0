Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.9687.1629636008737021605
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Aug 2021 05:40:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O9C4AzmS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id u16so21768017wrn.5
        for <bitbake-devel@lists.openembedded.org>; Sun, 22 Aug 2021 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=StcDOOyLWXx94lMp59PnUZ1fzU2WytfZtRhmp8ABINQ=;
        b=O9C4AzmSygNl24YjgyRKqUeEaH0rb1alUYH7BjIIs73VupWzqr+xaJzo36Uz7h4cIs
         TqX9Bd9MRyYmcrjZdNPj7zVSfktXu1BkljG6fdEoo82afAEFmFn1M7YZFyqFl+auRNy/
         4AcrULxj0zikkWjtM3nevPaSHiNC3jC8g0bu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=StcDOOyLWXx94lMp59PnUZ1fzU2WytfZtRhmp8ABINQ=;
        b=MFSw+r28SrD7jh23+abYGo59C/2MzeA1+1MRLyeZPoSvHkxOOw2xw4KjdZ8iRgjjQa
         0atWegImCrmnL23scirP7X+hztdLbmaQbZ7cyKTu2gquf8LPgSgHmd4YZ4UIeLTVUnFe
         gEcAqVhK90U3TTYs3TwDyeNHThUxlhy+2S1CTev68kjOhNuv2UhrukKLg17yStXsTx/L
         z2qSLHg5EDvtR/5Z7YRXKBJcJ/jhCditWZOHHJFbvnsS+YO6NYWQCJIwYwMf4sswjVSx
         YMzFMbhfee25DOyTAXCNyYSGUZ1jedvw31x2O8i3Df1jA1yQyj58PxQOnKGElmlbRoBG
         KLEw==
X-Gm-Message-State: AOAM530UWpgHEsnTJ9GDwo139Sib7Z/dD45xNeMOe38tanfNT5KUk6Vo
	vs1ErhHfiyDfMQ5RaCIJBVCnHA==
X-Google-Smtp-Source: ABdhPJwUUVyA/+nt+PhghaAG2CEx1V17Pa4Mrd/S1Z9ee5q7D2ASGjWK7r4MpPuTcZOYiIVgxe7kGQ==
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr8400836wrg.134.1629636007339;
        Sun, 22 Aug 2021 05:40:07 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:9821:d2f9:6401:2f3c? ([2001:8b0:aba:5f3c:9821:d2f9:6401:2f3c])
        by smtp.gmail.com with ESMTPSA id i9sm14532658wre.36.2021.08.22.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 05:40:07 -0700 (PDT)
Message-ID: <85b0c274cea943fc63070ac2eb0c1306a17d102a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][PATCH] bitbake: fetch2: correct PREMIRROR URI
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Scott Weaver <weaverjs@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Sun, 22 Aug 2021 13:40:06 +0100
In-Reply-To: <20210822123447.3477259-1-weaverjs@gmail.com>
References: <20210822123447.3477259-1-weaverjs@gmail.com>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2021-08-22 at 08:34 -0400, Scott Weaver wrote:
> When downloadfilename is defined in a recipe's SRC_URI and a PREMIRROR is also
> defined for that URI, the downloadfilename is appended to the mirror URI and it
> should not be.
> 
> [YOCTO #13039]
> 
> Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/__init__.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 914fa5c024..0bcd566e83 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -467,7 +467,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>                      uri_decoded[5] = {}
>                  elif ud.localpath and ud.method.supports_checksum(ud):
>                      basename = os.path.basename(ud.localpath)
> -                if basename and not result_decoded[loc].endswith(basename):
> +                if basename and result_decoded[loc].endswith('/'):
>                      result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>          else:
>              return None

Thanks for the patch. Should we be adding a test for this to
lib/bb/tests/fetch.py (run with bitbake-selftest)?

Cheers

Richard

