Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321DFC48BCF
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:41 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web12.8184.1649749883868301079
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 00:51:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OquEKvoP;
 spf=pass (domain: gmail.com, ip: 209.85.208.177,
 mailfrom: ptsneves@gmail.com)
Received: by mail-lj1-f177.google.com with SMTP id h11so23047405ljb.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 00:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=08cF5RCCFEfd1/bBnvdv+M+DkkXkPmGe7NmbJBM2oG4=;
        b=OquEKvoPWJKxIPA2rlj279rV0vvPZpbBIA+iGcvfo5YlHRlL9/QoWrCfir3nPCCcYs
         ZucHPzeWXqwCvh8zCiV1iqSftOM6a1bjgWzxpKv4mYpLgthSoC6BYqQJH/cWZt/hzGqk
         pO8t661kVXM5TSzxL7hGSfzbPAAaJyV5WQYZlpP6+l+pGKr8kDvQFdYFbg1K2nXe4PQG
         jx8GtqG+eIIhVvsenHM1MQa7ZaO/Kq6IKZXyVslDDn4q0OTs73YXMYjnzoUk+2KrothH
         cFmk3vWochyUIthNRnV+mw+eh78LgeqrSIX+jFKl49IDRULXdsJwGhTe4heljDhkhYWZ
         7vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=08cF5RCCFEfd1/bBnvdv+M+DkkXkPmGe7NmbJBM2oG4=;
        b=j968KVOKDhtCZj7whLWU4Fygid93eSfDlqg/MUbY7edQ54Ebm6ON70Gj1pZVI7BFhp
         g8oMVitE4R1SfVEeP/7Zn9lfuY5xedUuYbzioA79Do7q54nEm80AOLC/dcDJBdX63dm5
         6tNcBwxdSiUAqxA9rxVjIT5bwNMIUAJoUqdPs5YmPliF1uXBVAF1ijwfM1nNQr4FI0uH
         1rKwdlc3R3JH4NA8Y1Levi4/GZOZdMTLCjpu04AwAqblftBlSET9ZlcxowF/uCHF6UOL
         PBQ+o8Ci/mVsnpOVO+9ntlLMjC3rT2JWHYQDi2QpNn5+LsQCpAaUokKTU74tiyrsvfPW
         nBDQ==
X-Gm-Message-State: AOAM530ywYIKQuHrqkKNmD3P5Fp1PRlRn+zvoLjyUtAFXKmF031+tD59
	R2l8UcuEdQPzW348DxZV1A==
X-Google-Smtp-Source: 
 ABdhPJw/dwnuImddVhoD3AKByoAw80BmHBjjA+EeMzobf3nII2Xf0f08PA/cBqRSGU0HUM362Qp75Q==
X-Received: by 2002:a05:651c:a12:b0:24b:1726:9b49 with SMTP id
 k18-20020a05651c0a1200b0024b17269b49mr22934788ljq.497.1649749882028;
        Tue, 12 Apr 2022 00:51:22 -0700 (PDT)
Received: from [192.168.0.88] (77-92-34-4.cable-modem.tkk.net.pl.
 [77.92.34.4])
        by smtp.gmail.com with ESMTPSA id
 c3-20020a056512104300b0044a3582c9ecsm3548451lfb.219.2022.04.12.00.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:51:21 -0700 (PDT)
Message-ID: <4044fd64-fe74-6ac2-7747-e8351a766258@gmail.com>
Date: Tue, 12 Apr 2022 09:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220206134507.123558-1-ptsneves@gmail.com>
 <16D17908BC3DCB81.25014@lists.openembedded.org>
 <2c7698c9a48dcca849b964b5cd5076c12f5168be.camel@linuxfoundation.org>
 <957f9816-d2d8-b43e-b77e-51a64b9d984a@gmail.com>
 <54bf9bc2753e4b91adfe1efd2c5aeec382792dfa.camel@linuxfoundation.org>
From: Paulo Neves <ptsneves@gmail.com>
In-Reply-To: 
 <54bf9bc2753e4b91adfe1efd2c5aeec382792dfa.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Apr 2022 16:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13604

Thanks. I see that it is [1]. I would not have come up with the regex 
fix, so your patch looks much better than mine. Still it looks like the 
whole logic should rely on the url being passed around in encoded form, 
and be decoded only at usage time. Is this what you mean by the code 
refactor?

Paulo Neves


[1] 
https://git.yoctoproject.org/poky/commit/?h=master-next&id=450878eb43f378431066d9e9fd6ae2ce5cc70565

On 4/11/22 17:56, Richard Purdie wrote:
> On Mon, 2022-04-11 at 17:23 +0200, Paulo Neves wrote:
>> Hey Richard,
>>
>> Thanks for the ping. I will try to have a look at it this week. Sorry I
>> got a bit lost with private stuff and forgot about it :(
> I've just sent a different patch which I think should fix the issue. I'll run it
> through testing and may be able to merge my bitbake change with your test for
> OE-Core. Changes are in master-next.
>
> Cheers,
>
> Richard
>


