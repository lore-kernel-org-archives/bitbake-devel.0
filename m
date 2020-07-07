Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
 by mx.groups.io with SMTP id smtpd.web11.17250.1594131487919464568
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jul 2020 07:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=nV7Nz3xO;
 spf=pass (domain: gmail.com, ip: 209.85.208.66, mailfrom: jacob.kroon@gmail.com)
Received: by mail-ed1-f66.google.com with SMTP id h28so38554950edz.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Jul 2020 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A+ROiBpG6Pw/ApSOGMeO9KE+4v/qmGOmIZku6nROFbQ=;
        b=nV7Nz3xOsoEcy/5n8oD3xS/2LLl49+Y2JDl3GjqpEnEnAPxR+VFu2RAjOmcenv0MPd
         3L2joivuwmYm5/KKHxU9L8le8VaQrnTwejc80EEWaeRgLqRNeng6ZUQhVsx+y8kUffcI
         vhUAekJIFSjt7M7MEJc54299lOyzzr3pFnJ3hwWsnWY3IYJXmg+GR998ilA01UV/LmLk
         +lbcCRAg8vmh3XlQZcQQHyOE1Dznpp5l0rEKzoaDmQGLdWCnFODSXGpPL66UnOSZpoad
         +26M47CidaXVZ/0fxMeuTTKQ2mqjPPA1OHPIwv75edYWOgcKrwZiWg6aOPRYLxWCghKs
         JP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A+ROiBpG6Pw/ApSOGMeO9KE+4v/qmGOmIZku6nROFbQ=;
        b=jp02cLdpMXJF2ESHMKw2hlgrTmT9PzItHAw/wtbJdwhyDIl/9Vn/d0JxumJZDfGtTJ
         swuppY50bC1p1HLesR/fC8rapdHTy8G2n7QMXxfHkG3C9FhDynXIG7P85LA975x+6cIP
         KFjoAtyDmBZtaolw+d+3s3Or1qAtRUPHsYEF6hnVc9g0Tek80+/65uXGJTvRju1+3ku4
         hDQwTWeezK0k6tyoNK4EO0cfFvCfqmbLJwS6K8vv8w51sK1qub5Ti9JDbPL+obc7T6vm
         lvEqDo10m8vov+eAeEK+zODQddUNzU+skMbfMgI38omoNVQzxf62dWtVWwoqq+5YtuSM
         mLbA==
X-Gm-Message-State: AOAM530k5CsMKLuRLVm9HURXB3TzP2uiA/imHO36oF2NPG0TpOIfVdg7
	CBw+8rJum/I6a0YS+10f3TFE5zfcte0=
X-Google-Smtp-Source: ABdhPJzsBiZjHi6LIfV7K7x8OwotFGz+Ez+crW2MpdHhaJ494xzQOl/h4eQ8TDzkPW2iLtDLk2+4Pg==
X-Received: by 2002:a50:9f8c:: with SMTP id c12mr58398303edf.149.1594131486298;
        Tue, 07 Jul 2020 07:18:06 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id c10sm18813463edt.22.2020.07.07.07.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:18:05 -0700 (PDT)
Subject: Re: [bitbake-devel] [bitbake][PATCH] lib/ui/taskexp: Validate gi import
To: David Khouya <dakhouya@gmail.com>
Cc: Martin Jansa <martin.jansa@gmail.com>,
 bitbake-devel <bitbake-devel@lists.openembedded.org>
References: <20200701162740.258157-1-dakhouya@gmail.com>
 <d679c275-a191-eed0-a5bb-54f6d5a499c0@gmail.com>
 <CAKvemSJd9sbfbbKcw=hQhFSOLO2r05UwhSffmgQztb4JcCj30Q@mail.gmail.com>
 <CA+chaQebiZSLXiVh0a+dkGdfZ3+4aEiL-S5f5UeNv7YHmJAoTg@mail.gmail.com>
 <161F7718C6BC7653.28965@lists.openembedded.org>
 <CAKvemSKG8DGVBQGNkf=9R9105FsrHy62YAV=xKJO0qb2m3rnuA@mail.gmail.com>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <c826666f-e631-74ed-2ea3-195354d17442@gmail.com>
Date: Tue, 7 Jul 2020 16:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKvemSKG8DGVBQGNkf=9R9105FsrHy62YAV=xKJO0qb2m3rnuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 7/7/20 3:33 PM, David Khouya wrote:
> I pushed a commit on my fork if you want to give it a try. It works on 
> my side.
> 
> https://github.com/dakhouya/bitbake/commit/3af4530571cef1b6ec58f810b89f6f35a14cc475
> 
> I'll send a patch for that this evening.
> 

Yes, this patch fixes taskexp for me.
Thanks,
Jacob
