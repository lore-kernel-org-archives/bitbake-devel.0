Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB209C43334
	for <webhook@archiver.kernel.org>; Tue, 14 Jun 2022 07:46:43 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web09.3456.1655192795789529337
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 00:46:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=o1PRranz;
 spf=pass (domain: gmail.com, ip: 209.85.208.180,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id e4so8795172ljl.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vhc6VoS3m0kHmfNNbrXziX8Z/irz52O7b9bKKgUcetA=;
        b=o1PRranzz0mzhNt60pIH+l0+PYtcKlzjUGvx+ezVvMRZlpyz6Pi9e8lWSgqp5mAiUl
         P45sef/Cp31FMp5ZiGFD9OVU7cuEAsvdtp8zb2ElIlfSH3nGvIhTOFf5kyeEn0fvdcKZ
         CTqoiGR6OkhPHHEJ84i4NZJOG9J3y4l/faCc79nDH5fSswIw6iJjxHJ4fvzHuovOolFa
         NtAWcKcr1wVUwkXIn0Qi54rGue2H/2pxVL8S6Evd9nmtEWttU5psILpNDbJ/hhJKMTo9
         6uboDnSFJ+/F5px8vOEH9YRShbgbX9or8Q57JHXnxpDt02v2Xj6XpFI8nqxrsscl6VfD
         gNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vhc6VoS3m0kHmfNNbrXziX8Z/irz52O7b9bKKgUcetA=;
        b=0fMdEJXJO7F7vug9qAsqCW3CMVbITVL25NBvr5jVXAUaJ2WeYnlw9EsWrsJDQA2AZS
         wKMgG+txXvoofs2aT8/BGV8OjEHrEGb/OiDYIK8Dooed9FoVcn/f3BpfAWRsif6YW90L
         KqwxL06bWV/JLmEpOi5MlGBHXZj+vB3bWjWzq6lgNxqMNITgwwwRzqtma4L4GoW/DPyg
         KoMj7FbUQc0xsDSzlUrwupfcwT6xiYJH3SCW5kZ/nejnLoMiR00PtgSJQ6tQq3NwMmdt
         tU0VV6QWMScCvV47MwAUVybfjCFDYQNADH8L5GAZajPmZDtoLiVCGTf67snap4ZXBXfN
         dChA==
X-Gm-Message-State: AJIora9X0EQoFUhiZTMmVrMCjOGiybzxuVoWxUZLUYGbDrHka//SrmS4
	YLUmWVy9Vgqhx3vZJYaKVG8=
X-Google-Smtp-Source: 
 AGRyM1vzEfeQBpDHKxW0M1s+N3mZu/m02ZNhK96dqWNpVvALlAkGJOuK0JlhwvGp+gz5Iy0y/KJZbw==
X-Received: by 2002:a2e:b0dc:0:b0:255:a099:37f5 with SMTP id
 g28-20020a2eb0dc000000b00255a09937f5mr1842947ljl.77.1655192793836;
        Tue, 14 Jun 2022 00:46:33 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 u20-20020ac25194000000b00478b95dabb3sm1288533lfi.117.2022.06.14.00.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 00:46:33 -0700 (PDT)
Message-ID: <7658eb73-46d9-6c6e-2969-a8862b37d86d@gmail.com>
Date: Tue, 14 Jun 2022 09:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
References: <20220610190845.181330-1-jacob.kroon@gmail.com>
 <3f8312432bfa45e7a369e5c5a793569e@axis.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <3f8312432bfa45e7a369e5c5a793569e@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Jun 2022 07:46:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13759

Hi Peter,

Thanks for the comments, I don't claim to be a data_smart.py expert so 
bear with me below:

On 6/13/22 18:57, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-
>> devel@lists.openembedded.org> On Behalf Of Jacob Kroon
>> Sent: den 10 juni 2022 21:09
>> To: bitbake-devel@lists.openembedded.org
>> Cc: docs@lists.yoctoproject.org
>> Subject: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
>> description of the ??= operator
>>
>> Stating that the assignment is done at the end of parsing is misleading.
>> The weak default value is the value which a variable will expand to if no
>> value
>> has been assigned to it using any of the assignment operators.
>>
>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>> ---
>>
>> Changes in v3:
>> * Update commit message
>> * Change "... via one of ..." to "... via any of ..."
>>
>> Changes in v2:
>> * Add comment to line with immediate variable expansion
>>
>>   .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>>   1 file changed, 15 insertions(+), 16 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index af4b1358..45355b6c 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is
>> set to "aval".
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
>> +will expand to if no value has been assigned to it via any of the other
>> +assignment operators. Here is an example::
>> +
>> +   W ??= "x"
>> +   A := "${W}" # Immediate variable expansion
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
> 
> I think the new description is missing some of the information of the
> original description, e.g., "when multiple "??=" assignments exist, the
> last one is used". So, e.g.:
> 
> W ??= "x"
> W ??= "y"
> 
> gives
> 
> W = "y"
> 

I think saying

"when multiple "??=" assignments exist, the last one is used"

is too vague because it depends on when and how you reference the 
variable. It is not always the "last one" that ends up "being used".

How about something like:

"The ??= assignment operator takes effect immediately, overriding any 
previously defined weak default value"

?

> Another interesting case that is easy to get wrong is:
> 
> W ??= "x"
> W += "y"
> 
> that gives
> 
> W = " y"
> 	

Given the definition of the weak default value and the fact that the += 
operator does not involve expanding the LHS before appending, this is 
the result I would expect. Should we add an example to the docs ?

> and which should be compared to
> 
> W ??= "x"
> W:append = " y"
> 
> that gives
> 
> W = "x y"
> 

The docs states overrides are applied "at variable expansion time". But 
if the new definition of a weak default value that I am proposing is 
true, the variable content is expanded first, then the overrides are 
applied, in order to match the result above. But is that true ? I'm not 
that acquainted with data_smart.py to have the confidence in saying so.

Richard or any other data_smart.py expert, can you shed some light on 
all of this ?

Jacob

