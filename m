Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
 by mx.groups.io with SMTP id smtpd.web10.14038.1590677918800586632
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 May 2020 07:58:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=PWYjsK9M;
 spf=pass (domain: gmail.com, ip: 209.85.218.65, mailfrom: jacob.kroon@gmail.com)
Received: by mail-ej1-f65.google.com with SMTP id x1so305068ejd.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 May 2020 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w3+XlZ/mygtHHlE/wuVPjWFIedFCstN9QPLoQe7rDtE=;
        b=PWYjsK9MKxHhY2IbyN2F/ByfGpyMBfx1Xc3lIDF3pHUrEgRRjKETO4LGCkBDUcACfd
         Sxc8/NF/CJOsvbJ3OKfkVl1SBR1gXzD0YedKJazCJ3yhBSVIqzpF3zcl/Efv3MAG1F26
         spGf7Ud4kya45io3Tlsh8gCUm6PURBaMbO6UYAUEChjD3AX3upASS3nf6DfkYbRFfS+O
         aXdaOqYz4EaAHh5KjJTIdTETbjs1U8tzHWmCpj98WyDNNxb/tDxqFUHWiiJEdN2J4VhS
         7rMetkjqLY6ZAhkYEt7VfSvnFO9RM2PSFzDsXiBCpCiTMnlteygS7jahBpjJX302YgOF
         IY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w3+XlZ/mygtHHlE/wuVPjWFIedFCstN9QPLoQe7rDtE=;
        b=opnyAnMzzuEoxWJfy2e2wirm4MwtgoKpDr9rAKUsg2dQ7QNEVu8UvT86sVKznqH+Jf
         VDvXSIH03Y16yjQF64Zb8t46p1iZo5wkNYsdY4fKhALFhTNopOeVsmjjdwrWqPgeohlf
         xi4El7rvmZq0smz5IiyHutCtES3se/S6Btnqp/t6AdTqG8WzukQuFaZM5j4XnDTE4GTQ
         CtrBi8cAQ8XbpI1KjyajxxKSXvkMuYC/Dm/mcsbyrsBUxFgthl+kmvAd2w4FmsaDtt0d
         kLssygfsMkQbtifq1LcEzkM9eZNrX+b4aDPnxLOCX4Vc1n7PN4D+eXlgSOlwSJC6g8CK
         tLEw==
X-Gm-Message-State: AOAM530b1HI5HQag38UCQJiVyXj4TW+BgGUyKudZeGo6fnTwC6M1WDVF
	D/fkveC/TeY5K4+cotLHYAMEiHRZ
X-Google-Smtp-Source: ABdhPJzMuuvwms6no3Z79KiskSReRoMmLI/y6Zy0aF9MXMXypANumXl9vib8hlpETiXUYw30npOhiQ==
X-Received: by 2002:a17:906:1b4a:: with SMTP id p10mr3130986ejg.299.1590677916936;
        Thu, 28 May 2020 07:58:36 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id dt12sm5602294ejb.102.2020.05.28.07.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 07:58:36 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH] doc: More explanation to tasks that recursively depend on themselves
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20200528064115.35703-1-jacob.kroon@gmail.com>
 <bc07f11a32eb98bfac79aa67bcc838cd1271bb4d.camel@linuxfoundation.org>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <67ae474e-11f6-94f7-bba7-0f3622f9a277@gmail.com>
Date: Thu, 28 May 2020 16:58:35 +0200
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

I think the hard part for me as a non-native english speaker was 
identifying what "those tasks" and "dependent tasks" referred to. And I 
tend to dislike the phrase "look for", since BitBake is *adding* 
dependencies, right ?

Let me do another attempt in a v2.

Jacob
