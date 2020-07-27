Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
 by mx.groups.io with SMTP id smtpd.web11.56871.1595860612513900396
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jul 2020 07:36:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kuJc0pBk;
 spf=pass (domain: gmail.com, ip: 209.85.215.195, mailfrom: akuster808@gmail.com)
Received: by mail-pg1-f195.google.com with SMTP id p3so9646302pgh.3;
        Mon, 27 Jul 2020 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zTdM1D4wEVsNTVgUFFjF0AbTfi0vc+hxwQ9r1RQD0Io=;
        b=kuJc0pBkzOYEM+nFHR8rnAmTo9Ygj4nmuy1v5SGnS2ydpeCKt3agUF0gw2S0EWb4v2
         ZDkft/3NQbx5BLAodZCUJpoUMmWkbcd3riBr6IJvWy12MUVG3zeV30UNh4NpA4u4sMDI
         Wa6Li4EQU3Gp3+e32ByproRHn+vHI7au60rn5x5fwmieCbjMhSFLn/krs6uaT5E7btUN
         Y408PuM+Z2h4VKWBej+GdcBCeYfBicjeE3pIr298jdRMg5eVW+YnwSpTtCDkv/ztNL84
         KutIi3woj3R73dQDQTU7rp7VP+6TyvrOhVro1XS0RCJzPqwj3I1nbajNpPmRxC1ydZ27
         i1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=zTdM1D4wEVsNTVgUFFjF0AbTfi0vc+hxwQ9r1RQD0Io=;
        b=ZduN6h9r1YEjgWsIb3LR9eIAvVPxQZsRX9C+e0a3BE08VruSQTBet6WjmNwfzWMcR6
         GotnB2dBXK+tlbkmlfW/RXz5VtLrxgeNVbjnkR97P3a1jYxHbdI5aEKOfZ7szWHKYLty
         GTVcp0+5gDfO5uvHnRKpSrPMu9x6el2uTueTcQIVlAjxabJ6iArwARbmUyCTe0zxjw9v
         Uo35Z8kJGJitA5wuTPS4Owp1uUgSOyHJHujmzP1epd29eBijpZO2Ts9/4uGz3iow0If2
         30BsDMdclXQf4QukDk6sePaEktKm23OoA4UqENSMDBFE53eadP6xoppeOy3StUkdHEPO
         Qqpw==
X-Gm-Message-State: AOAM533FYbI4TvI0DjQybqkjqnv3fYo9OLe1gM9qh0AOeQiGRAIUDKHU
	RVKlVMIq7sSE5v9CsK9J58rSDTtjPLA=
X-Google-Smtp-Source: ABdhPJyj2fb/J2lEndItqhHtHKRhgrDhb+vcDxzdMnd5pmcdptqEHmUPDZcfHFABvt9DwyEsaJNmJQ==
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr20414005pfr.191.1595860611612;
        Mon, 27 Jul 2020 07:36:51 -0700 (PDT)
Return-Path: <akuster808@gmail.com>
Received: from ?IPv6:2601:202:4180:a5c0:8df1:f28:d14a:8296? ([2601:202:4180:a5c0:8df1:f28:d14a:8296])
        by smtp.gmail.com with ESMTPSA id x9sm16448954pfq.11.2020.07.27.07.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:36:50 -0700 (PDT)
Subject: Re: [bitbake-devel] [yocto] Stable Warrior branch
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Adrian Bunk <bunk@stusta.de>
Cc: Patches and discussions about the oe-core layer
 <openembedded-core@lists.openembedded.org>,
 "yocto@yoctoproject.org" <yocto@yoctoproject.org>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <03a353c4-80dd-e66c-3222-7850a98182f7@gmail.com>
 <20200714135619.GF25970@localhost>
 <cca863dd41cf837cfaa89484c010578e5ac0809b.camel@linuxfoundation.org>
From: "akuster" <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
 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
 8CS2NxU=
Message-ID: <e6743da0-b2d2-14bf-2d1c-7e6f50ba8e1b@gmail.com>
Date: Mon, 27 Jul 2020 07:36:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cca863dd41cf837cfaa89484c010578e5ac0809b.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US

Adrian,

On 7/21/20 1:53 AM, Richard Purdie wrote:
> On Tue, 2020-07-14 at 16:56 +0300, Adrian Bunk wrote:
>> On Thu, Jun 04, 2020 at 09:28:00PM -0700, akuster wrote:
>>> Hello,
>>>
>>> The Warrior branch of Poky has had its last official dot release.
>>> It
>>> will be moving to Community support and EOL within 6 weeks if no
>>> one
>>> steps up.
>>> If someone is interested in taking on the responsibilities of
>>> maintaining the "Warrior" branch moving forward, please email this
>>> list.
>> I have an interest in keeping warrior branch alive in poky and meta-
>> oe,
>> and I'll take this responsibility since noone else seems to be
>> interested.

Are you still interested?

-armin
>>> Please look at the
>>> https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS for what
>>> will
>>> be expected.
>> I have some ideas, but not yet a fixed plan how I will set this up.
> Ok. FWIW we are struggling a little with keeping the older releases
> building on the autobuilder as the workers change. We do have plans for
> handling this with buildtools but its not rolled out on the older
> autobuilder-helper branches.
>
> I do have work in progress working with Jeremy for thud
> (contrib/rpurdie/thud), much of which should apply to warrior too
> (contrib/rpurdie/warrior is a guess). I just really want to highlight
> that there may be some initial work to get these older branches to the
> point where they continue to work on the infrastructure.
>
> I think we may have to accept backporting a lot of patches in helper to
> bring things more into sync with master/dunfell to make all this easier
> to maintain/get working.
>
> Cheers,
>
> Richard
>

