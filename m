Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B98C54EBD
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 10:51:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.51867.1673520703989595402
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jan 2023 02:51:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=a4c8EHMb;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id ja17so12893030wmb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 02:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNo+EgMSkSet3Ud1I4agPFaeisbuvRevJbohmk9/zkY=;
        b=a4c8EHMbE0J4jwQAkgtnegazFIgwd07H/P/y0fmYT61cFsSGocUhw4F4q5G8+t0grP
         fzJnv3N0ekc8gETuU+b7wGBJmKn7mgnRv5ZWe0xyH80E62UrG8ezyb+QKfUFWCn3rrma
         HHfq6Wli2vBizMDp5H1IrD5GyK8341V5oqbFrOQnnLfvs9P1vyxxVtKrEttQ+QWUv1Am
         Pe5FDlYduHsdRjB45cHI7byjQPxe+ySsyZbEx1HMhxcYWnNl8k0oHV7pwfKz5X/Smr0y
         iFrg95DY+UTorFBToTSH+nIY4hpuMEniG13Qcr4NrnbJEVYpe+Jut0QOPbV8EQ66S8M7
         agPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNo+EgMSkSet3Ud1I4agPFaeisbuvRevJbohmk9/zkY=;
        b=CWHdKmS6PVRqv5PLWt3SphmKf1+0pCGZH/dvDg7ADJrUKZJq2DzIRcnH1IpuqjhFQ/
         BBtGj6QEty4+n5oRLW+GpvmkQxHMFtGwcpnRih6i0r0szfVP7ikq+dYVWJ8TJn2ib5q5
         DbQtwR3HKn/UN7QwwB9l+34iWIwludSVx60FuqfnzI7khxUMFTcNySB08yN67PeNhwo0
         JlhsboQpyMSNwPxJHPjfxk9E/k+Wk8v4Rzi0inid4+HDQSCq1Bc/VZv/M8vPXnEzsf+Q
         AYi+WMOX+zuL2V3QGrp0ADlTP2w0RyvrGKCCHHKpxlR9laHA7Hqzup5AahWVqRKi0T1/
         oM+w==
X-Gm-Message-State: AFqh2kqlu37HerrBomLgwA1gOUeIVHKTbeLeGN10CWjMtO7OSd3CvxE2
	uf11YgTFHRg/oHBaKSZtt2gHoA==
X-Google-Smtp-Source: AMrXdXuyQyWZhpfyDP20M/4iFboRkcl00NesSSC+wixo62FvSWaaIVeQ9pQpXZOBFmTmneZ0bpvnnA==
X-Received: by 2002:a05:600c:4e09:b0:3d4:5741:af9b with SMTP id b9-20020a05600c4e0900b003d45741af9bmr58637528wmq.0.1673520702144;
        Thu, 12 Jan 2023 02:51:42 -0800 (PST)
Received: from [10.1.8.202] (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id by12-20020a056000098c00b002bdd8f12effsm652839wrb.30.2023.01.12.02.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 02:51:41 -0800 (PST)
Message-ID: <713da91f-3704-af9c-da54-31cf6a7908f0@smile.fr>
Date: Thu, 12 Jan 2023 11:51:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] persist_data: Handle sqlite error when
 cachefile path is too long
Content-Language: en-US
To: Randy MacLeod <randy.macleod@windriver.com>,
 bitbake-devel@lists.openembedded.org
References: <20230111223729.3472181-1-yoann.congal@smile.fr>
 <c957c661-c904-62f0-66ea-1bfab679ba25@windriver.com>
 <17397FFB097E5AFE.23170@lists.openembedded.org>
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <17397FFB097E5AFE.23170@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 10:51:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14308

On 1/12/23 08:44, Yoann Congal via lists.openembedded.org wrote:
> On 1/12/23 03:41, Randy MacLeod wrote:
>> On 2023-01-11 17:37, Yoann Congal via lists.openembedded.org wrote:
>>> Sqlite can't open the cachefile when its path is too long (>= 505 
>>> char by
>>> my tests).
>>>
>>> We do have a path length check in sanity.bbclass but this code is called
>>> before sanity checks.
>>>
>>> Treat the error in the exception instead of checking before hand in case
>>> sqlite eventually fixes this.
>>
>> Nice.
>>
>> Did you re-open the bug upstream to see if a
>> longer max path is acceptable this decade
>> &&
>> got a link to that?
> 
> Nope, I did not re-open the bug. I was somewhat calmed down by the sheer 
> list of supported systems by the code which include the sqlite limit :
>  > This file contains the VFS implementation for unix-like operating 
> systems include Linux, MacOSX, *BSD, QNX, VxWorks, AIX, HPUX, and others.
> My guess is: one of those impose this limit.
> 
> I'll look into this.

Here the "ticket" I opened with sqlite (it's a forum post):
https://sqlite.org/forum/forumpost/0b1b8b5116

Regards,

-- 
Yoann Congal
Smile ECS - Tech Expert

