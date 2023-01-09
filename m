Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8A2C54EBE
	for <webhook@archiver.kernel.org>; Mon,  9 Jan 2023 14:40:09 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.73411.1673275200440689407
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Jan 2023 06:40:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=LR1eGFWD;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id ja17so6426023wmb.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Jan 2023 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCnR6731z1l6MsNDXcJcYMsDY+0v9elvQV8C/iDABZ4=;
        b=LR1eGFWDzKiPPLFEcz6zQ1zlJb68b+nQdwb1mnzJC83nHPr18GyF155s+/nx7XqMc+
         0FrJhvWvgRCqFn3T75M+N+wIo79k13S3jODZnmRn+BXUXpV+CSPgYGnygYR7OgkRKeiS
         Gy8wmmxWDZCCXbx/3WdK8TIB0m1OhMCOcPoirSFFryYSuNwv3eGFVZLra8BkeLXzGTTs
         7Pd54ZTOFrwOoJFPEt0owS5gW+AB5U6fGFGQGzRA5DmYJNSL0EE1MiOHJam45qBxhUCN
         Wwa4kpHDlHeXB1EUji8HUHbBTcX+0mk8ktmDVlCSnVWSnULNrq+ggBEKWqVXppYIW6qz
         DzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCnR6731z1l6MsNDXcJcYMsDY+0v9elvQV8C/iDABZ4=;
        b=stTwGUPMytemCLBEAK3anFksboR3EdRvcW9rP8vp3RjoQ0ZK9oQy2gGN8PwIXagdTC
         ia2HgUgpB8284QCSS7Fln70NdH88D3Y37ArzTLI0Bd5W1Xv+F2ataTgFJ9veyTjePGuO
         eWhxvla/EfkL/G67H+sABe/4jP2FD5MBckCYLA51YlvQaCyaI8v2J/hVBGcAfij8Q8IG
         HzC0TbsRcPscUSB7ea2SvYtfVyAfRNDYL/9ypwjWKawbk3gxpklKyo5P5RO6e1m4Rsi6
         SmVBViXmkAYR/CXPgWnCvqVfp/xj+Wdt59X5b186OVzAekLz2OGr5MTu0Hjv4N70JgzY
         I+nw==
X-Gm-Message-State: AFqh2koBezDJ4teDNTX64EUowTiVUYoNgP0CVCtQwtYv6Zzsfep8Kyio
	hzinte+NzEJhfyzJKmD2e5Vrjw==
X-Google-Smtp-Source: AMrXdXv1IojSjhlV49mF8HYKC+RPI5lyBGTsDVe/w0K0oUlC7UHACt13gKMiQXp3XvG1S5uxQ9K6gw==
X-Received: by 2002:a05:600c:1d0e:b0:3cf:7c8b:a7c7 with SMTP id l14-20020a05600c1d0e00b003cf7c8ba7c7mr46151213wms.39.1673275198922;
        Mon, 09 Jan 2023 06:39:58 -0800 (PST)
Received: from [192.168.0.28] (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4cd1000000b002365254ea42sm8770391wrt.1.2023.01.09.06.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:39:58 -0800 (PST)
Message-ID: <f7db8eb3-1b77-0045-676d-754b1882f2ed@smile.fr>
Date: Mon, 9 Jan 2023 15:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] Group and reorder options in bitbake help
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <1737BD92075F06D0.26636@lists.openembedded.org>
 <bf7521d9-5a6d-c33d-53bc-01dbcfae91c3@smile.fr>
 <58bb68ffb87e64c7ad6f63bd08e33873c329aaf4.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <58bb68ffb87e64c7ad6f63bd08e33873c329aaf4.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Jan 2023 14:40:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14294

On 1/9/23 15:22, Richard Purdie wrote:
> On Fri, 2023-01-06 at 15:20 +0100, Yoann Congal wrote:
>> On 1/6/23 15:09, Yoann Congal via lists.openembedded.org wrote:
>>> Fixes [YOCTO #12018].
>>> 
>>> Also, I have included some small fixes: * added a '.' at the end
>>> of sentence where it was missing * split some long lines
>>> 
>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr> --- 
>>> lib/bb/main.py | 222
>>> +++++++++++++++++++++++++++---------------------- 1 file changed,
>>> 122 insertions(+), 100 deletions(-)
>> To help review/discussion, here the new generated output with the
>> patch applied. Please note there was a discussion in 
>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=12018
> 
> This passed testing and has merged, thanks. I think the output does 
> look a lot better.

Thanks!

There was a suggestion from Ross in
https://bugzilla.yoctoproject.org/show_bug.cgi?id=12018#c9

I'll send another patch.

> 
> Cheers,
> 
> Richard

-- 
Yoann Congal
Smile ECS - Tech Expert

