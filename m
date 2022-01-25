Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053BBC433EF
	for <webhook@archiver.kernel.org>; Tue, 25 Jan 2022 12:20:30 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.6220.1643113228683697438
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 04:20:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QA2j54k6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id e8so17761105wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 04:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=7ZzjhIcAxK4FjWv44qkdo8a2s9mE6YuN3fqRnucal5o=;
        b=QA2j54k6ucHtAwVoyUQ5ZASM7Wbkt3+4NsIyHlWZoAMe7vQbsSN0bIsDmcp+w8C/ey
         2H+EAIxC0MpOCYQQEX+jdJtrdOnjMWdL/Wv6QPTe0pdklYoUUmkdSL5eqfKF2CXg5DEK
         7fhurleQ5gzPH34+W0mITOCEsy05wRJ24OnYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7ZzjhIcAxK4FjWv44qkdo8a2s9mE6YuN3fqRnucal5o=;
        b=IpSKvelGVMzjoVK4dp5UXlEoKQrnqkec5DwAdY7OSFQz33YJAn7/YZKEnvNztJtMhI
         2/fGWrnBMFVbOoNMCWpeaej1qYCWti6z32WpaCP/aOXlobAo/+FAmaDKN7t5XSglwNEE
         g7XrYZzJQsQUxv9x694YAnq5SA2YHuaRp/8j+6ftRZeCGiReiNFs2FpJkC62C5h6tNjV
         kG8vJYOhKTrOlqJxArs7UdbuHXx5jec0+AwJNyATWPBjkqkpMh+dHVrvZ1vgCVlrTbfA
         34O3j4v7L9+/DPmxsE2gYHeDm7p+p03BYb+rGpuv0Ec20nbS/gBBi4TmyJO7C5tFyfVY
         of/g==
X-Gm-Message-State: AOAM533mxJYlCbFe6mROVD1bybvLQMsyAHMGdqKMsIOD+7vlgSNxkE0P
	PUnTJvB4WTe1rOJFo4VYDOxQMVkRw1Frjw==
X-Google-Smtp-Source: 
 ABdhPJw8dtXDVEOWguhWMUN4TkyQNYPMpB67+Ha3NB1zhBL1qleY1Nfb4G+L4A5gN3qHjMwDBp3aSw==
X-Received: by 2002:a5d:6da1:: with SMTP id u1mr18391763wrs.420.1643113227306;
        Tue, 25 Jan 2022 04:20:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6b0a:3d41:67d:ed83?
 ([2001:8b0:aba:5f3c:6b0a:3d41:67d:ed83])
        by smtp.gmail.com with ESMTPSA id
 14sm13359818wrz.100.2022.01.25.04.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 04:20:26 -0800 (PST)
Message-ID: 
 <db3861e842d22d49b7c834d9fbc9a5ca613bab01.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH]] checksum: Support uri formatted file
 list
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 25 Jan 2022 12:20:25 +0000
In-Reply-To: <20220121153905.1701521-1-ptsneves@gmail.com>
References: <20220121153905.1701521-1-ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jan 2022 12:20:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13279

On Fri, 2022-01-21 at 16:39 +0100, Paulo Neves wrote:
> Before this commit, if the file list for checksumming had
> files names with spaces there would be a crash. This happened
> due to filelist.split breaking on the file names instead of
> on k:v boundaries. Now we validate this case and emit a fatal
> error if such case is found. This needs to be fatal as the split
> will generate broken k:v from then on.
> 
> Instead of putting literal spaces in the file list the user
> should urlencode the file names and if they contain coded spaces
> they will be decoded. This is consistent with the current
> practice where file names are urlencoded. A reproducer of the
> issue this commit fixes, was to pass a do_compile[file-checksums]
> list with files containing spaces in their names, urlencoded or
> literal.
> 
> Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>  bitbake/lib/bb/checksum.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
> index fb8a77f6ab..97cf10825e 100644
> --- a/bitbake/lib/bb/checksum.py
> +++ b/bitbake/lib/bb/checksum.py
> @@ -8,6 +8,7 @@
>  import glob
>  import operator
>  import os
> +import urllib.parse
>  import stat
>  import bb.utils
>  import logging
> @@ -110,10 +111,14 @@ class FileChecksumCache(MultiProcessCache):
>  
>          checksums = []
>          for pth in filelist.split():
> -            exist = pth.split(":")[1]
> +            spl = pth.split(':')
> +            if len(spl) != 2:
> +                bb.fatal("found unformatted path in filelist " + pth)
> +
> +            exist = spl[1]
>              if exist == "False":
>                  continue
> -            pth = pth.split(":")[0]
> +            pth = urllib.parse.unquote(spl[0])
>              if '*' in pth:
>                  # Handle globs
>                  for f in glob.glob(pth):

Does any code currently urlencode the filepaths into this flag?

I think we may also need to add some tests around this to bitbake-selftest...

Cheers,

Richard


