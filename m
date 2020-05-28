Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
 by mx.groups.io with SMTP id smtpd.web11.21208.1590697666921757244
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 13:27:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ahHkkusE;
 spf=pass (domain: gmail.com, ip: 209.85.208.65, mailfrom: jacob.kroon@gmail.com)
Received: by mail-ed1-f65.google.com with SMTP id e10so1170227edq.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DgpQ77CftwGX7M6Gvm/7JOJmUGJlh9W69fKYcgS4jpY=;
        b=ahHkkusE25X9Efz3aoixByXpydF0raNIcfDztGAwqBZamNY66UtN9flk/wp2ASztbV
         dyETTOCKovyNA0Tl4lT2JZr/y5b3/qTwvHJBOVDg/FG4oszUq2+WsqTMPaL0X81DwhfU
         Kf+H2O16UEMU8m6o3bVPe7hX7LyQqkDMnRQ7ZQOrYu9v8kQeJ+HQbN37jo5W9LcMQf5r
         63p9jHyQogY58Jeqjy4Nxe45oqpOoyo9ueRFe7/6Z1iAhTGVF/tt+gd2dovh0lR9WzDr
         9PX37iUoX6UuJKBuP99mIamfpv7JfwjIcxEWnuBvxJju4RFPC1VXlg0cvbbbeEgupuVm
         UJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DgpQ77CftwGX7M6Gvm/7JOJmUGJlh9W69fKYcgS4jpY=;
        b=Qg8EEfaRyKBafVWp7QgkWQ8s1/M2dD0Vd0/lR8Md3lcX7M90YgLk827VDfQPRRwJ+B
         Rg6YesPUily0q/Eud85/YSlegfuaYVLD5KcVcVq5Oga10hKYkLLHdoCC2R7q4CO50L0n
         jKARBq7C0ln1X2g/F7rS2Fjp43rKPJxMt2IGF3uq88ldDBn9zX1dc5iMNOr3OnahlBwe
         RchuF5P0bph2Yv/SAicwnUVMrr5KG+ptqNJnONa8VT54OL779RGhecRSEhRu3HNU0a2f
         ODqnm9AVhsr0p3IOOqLHDFR56Ja4PnqophHOdQ6A51xQq/twkbCiWYkmmgI78ot+VyBX
         PVJA==
X-Gm-Message-State: AOAM530C507kueIiMOghRNf0YVU7gCPplukrNBYfvWoJvmzVZiGJGQNp
	v9DVzFV2DwjvNyN3LjS3FTF1ELnA
X-Google-Smtp-Source: ABdhPJwa0QPPwO6shED8Z1kS3XM+eSd8MwLUADTEP+xMsiq7nbywgcnSjxZ4kml6sQSsl19KKJbPtA==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr3713977eds.248.1590697664953;
        Thu, 28 May 2020 13:27:44 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id n6sm1388221edv.24.2020.05.28.13.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 13:27:44 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH] doc: More explanation to tasks that recursively depend on themselves
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20200528064115.35703-1-jacob.kroon@gmail.com>
 <bc07f11a32eb98bfac79aa67bcc838cd1271bb4d.camel@linuxfoundation.org>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <0a785142-e8b4-fd94-f0ca-5598295121a2@gmail.com>
Date: Thu, 28 May 2020 22:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <bc07f11a32eb98bfac79aa67bcc838cd1271bb4d.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 5/28/20 3:46 PM, Richard Purdie wrote:
> On Thu, 2020-05-28 at 08:41 +0200, Jacob Kroon wrote:
>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>> ---
>>   .../bitbake-user-manual-metadata.xml               | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>> index 95a8b95b..069a0ec8 100644
>> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
>> @@ -2565,15 +2565,17 @@
>>               </para>
>>   
>>               <para>
>> -                You might want to not only have BitBake look for
>> -                dependencies of those tasks, but also have BitBake look
>> -                for build-time and runtime dependencies of the dependent
>> -                tasks as well.
>> -                If that is the case, you need to reference the task name
>> -                itself in the task list:
>> +                BitBake allows a task to recursively depend on itself by
>> +                referencing itself in the task list:
>>                   <literallayout class='monospaced'>
>>        do_a[recrdeptask] = "do_a do_b"
>>                   </literallayout>
>> +                In the same way as before, this means that the <filename>do_a</filename>
>> +                and <filename>do_b</filename> tasks of the current recipe and all
>> +                recipes reachable (by way of dependencies) from the recipe
>> +                must run before the <filename>do_a</filename> task can run. In this
>> +                case BitBake will ignore the current recipe's <filename>do_a</filename>
>> +                task circular dependency on itself.
>>               </para>
>>           </section>
> 
> I'm not sure I 100% agree with the change. I think the original first
> paragraph is clearer but it is good to add something about breaking the
> circular dependency where necessary.
> 

I've read the original text several times, and I must disagree with you. 
I think its easy to misinterpret "dependencies of those tasks" as 
meaning "the tasks that the right-hand-side listed tasks depend on".

I think it would be easier to understand if we just wrote something like

"It is allowed for a task to recursively depend on itself by including 
itself in the list of tasks. In this case BitBake will ignore the 
current recipe's circular task dependency on itself."

What do you think ?

Jacob
