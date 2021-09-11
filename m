Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.133.1631331760473017611
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 20:42:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kotNoQQv;
 spf=pass (domain: gmail.com, ip: 209.85.215.169, mailfrom: jiladahe1997@gmail.com)
Received: by mail-pg1-f169.google.com with SMTP id k24so3644881pgh.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:references:from
         :cc:in-reply-to:content-transfer-encoding;
        bh=GM38VTq2LjspukAq0gBdC6rnr+aybiqRnRX4gWnHx9A=;
        b=kotNoQQvYFlymyAvhkjEIg1qbK50snjtFdJ5NJ9NvHEs2p1ABglKO/dZvL7uKHtmQK
         SOA3DQQCgAH+iJ6v+w/Omi5LG3o8AuiMPe4roGnddkP7zH902fNgR7LEt8090hN8DvdU
         d8BgkGhDTmKyxh/Qv8K9HrK0rooeRIaPmdZBtbehGUe3yU0R/UJlVwwDX28B1noNclGg
         oxZ6knZDaNodcKROJLFEXUBP3I9qDyRiKpmyi10CPsQogO5uNjJJQzOeMJqS7f9ZkOPl
         uBEFQzQ15AlyG0ATXRg205XOqHaTVMs3ZyPk38kLd+KnHQJiY27pC1/Ouz6tSuwk2JNc
         LWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:references:from:cc:in-reply-to:content-transfer-encoding;
        bh=GM38VTq2LjspukAq0gBdC6rnr+aybiqRnRX4gWnHx9A=;
        b=sJKaZEE7GaAH6O5qhzqoEbA5kktgU+hsm/qql0e15NaEaObuwfaR5ediHHudX50jEw
         PHdXj7YXttgYvkPAH0a4yiEIqlRRhTF3WUi4piP4IohOEzWUgbrR8tZ7ovyfsokqaz3O
         yq1LaPmjOgN/J+MjczR+NieaNJWN8CSAWCOwG4SIIHJuibPR3x1McchUO1zIKVm2sXno
         2siBU6cDdHd/AIL9Jkqx+sVPeeG+UiYVMIV6VPebOds94XK0xA7zWjICZLMklMqe5kUB
         xCeAzxiBlN9htC/qBHGweDCa6hxCKkJbvu3sHlRiJWvb/wMpjLg9QkV5I9VEmN6JilPE
         4BlQ==
X-Gm-Message-State: AOAM532U6vojoMuC+2SkqEUipLzMcDjGe4XGGcDYIlD9QOftvNX+Co4u
	5j2gcQS6FGQvoRGmEm8dX/er+nWeM28wn40a
X-Google-Smtp-Source: ABdhPJwcc2vBiG6KWiu+1vCTc/OtuBvG+jeEzT/a0bVZPZlAzOWNita9GCAgcH+hx7bHvU3JCfpdyQ==
X-Received: by 2002:a63:dd56:: with SMTP id g22mr864936pgj.38.1631331759728;
        Fri, 10 Sep 2021 20:42:39 -0700 (PDT)
Return-Path: <jiladahe1997@gmail.com>
Received: from [127.0.0.1] (pcd453045.netvigator.com. [203.218.243.45])
        by smtp.gmail.com with ESMTPSA id v7sm292445pjk.37.2021.09.10.20.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 20:42:39 -0700 (PDT)
Message-ID: <7ba30db0-c7db-b1c0-5243-86d5df789f17@gmail.com>
Date: Sat, 11 Sep 2021 11:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2] bitbake/fetch2: Add a new variable 'BB_FETCH_ENV' to export Fetcher env
To: yocto@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org,
 poky@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <2021082315183802113213@gmail.com>
 <92b1ba20b320376227c3003c53784de67ae01505.camel@linuxfoundation.org>
From: "Mingrui Ren" <jiladahe1997@gmail.com>
Cc: ross.burton@arm.com
In-Reply-To: <92b1ba20b320376227c3003c53784de67ae01505.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Richard,


On 06/09/2021 17:41, Richard Purdie wrote:
> Hi,
>
> Thanks for the patch. This isn't ready to be merged yet though as there are some
> issues.
>
> On Mon, 2021-08-23 at 15:18 +0800, jiladahe1997@gmail.com wrote:
>>   # CONF_VERSION is increased each time build/conf/ changes incompatibly and is used to
>>   # track the version of this file when it was generated. This can safely be ignored if
>>   # this doesn't mean anything to you.
>> diff --git a/scripts/oe-buildenv-internal b/scripts/oe-buildenv-internal
>> index e0d920f2fc..29cb694790 100755
>> --- a/scripts/oe-buildenv-internal
>> +++ b/scripts/oe-buildenv-internal
>> @@ -111,7 +111,8 @@ HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY \
>>   all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY \
>>   SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND \
>>   SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR BBPATH_EXTRA BB_SETSCENE_ENFORCE \
>> -BB_LOGCONFIG"
>> +BB_LOGCONFIG HOME PATH GIT_SSH GIT_SSL_CAINFO GIT_SMART_HTTP DBUS_SESSION_BUS_ADDRESS \
>> +P4CONFIG SSL_CERT_FILE AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION"
>>   
>>   BB_ENV_EXTRAWHITE="$(echo $BB_ENV_EXTRAWHITE $BB_ENV_EXTRAWHITE_OE | tr ' ' '\n' | LC_ALL=C sort --unique | tr '\n' ' ')"
> I think if you leave BB_ORIGENV handling in place, these latter changes
> shouldn't be needed?
>
> If you need to be able to pass extra variables into the fetcher, I think we
> could/should add API for additions rather than allowing the whole list to be
> customised. Without stating which problem you're solving, guessing what you
> really need is hard though. A better description of the issue you're seeing
> would help a lot.
>
> Cheers,
>
> Richard

Thanks for your reply.

The issue I have is that I have to pass additional variables into 
fetcher. More specifically,
I'm using a git:// protocol proxy tool, which requires GIT_SOCKS_PROXY 
variable.

I have made a bit more changes in this patch, I'm trying to make the 
code'perfect'.
But as you said, we could also add an API for adding additional 
variables into fetcher,
that's safe for back compatibility, but a bit more complicated for 
furture maintainability.
Please tell me which one you prefer.


By the way, I found two recent commits on this issue:
  (commit ID)
348384135272ae7c62a11eeabcc43eddc957811f
5dce2f3da20a14c0eb5229696561b0c5f6fce54c
which means the variables used by fetcher may change frequently.

I think it's a good a feature if we could add custom variables into 
fetcher. For example,
we could fetch private code by adding username or password, or we could 
adding custom
proxy tools.


Thanks,

Mingrui Ren
