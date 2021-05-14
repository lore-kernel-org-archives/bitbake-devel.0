Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.5327.1620972988276754588
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 May 2021 23:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d0Ml/zD5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id z17so9880771wrq.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 May 2021 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=yG0wX+hLv9CNKulKdoi9Ti9xA6sQRc/rVjvJzAgGers=;
        b=d0Ml/zD5iQ18c7mCksnYN9qYPTxXBPkOhLkEl/CEhSDZ7r4mCM5Neh7wy/pvqiogAV
         tnCGxj+1P2illhSt9X0abUNy1MwBwE/ceNzOOaibi9MndlWUIfkfq/l1B0GuvARssZst
         MMYUMuZL1QJKrzfsTGUPeCu+6kfI2v/jiAuoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=yG0wX+hLv9CNKulKdoi9Ti9xA6sQRc/rVjvJzAgGers=;
        b=Af+DZvjjN8sPKtmphAd1c2dX2QMbFT6qdokHuqVTJL+Bj+Xqr7P7amy1Shb5FR/Yxi
         W1UhixxJQvwPJCyb/ypM3Lf5MF4dk90ljWKQMjiPseT7BAkXhbHvvLRikAGFdIVcipLq
         wsUWxxA9fWGA8gXF47WHke2pk99d/ygT6WmPJ5v33LkIQFctHHMvy4PNF2zaq1470P1w
         OJGHh0TA/hr+Dq6Qz+RhyxtCgu7xfgiHrTwxjVZDIwEirqNH1/b6WU1RsehssJ9Bd7lM
         TKi4n8/QpBLmIDBZm6tiuH73shjD8oZtgoeg7YQyun9+moGYg5Iq5vqlUPNlQ/iwVhTv
         X+TA==
X-Gm-Message-State: AOAM531VNTDmjCRpaUaKmnF5XPtYVuYU0DmdwQCyeRGa2EZy8FzfbdUp
	N8O0LreInslC5We5aozDMYNxgA==
X-Google-Smtp-Source: ABdhPJyo05E2KIYhoKmw84GdJy6sLE7BtskfNc1RmHI6a9xwH19UwMKZ14aocXnXowgaAq9r9f4g5A==
X-Received: by 2002:a5d:698f:: with SMTP id g15mr55653857wru.316.1620972986729;
        Thu, 13 May 2021 23:16:26 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:87b3:98a4:71f:63a5? ([2001:8b0:aba:5f3c:87b3:98a4:71f:63a5])
        by smtp.gmail.com with ESMTPSA id k11sm5546180wrm.62.2021.05.13.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 23:16:26 -0700 (PDT)
Message-ID: <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "Yu, Mingli" <mingli.yu@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 14 May 2021 07:16:13 +0100
In-Reply-To: <20210514060443.33335-1-mingli.yu@windriver.com>
References: <20210514060443.33335-1-mingli.yu@windriver.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2021-05-14 at 14:04 +0800, Yu, Mingli wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> Make sure the uri added as expected in some scenarioes such as
> with below setting:
> 
> PREMIRRORS_append = ".*://.*/.* git:///net/SharedImage/downloads/git2/MIRRORNAME;protocol=file"
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  lib/bb/fetch2/__init__.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cf0201c4..6701654b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>      uri_replace_decoded = list(decodeurl(uri_replace))
>      logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
>      result_decoded = ['', '', '', '', '', {}]
> +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
> +        uri_find_decoded[0] = uri_replace_decoded[0]
>      for loc, i in enumerate(uri_find_decoded):
>          result_decoded[loc] = uri_decoded[loc]
>          regexp = i

I've not thought too much about the fix itself but for these kinds of changes
we do ask that the tests be updated too in lib/bb/tests/ (run with bitbake-selftest).

Cheers,

Richard

