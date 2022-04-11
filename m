Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3C5C636F6
	for <webhook@archiver.kernel.org>; Mon, 11 Apr 2022 17:18:01 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web08.29788.1649687310361536724
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 07:28:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ebP1Cpu6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 l62-20020a1c2541000000b0038e4570af2fso10170639wml.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 07:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=500JEQoSdmHAYf4zisOpntejoAUNi8NaJHNcu/isiSE=;
        b=ebP1Cpu6gp0MFxb43mKzrzgShERv/Nkg5yoNCHWUIQsmztkeO1fGRfyxhxP4NvYHb/
         nCCwq3JDjPoPm0ZyEPO1A3C3G5FCgGuKKpD0SNhrWbRJxoQMZgoS7qXeZWzcyElNtaCo
         hZ9jKY/w8ofbJbUiVK/qLatHDnontSrjnMn4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=500JEQoSdmHAYf4zisOpntejoAUNi8NaJHNcu/isiSE=;
        b=jijj3qXznuROMRHtbO4FlUgzccELSVeFrG0to2SdFW+wb2qPk3iKHhW3dSOFilb26h
         1gLW2Yy5B4R7nRzuMha6eaf3HqeYfrYVq8fU5eA/MM/qsQjq7EEOsvqNWiQaox8Q3/n0
         9FxTzTP97PoCzFTlscF83i1yvNOOXaVj+y4oEq7NOwp7UgEflssG8IuKCr+92OQ1Ey55
         sf+PWalHj34Jt13eEIyuKFHhD/B0IO6CY6H9abKlQ8+Qme6fKmOywkEFmzWkytINgiQN
         3FXmJgFrPKXQQswi41H+cntpRMvRrHvI6nT+fU7/xzLQjprcvO/ds7QvVv4CnpksHfk9
         QJNg==
X-Gm-Message-State: AOAM532Hm11onX59okfesAPu7mbM0PoXdx0RJ3fdYaxHfx2UmhfXxAuu
	EaEJHlAC5mL5q1SyX5WgjENCX9YU0Mup1A==
X-Google-Smtp-Source: 
 ABdhPJyjWJ4/ZLIIaFnLArWko/1Y8Kc+q2x8IhSvt+W/bCQGZeuVkc8NHdBqqTITU/wWJrNulRc7Bg==
X-Received: by 2002:a05:600c:1ca1:b0:38e:7680:cc20 with SMTP id
 k33-20020a05600c1ca100b0038e7680cc20mr29856982wms.27.1649687308925;
        Mon, 11 Apr 2022 07:28:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f8d9:779e:103c:69c3?
 ([2001:8b0:aba:5f3c:f8d9:779e:103c:69c3])
        by smtp.gmail.com with ESMTPSA id
 r12-20020a5d6c6c000000b00203ec2b1255sm33360958wrz.60.2022.04.11.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 07:28:28 -0700 (PDT)
Message-ID: 
 <2c7698c9a48dcca849b964b5cd5076c12f5168be.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 11 Apr 2022 15:28:27 +0100
In-Reply-To: <16D17908BC3DCB81.25014@lists.openembedded.org>
References: <20220206134507.123558-1-ptsneves@gmail.com>
	 <16D17908BC3DCB81.25014@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Apr 2022 17:18:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13599

On Mon, 2022-02-07 at 10:06 +0000, Richard Purdie via lists.openembedded.org
wrote:
> On Sun, 2022-02-06 at 14:45 +0100, Paulo Neves wrote:
> > Before this commit, if the file list for checksumming had
> > files names with spaces there would be a crash. This happened
> > due to filelist.split breaking on the file names instead of
> > on k:v boundaries. Now we validate this case and emit a fatal
> > error if such case is found. This needs to be fatal as the split
> > will generate broken k:v from then on.
> > 
> > Instead of putting literal spaces in the file list the user
> > should urlencode the file names and if they contain coded spaces
> > they will be decoded. This is consistent with the current
> > practice where file names are urlencoded. A reproducer of the
> > issue this commit fixes, was to pass a do_compile[file-checksums]
> > list with files containing spaces in their names, urlencoded or
> > literal.
> > 
> > Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
> > Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> > ---
> >  bitbake/lib/bb/checksum.py                   |  9 +++++++--
> >  bitbake/lib/bb/fetch2/__init__.py            |  6 +++---
> >  meta/classes/base.bbclass                    |  4 +++-
> >  meta/lib/oeqa/selftest/cases/lic_checksum.py | 18 ++++++++++++++++++
> >  4 files changed, 31 insertions(+), 6 deletions(-)
> > 
> 
> Since this touches both bitbake and OE-Core I had to split the patch into two to
> be able to test it. I did that and found that one of the other selftests fails
> when it is applied:
> 
> oe-selftest -r layerappend.LayerAppendTests.test_layer_appends
> 
> e.g.:
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/3128/steps/14/logs/stdio
> 
> but it does this consistently and reproducibly. We'll need to get to the bottom
> of that potential regression...

I'm a little sad we never got this resolved, I took a bit of a further look as
I'd been carrying the patches for a bit hoping this would get some follow up.

The issue is the change in get_checksum_file_list() always comes up as false for
str(os.path.exists(pth)) as it isn't a complete path. As such the change
definitely has a problem which needs to be resolved.

Cheers,

Richard



