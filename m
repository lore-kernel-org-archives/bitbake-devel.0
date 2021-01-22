Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web09.7338.1611313855892256960
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jan 2021 03:10:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NyGE38eB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id u14so3983450wmq.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 22 Jan 2021 03:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=YOHwB6soLTZUIJ1ceo+NbRUZb6KvSGodvPqmj5uv+ow=;
        b=NyGE38eBFT7SqxqXvdN5vvas4g3h+nXdmHTMkwVt7Czh3JpMd4TK6K2CGinrU/s8M1
         OCfrZXbYSMpvd6yprPvVWBY13Nsro5Wrr793txMs21SWy5CwMiOQlEt4ta5+1RaqqvU2
         0JoAIfMGU62DMEZ/D12oCvrE2WlTSl0RuY0B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YOHwB6soLTZUIJ1ceo+NbRUZb6KvSGodvPqmj5uv+ow=;
        b=HSNid+JKneBbKZMc6upm9Ihr0uME3iZE1cxjuqSXTv5Kp9MsxVkh9/r9g4wfkoqljN
         50gxCuvDcdSXLqI7m/5zEpzAhuy2pBp7ZJNesG15a1Z3FzS3djMk8OzQWZbo+Lbn011n
         mNESSzMVxTuwZyItjOGCuJOZgAszkxyjV1bP4o0ic5GVfKU/UPVqSb4TABP3m4Cf8iPI
         s7kS6aQnkhdM2SAaqOKT+aBCzCnyYox68lC0w2iDYnDRWVYTGJq1uQyFoRcK/ApCHNJI
         6OtdwxSgJaQ91HFBG6Mj5jNXK/NUEsfcZVjV4YFiawlQE0JmhgDU7zAfMV+YpUJlr9a/
         e8Qw==
X-Gm-Message-State: AOAM5312UhFm9SPnhF9gs0zmYUJ/Y5ZpUvuwnx0AJJQlyINNLhsA5PL4
	HLymha8uoAttL/Wg4U4OSNKwKw==
X-Google-Smtp-Source: ABdhPJyhVI10tN6ClC0a6wBJSlpCYin1pI8A5W7TgvveDjCzmT00dByW0xtijqBbOCBYv+jKA31EIg==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr3518838wma.6.1611313854291;
        Fri, 22 Jan 2021 03:10:54 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:6d8b:661b:50ff:3a78? ([2001:8b0:aba:5f3c:6d8b:661b:50ff:3a78])
        by smtp.gmail.com with ESMTPSA id r126sm11429505wma.48.2021.01.22.03.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 03:10:53 -0800 (PST)
Message-ID: <da743b4ce7426b6e44641c83ccc689babf82091f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: download LFS content too during do_fetch
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: matt.hoosier@garmin.com, bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jan 2021 11:10:53 +0000
In-Reply-To: <20210119205934.24174-1-matt.hoosier@garmin.com>
References: <20210119205934.24174-1-matt.hoosier@garmin.com>
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2021-01-19 at 14:59 -0600, Matt Hoosier via
lists.openembedded.org wrote:
> Insert an explicit call-out to git-lfs to fetch all blobs needed by
> each ref named in SRC_URI, during the fetch() function. This avoids
> the default behavior of Git LFS to wait until 'git checkout' to
> begin downloading the blobs pointed to by LFS records. Network
> access is not allowed at that point in the recipe's lifecycle.
> 
> Signed-off-by: Matt Hoosier <matt.hoosier@garmin.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

This did cause some fallout on the automated testing infrastructure:

https://autobuilder.yoctoproject.org/typhoon/#/builders/23/builds/3192

(the vulkan-samples recipe seems to find lfs contents somewhere we
didn't know about)

bitbake-selftest failing:

https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1745
https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/1745

since we don't use/install git-lfs on the infrastructure.

We should perhaps skip the test if git-lfs isn't installed?

Cheers,

Richard



