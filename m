Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web09.5182.1626770705127017612
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 01:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=iNwhTvq2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id l7so25090215wrv.7
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jul 2021 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=AOEjQ+E9uNNM3kBQaWlGCkXluUzyyUNZfO0FxmMifOc=;
        b=iNwhTvq2Kuvha9VkOT4w6Xjqo8DiJZIXJA8EbM8b+E4LW3t7VC305PMR3+5KPMy8n2
         tKzEWqmLcXnlwHL9qMFEf0igonM+0kJ7W7riD9yNxN2PHnk5dTCEcKxixPSBFfwThOEE
         X8BP7ETwEC83t5oac0ak4tJyHLNCZ8qxaWmmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=AOEjQ+E9uNNM3kBQaWlGCkXluUzyyUNZfO0FxmMifOc=;
        b=KfvFbzCeLJrB/nigoM7cbt06xaJEJXEYCXQ7WyEYjJLWw+lKXeFqlFRmMBMUt0BPGx
         CuL3BMt/kov4jNJEsveifw29HTJv+ZZSizjMLHyoizzXSylQ8Ul9yzx+Ur01H2cpswIe
         AfKfAfjAhKzHBb8TZLBGn57zT/gTbFRZiU7RaD0K0GsWbEkfEdhkEXxrNaDCuLkMX4LK
         JcZ8U0+H+AVc4DKiLifSGYKXy5srGo4uioJhP2i4nNmV4aPaQY5UgJ+/0ewfLzgMcys1
         exxe/0j8O/kjOakxTUvhQw6SqByArSP+ZrEnhcSP6tTM26Fkfp5qNn5OKBvdGEkc/YVz
         mOpQ==
X-Gm-Message-State: AOAM530YOVaOWd1+7lSrKaUKU2qvVU5PNmaE585Q+V+Sh/Jdm7vWkL+S
	ILgCmsPOHPMlZx1Xdp11bZooqgiNGOPg0A==
X-Google-Smtp-Source: ABdhPJygTYd8bcZVZ9/XxKqdI8gQJJbu2NjgGkze1kVOtB5E/9W4avMiu05/qPQS9e+VwST8DxI5Ig==
X-Received: by 2002:adf:f109:: with SMTP id r9mr16008233wro.370.1626770703812;
        Tue, 20 Jul 2021 01:45:03 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:2cd8:e78f:29a5:f753? ([2001:8b0:aba:5f3c:2cd8:e78f:29a5:f753])
        by smtp.gmail.com with ESMTPSA id p8sm1831584wmc.24.2021.07.20.01.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 01:45:03 -0700 (PDT)
Message-ID: <b4dffb095fd69a67cf4f1e9386e013fb912f0fcd.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v3] bitbake: Add piping compression library
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Joshua Watt <JPEWhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Tue, 20 Jul 2021 09:45:02 +0100
In-Reply-To: <20210714150157.33191-1-JPEWhacker@gmail.com>
References: <20210617193809.33714-1-JPEWhacker@gmail.com>
	 <20210714150157.33191-1-JPEWhacker@gmail.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2021-07-14 at 10:01 -0500, Joshua Watt wrote:
> Adds a library that implements file-like objects (similar to
> gzip.GzipFile) that can stream to arbitrary compression programs. This
> is utilized to implement a LZ4 and zstd compression API.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
> V2: Now with tests!
> V3: Added compression level for zstd
>     Tests are skipped if command line programs are missing, which should
>     prevent needing to update bitbake and oe-core in lock-step.
>     
> 
> 
> 
> 
> 
> 
> 
> 
>  bitbake/bin/bitbake-selftest        |   1 +
>  bitbake/lib/bb/_pipecompress.py     | 194 ++++++++++++++++++++++++++++
>  bitbake/lib/bb/lz4.py               |  17 +++
>  bitbake/lib/bb/tests/compression.py |  98 ++++++++++++++
>  bitbake/lib/bb/zstd.py              |  28 ++++
>  5 files changed, 338 insertions(+)
>  create mode 100644 bitbake/lib/bb/_pipecompress.py
>  create mode 100644 bitbake/lib/bb/lz4.py
>  create mode 100644 bitbake/lib/bb/tests/compression.py
>  create mode 100644 bitbake/lib/bb/zstd.py
> 
> diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
> index 757441c754..63762fe794 100755
> --- a/bitbake/bin/bitbake-selftest
> +++ b/bitbake/bin/bitbake-selftest
> @@ -29,6 +29,7 @@ tests = ["bb.tests.codeparser",
>           "bb.tests.runqueue",
>           "bb.tests.siggen",
>           "bb.tests.utils",
> +         "bb.tests.compression",
>           "hashserv.tests",
>           "layerindexlib.tests.layerindexobj",
>           "layerindexlib.tests.restapi",
> diff --git a/bitbake/lib/bb/_pipecompress.py b/bitbake/lib/bb/_pipecompress.py
> new file mode 100644
> index 0000000000..4b9f662143
> --- /dev/null
> +++ b/bitbake/lib/bb/_pipecompress.py
> @@ -0,0 +1,194 @@
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Helper library to implement streaming compression and decompression using an
> +# external process
> +#
> +# This library should be used directly by end users; a wrapper library for the
> +# specific compression tool should be created

Should or should not? :)

I'm fine with adding this but I think it should be under a bb.compress. namespace
rather than directly in bb. I tweaked that patch in master-next to test that.

Cheers,

Richard


