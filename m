Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1E1C54EBD
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 07:44:16 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.49498.1673509451928815106
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 23:44:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=6wJjiIpA;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so15929328wms.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 23:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bDKUnvjsWaGY4AbGKa8tQZKnix69z/qC8Vjc8HrAod0=;
        b=6wJjiIpAMCIbKre837YY8dVUvoXnp/s1Yai6juWUGk9FkkoE6A+XP/qQweemyGgdCq
         6x0C5w05AIGpe0zuOI/dRQVcH/mNQ7qqVlfyl3E2fUhx1YvfOOk2QCViij9laRn42kha
         nI8No+VR65QjjuPrxXyh2hiT02p93mU52JXoGIf4Qz8nuOIwlTvJiuSU/u+5Ou8nhPRp
         g5ZNZZyVV5R88gCglWagRRIt5sp8sO7fmxK1vaBGiRR2ocoPTY+ozqh9EFakGTCMgaw0
         uehiQbvXOBhftFxtSgSkelHsaxII9SKm3dnQtz3WuMKFy3DNe4hvo3cO6Ce2sY1ZUU3W
         f7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDKUnvjsWaGY4AbGKa8tQZKnix69z/qC8Vjc8HrAod0=;
        b=SGIl+ecsNMGRjxqpz4tcFnagNfM4Oh9Y9uBJpvek7GChenGDc2G0H5B10AMjeaEyOV
         pBhYnLaQ10dXAzox/22pg6cSWJWAG6yF9SD5LFLhxn44F4+JEdnIg6SDhktLG7ON95SR
         LMu6TXSuLHDENcvyTRjRFD/iO00QR/9Hd40doXMIrH1ibmo0b0i6JpFm+dVU2Ogq6fuL
         tR6yWvjnShvPMSLzZg3BUigh8ptHM5b2C81q3QcUbrSaNzaBYM+vGD+sjMOro89wQUYp
         mMNBlAhtrrzTNPoAg1jCXABec7/ZJ0ZO1eKcYqdtr2EkrfWaHgTWtsWK0oYUBAodcB/D
         7dqg==
X-Gm-Message-State: AFqh2krDgCfQX1rVapR22nJDpZO79IpDnGyNKaHP83wzRyiyICRAmNjD
	FS93MCEu5kFjF9S+kwtR2+dWGw==
X-Google-Smtp-Source: AMrXdXsMyK/T1mQWHhWPZlUnJ1NpGVsggFik0Hw6oGsB5YFl+DOJxNoMmNXTnvbXPDcpJF5WcirsfQ==
X-Received: by 2002:a05:600c:3d8b:b0:3d9:f0d8:708c with SMTP id bi11-20020a05600c3d8b00b003d9f0d8708cmr10435585wmb.26.1673509449917;
        Wed, 11 Jan 2023 23:44:09 -0800 (PST)
Received: from ?IPV6:2a04:cec0:1054:ad64:c3b0:9f95:abda:1115? ([2a04:cec0:1054:ad64:c3b0:9f95:abda:1115])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c544f000000b003b4fe03c881sm24858090wmi.48.2023.01.11.23.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 23:44:09 -0800 (PST)
Message-ID: <7601e862-e762-6594-01b9-b1fbd6854513@smile.fr>
Date: Thu, 12 Jan 2023 08:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] persist_data: Handle sqlite error when
 cachefile path is too long
To: Randy MacLeod <randy.macleod@windriver.com>,
 bitbake-devel@lists.openembedded.org
References: <20230111223729.3472181-1-yoann.congal@smile.fr>
 <c957c661-c904-62f0-66ea-1bfab679ba25@windriver.com>
Content-Language: en-US
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <c957c661-c904-62f0-66ea-1bfab679ba25@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 07:44:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14307

On 1/12/23 03:41, Randy MacLeod wrote:
> On 2023-01-11 17:37, Yoann Congal via lists.openembedded.org wrote:
>> Sqlite can't open the cachefile when its path is too long (>= 505 char by
>> my tests).
>>
>> We do have a path length check in sanity.bbclass but this code is called
>> before sanity checks.
>>
>> Treat the error in the exception instead of checking before hand in case
>> sqlite eventually fixes this.
> 
> Nice.
> 
> Did you re-open the bug upstream to see if a
> longer max path is acceptable this decade
> &&
> got a link to that?

Nope, I did not re-open the bug. I was somewhat calmed down by the sheer 
list of supported systems by the code which include the sqlite limit :
 > This file contains the VFS implementation for unix-like operating 
systems include Linux, MacOSX, *BSD, QNX, VxWorks, AIX, HPUX, and others.
My guess is: one of those impose this limit.

I'll look into this.

> ../Randy

-- 
Yoann Congal
Smile ECS - Tech Expert

