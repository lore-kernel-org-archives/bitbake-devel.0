Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABAC02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 13:16:39 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web10.10295.1737119797177506214
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 05:16:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=PwFTioNr;
 spf=pass (domain: linaro.org, ip: 209.85.208.173, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30613802a59so22368581fa.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 05:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737119795; x=1737724595; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tdjW05QaR3CF7/pf/o1x4Q2uotxWKIwfmJIcoJ9sc8=;
        b=PwFTioNrGd+ykfC9uaHpo2nyi3plHQhFu2SCT8aqvNpTh07RVI057KD5HowrOEEcgB
         zzVEitafR9Il0meZHdewW4IuFGoCHKPo9PH9N8Zh8KzElDD/tbXrrnqTQsbGSLpn246l
         tciqDRfvej5QLLv+oc4B8qkqQxzbPiCxmictZV4dnsSWBPk03MHmAltxKY+SI8+wRJnD
         Qab9+HABQm4Zb2N/T2To7kBDmpMgxGOV8NqRKVNNU3cpkvZSxSsfC0atktT2Y2WkgReG
         2XTMOfGS43JX6jo0eRPFiBsGJmdphF1wlt2ae3w4k6kmOSXz+IWY24AogI+FZO4Wr0hk
         Qj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737119795; x=1737724595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tdjW05QaR3CF7/pf/o1x4Q2uotxWKIwfmJIcoJ9sc8=;
        b=QNm7jowg2CElO9Z1GT1ff9prJbLUinZy2pk1og6A68LQ9ZADAsd83QbsKd/A1fieQp
         c7EsZIXGUUBqQzpk2SzaVbGfKAGAYcG6J9Li2+u3k6zo8nxExq0XUss+9dxYQbLqM7Bp
         AOjQcGXgzdU38/5w6XItN1e7AxCBBjqrpxdHUmu14bPpO7HLtiT/nOAOo/euJcgY4Y6a
         sh8QjaUl2LcaEC5qXi5mHpgApim1H9B6eGoWOfuE3JPCol5XoYykB3kM49uoSjbkDCwK
         2/1E04xLG/kbfzQ6WdjM7Wj+2MPegsIOaCNYl5h3tC5GIAnz3aykeLD+w1Qu/X4lVbW3
         C6JQ==
X-Gm-Message-State: AOJu0Yzab1ATMg1XgKybWZEskbuIQe8ijI6G8oqal7Y7Q27jIpIW/C6Z
	PtErCJaWpZzCfA+AmSo4/ZzYdJu6i5yZWw93XYujqNjFhrqi2+fVlqzTVQ490R4=
X-Gm-Gg: ASbGncudTLsFcr35iuNtloOi5wY9oJsjzRUz+Q7Gwn44KOrTsWwr5q3tRnFpwcNwmiF
	mh4TFYl3M/YIRsHk5yZ7uy1LWuvYxkIwOKkcXBIjPS12HD0JpFxGjFPesleZw6YNDY4OEwrcyrP
	q/VXuupuDw6bO4cQzRMyMLFObSrKyn5oanEk5R/jNyozkvfAT1UHZhjTI0fUTZhd+TZ+afS2BEu
	OmRK6NAlLgtTsW8F5bMh3tJOby1caw0npudGZ87gXSMKezMNE1ZtAwXGulRKohcQAaQMOwvvbfC
	hD3t5Q==
X-Google-Smtp-Source: AGHT+IE+0UWnKmHyMUujuJzSC8jXbmCiMty7K/rECmbFPXy6a2ryxXi/3+VCMQDjU7ZzgMhhaiY1Cw==
X-Received: by 2002:a05:651c:896:b0:300:1d45:871f with SMTP id 38308e7fff4ca-3072ca5bce5mr8803041fa.5.1737119795252;
        Fri, 17 Jan 2025 05:16:35 -0800 (PST)
Received: from nuoska (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a3308b4sm4426591fa.6.2025.01.17.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 05:16:33 -0800 (PST)
Date: Fri, 17 Jan 2025 15:16:30 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: ganesh.manoj.mahajan@signify.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [scarthgap] Gplv2 layer incompatibility
Message-ID: <Z4pYLs1mXZPG-aG9@nuoska>
References: <sHHJ.1737118955583729476.ujxu@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sHHJ.1737118955583729476.ujxu@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 13:16:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17030

Hi,

On Fri, Jan 17, 2025 at 05:02:35AM -0800, Ganesh Mahajan via lists.openembedded.org wrote:
> As we have phased out meta-gplv2 for Scarthgap, but my system needs gplv2 and also i need to upgrade to scarthgap. Is there a way to have both accomplished.
> I am getting below error. When i run bitbake.
> 
> build@ubuntu-bionic:~/project/build$ bitbake
> ERROR: Layer gplv2 is not compatible with the core layer which only supports these series: scarthgap (layer is compatible with dunfell)

Remove dangerously out-of-date meta-gplv2 and build your images without
GPLv3:

https://docs.yoctoproject.org/dev/singleindex.html#images

This can be done with poky, but may require changes to the SW
components you ship on images. Details depend on your setup.

Cheers,

-Mikko

