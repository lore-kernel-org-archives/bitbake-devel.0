Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
 by mx.groups.io with SMTP id smtpd.web11.4510.1590581286117944579
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 May 2020 05:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=SvKBs/Xa;
 spf=pass (domain: gmail.com, ip: 209.85.208.195, mailfrom: jacob.kroon@gmail.com)
Received: by mail-lj1-f195.google.com with SMTP id q2so28546600ljm.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 27 May 2020 05:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7udSK+gK0dIRIKAV9p80ougKsB2BGZX/ueecC3AEBno=;
        b=SvKBs/XaRkx8KuDMQ5kURf9NZg3X8Bat6ASZ6pP4zEldh90YbPD0b+HIUmKDybhHFL
         RhHNLK4OA1nHuQJ3ryAu8hE/a1CHhMkXQZX079hICgUo36uku+z0zkKcrY4YBPkrElTK
         UYRO4IJoY/JlaxyyJroAWOOgLkurjV7AFwvNC/lCIxmVpnGzAVBWswn72Of28Qy7jcid
         pqdhcy+KWEQCfUir9m/0UADw7+PkeN3fHtODJn6EhWPWYxCmjqHhA/YdyHCAKSdUcwGJ
         YajO7LXtbKvVhdsup+lus+AbafuNTx6OS8HiVvnSYq4EOqFkcSHjqx70OF/ryuZEUljT
         OqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7udSK+gK0dIRIKAV9p80ougKsB2BGZX/ueecC3AEBno=;
        b=XBT3pqgoCfMydb5IaLNLNKtfG9vWeU3T06zWDlrObqP0WV1qSd2IgQ/pHm+9wBVALt
         OJGfd+J69N1z7smsyvb9bQ728nWi0jT5v/rpKHrgzAr8qM4IaPCKaaWSonECNzVp2Eqs
         QNookbg9wqQtlhY6TPbHgJkUuuFzYmt2wdIGWkE4W9eWsVGadKuEtjuq3MOo3cn2ijqC
         n3zYXXhKdeeljCa4+OiOm3Ut/u+DXyckgsap/n/Lhqo7YXM+6iitUfoBgqyfUPOh0vfZ
         /s1HILYxXxnsJ7elLfH69U5LUt5/SaXbAgYrseVFwfh2O3Wncaju1haHE2GYSKPqAojl
         edAw==
X-Gm-Message-State: AOAM531dFlaDvPXDzi6KOa5ldggXDQksvlnMMMVmt7ptIlQ1LvsDwVID
	EQPyUxmyCYrkBukit9fdsVOxVDuD5ac=
X-Google-Smtp-Source: ABdhPJwF2QV6/QUEbWHrTZdptveSbHDzG11hZ23Z2tYjM+D5OAIDGJZqb/5OjEHaNb4wdE9+g3myKA==
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr3141625ljp.368.1590581283694;
        Wed, 27 May 2020 05:08:03 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain ([213.185.29.22])
        by smtp.gmail.com with ESMTPSA id w15sm771278lfl.51.2020.05.27.05.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 05:08:02 -0700 (PDT)
Subject: Re: [bitbake-devel] Question about recursive dependencies
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <73eb04e4-ad0b-3738-fb82-39720a68e26c@gmail.com>
 <924d7c6ed6219405d6ce1c52825f9e636bfd8608.camel@linuxfoundation.org>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <22a7399e-fa94-d072-c61b-58adf9dd9ebb@gmail.com>
Date: Wed, 27 May 2020 14:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <924d7c6ed6219405d6ce1c52825f9e636bfd8608.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 5/27/20 12:01 PM, Richard Purdie wrote:
> On Wed, 2020-05-27 at 09:11 +0200, Jacob Kroon wrote:
>> Hi,
>>
>> After many reading attempts I have to admit I still don't understand the
>> last section of
>>
>> https://www.yoctoproject.org/docs/latest/bitbake-user-manual/bitbake-user-manual.html#recursive-dependencies
>>
>> <quote>
>> You might want to not only have BitBake look for dependencies of those
>> tasks, but also have BitBake look for build-time and runtime
>> dependencies of the dependent tasks as well. If that is the case, you
>> need to reference the task name itself in the task list:
>>
>>        do_a[recrdeptask] = "do_a do_b"
>> </quote>
>>
>> The text before would suggest this means that
>>
>> "do_a" and "do_b" in the current recipe, plus "do_a" and "do_b" in all
>> its build-time/runtime/inter-task dependencies, recursively, must run
>> before the recipe's "do_a" can run. That would mean "do_a" in the
>> current recipe depends on itself. What am I not getting here ?
> 
> It does mean that but bitbake will just skip a task depending on itself
> in this context as that doesn't make any sense.
> 

Thanks for clarifying. But I'm still not understanding the quoted text.. 
Is the intended meaning basically what I wrote above ? Or is the text 
referring to something else ?

Jacob
