Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
 by mx.groups.io with SMTP id smtpd.web10.1147.1592339887717148767
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2020 13:38:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Cdbe3fk5;
 spf=pass (domain: gmail.com, ip: 209.85.208.66, mailfrom: jacob.kroon@gmail.com)
Received: by mail-ed1-f66.google.com with SMTP id c35so201124edf.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2020 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EpjPeTgWfwTW3Xx+EdH/H4FRAJA+5LUP6VAOS0wShlI=;
        b=Cdbe3fk5pnQEl+wE6Ob7L0KQSbnnGrZhJyXrQVnLDiU2ag63RA6sVibZZmBpbyaf1Q
         k1yzF5VF0hRT10Htjvfixp19uX8rc0XOGtgJwMaOBDRWm+v3iB8AMuy91Vh/3VxgS2Wk
         hjk+kD9CB8WnOwvb8E5RZ34iaT7+1oG/QV5yz7cDksk4JYT9pmVUAa6fOlIQIPI0N2Et
         uyOTqBLv0Vhsw37pE5pjRmwgUsvGgi75H6jY150KD719wPDU4R09/jQsQ3N9dY7nBAOM
         WXBChzq+VZ6fP8pGwdCZUSeiQsTmQidmhbWQOZL0FMBRtibowAhUc7RJoh8QAoDWW98m
         JK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EpjPeTgWfwTW3Xx+EdH/H4FRAJA+5LUP6VAOS0wShlI=;
        b=nfusElLSeGuxcVCnUnpPShltmNGnyXgX5igigliXGS5LAh4Wc6uCcvyvzlOJCrCK7J
         4ftFSsVDkeF6NLsilP+aF/A1NyjtXRQp7BVmRt4AV4B75bSV35RyovuCo3ylszsVesh/
         kIgyJlHf6giKaJNJhptzAxwznMQI3D0ru8ll6uuIlRyyHClO3Xy+34pvfaD0KFcmDGZX
         nGIACxXbZ7S/43LG88e5o9yTfkPhZZcAxvndeSOI9m9V4gtQpOAVe46uHSWKh5+a3c12
         3SATTZ6QnnOUjDrrLDf/djOheCjsD8K+fMGWNbT7tzvrn9R4lnTNX3NWhAQ+jhqO7fXM
         g8bA==
X-Gm-Message-State: AOAM533iDZEIt+4dyT0lw2WUf43qakChRI8JlWaDHjLo/LUMnVsc4mhu
	xmCT5VTN63vV+a1oSatOV5yiJy0R
X-Google-Smtp-Source: ABdhPJwe4fTWV8ZNIwDeLHkVJm8t4QkpI3qLBNxkQAzoJdMNOL/PsgzIcSHkPmcN5y9V74xz/69cMw==
X-Received: by 2002:a50:fd05:: with SMTP id i5mr4163478eds.79.1592339885816;
        Tue, 16 Jun 2020 13:38:05 -0700 (PDT)
Return-Path: <jacob.kroon@gmail.com>
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se. [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id h5sm11739453ejp.45.2020.06.16.13.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 13:38:05 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH] lib/bb/utils.py: Do not preserve TERM in the environment
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20200615122231.1325750-1-jacob.kroon@gmail.com>
 <2677ce4ecd89cb99e7bd491a68be93908023c87b.camel@linuxfoundation.org>
 <b748351a-7330-50d0-86b3-890b3ec28570@gmail.com>
 <7f41ff1c938ef998c4e5d67ac07642b8ebb324c4.camel@linuxfoundation.org>
From: "Jacob Kroon" <jacob.kroon@gmail.com>
Message-ID: <4b1882bd-0811-ee77-aa99-654924fb0953@gmail.com>
Date: Tue, 16 Jun 2020 22:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <7f41ff1c938ef998c4e5d67ac07642b8ebb324c4.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 6/16/20 8:48 PM, Richard Purdie wrote:
> On Tue, 2020-06-16 at 10:14 +0200, Jacob Kroon wrote:
>> On 6/15/20 2:29 PM, Richard Purdie wrote:
>>> On Mon, 2020-06-15 at 14:22 +0200, Jacob Kroon wrote:
>>>> The value of TERM is leaking into OE-Core postinst-useradd-${PN}
>>>> scripts,
>>>> which in turn can optionally be monitored by buildhistory. Prune
>>>> the
>>>> value in
>>>> order to make the OE-Core buildhistory output more deterministic.
>>>>
>>>> Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
>>>> ---
>>>>    lib/bb/utils.py | 1 -
>>>>    1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>>>> index 5f5767c1..50032e50 100644
>>>> --- a/lib/bb/utils.py
>>>> +++ b/lib/bb/utils.py
>>>> @@ -580,7 +580,6 @@ def preserved_envvars_exported():
>>>>            'PATH',
>>>>            'PWD',
>>>>            'SHELL',
>>>> -        'TERM',
>>>>            'USER',
>>>>            'LC_ALL',
>>>>            'BBSERVER',
>>>
>>> When you send a patch like this, please be clear that its for
>>> testing.
>>> I know from a discussion on IRC that this patch needs close vetting
>>> to
>>> see if its "safe" and its likely going to break things around the
>>> menuconfig tasks for example. The patch needs to state that so
>>> people's
>>> expectations are right.
>>>
>>
>> Right, I should have been more upfront with that in the patch.
>> Should that go in the commit message itself, after the '---', or just
>> a prefix in the email header ?
> 
> After the --- would be fine. Its just so everyone has the right
> expectations about the patch.
> 
>> I understand TERM must be used for *something*, I've just never
>> understood in what ways exactly. Is it for allowing
>> screen/tmux/xterm/your-favourite-terminal to do extra fancy things ?
>>
>> At a first glance I can't see anything breaking the kernels
>> menuconfig,
>> and in a devshell TERM is back, regardless if I use tmux or plain
>> gnome-shell.
> 
> We're not seeing any issues testing this on the autobuilder which is
> good. Its part of some very old code, created when we first started to
> try and clean up the build environment so its possible other
> improvements have obsoleted this need now. Its obviously just had to
> test and be sure!
> 

If we decide to drop it as the patch suggests, then I guess we could 
drop it from BB_HASHBASE_WHITELIST in oe-core/meta/conf/bitbake.conf as 
well. (There is also a reference to 'TERM' in the bitbake manual which 
should also be removed in that case)

Jacob
