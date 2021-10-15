Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBC3C433EF
	for <webhook@archiver.kernel.org>; Fri, 15 Oct 2021 11:35:30 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.8001.1634297729952939596
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 04:35:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MiNAqTJr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id z2so2282686wmc.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Oct 2021 04:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=bC0/W9S+onp71o9xUutGfuWTFqoyTHSR4Zc4XB1ESOo=;
        b=MiNAqTJrpnL+/pqH20vWJhvIaSLCQWZIaPyszdhPmCh0BN2wxXzknvbHRKXIf7rvUx
         f//77ZiHoeKUcgEdfBr6OXhpTMRMtCTCHdWoVf9I7gqIEoWJOEuvqkbJ+D3Spbg5t1VM
         kp2X2SftCXVKAo6v0SHG5oF8NpWVzU4/UdCoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bC0/W9S+onp71o9xUutGfuWTFqoyTHSR4Zc4XB1ESOo=;
        b=4WjubN3MmYbF/UU6coUoN1Jyo9ZwnUoMoMzFpkS5471XkIgIvOaqiiGn2dZbpMXc6C
         iLzS9UhLEDX+LvKnNCjRGMCgB1kpl1MpNamMhdOP6dRUS/XVOG7DIdrMA0LUHQqQu9VT
         K2Af9m2Yu2iGAMfqksx0OHdFD/znqeP+vwq9TiJ8wSK9tcgWvfoTI5TvmxkrawT1gf6g
         X/0aRQoHxaTOT4d1Lcee8c1FGgAeQpAAlzkcqWu//3TQ3JH5nU199GTwzxjpghHvct6k
         BeV1swSU3NdckvJHvM+kEGewsdK5ZsUIZrtW4J0NHVx84kz/SUTMj7Uw0Qc+8hs3GuI3
         66fA==
X-Gm-Message-State: AOAM532DYpJX8VASbbMpsFJUvlsh0dqmh9aHXZs2upD5NSYEd073wT8Q
	U/Zf5X6WpyO/n4z+o9fkUl0Gog==
X-Google-Smtp-Source: 
 ABdhPJyoPfBbYCUA4OrA3vQaUN9+31GSQ936zK5JysSduulvwhqBat7koF3oo+VfPLhzufTbO4kfBQ==
X-Received: by 2002:a1c:7c19:: with SMTP id
 x25mr25673539wmc.190.1634297728401;
        Fri, 15 Oct 2021 04:35:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3c2a:82f4:3a7b:54b1?
 ([2001:8b0:aba:5f3c:3c2a:82f4:3a7b:54b1])
        by smtp.gmail.com with ESMTPSA id
 v10sm4999975wri.29.2021.10.15.04.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 04:35:28 -0700 (PDT)
Message-ID: 
 <582824039f6ac8e11b9a5ff91256ee591372c1ec.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue with
 premirror
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chen Qi <Qi.Chen@windriver.com>, bitbake-devel@lists.openembedded.org,
	weaverjs@gmail.com
Date: Fri, 15 Oct 2021 12:35:24 +0100
In-Reply-To: <20211015061753.70640-1-Qi.Chen@windriver.com>
References: <20211015061753.70640-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Oct 2021 11:35:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12782

On Thu, 2021-10-14 at 23:17 -0700, Chen Qi wrote:
> The following commit to fix [Yocto #13039] causes regression of
> the behavior of PREMIRRORS.
> 
>   "bitbake: fetch2: fix premirror URI when downloadfilename defined"
> 
> Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
> as an example.
> SRC_URI = "\
>     http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
>     ...
> "
> With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
> freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
> not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.
> 
> The commit above tries to avoid fetching from invalid url such as:
> https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
> And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
> regression.
> 
> This patch fixes the above regression. For Yocto #13039, it now tries
> to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.
> 
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  lib/bb/fetch2/__init__.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 666cc1306..000b49a50 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>                      # Kill parameters, they make no sense for mirror tarballs
>                      uri_decoded[5] = {}
>                  elif ud.localpath and ud.method.supports_checksum(ud):
> -                    basename = os.path.basename(uri_decoded[loc])
> -                if basename and not result_decoded[loc].endswith(basename):
> -                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> +                    basename = os.path.basename(ud.localpath)
> +                if basename:
> +                    uri_basename = os.path.basename(uri_decoded[loc])
> +                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
> +                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
> +                    elif not result_decoded[loc].endswith(basename):
> +                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>          else:
>              return None
>      result = encodeurl(result_decoded)

I've been meaning to reply to this thread as the regression wasn't good. We need
to be able to use DL_DIR as a mirror.

Could we add another test case for this case so that this doesn't regress again
please?

Cheers,

Richard




