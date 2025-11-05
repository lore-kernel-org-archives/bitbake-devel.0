Return-Path: <zboszor@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB6CCF9F8
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 10:46:55 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6841.1762339607679007063
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 02:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eMpV2HGm;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: zboszor@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7277324054so39873866b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 02:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762339606; x=1762944406; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Epefpa/KbVq+c8CPow8Lc2jCNsLOSJuBGs0so76Th5o=;
        b=eMpV2HGmovm9XSm6VoZaigWTh1XQvFalQ46I3qNHwz9y7cgpt6LIK3rwnzqyDaZ1mc
         r6zOcxrGx4bWo7GRFHB723aGBdpzcddQa3VGBE87eJn1bQne4lAY7H+NEQXUQ5NFpfIG
         xXKghCQOR/g2TGdSOacRE5pVJ8d3aehnLIEifT6rnD9K0Cki/V6+gUau8WMaFJfu3JDi
         +NhxfOJOnpNXSQyL2il1mfenMYpQo0E7cGxOnLai4wiyJUimIevW99Be8QbumTFC4WbB
         Rlo5GIqQzW8Py+iisqqXHbhdeMWylC3eHplsIFNVB3SC2YxZ83TPuoiWXzHcYRRTv7dz
         5S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762339606; x=1762944406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Epefpa/KbVq+c8CPow8Lc2jCNsLOSJuBGs0so76Th5o=;
        b=XFcvxKbybeyzt2ZV2JBvNxRaJIGts6WpflohX95vVUA1u7Ow0ZBp8oFYVp2CY/ZAhH
         sbZl/6WR+y+XEfqNMP3BY4y2p5+4jytB3FWcCKnJi+ZvFranokKH2fBIutjyjb5gExIL
         +0AeIyoJEGwunsqupXNFeyIqDscn6OvEMN9W5iWAkBXw47z9lqRcF7s3vu9YkBc3zoz+
         07JzkeXgnljImAAHHyfGkVAODn20DjYvGTHnI6BPgBcgY8KCTEgVvoXVeN0hqATaaZ0x
         zGDb87TDm97H/8s+m/k1bhkHeM/FiRuUbHQZTI11HLWHwCH8c+jjClcm6FNOop/tuMQu
         w0GA==
X-Forwarded-Encrypted: i=1; AJvYcCUPqodvwUNYt+q61wGSBiEEckmLO3eY9o0aTXA2g2PKOxk5/JtFUs9FOJQRCr/DB6/LCq/eQjBrrs+bahnc@lists.openembedded.org
X-Gm-Message-State: AOJu0YxKkvy7xh0oehssncVJ+xMChygJzdaN31IIbB14VT1TYdoFD/m6
	9oPLsZxaxKlElY0CWVPb8zXNT6jAoUmXPW2Voyqia43eoo2+PPwqAlQL
X-Gm-Gg: ASbGncsB0UW4+hTTZP+YswbibTKoq9n2ZIIgBP/BAGbm2ckPopcNRnD3UD03so7hx+N
	vBPFDc9C0YuW5ECmfOsXkWdDhcJOa0VlWYKt8h+ouNkNCU+8EfJ2bWW58iw0ogQ4/99/7rDphtp
	fnOjGKZzjJmGpo1VEpd8VlKZWU6IhiATAiYNUUiDjIP/mHe3I13xFNeRwwFdPmD5yBtbhRemdgo
	ZUO9Xz5TpEXJlq1ldvBkCYQ112IJOxGrZ6xNEwM9nBBS+4H4legAWgoJxwsIjSbUO+GwfvC6pjy
	2lfmkh1LiQ/Z5qdqMEhpr7Zu2njpER1oiY3ohJXOlAh8IF7r2scrMUYO0T5VImv85W7CPg7Qfge
	/ADrcvPiuvk8lXtzgvKiqqQZ7jDooWi+/X7DRhso7TjGpYh9BxVVqfcbhucYUP02BVZUOiZgVog
	TbQnRlMCpuNnjybCTqfajwIGXKqIhvNTbVTQ==
X-Google-Smtp-Source: AGHT+IH7BMOUaPR6YS29aCTvHe69o+cOgbxTRcA4WmP52e+hYLV1yM3NnfuE3ZIJtxWQI2jOzBcBpQ==
X-Received: by 2002:a17:906:730f:b0:b71:dd06:48de with SMTP id a640c23a62f3a-b72655a5d88mr242130566b.59.1762339605547;
        Wed, 05 Nov 2025 02:46:45 -0800 (PST)
Received: from [192.168.2.143] (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe37b7asm451374566b.60.2025.11.05.02.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 02:46:45 -0800 (PST)
Message-ID: <b4c0f7e5-73ae-46bc-84bb-ffd71e6c1424@gmail.com>
Date: Wed, 5 Nov 2025 11:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] knotty: Cast two variables to int in
 integer expressions
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20251105071405.636900-1-zboszor@gmail.com>
 <18751578F72EE953.363297@lists.openembedded.org>
 <DB5PR02MB10213B99F0900A16DD0023B54EFC5A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <DB5PR02MB10213B99F0900A16DD0023B54EFC5A@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 10:46:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18260

2025. 11. 05. 11:32 keltezéssel, Peter Kjellerstedt írta:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Peter Kjellerstedt via lists.openembedded.org
>> Sent: den 5 november 2025 11:27
>> To: zboszor@gmail.com; bitbake-devel@lists.openembedded.org
>> Subject: Re: [bitbake-devel] [PATCH] knotty: Cast two variables to int in integer expressions
>>
>>> -----Original Message-----
>>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Zoltan Boszormenyi via lists.openembedded.org
>>> Sent: den 5 november 2025 08:14
>>> To: bitbake-devel@lists.openembedded.org
>>> Cc: Zoltán Böszörményi <zboszor@gmail.com>
>>> Subject: [bitbake-devel] [PATCH] knotty: Cast two variables to int in integer expressions
>>>
>>> Python 3.14 complain about these:
>>>
>>> Traceback (most recent call last):
>>>    File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
>>>      termfilter.updateFooter()
>>>      ~~~~~~~~~~~~~~~~~~~~~~~^^
>>>    File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 339, in updateFooter
>>>      lines = self.getlines(content)
>>>    File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 370, in getlines
>>>      lines = lines + 1 + int(len(line) / (self.columns + 1))
>>>                                           ~~~~~~~~~~~~~^~~
>>> TypeError: can only concatenate str (not "int") to str
>>>
>>> and
>>>
>>> Traceback (most recent call last):
>>>    File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 722, in main
>>>      termfilter.updateFooter()
>>>      ~~~~~~~~~~~~~~~~~~~~~~~^^
>>>    File "/mnt2/zozo/yocto-5.3/bitbake/lib/bb/ui/knotty.py", line 341, in updateFooter
>>>      for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
>>>                                             ~~~~~~~~~~^~~
>>> TypeError: unsupported operand type(s) for -: 'str' and 'int'
>>>
>>> Cast self.rows and self.columns to int.
>>>
>>> Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
>>> ---
>>>   lib/bb/ui/knotty.py | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
>>> index 00258c80f..f04607df8 100644
>>> --- a/lib/bb/ui/knotty.py
>>> +++ b/lib/bb/ui/knotty.py
>>> @@ -338,7 +338,7 @@ class TerminalFilter(object):
>>>               print('', file=self._footer_buf)
>>>           lines = self.getlines(content)
>>>           if not self.quiet:
>>> -            for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
>>> +            for tasknum, task in enumerate(tasks[:(int(self.rows) - 1 - lines)]):
>>>                   if isinstance(task, tuple):
>>>                       pbar, msg, progress, rate, start_time = task
>>>                       if not pbar.start_time:
>>> @@ -367,7 +367,7 @@ class TerminalFilter(object):
>>>       def getlines(self, content):
>>>           lines = 0
>>>           for line in content.split("\n"):
>>> -            lines = lines + 1 + int(len(line) / (self.columns + 1))
>>> +            lines = lines + 1 + int(len(line) / (int(self.columns) + 1))
>>>           return lines
>>>
>>>       def finish(self):
>>> --
>>> 2.51.1
>> Wouldn't it make more sense to make getTerminalColumns() return two integers?
>> If I understand the code correctly, this should only be a problem when
>> reading the sizes from the environment, so changing this:
>>
>>                  cr = (os.environ['LINES'], os.environ['COLUMNS'])
>>
>> to this:
>>
>>                  cr = (int(os.environ['LINES']), int(os.environ['COLUMNS']))
>>
>> should solve the problem.
>>
>> //Peter
> Oh, and I would also change the subject to say:
>
> knotty: Make sure getTerminalColumns() returns two integers
>
> //Peter

Thanks for the suggestions, I will send a new patch.

FWIW, this change allows using Fedora 43 with Python 3.14.0 as the build host.


