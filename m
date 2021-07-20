Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web10.8916.1626793432375074709
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jul 2021 08:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=TcrxcAtY;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so2173342otu.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jul 2021 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=TA3XpOBuTCwX1SkFE3nyc6hf9G0ijWNHbZ91w97uQgo=;
        b=TcrxcAtYZK8JpHZQtfzvvTeg5eExQgQnu3PREid9CLrl/Sz74sPw39Hu0/l2C7jOZA
         XYywhKwuF56KOcoWaANY4i56aj410MOiXjrc19c2PktmKRF719zP6JOWP8H8hbqsanbS
         6NV5V1sqbVE00Ckv82DirSjc8VyzWfrM4OzlGfnCIug2rNQqVB1wPfbHA0cQx8ip9pGK
         uF4VQaSObYP5PbVIDCOeWLneYXpGlyorgskeCvOfMMfIcq5DWsoLUg1hWCLZ3nRHCK0O
         Rxrye+fNnwAzE3Q24ya7BcTSZXkvJLRuzeSClfXPXVgXlXBmgyPO2+wSPQGJQ0tDwRWc
         uiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TA3XpOBuTCwX1SkFE3nyc6hf9G0ijWNHbZ91w97uQgo=;
        b=dxoccHIxTdcSpYIb7H4LArIKSc9h+fSrRLXy0qUPo/ZddEppy30fw3dBjcG56APkJo
         Jwk8QYgUD37r3ktynYlwlRh59gd3XrKV5fTuW6uvOXZ+CZxwEM3Q/Ownj+fdWIZ2d+3T
         LMBuWOjYe6tIlqBSZbvMCfzrPq2RrD6vNTxmlG06fokBPlvUh0KSXN6t1zc7GMCvCb4k
         lyxpcYzV1+Kt9tIY+IabylOCFdfcCNGbag6YCGjkAV99QinlGWD+1X7giKJ7b2aZNWC+
         JnS7aIhrRrXDvq3CYtem4QVFmWyb6QXrneIJGIQ5t5MDvP8LgmTkeacEfs7STPTdOjUK
         xXVA==
X-Gm-Message-State: AOAM530WEto9P0Wn/EUHGeUQINIBZHu/xK/sDDy+Od9KBhR9xNZpbzmU
	+UcEvy0JWpXKxcPGIA3sNIbtgFs7LeF81g==
X-Google-Smtp-Source: ABdhPJxKVmhpuowFpIVEwODzIU/PMyA8jdazIDV1Nnqa/VnIc28AlMWbF4Bk3a91RVuufIld7HEntg==
X-Received: by 2002:a9d:4112:: with SMTP id o18mr23062183ote.128.1626793431468;
        Tue, 20 Jul 2021 08:03:51 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:e3e8:d9:3a56:e27d? ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id x38sm1677659ott.42.2021.07.20.08.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 08:03:51 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel][PATCH v3] bitbake: Add piping compression library
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210617193809.33714-1-JPEWhacker@gmail.com>
 <20210714150157.33191-1-JPEWhacker@gmail.com>
 <b4dffb095fd69a67cf4f1e9386e013fb912f0fcd.camel@linuxfoundation.org>
Message-ID: <4e1c3d59-b77f-5811-e90f-569a094e394a@gmail.com>
Date: Tue, 20 Jul 2021 10:03:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b4dffb095fd69a67cf4f1e9386e013fb912f0fcd.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US


On 7/20/21 3:45 AM, Richard Purdie wrote:
> On Wed, 2021-07-14 at 10:01 -0500, Joshua Watt wrote:
>> Adds a library that implements file-like objects (similar to
>> gzip.GzipFile) that can stream to arbitrary compression programs. This
>> is utilized to implement a LZ4 and zstd compression API.
>>
>> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
>> ---
>> V2: Now with tests!
>> V3: Added compression level for zstd
>>      Tests are skipped if command line programs are missing, which should
>>      prevent needing to update bitbake and oe-core in lock-step.
>>      
>>
>>
>>
>>
>>
>>
>>
>>
>>   bitbake/bin/bitbake-selftest        |   1 +
>>   bitbake/lib/bb/_pipecompress.py     | 194 ++++++++++++++++++++++++++++
>>   bitbake/lib/bb/lz4.py               |  17 +++
>>   bitbake/lib/bb/tests/compression.py |  98 ++++++++++++++
>>   bitbake/lib/bb/zstd.py              |  28 ++++
>>   5 files changed, 338 insertions(+)
>>   create mode 100644 bitbake/lib/bb/_pipecompress.py
>>   create mode 100644 bitbake/lib/bb/lz4.py
>>   create mode 100644 bitbake/lib/bb/tests/compression.py
>>   create mode 100644 bitbake/lib/bb/zstd.py
>>
>> diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
>> index 757441c754..63762fe794 100755
>> --- a/bitbake/bin/bitbake-selftest
>> +++ b/bitbake/bin/bitbake-selftest
>> @@ -29,6 +29,7 @@ tests = ["bb.tests.codeparser",
>>            "bb.tests.runqueue",
>>            "bb.tests.siggen",
>>            "bb.tests.utils",
>> +         "bb.tests.compression",
>>            "hashserv.tests",
>>            "layerindexlib.tests.layerindexobj",
>>            "layerindexlib.tests.restapi",
>> diff --git a/bitbake/lib/bb/_pipecompress.py b/bitbake/lib/bb/_pipecompress.py
>> new file mode 100644
>> index 0000000000..4b9f662143
>> --- /dev/null
>> +++ b/bitbake/lib/bb/_pipecompress.py
>> @@ -0,0 +1,194 @@
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# Helper library to implement streaming compression and decompression using an
>> +# external process
>> +#
>> +# This library should be used directly by end users; a wrapper library for the
>> +# specific compression tool should be created
> Should or should not? :)
>
> I'm fine with adding this but I think it should be under a bb.compress. namespace
> rather than directly in bb. I tweaked that patch in master-next to test that.

That's fine with me. I would hope that having this in the code will 
lower the barrier to entry and it start getting used more frequently... 
I do have plans to use it once it's available.

>
> Cheers,
>
> Richard
>
>
