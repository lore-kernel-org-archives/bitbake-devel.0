Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web08.599.1630688840702547503
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Sep 2021 10:07:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I2ZhUYR2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id m2so3976836wmm.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Sep 2021 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=60yYnluhlASOoSvbY+gFmax3Jb+HGuudjYHER/1vCfs=;
        b=I2ZhUYR26VK9MwmcWPrbNsxT3dYDoE5juUjoVEQAjHYW0oWudse1MTQKihWsdCADIc
         4nu5uPJskFyZ/23RDsHYk0JqcotZofVtoyuTjNABBKlOlk8w7XnZVUA/cOxVWBSyxqXH
         47iUURMR1gvaIP61uxyVQVnDSSMf6VRab4UPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=60yYnluhlASOoSvbY+gFmax3Jb+HGuudjYHER/1vCfs=;
        b=kf4EFBQ4ESZgVrLlpMs8E8OG7W8IYlVPqIcj6zA7FX3B/nVnYSmyqOXLQr7Xpzk2sy
         +I9fqfbH1eL7YEsaD8Kc3nOhyqkkPlOreR3oUoclOu5yAZGwwb8KdRTgPz3pDQNoBKl/
         9wR571YHxfrfzEfWtej4XNnAD5Pdc3FBSqSig0lXls+nNT5PYhRWJL6p0V0tpZenH9M6
         891nUG+YlTHl3SMErlP+6vY0KdSQxmoj0Sj2NffcYbtWKwGo/CAyPYwPqP7ejnfDTwjB
         fr68+SaicJ80Mg3PEiatmWb2LkdSAhf5YrowiJVMlCtes7pRDt8+FJbVmOmasXr1vKH9
         vs+g==
X-Gm-Message-State: AOAM531Xk1eKnse7TYpjEPQ04UPzgsnbZcgT1tgjP620LTM45YmzR24W
	OSrBQOtNpghyy/Y7SW0HEgAdaw==
X-Google-Smtp-Source: ABdhPJycz3xKdIBJhszsMf97ZLNv3fui+Til+HmgNprUdBrDzwmeBvrUN7o7qYhqBFBVhb1sDRfnyg==
X-Received: by 2002:a1c:114:: with SMTP id 20mr1377020wmb.179.1630688839176;
        Fri, 03 Sep 2021 10:07:19 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:748d:fb86:ebb2:cea5? ([2001:8b0:aba:5f3c:748d:fb86:ebb2:cea5])
        by smtp.gmail.com with ESMTPSA id v5sm5036393wrw.44.2021.09.03.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:07:18 -0700 (PDT)
Message-ID: <b23f250a23dbd3273392b6694a442f5bb5602bf7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 03 Sep 2021 18:07:17 +0100
In-Reply-To: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl>
References: <20210903142840.68050-1-dwrobel@ertelnet.rybnik.pl>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-09-03 at 16:28 +0200, Damian Wrobel wrote:
> It frequently happens that the 3rd party layer is, in practise,
> fully compatible with the older version of yocto. So, instead of
> false positively reporting an error, it seems to be more
> appropriately to just emit the warning.
> 
> Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
> ---
>  lib/bb/cookerdata.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
> index 1c1e008c..ed678616 100644
> --- a/lib/bb/cookerdata.py
> +++ b/lib/bb/cookerdata.py
> @@ -397,7 +397,7 @@ class CookerDataBuilder(object):
>                      bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
>                  compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
>                  if compat and not (compat & layerseries):
> -                    bb.fatal("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
> +                    bb.warn("Layer %s is not compatible with the core layer which only supports these series: %s (layer is compatible with %s)"
>                                % (c, " ".join(layerseries), " ".join(compat)))
>                  elif not compat and not data.getVar("BB_WORKERCONTEXT"):
>                      bb.warn("Layer %s should set LAYERSERIES_COMPAT_%s in its conf/layer.conf file to list the core layer names it is compatible with." % (c, c))

This isn't something we should change.

If two things are not marked as being compatible with each other, we don't allow
them together and you have to make some effort to bypass it. It is possible, it
isn't easy and that is reasonable.

Cheers,

Richard



