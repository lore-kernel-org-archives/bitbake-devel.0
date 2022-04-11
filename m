Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA9C63701
	for <webhook@archiver.kernel.org>; Mon, 11 Apr 2022 17:18:01 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web09.30703.1649690630623498665
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 08:23:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=K9gdjyDi;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: ptsneves@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id bu29so27383559lfb.0
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Apr 2022 08:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=EPJjX6I2kCTnHS40omVxzy/utsxc369VIIwTrliY55c=;
        b=K9gdjyDiFEjREzFsqnWzKw5KBQx/qrkxvSKwoW2Bc03H41xdQglgkofMPq72xv7ls2
         F+oc8bu+b2oLFvQkLtsx2LaJbRdtmdyOiPedwmkNuL5ok7H63vBFIjv3kOTjiBQRxP8p
         Plded6lSlk9bf3XDYfOWKkEEXyV00LS6V3EEV8JrG/5E+MvXUiwTEoKnRvH0tIP2A0q5
         90RzFBjAU++dJn+DuCulOu8bYIBprrTLJ4eV0Pj3utFR4IvPrKi4mDO3ZEDECv2CZnph
         LZvbZ25QhpPWQK3IueggN5GU/+FVnV3sK4ssfSYPK2gDSS/FQks9W3V4w/haEvT9kTD9
         pubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EPJjX6I2kCTnHS40omVxzy/utsxc369VIIwTrliY55c=;
        b=lxVMxD1JZWa17cLDYuZ+28ozOoXnYPCulMC1dW+HPI+wU55VJAISVuJmu3yUTR9Xg+
         TxPK/JD7xTD7iBw1XzflGOUB2DCsVTw65NjRjoKn/03gEXSuUmzBj4bT87/xLXIyDYV1
         6RCQKHaubRF9a0DunY9FcD/5Jk2UIo2DFvdDHh/F5qqEjij90Kv5YWjFQ2sz6AMMjuTN
         uQkUsiGv48TR+LAtMRrqYRE6d/7/IWNUTySWfeTndGOk55lzlK2dVgh634qJ4PTW2tfZ
         X61h7nSIl0Vf2sRQ6WVHtYtkH50JwrZAq9VfaL5omyu1HInj1KEjQ5kcv3Q02myGcfPu
         eluQ==
X-Gm-Message-State: AOAM531yBUhLbUZewJh8LUgPMah/LHTY1mtI7DIw9gPbi8Y3CsUwyBIU
	rOrZL+DiGuvH2c6F7SkBzw==
X-Google-Smtp-Source: 
 ABdhPJx6wsdiuYZBsxRQFBhQIA2PuXosqDZoQeX0IkkiUMDTjCqJEEodKjjk/aaCCA2jxqfWWfnoHw==
X-Received: by 2002:a05:6512:5d1:b0:469:4887:6b41 with SMTP id
 o17-20020a05651205d100b0046948876b41mr13227758lfo.679.1649690628585;
        Mon, 11 Apr 2022 08:23:48 -0700 (PDT)
Received: from [192.168.0.88] (77-92-34-4.cable-modem.tkk.net.pl.
 [77.92.34.4])
        by smtp.gmail.com with ESMTPSA id
 s22-20020a195e16000000b00464f9daf7f0sm1288056lfb.277.2022.04.11.08.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 08:23:48 -0700 (PDT)
Message-ID: <957f9816-d2d8-b43e-b77e-51a64b9d984a@gmail.com>
Date: Mon, 11 Apr 2022 17:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bitbake-devel] [PATCH v3] checksum: Support uri formatted file
 list
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220206134507.123558-1-ptsneves@gmail.com>
 <16D17908BC3DCB81.25014@lists.openembedded.org>
 <2c7698c9a48dcca849b964b5cd5076c12f5168be.camel@linuxfoundation.org>
From: Paulo Neves <ptsneves@gmail.com>
In-Reply-To: 
 <2c7698c9a48dcca849b964b5cd5076c12f5168be.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Apr 2022 17:18:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13600

Hey Richard,

Thanks for the ping. I will try to have a look at it this week. Sorry I 
got a bit lost with private stuff and forgot about it :(

Paulo Neves

On 4/11/22 16:28, Richard Purdie wrote:
> On Mon, 2022-02-07 at 10:06 +0000, Richard Purdie via lists.openembedded.org
> wrote:
>> On Sun, 2022-02-06 at 14:45 +0100, Paulo Neves wrote:
>>> Before this commit, if the file list for checksumming had
>>> files names with spaces there would be a crash. This happened
>>> due to filelist.split breaking on the file names instead of
>>> on k:v boundaries. Now we validate this case and emit a fatal
>>> error if such case is found. This needs to be fatal as the split
>>> will generate broken k:v from then on.
>>>
>>> Instead of putting literal spaces in the file list the user
>>> should urlencode the file names and if they contain coded spaces
>>> they will be decoded. This is consistent with the current
>>> practice where file names are urlencoded. A reproducer of the
>>> issue this commit fixes, was to pass a do_compile[file-checksums]
>>> list with files containing spaces in their names, urlencoded or
>>> literal.
>>>
>>> Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
>>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>>> ---
>>>   bitbake/lib/bb/checksum.py                   |  9 +++++++--
>>>   bitbake/lib/bb/fetch2/__init__.py            |  6 +++---
>>>   meta/classes/base.bbclass                    |  4 +++-
>>>   meta/lib/oeqa/selftest/cases/lic_checksum.py | 18 ++++++++++++++++++
>>>   4 files changed, 31 insertions(+), 6 deletions(-)
>>>
>> Since this touches both bitbake and OE-Core I had to split the patch into two to
>> be able to test it. I did that and found that one of the other selftests fails
>> when it is applied:
>>
>> oe-selftest -r layerappend.LayerAppendTests.test_layer_appends
>>
>> e.g.:
>>
>> https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/3128/steps/14/logs/stdio
>>
>> but it does this consistently and reproducibly. We'll need to get to the bottom
>> of that potential regression...
> I'm a little sad we never got this resolved, I took a bit of a further look as
> I'd been carrying the patches for a bit hoping this would get some follow up.
>
> The issue is the change in get_checksum_file_list() always comes up as false for
> str(os.path.exists(pth)) as it isn't a complete path. As such the change
> definitely has a problem which needs to be resolved.
>
> Cheers,
>
> Richard
>
>


