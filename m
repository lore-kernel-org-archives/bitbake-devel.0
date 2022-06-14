Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CE3C43334
	for <webhook@archiver.kernel.org>; Tue, 14 Jun 2022 09:35:34 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web08.4217.1655199330149641173
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 02:35:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=JYyEbpOI;
 spf=pass (domain: gmail.com, ip: 209.85.167.54,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f54.google.com with SMTP id a15so12958009lfb.9
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Jun 2022 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i2VZjLpab2Vkbm1w4P0OmEuAfDSYRilwLwRkes0I88w=;
        b=JYyEbpOI5IgYuQmlPZlyGUQVwbq11Pa2rlvsEAjWbs7SM3OMx8/bKQ5UQUWnU9iNFc
         cumvIyNGzxif5evFGVF+X1ENWRdudsDR3lYVvvxJ05YJBbFvhhhXNb2Ks4ocUlB2HQd9
         YDTJa4Js0U7I/eCeRaPjqTXEf4785Msi9yhNyfhjcbs+ZYoxNNA83o2qHf7jd7JK09A1
         wwPPu7EQh1bSR77xsULzNcmj6a1se7WYP0L8bmAvVlRVZ+Vd2j55jeWZbdstBsF5suxE
         5nW8llcg4EWRV0PRNHwuWXz1WFprGOtjlkSSoC7qz+5AyZnPOMt6HxFCvy0RYaEQOomc
         seBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i2VZjLpab2Vkbm1w4P0OmEuAfDSYRilwLwRkes0I88w=;
        b=okG8eehQKtzXwebR2VZ+Fi7US2SAf1TYrsCkZf4LRypVzUOyYvAqo3ndQNhFtO0tcV
         5d6AoFASmZQYzHwnSFKe5Du6m31hHL/siYbHHlXLupPwvN1yz9UWQRr/LUFbfrl9tnsY
         D+jgnDOjg0pRFOlXbUAktZVfRiigFPG28ebXP5Nmq+6on0D+dWNWhvmOmMfnSHCuvDod
         qoww2q1JgWOSY+D6KIzWVdvi0KMZ/98opM48K2LKem8crB1yzTF2JwpKmyfppnT2mr7L
         eastzBW/HsnJAjyguvHJjusp3mtGFFqBPIuWazU6vA3yJOotT0hfH8mnI0N8RTndfA+c
         efJQ==
X-Gm-Message-State: AJIora8nhP0MZkkDfo27zZQuZTjxPMGyqiBLfrIruZZWbjhbFizcziJk
	Z5hR4j++VnUV7tqw+9vWHXs=
X-Google-Smtp-Source: 
 AGRyM1s/6wzpaA0O/2Ia6p2N6nvQT9mD0LEW2I+fBAtYv/RM33aFe+FLbmAuGrhtfuwDpUCyHY8gUQ==
X-Received: by 2002:ac2:5f50:0:b0:479:1d15:529f with SMTP id
 16-20020ac25f50000000b004791d15529fmr2426698lfz.643.1655199328226;
        Tue, 14 Jun 2022 02:35:28 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 u20-20020ac25194000000b00478b95dabb3sm1321951lfi.117.2022.06.14.02.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 02:35:27 -0700 (PDT)
Message-ID: <7a239bf7-c72e-2ed3-ea7d-3c9f46012baa@gmail.com>
Date: Tue, 14 Jun 2022 11:35:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Cc: "docs@lists.yoctoproject.org" <docs@lists.yoctoproject.org>
References: <20220610190845.181330-1-jacob.kroon@gmail.com>
 <3f8312432bfa45e7a369e5c5a793569e@axis.com>
 <7658eb73-46d9-6c6e-2969-a8862b37d86d@gmail.com>
 <de66a6b77cfd93e9bda73cca63b5304313cd2f72.camel@linuxfoundation.org>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: 
 <de66a6b77cfd93e9bda73cca63b5304313cd2f72.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Jun 2022 09:35:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13761

Hi Richard,

On 6/14/22 09:57, Richard Purdie wrote:
> On Tue, 2022-06-14 at 09:46 +0200, Jacob Kroon wrote:
>> Hi Peter,
>>
>> Thanks for the comments, I don't claim to be a data_smart.py expert so
>> bear with me below:
>>
>> On 6/13/22 18:57, Peter Kjellerstedt wrote:
>>>> -----Original Message-----
>>>> From: bitbake-devel@lists.openembedded.org <bitbake-
>>>> devel@lists.openembedded.org> On Behalf Of Jacob Kroon
>>>> Sent: den 10 juni 2022 21:09
>>>> To: bitbake-devel@lists.openembedded.org
>>>> Cc: docs@lists.yoctoproject.org
>>>> Subject: [bitbake-devel] [PATCH v3] bitbake-user-manual: Correct
>>>> description of the ??= operator
>>>>
>>>> Stating that the assignment is done at the end of parsing is misleading.
>>>> The weak default value is the value which a variable will expand to if no
>>>> value
>>>> has been assigned to it using any of the assignment operators.
>>>>
>>>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> * Update commit message
>>>> * Change "... via one of ..." to "... via any of ..."
>>>>
>>>> Changes in v2:
>>>> * Add comment to line with immediate variable expansion
>>>>
>>>>    .../bitbake-user-manual-metadata.rst          | 31 +++++++++----------
>>>>    1 file changed, 15 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> index af4b1358..45355b6c 100644
>>>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>>>> @@ -195,22 +195,21 @@ value. However, if ``A`` is not set, the variable is
>>>> set to "aval".
>>>>    Setting a weak default value (??=)
>>>>    ----------------------------------
>>>>
>>>> -It is possible to use a "weaker" assignment than in the previous section
>>>> -by using the "??=" operator. This assignment behaves identical to "?="
>>>> -except that the assignment is made at the end of the parsing process
>>>> -rather than immediately. Consequently, when multiple "??=" assignments
>>>> -exist, the last one is used. Also, any "=" or "?=" assignment will
>>>> -override the value set with "??=". Here is an example::
>>>> -
>>>> -   A ??= "somevalue"
>>>> -   A ??= "someothervalue"
>>>> -
>>>> -If ``A`` is set before the above statements are
>>>> -parsed, the variable retains its value. If ``A`` is not set, the
>>>> -variable is set to "someothervalue".
>>>> -
>>>> -Again, this assignment is a "lazy" or "weak" assignment because it does
>>>> -not occur until the end of the parsing process.
>>>> +The weak default value of a variable is the value which that variable
>>>> +will expand to if no value has been assigned to it via any of the other
>>>> +assignment operators. Here is an example::
>>>> +
>>>> +   W ??= "x"
>>>> +   A := "${W}" # Immediate variable expansion
>>>> +   W ??= "y"
>>>> +   B = "${W}"
>>>> +   W ?= "z"
>>>> +
>>>> +After parsing we will have::
>>>> +
>>>> +   A = "x"
>>>> +   B = "z"
>>>> +   W = "z"
>>>>
>>>>    Immediate variable expansion (:=)
>>>>    ---------------------------------
>>>
>>> I think the new description is missing some of the information of the
>>> original description, e.g., "when multiple "??=" assignments exist, the
>>> last one is used". So, e.g.:
>>>
>>> W ??= "x"
>>> W ??= "y"
>>>
>>> gives
>>>
>>> W = "y"
>>>
>>
>> I think saying
>>
>> "when multiple "??=" assignments exist, the last one is used"
>>
>> is too vague because it depends on when and how you reference the
>> variable. It is not always the "last one" that ends up "being used".
> 
> The last value set during parsing order is used as the weak default
> value.
> 
>> How about something like:
>>
>> "The ??= assignment operator takes effect immediately, overriding any
>> previously defined weak default value"
> 
> I do think you need to spell this out with an example as it isn't what
> people expect.
> 
>>> Another interesting case that is easy to get wrong is:
>>>
>>> W ??= "x"
>>> W += "y"
>>>
>>> that gives
>>>
>>> W = " y"
>>> 	
>>
>> Given the definition of the weak default value and the fact that the +=
>> operator does not involve expanding the LHS before appending, this is
>> the result I would expect. Should we add an example to the docs ?
> 
> Yes, definitely. Whilst it makes sense, people often don't expect it.
> 
>>> and which should be compared to
>>>
>>> W ??= "x"
>>> W:append = " y"
>>>
>>> that gives
>>>
>>> W = "x y"
>>>
>>
>> The docs states overrides are applied "at variable expansion time". But
>> if the new definition of a weak default value that I am proposing is
>> true, the variable content is expanded first, then the overrides are
>> applied, in order to match the result above. But is that true ? I'm not
>> that acquainted with data_smart.py to have the confidence in saying so.
>>
>> Richard or any other data_smart.py expert, can you shed some light on
>> all of this ?
> 
> ??= is the value given to a variable if nothing else sets it.
> 

The problem I have with the above formulation is that "value given to a 
variable" does not mean that the variable will be assigned that value, 
which is why I prefer to use "expand to", which makes it clear that 
there is no assignment going on.

> In the above example it is given a weak default value of "x". " y" is
> then appended to the base value which would be "x" since nothing else
> sets it. Again, it does make sense we need to have examples in the
> manual to make it clear.
> 
> Cheers,
> 
> Richard

Jacob

