Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD0C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 22:47:28 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web09.59138.1638830847261201023
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 14:47:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U7PyqId2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 k37-20020a05600c1ca500b00330cb84834fso385420wms.2
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Dec 2021 14:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=s01CkJ7amXMm6u0sG/7vYMehnfLnZMU4uVJ4LMwWlfg=;
        b=U7PyqId2HDXIsUbWwYc4WNLj6HhispWVIHKx2bT4RM/vCSUGY1kVUWG2XNOwRctzZf
         8RsWPiCeOCrsplCyYpUra0YTrnHaLnra+Z2cpkgVkFe0aSyHLfi4VuF0eP+G5jy+KU7c
         Y81bOJP1UWWcca3uzo2A149k5Nuuzuol5Ftaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=s01CkJ7amXMm6u0sG/7vYMehnfLnZMU4uVJ4LMwWlfg=;
        b=JvLklAXeQq3uoaffzn+RNd2i9qnXWMoVMbppR9Pyth4Thm/uCS6Gi2PIXL9Z37eJ0F
         xKPqzuQSWKI5pqhoptkApAw7HBGxR8b/p+FwSl8O1CdUE3n9iTlYhWcSbstOMKrhfQiP
         VT3NLzTcY7x7BC/dCEL2OQIPSp8w5JAoIdLE6+1J25MnYohxJTWoHJ9bCctaKCBTDzBU
         uU/Qq1QlxmwfRFeUSTSw+zqY+GfJ/Tot+FevlMpPgBA/X7ftI8S3fmyZ0Bd9+duR6cob
         xoqmEZVHqPUOdwiQ0Dv+IB5nDlZ6Kg1JW3XXJM6cuo3NnU6ceHpPxXFj71s2x3uHWn+T
         +/lQ==
X-Gm-Message-State: AOAM5310cKlRJFIYlbSr3jgDJEXdnP5UtJ6jfUD3EyeWIuXRz6nfeo+U
	8RxUtK1qXjzCoSHi+iTfByeyDQ==
X-Google-Smtp-Source: 
 ABdhPJyJ0ifUzARVEfGySsQMbLsfke9wJZDrsMGMPkWxiBgCmGV+RzQYUaZMP/3FM0YxN9WPWllVfQ==
X-Received: by 2002:a05:600c:3586:: with SMTP id
 p6mr1943686wmq.34.1638830845688;
        Mon, 06 Dec 2021 14:47:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:a430:ef69:a06e:8b4a?
 ([2001:8b0:aba:5f3c:a430:ef69:a06e:8b4a])
        by smtp.gmail.com with ESMTPSA id
 f15sm798192wmg.30.2021.12.06.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 14:47:25 -0800 (PST)
Message-ID: 
 <4ff493233f785384ac845b2b712388155a328bab.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: do not hardcode tarball
 compressors in version check
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Date: Mon, 06 Dec 2021 22:47:24 +0000
In-Reply-To: <20211206164119.4076119-1-alex@linutronix.de>
References: <20211206164119.4076119-1-alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Dec 2021 22:47:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13137

On Mon, 2021-12-06 at 17:41 +0100, Alexander Kanavin wrote:
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bitbake/lib/bb/fetch2/wget.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index fd9b304961..3021ef359e 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -583,7 +583,7 @@ class Wget(FetchMethod):
>  
>          # src.rpm extension was added only for rpm package. Can be removed if the rpm
>          # packaged will always be considered as having to be manually upgraded
> -        psuffix_regex = r"(tar\.gz|tgz|tar\.bz2|zip|xz|tar\.lz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
> +        psuffix_regex = r"(tar\.\w+|tgz|zip|xz|rpm|bz2|orig\.tar\.\w+|src\.tar\.\w+|src\.tgz|svnr\d+\.tar\.\w+|stable\.tar\.\w+|src\.rpm)"
>  
>          # match name, version and archive type of a package
>          package_regex_comp = re.compile(r"(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"

Looks good, is there something we should be adding to lib/bb/tests/fetch.py so
that we don't forget this lesson?

Cheers,

Richard


