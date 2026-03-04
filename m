Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8974EF8FE3
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 13:27:27 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17926.1772630844904136859
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Mar 2026 05:27:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=m3XIwfUN;
 spf=pass (domain: baylibre.com, ip: 209.85.222.169, mailfrom: tgamblin@baylibre.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb38e6d164so892504785a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Mar 2026 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772630844; x=1773235644; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQVkiNch8lTrbuaThTHgHaaFCNqyrcWFDDeeX3Seg1A=;
        b=m3XIwfUNoZaY37HjFrKZ4y2F6Q20gbBoJ3b/jYVDK6YM4xbekWWpTMCc6NCCeVAcwZ
         fhhIb6IESjqFIcaJmFqlvqpy522u/mlAeuCPgkax79DWDlNtECrMKDRmc19Q1yuxjBG4
         wH4mMziSLdKTfnAEdhuE8c1mLJ94crifznhRniX1qYOd5balTj+gdsOPGEvnAxpGl4gZ
         rxo9VGQR4lsItnzsJ7VXPtlUb5X+DYsRNTjFhg08/exb2zTa/2Naq25W4S6IskT0Vb7e
         nARkgZatuiRr7bKZJdzJ0nITNRkgYQpSvXR+YydCEjj5L6qdVnuQaMcmBvAwBJCSVJDg
         geVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772630844; x=1773235644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQVkiNch8lTrbuaThTHgHaaFCNqyrcWFDDeeX3Seg1A=;
        b=V2nL4qpXPIwGLvdSlRC+3jt6tiyYzNVcoT4xX04jzW6djgVM+qvwHyQzKLQsDOoAtA
         gN+eAeixYrLRx4bQLQjyDfIi/KQ4fMAmIZe6s93EebZ0mIxMm+ADsdxO9xf5eYxGfZqK
         LcLz3Wt8pKpDeyiR4UG1w533Ed5UibPK8QxZVlM9hPyXJoe94Dz+H0CJrHQZiWNJrDXp
         8jR5TDaAqvZVmpuHLF1Xl7El/fvddMeoZpB9hKjYFMJ+wsEYVZsPHMkiHg+SUMzqeR3Z
         D7cCSokc8R0RQ46Wcg6EeBXk4c4Uw+rqmbOqVFjRU9XQfpEvLPAccm2NVPEc7bfV76NP
         /URA==
X-Forwarded-Encrypted: i=1; AJvYcCXQCoutaSmtNhEZyntusfZ9wYLsBJJmUwJ9OlQ/TNmdbYdUZhrcJCznYBU2WSjIR20uA5lT4LK8dTj3vIPg@lists.openembedded.org
X-Gm-Message-State: AOJu0YweSKNPzy+RU2ygWvwOwqEfy4DA13oSUt4K9R9ZkXZQwA/CMaWU
	uUKQFQniPXcXeuGgfydh0UFIB577jRrMXep3ANMgqTAjh4lV8sUHuer0PFGUjgB47Yc=
X-Gm-Gg: ATEYQzz8xS6bHViqWLULleECEpB32CYS6mJXfkgxyV2s+La4JSwvj9S9sHWAM0GDJgl
	n7wxjQr1eWu1IymE4uCSNV8yW4pf1uMSR7XxzvGXjYhluuv4iFKngVPxG8pNe15DCRTt/wInMwC
	mrS5yHVlGL5eRx/+JKIs8tNc5J1UblSZXCj5FmUjee54HuHRsPiYvMsAo6uZWj9icwkdsgR83NB
	8TMF8yFbXsPcVc0hE4lLzSWuj0w727iUwrWJtL9zW3nQgtCTDQeqEhfUO1K82OD2sy2hk8uBjji
	qg50ofO03RjdMPLZl0eBgZlBnPLGgAK6MnSnmCwemOSRAgThQIAfX09ztkj1ksHRk8CGD7dCCjY
	ZHMoxBbsYx16c7+stvHi9eAB97Xo5bhamOIwA6gzCq9ZKAYckYJyOARJKoCArSON09bFsBenZVY
	HO1oiP2ph31UV6TyaX6cH+LhEh3FsNmd0uqF/WHU/qdgoKfXn+oPWQy3yZxd5rt8sJW7A7whZjU
	hyk
X-Received: by 2002:a05:620a:370a:b0:8cb:4059:a90e with SMTP id af79cd13be357-8cd5afc7e17mr234243385a.80.1772630843889;
        Wed, 04 Mar 2026 05:27:23 -0800 (PST)
Received: from ?IPV6:2001:1970:3847:e000:4c82:63a9:39e9:5c17? ([2001:1970:3847:e000:4c82:63a9:39e9:5c17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6869f5sm1882519985a.20.2026.03.04.05.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 05:27:23 -0800 (PST)
Message-ID: <cf023de9-544b-46a5-8753-54bd79a45f40@baylibre.com>
Date: Wed, 4 Mar 2026 08:27:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] runqueue.py: make sure we use bb
 multiprocessing
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20260303165657.1803606-1-tgamblin@baylibre.com>
 <DB5PR02MB10213F130CD24D9D606824F51EF7FA@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <DB5PR02MB10213F130CD24D9D606824F51EF7FA@DB5PR02MB10213.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Mar 2026 13:27:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19104


On 2026-03-03 16:49, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Trevor Gamblin
>> Sent: den 3 mars 2026 17:57
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel][PATCH] runqueue.py: make sure we use bb multiprocessing
>>
>> Otherwise, we see errors like:
>>
>> |ERROR: An uncaught exception occurred in runqueue
>> |Traceback (most recent call last):
>> |  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib/bb/runqueue.py", line 1663, in execute_runqueue
>> |    return self._execute_runqueue()
>> |           ~~~~~~~~~~~~~~~~~~~~~~^^
>> |  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib/bb/runqueue.py", line 1607, in _execute_runqueue
>> |    retval = self.dump_signatures(dumpsigs)
>> |  File "/srv/pokybuild/yocto-worker/check-layer/build/layers/bitbake/lib/bb/runqueue.py", line 1718, in dump_signatures
>> |    p.start()
>> |    ~~~~~~~^^
>> |  File "/usr/lib64/python3.14/multiprocessing/process.py", line 121, in start
>> |    self._popen = self._Popen(self)
>> |                  ~~~~~~~~~~~^^^^^^
>> |  File "/usr/lib64/python3.14/multiprocessing/context.py", line 224, in _Popen
>> |    return _default_context.get_context().Process._Popen(process_obj)
>> |           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
>> |  File "/usr/lib64/python3.14/multiprocessing/context.py", line 300, in _Popen
>> |    return Popen(process_obj)
>> |  File "/usr/lib64/python3.14/multiprocessing/popen_forkserver.py", line 35, in __init__
>> |    super().__init__(process_obj)
>> |    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^
>> |  File "/usr/lib64/python3.14/multiprocessing/popen_fork.py", line 20, in __init__
>> |    self._launch(process_obj)
>> |    ~~~~~~~~~~~~^^^^^^^^^^^^^
>> |  File "/usr/lib64/python3.14/multiprocessing/popen_forkserver.py", line 47, in _launch
>> |    reduction.dump(process_obj, buf)
>> |    ~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^
>> |  File "/usr/lib64/python3.14/multiprocessing/reduction.py", line 60, in dump
>> |    ForkingPickler(file, protocol).dump(obj)
>> |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^
>> |_pickle.PicklingError: Can't pickle local object <function CoreRecipeInfo.init_cacheData.<locals>.<lambda> at 0x7f7925667d70>
>> |when serializing tuple item 0
>> |when serializing collections.defaultdict reconstructor arguments
>> |when serializing collections.defaultdict object
>> |when serializing dict item 'rundeps'
>> |when serializing bb.cache.CacheData state
>> |when serializing bb.cache.CacheData object
>> |when serializing dict item ''
>> |when serializing dict item 'recipecaches'
>> |when serializing bb.cooker.BBCooker state
>> |when serializing bb.cooker.BBCooker object
>> |when serializing dict item 'cooker'
>> |when serializing bb.runqueue.RunQueue state
>> |when serializing bb.runqueue.RunQueue object
>> |when serializing tuple item 0
>> |when serializing method reconstructor arguments
>> |when serializing method object
>> |when serializing dict item '_target'
>> |when serializing multiprocessing.context.Process state
>> |when serializing multiprocessing.context.Process object
>>
>> Fixes: [YOCTO #16184]
>>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>>   lib/bb/runqueue.py | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
>> index a880a0d54..27da5efaa 100644
>> --- a/lib/bb/runqueue.py
>> +++ b/lib/bb/runqueue.py
>> @@ -21,13 +21,15 @@ import re
>>   import bb
>>   from bb import msg, event
>>   from bb import monitordisk
>> +from bb import multiprocessing
> Is this really needed? You use bb.multiprocessing below,
> not multiprocessing.
No, it isn't - looks like I committed extra. I'll send a v2.
>
>>   import subprocess
>>   import pickle
>> -from multiprocessing import Process
>>   import shlex
>>   import pprint
>>   import time
>>
>> +Process = bb.multiprocessing.Process
>> +
>>   bblogger = logging.getLogger("BitBake")
>>   logger = logging.getLogger("BitBake.RunQueue")
>>   hashequiv_logger = logging.getLogger("BitBake.RunQueue.HashEquiv")
>> --
>> 2.53.0
> //Peter
>

