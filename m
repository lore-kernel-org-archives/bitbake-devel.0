Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B794C433EF
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:17:54 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web09.2467.1655284668859039456
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 02:17:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Jme1t6fm;
 spf=pass (domain: gmail.com, ip: 209.85.208.174,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id g2so12544460ljk.5
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jun 2022 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IxKwjp1UepJz7yRlp+T8aDWFGdmfw00khaZ3T75RHts=;
        b=Jme1t6fm+5uxSLCNwCvpjkXZhddEPEmAlRnDwuS61/eM/oPrGb9FiIDPH65CP5933A
         20YYuE2/p7sdydzH7ZwUWxHCS0lqXKVX08h2rEjX2eXB8bWR5LKR+nlpTEy/qsicf86R
         NP4N3YlmKSe62r/C0jJqLsDo1SvzdXrkuUioYhSU+J1X72uFnMAFzIfoGiytKQgYcyQQ
         eoOt8mzEthVJ53JF5OH51OGeld2UwBndFPupg+Fg6hjoCpqHSYgxdPgCeTtgI7NTeabK
         VdGbxOqk4YkrcF0ZsaHNM7A/aIpxaaqymbA0WLTRLGUryBJuFjIA0Ysok/H4/k1bX8ym
         8MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IxKwjp1UepJz7yRlp+T8aDWFGdmfw00khaZ3T75RHts=;
        b=SEpNbXuQRQlxsIoA8ZHqJ4Bs+yxhxp+AQcxHOtyBQK2zfvbtYxfRth9i5ldl6N+pW1
         OJcLuphZW4eCafVBBWJu5XDHJTAtrT18f8ivxLSy0/3vKw8j7tbVuFdfpVK4lhO/EUCi
         /M+EDQt8fNcZERm5Dt2o9vzvTLmgImzRFUrsdOuxYvgyFLT17ohL5jQtTi7RBKZTeyA8
         /suu3aUAonsU5LQ6TKBePudS0l8vjMGaNiITmvj/wb5y8NzHfC03z3ZQWuNTYlYjGnZN
         Xttsfgz++aj4hggHVK4lK0W/H0iJVjZlmgCDjceWMtayD4EEPZjy28U7YT+/AQdEsrsr
         5dxA==
X-Gm-Message-State: AJIora8NFlobvDM1y4ih6wKoIK9iIX3Z/O5c63HVl5N81DrnYJYOzdtO
	N8TppNjI/KedcAtjfEnrhMY=
X-Google-Smtp-Source: 
 AGRyM1sFtUMwt+r34dmDTiIZCcIXCtka4BR8cu8coSbrq+Adi9RiQAnsJaXEtp5dg5fde5dQfsiFJA==
X-Received: by 2002:a2e:a236:0:b0:259:c94:3144 with SMTP id
 i22-20020a2ea236000000b002590c943144mr4523070ljm.466.1655284665279;
        Wed, 15 Jun 2022 02:17:45 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se.
 [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id
 w14-20020a05651234ce00b00477b11144e9sm1727963lfr.66.2022.06.15.02.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:17:44 -0700 (PDT)
Message-ID: <7911fee5-885e-ab51-a9b8-83b6453eb681@gmail.com>
Date: Wed, 15 Jun 2022 11:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [bitbake-devel] [PATCH v4] bitbake-user-manual: Correct
 description of the ??= operator
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220615042424.7606-1-jacob.kroon@gmail.com>
 <d4dd89aa32ad3c7829d8f79e11bd35486397a9c9.camel@linuxfoundation.org>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: 
 <d4dd89aa32ad3c7829d8f79e11bd35486397a9c9.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Jun 2022 09:17:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13764

On 6/15/22 09:23, Richard Purdie wrote:
> On Wed, 2022-06-15 at 06:24 +0200, Jacob Kroon wrote:
>> Stating that the assignment is done at the end of parsing is misleading.
>> The weak default value is the value which a variable will expand to if no value
>> has been assigned to it using any of the assignment operators.
>>
>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>> ---
>>
>> Changes in v4:
>> * Mention that "??=" operator overrides previously defined weak default values
>> * Add examples when appending/prepending, with and without override-style syntax
>>
>> Changes in v3:
>> * Update commit message
>> * Change "... via one of ..." to "... via any of ..."
>>
>> Changes in v2:
>> * Add comment to line with immediate variable expansion
>>
>>   .../bitbake-user-manual-metadata.rst          | 55 +++++++++++++------
>>   1 file changed, 39 insertions(+), 16 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> index af4b1358..3250c205 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
>> @@ -195,22 +195,45 @@ value. However, if ``A`` is not set, the variable is set to "aval".
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
>> +assignment operators. The "??=" operator takes effect immediately, overriding
> 
> Generally looks good but I'd replace "overriding" with "replacing"
> since overriding means something very specific to bitbake!
> 

Agreed, new version on the way.

/Jacob

