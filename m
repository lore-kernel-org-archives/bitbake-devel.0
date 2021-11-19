Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B45C433F5
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 05:11:42 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.4635.1637298701676184421
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 21:11:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=gjLi/AmN;
 spf=pass (domain: gmail.com, ip: 209.85.167.52,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f52.google.com with SMTP id z34so37783108lfu.8
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 21:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tjJq/18FdWDfwUaI8wjAdurfwzV+pkBaiMMa/viChO0=;
        b=gjLi/AmNG0xyPAlJOQfgIz+yDjfYiY5z0I17hJ3mQ9YFPlFJdn2nKv3LTTXaf6T8Dp
         peADqGmB3Xt6sx/UoD7htyUzxTdjDFOsG8Eu05njm1pGGPfmkTBGwzPh95XJWJbHJGeX
         7ZAYqz61u8lSS2PojOkfOALEpBivHQXmtNjzQZ3A0zsANrc6/21ge+mjBPjNUG4nalXG
         hM+N6YX/uiGVdn0WcBWu0YZVi7Jqmm3oCkq5vbC2Q/CmxdPSNMnCpTDKe5FH0hgn1mO/
         k+g/lf0gzXpjoWR7SkBRQcMl8rB2JXNanhghpJqa1pTo249jj4p9KRE10/3/SCtvEWGT
         xryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tjJq/18FdWDfwUaI8wjAdurfwzV+pkBaiMMa/viChO0=;
        b=u6ztEmgdL7YepMRJBfd2Fashreo9SAR/aaeM4EIYCMSjlFiPtv04EdvkODQfZFLn4Z
         IjPznigwOv6XalbV7hm3a5cefevZLdEp0GOXNQygCy7arCedLh1uCaPq4vWE39Z7CLxq
         Ie/TsSnD4581Sh1EfaPNqt3hW6XzSFBsBp/Ds7YkLBxt98ybDS3DcRUgx9C6VMav9VJn
         RAWhH/gbJTVBk60BFPlh07XOoO9m0GxWlGNMkVDo16fc3qsU3Soq0Phm+mTYOoWqTl2H
         oFsjsCe4rQ2QwN0zp546gfjs/IZLCpy/H6R9jsViWpd9EYlUV8QNvsVPLgt9ndGsapKo
         Sc9g==
X-Gm-Message-State: AOAM5305FxWneILQkbSZ0puvEB1IYO7LFKRGevTFoCKnvwuYZUD8JKhd
	Qn1IiLiF8xT2ku8oxHsql40=
X-Google-Smtp-Source: 
 ABdhPJw7sMvBKntFjDHuTk+Ern5exzQJVPjpVLr5DbfMr2RXUtHEFsghLzmN4UyJx6O8z7b2Rv3WQA==
X-Received: by 2002:ac2:4312:: with SMTP id
 l18mr29482521lfh.602.1637298699475;
        Thu, 18 Nov 2021 21:11:39 -0800 (PST)
Received: from [192.168.10.175] (37-247-29-68.customers.ownit.se.
 [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id
 x27sm243766lfq.192.2021.11.18.21.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 21:11:39 -0800 (PST)
Message-ID: <1ddd2d5d-addd-6fce-628a-253ddc137255@gmail.com>
Date: Fri, 19 Nov 2021 06:11:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [bitbake-devel] [1.50][PATCH 0/4] Backport fixes for python 3.10
Content-Language: en-US
To: "Mittal, Anuj" <anuj.mittal@intel.com>,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20211118162623.3117035-1-jacob.kroon@gmail.com>
 <SJ0PR11MB4896E641713CC8C0787C9E28F89B9@SJ0PR11MB4896.namprd11.prod.outlook.com>
From: Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: 
 <SJ0PR11MB4896E641713CC8C0787C9E28F89B9@SJ0PR11MB4896.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Nov 2021 05:11:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13076

On 11/19/21 00:35, Mittal, Anuj wrote:
> Thanks, I already have these in my queue and would be sent as part of next merge request.
> 
> https://cgit.openembedded.org/bitbake-contrib/log/?h=anujm/1.50
> 
> Thanks,
> 
> Anuj
> 

Super! Thanks Anuj

/Jacob

>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-
>> devel@lists.openembedded.org> On Behalf Of Jacob Kroon
>> Sent: Friday, November 19, 2021 12:26 AM
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [1.50][PATCH 0/4] Backport fixes for python 3.10
>>
>> Backport fixes for running bitbake on Fedora 35, which ships with python 3.10.
>>
>> Alexander Kanavin (3):
>>    bitbake: correct the collections vs collections.abc deprecation
>>    bitbake: adjust parser error check for python 3.10 compatibility
>>    bitbake: correct deprecation warning in process.py
>>
>> Justin Bronder (1):
>>    hashserv: let asyncio discover the running loop
>>
>>   lib/bb/cache.py          | 3 ++-
>>   lib/bb/data_smart.py     | 4 ++--
>>   lib/bb/persist_data.py   | 5 +++--
>>   lib/bb/server/process.py | 2 +-
>>   lib/hashserv/server.py   | 4 ++--
>>   5 files changed, 10 insertions(+), 8 deletions(-)
> 

