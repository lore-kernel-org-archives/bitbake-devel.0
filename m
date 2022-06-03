Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0318C43334
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 11:12:06 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.6008.1654254720332722226
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 04:12:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=W/D6wwwz;
 spf=pass (domain: gmail.com, ip: 209.85.167.45,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id y32so12072963lfa.6
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Jun 2022 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hT0ekp/MyHBbrDFOvx2OOii8GqqgnqnK9w4goJO290I=;
        b=W/D6wwwzCXaGZZCXm7HkDxJ2V/d+W1syU0G9eaeVVTHxf2AUQ9761mcKRRB/PoSdiY
         X2CTEFkmZsqQvFFJfgmuURPogm+po4qrDqfnOpa8BXcqSeA3NcPC+oSlj3rBmu2PTl7s
         B7RurpYE3EFZ/h40BAXc0c+T4QHd7mPW3Kin5YizQY+HvtKbWI6WJPM68HSYE4YZfk9K
         MgHFFFT0pg1wjpDxYJ7k/pVvKHnwLiMPoFZ7FhbTtCUSlezjnK5dAnTa3yBcYYcwx35V
         bivMfg2RSP3uuXFO3Sn57c7bZqcI3UyJk2vG8qp6c7y2eJ/YmYTrefKZEggQZIWUSNYU
         4v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hT0ekp/MyHBbrDFOvx2OOii8GqqgnqnK9w4goJO290I=;
        b=1pYQm0WkvLs0Lo68cPVcgMDVYlNIqAczfpFMOfsl8FYGD1kW2xe1YZhh3j8jWY8xx7
         aSV6RXS9B1m3EPtVvblR6criG3OTNEu5CneQ2y0mKw2qPUfCRgkKEtxCYAYxqd0Un86Q
         GICyUhjLYHUIZYjDkEWC60Bhf5vljRep2KeyNc4gMArKyJzdWTD4YV/ulvRLm4IvvlOQ
         vZC8BCXsxM0UiEKNdJygF9L3c7m7acMRae8sbQbYIzcFB2XiKRjgteUZmSjnIzc00PFy
         CIDxCk9x0GsaUBnL+uEIg7NwQdTaHo6gyIXFWA/EV9MUyfe+jwjVh75dE2amY9v0/BtW
         /x5A==
X-Gm-Message-State: AOAM532LqUX9uXaB+6SPR7NsYmXCDto9i4Vc25GuKm+QDyA0cCINKYSp
	o/vrC3RCbseTrAAlpUzEUO8=
X-Google-Smtp-Source: 
 ABdhPJxD8LRjzAmOQjpXoXxf1Iwu9caJJ4mL2H3os+K+VX1H0xA8Y0ble3WaHkr/jV7zzCioujW20w==
X-Received: by 2002:a19:e349:0:b0:479:248:4e7d with SMTP id
 c9-20020a19e349000000b0047902484e7dmr9406151lfk.539.1654254717898;
        Fri, 03 Jun 2022 04:11:57 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 b9-20020a2e8949000000b00255605bc587sm1259578ljk.58.2022.06.03.04.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 04:11:57 -0700 (PDT)
Message-ID: <d7cf43df-e0a4-fa45-b49f-d5df3eb07801@gmail.com>
Date: Fri, 3 Jun 2022 13:11:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: Correct description
 of the ??= operator
Content-Language: en-US
To: pavel@zhukoff.net
Cc: docs@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <20220603094651.22816-1-jacob.kroon@gmail.com>
 <87sfomf3qx.fsf@gentoo.zhukoff.net>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <87sfomf3qx.fsf@gentoo.zhukoff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Jun 2022 11:12:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13730

On 6/3/22 12:16, Pavel Zhukov wrote:
> 
> IMO the example with ":=" should go under "immediately variable expantion" section.
> The change mentions operator which has not been
> described earlier and this may be confusing for the person who reads the
> manual for the first time.
> 

I see you what you mean, but I'd say it is ok to use syntax that has not 
yet been described in examples, otherwise it would be difficult to give 
examples. And I can't move an example that is supposed to demonstrate 
how "??=" works to a completely different operator description. But 
maybe I could add a comment in the example like:

A := "${W}" # Immediate variable expansion

Jacob

> -- Pavel
> 
> "Jacob Kroon" <jacob.kroon@gmail.com> writes:
> 
>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>> ---
>>   .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index af4b1358..1c146f0f 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is set to "aval".
>>   Setting a weak default value (??=)
>>   ----------------------------------
>>   
>> -It is possible to use a "weaker" assignment than in the previous section
>> -by using the "??=" operator. This assignment behaves identical to "?="
>> -except that the assignment is made at the end of the parsing process
>> -rather than immediately. Consequently, when multiple "??=" assignments
>> -exist, the last one is used. Also, any "=" or "?=" assignment will
>> -override the value set with "??=". Here is an example::
>> -
>> -   A ??= "somevalue"
>> -   A ??= "someothervalue"
>> -
>> -If ``A`` is set before the above statements are
>> -parsed, the variable retains its value. If ``A`` is not set, the
>> -variable is set to "someothervalue".
>> -
>> -Again, this assignment is a "lazy" or "weak" assignment because it does
>> -not occur until the end of the parsing process.
>> +The weak default value of a variable is the value which that variable
>> +will expand to if no value has been assigned to it via one of the other
>> +assignment operators. Here is an example::
>> +
>> +   W ??= "x"
>> +   A := "${W}"
>> +   W ??= "y"
>> +   B = "${W}"
>> +   W ?= "z"
>> +
>> +After parsing we will have::
>> +
>> +   A = "x"
>> +   B = "z"
>> +   W = "z"
>>   
>>   Immediate variable expansion (:=)
>>   ---------------------------------
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#13728): https://lists.openembedded.org/g/bitbake-devel/message/13728
>> Mute This Topic: https://lists.openembedded.org/mt/91517826/6390638
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [pavel@zhukoff.net]
>> -=-=-=-=-=-=-=-=-=-=-=-
> 

