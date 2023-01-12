Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58742C54EBD
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 13:44:08 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.55018.1673531038297358916
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jan 2023 05:43:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=3qDBbpQp;
 spf=pass (domain: smile.fr, ip: 209.85.221.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f50.google.com with SMTP id h16so18111022wrz.12
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 05:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMOtgcbnKGREhHihqBQlQC+Xr1cmMtxiRI5iaNwLAOw=;
        b=3qDBbpQpwWBMJLkB7O0OdQ5LvmWZpaV4KMMv7CxCkBIT4977wNpeCFUxL8jv6HEueD
         Bmh4iieBY1/280RLNqMExG4Hsiv5wr815P+hecZsArF79y1ltmr7UoZehbgvigxZl50q
         6sTNymp4ImJaAYwlM8L9XISiSMnHdrTmR2JAg1Ym/myEYj3poq+Ugi8NEfL3Iz8eUHBq
         93eo6Boni5JvX6UtqcW2UkrNZNfzGkNo4epfMhGqYyc/9lHLl2PONjBGI0hhW6loJwHL
         Ojb+k1VraArZE3hEmNZRfqh44C6/DObSrJ6q+sKh05iiQUhjDw3jYc0TDmJyQFLa6rH9
         tFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMOtgcbnKGREhHihqBQlQC+Xr1cmMtxiRI5iaNwLAOw=;
        b=tThE6lt8D+/xYKBsx9rX4RNLYLQckqH5fBKn2sS1M7w1m2plDwmaVzJ/+i+nEhu74y
         0g9R/Eqj0iWmhenCTjeqNFoqIijfoZRYyDiNBrj1AtMlr3HnWcxg8GyZyS0ooSrOJesb
         cAC0R8W2AUwxDyYZE1zfyZ0rfZRIzAZW0BMdQRvibLFE3sq5GeIkcdUP5KX7nGAlUZ/t
         JaF6bIbSPKBT/BaPKDEz77ud4yXjpycbVgiPcndhNrHTzt+7aq6qmeStHg4fAM+vuasN
         2s/+CgmGc2TwaiKP7JtAG+FZfbCsMlUqpy42+FmE/385tvigGbOjNvdOXWI954otf6lu
         0U1w==
X-Gm-Message-State: AFqh2kqEkNTacVCHFZyCxyedVBOQPG/348Fzckf49ZH65DAUtNggy9d2
	lStCHkKU7/FnN0DSSb9tFD+BYQ==
X-Google-Smtp-Source: AMrXdXveXy8JPAtRh1TRL1iMbpSJOru2nkkocVPPGIk1S4Lo9SeeIOaphK4JCpt34DWtLC1DR8HS4g==
X-Received: by 2002:a05:6000:124e:b0:2bb:e9e6:ac26 with SMTP id j14-20020a056000124e00b002bbe9e6ac26mr9987251wrx.57.1673531036473;
        Thu, 12 Jan 2023 05:43:56 -0800 (PST)
Received: from [10.1.8.154] (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b003d9ea176d54sm22839921wmq.27.2023.01.12.05.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 05:43:56 -0800 (PST)
Message-ID: <772dadde-b999-f88d-c38d-11d717dd0636@smile.fr>
Date: Thu, 12 Jan 2023 14:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] persist_data: Handle sqlite error when
 cachefile path is too long
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20230111223729.3472181-1-yoann.congal@smile.fr>
 <CANPvuRku0dQQPQVX5Hxcw27zZQhLTM-3X0SAV0hZ4JTkVe26Ag@mail.gmail.com>
 <ff985da2d6dc93e4a75adc94bb84ecd176f26495.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <ff985da2d6dc93e4a75adc94bb84ecd176f26495.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 13:44:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14311

On 1/12/23 13:50, Richard Purdie wrote:
> On Thu, 2023-01-12 at 11:43 +0000, Jose Quaresma wrote:
>> Hi Yoann,
>>
>>
>> Yoann Congal <yoann.congal@smile.fr> escreveu no dia quarta, 11/01/2023 à(s) 22:38:
>>> Sqlite can't open the cachefile when its path is too long (>= 505 char by
>>> my tests).
>>>
>>> We do have a path length check in sanity.bbclass but this code is called
>>> before sanity checks.
>>>
>>> Treat the error in the exception instead of checking before hand in case
>>> sqlite eventually fixes this.
>>>
>>> Fixes [YOCTO #12374]
>>>
>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>>> ---
>>>   lib/bb/persist_data.py | 18 +++++++++++++++++-
>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
>>> index ce84a158..a027f912 100644
>>> --- a/lib/bb/persist_data.py
>>> +++ b/lib/bb/persist_data.py
>>> @@ -249,4 +249,20 @@ def persist(domain, d):
>>>
>>>       bb.utils.mkdirhier(cachedir)
>>>       cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
>>> -    return SQLTable(cachefile, domain)
>>> +
>>> +    try:
>>> +        return SQLTable(cachefile, domain)
>>> +    except sqlite3.OperationalError:
>>> +        # Sqlite fails to open database when its path is too long.
>>> +        # After testing, 504 is the biggest path length that can be opened by
>>> +        # sqlite.
>>> +        # Note: This code is called before sanity.bbclass and its path length
>>> +        # check
>>> +        max_len = 504
>>> +        if len(cachefile) > max_len:
>>> +            logger.critical("The path of the cache file is too long "
>>> +                    f"({len(cachefile)} chars > {max_len}) to be opened by sqlite! "
>>> +                    f"Your cache file is \"{cachefile}\"")
>>>
>>
>>
>> As fair as I know bitbake don't use python fstrings anywhere
>>
>> grep --include=\*.py  -rnw bitbake/lib/ -e 'f".*"'
>> bitbake/lib/bb/data_smart.py:345:        """Get the line where a operation is made on a variable in file f"""
>> bitbake/lib/bb/main.py:135:    parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
>> bitbake/lib/bb/tests/runqueue.py:305:            tasks = self.run_bitbakecmd(["bitbake", "mc:mc_2:a1", "-c", "compile", "-f"], tempdir, "", extraenv=extraenv, cleanup=True)
>> bitbake/lib/pyinotify.py:2255:    parser.add_option("-f", "--raw-format", action="store_true",
> 
> We don't, no.
> 
> We do now meet the minimum python requirements so in theory we could
> but it would mean the code can't be backported. A fix like this could
> be useful in older releases so it is perhaps sticking to the older
> syntax but I know others would prefer to be able to use it. I'm torn on
> it...

I really thought I saw some f-strings near this patch... But I guess I 
mixed my codebases... sorry.

I'm okay with sending a V2 based on "".format().

-- 
Yoann Congal
Smile ECS - Tech Expert

