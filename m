Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
 by mx.groups.io with SMTP id smtpd.web12.10730.1591795633755332465
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2020 06:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=JAfrRKV2;
 spf=pass (domain: gmail.com, ip: 209.85.210.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-pf1-f196.google.com with SMTP id h185so1115618pfg.2;
        Wed, 10 Jun 2020 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YjytT0Te2k2OpRIrHSwDRdKwTghlwvKG/SZvu7frn4o=;
        b=JAfrRKV2dc/JsviCulNYhTe5ixP8sOdKOqLA0Sam0aKlNZ7fsN5kDIO3QQVFu07IwV
         4Ns5aDMYlBr/yw9xmDH5cS+6cTX3d3VjDUXJL6kec10UzdcpQQASBxi+/eVi+mqUgoFe
         u8L/TtXGzD16EzL13VJ4tykUOe/uCy/RQkOshSh4bgaXtIT47iY3shta9EwWWtLpZ9cL
         N0yhJsn2IkIjzGIm3K5e+jmWAV1uzpAC++TARGjsezYWy4sUr5B68Gp/SeWHFlnEBMeQ
         l6nW0AFlEpup0f3FA8mUjKwLrqqDvQkFBqxo54Cgme7/JRDUF9rRBJESkbUxRv+IJO5t
         mfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YjytT0Te2k2OpRIrHSwDRdKwTghlwvKG/SZvu7frn4o=;
        b=ISLr7eTmK06bcyhoL1yzh4+r+qiv3eTkqtvHUFfx7+4BzVLkT8JLG5DJztz2kLAS+l
         FxTnwx+65i5Lddc4yOoikgExcunnMwm2Cib3kJLDHopuqpM30HzBZIRp58hWBkwoVdTJ
         TacnVX7ZHHfY6N/+wtS4jx2ollUmm7ZiTDNL0O4N7N7NVmtyEXcnHdM/H/JCwcvwuGKX
         fNOaAJ+vuiBJQU9P0uaEnvY6HoeyOVhBQ2tvd08aqETR4cHNkLX6P/2AGiqpdtpJvZXs
         bozCp/Ykjgrt4R6QgR0sEOjCY5Bc+zmkJ9W59Ci0MCmCMQC0Kb6snl/qXMmvB4HVN+6O
         NBzw==
X-Gm-Message-State: AOAM530iCyVUqAddj0wexZbrAN7WItEvwDMZyeKAG0jIkudNWXpAGGDY
	RAB6xJPVfOhKkJyR0DHqVI0bmpgn
X-Google-Smtp-Source: ABdhPJxwcabLE9JWyp6jkuZubiiW1hHE00k3ZJYe8Q/Me1uArgmrrboMoMB7IO9Dt08Nwcsb0Di0Mg==
X-Received: by 2002:a05:6a00:1589:: with SMTP id u9mr2821652pfk.201.1591795632767;
        Wed, 10 Jun 2020 06:27:12 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from ?IPv6:2605:a601:ac3d:c100:1c01:47eb:7ccc:e4f? ([2605:a601:ac3d:c100:1c01:47eb:7ccc:e4f])
        by smtp.gmail.com with ESMTPSA id h3sm11377pgd.0.2020.06.10.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:27:11 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 0/3] Include mcdepends in signature generation
To: Denys Dmytriyenko <denis@denix.org>
Cc: bitbake-devel@lists.openembedded.org,
 openembedded-core@lists.openembedded.org
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
 <20200605235435.GR17660@denix.org>
Message-ID: <bcf48cde-afc0-d999-0aef-cfc95a337019@gmail.com>
Date: Wed, 10 Jun 2020 08:27:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605235435.GR17660@denix.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US


On 6/5/20 6:54 PM, Denys Dmytriyenko wrote:
> Joshua,
>
> I see you've been actively working recently on multiconfig-related fixes in
> bitbake, thanks! While at it, would you also be able to take a look at
> multiconfig-aware RDEPENDS implementation, as discussed here[1]? Thanks!
>
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/74485221

I've though about this a little bit, but I'm not exactly sure what it 
would entail.


It might help if there was a concrete example of what you are trying to do?


>
>
> On Fri, Jun 05, 2020 at 01:17:51PM -0500, Joshua Watt wrote:
>> Updates signature generation so that mcdepends are included. Previously,
>> they were not which meant that if recipe A mcdepends on recipe B, and
>> recipe B changed, it would not automatically cause recipe A to also
>> rebuild.
>>
>> In order for signature generation classes to correctly handle mcdepends,
>> they need access to all the data caches, so all are passed instead of
>> just the one for the recipe in question.
>>
>> This breaks the bitbake siggen API and makes it incompatible with
>> previous signature generators, hence the cross-posting between bitbake
>> and oe-core.
>>
>> Joshua Watt (3):
>>    bitbake: siggen: Pass all data caches to hash functions
>>    bitbake: tests: Add mcdepends test
>>    sstatesig: Account for all dataCaches being passed
>>
>>   bitbake/lib/bb/runqueue.py                    |  6 +-
>>   bitbake/lib/bb/siggen.py                      | 32 ++++----
>>   .../lib/bb/tests/runqueue-tests/recipes/f1.bb |  1 +
>>   bitbake/lib/bb/tests/runqueue.py              | 30 ++++++++
>>   meta/lib/oe/sstatesig.py                      | 77 ++++++++++---------
>>   5 files changed, 89 insertions(+), 57 deletions(-)
>>   create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
>>
>> -- 
>> 2.26.2
>>
>> 
