Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91209D6A251
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 22:22:58 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.7041.1731622973384305429
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 14:22:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CTVMhFjF;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43159c9f617so9331715e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 14:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731622971; x=1732227771; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aCDbcV/0aMjs45yWe8ZdaHgphAyhp4BU+/ItN6Yrd6s=;
        b=CTVMhFjF6CNS7MXl8YuVjz3QsVcLaJFrG70P3iccT7HpqdVCcz5H3r8IphoQO/9U7N
         BOs22NT46GZJKN59IPqUM/WOe2IeE78Z03qxkcc7tO9rOokKmRPeMAVWXV4+DMEDThjZ
         RA7dmsYTkJqz/2R4Mnnrde8eeiBZ2xcUhPAC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622971; x=1732227771;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCDbcV/0aMjs45yWe8ZdaHgphAyhp4BU+/ItN6Yrd6s=;
        b=iM4po7MSUtfqlpGeFXnuSK2ZTpd5JpujV/POXjecub+qoiCbSmOW2IkRWXdN3RzBFX
         idYotGFNsRTlG41AeH7c8VCuuJcQt8bDWg/PTBgrSPMMl1k3ibK7oLvV7AOK+SSs816v
         LAoJgwpvyXhZ44bhQMzAjyF2E2DaqgbYvWpKMLKCcvIp42vBc679ugvzqkT6erA1u12y
         GpY4oWaWS+TU7++IM82pXjPn9r2cDbQNF/kpSDjBh7DB1UvW0R5ZKr07SvGuE/1hTbVE
         pFTRl4OlONH857dYxs6zIt99+4DrHaX1my7t9TSd/fQd71GKKGZ2BG8/xvd+meSRfti/
         lUCg==
X-Gm-Message-State: AOJu0YwOOxavFNzwcKbEg522ZKNoMjloiAn1LQNJzBaT2e6cf2l3R9J3
	LDZ2riD7eOqS4X7ULnITsiYoLjgWlBFippZdhCC2/e/OZu6rWUr19663R3O3Lwg4KQPpBe/elkD
	a
X-Google-Smtp-Source: AGHT+IFXXp6cQa4hLEEc+Q4q1Zc1XyMGR7TvSq7eq4NhN0FTQPBFrmkk40e8Tqt35fSZk0znNUG9aQ==
X-Received: by 2002:a05:600c:5121:b0:42f:7e87:3438 with SMTP id 5b1f17b1804b1-432df67990fmr3343685e9.0.1731622971248;
        Thu, 14 Nov 2024 14:22:51 -0800 (PST)
Received: from ?IPV6:2a04:cec0:11fb:21bd:1f18:7aa1:7b8e:5f4a? ([2a04:cec0:11fb:21bd:1f18:7aa1:7b8e:5f4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265e0bsm37187085e9.15.2024.11.14.14.22.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 14:22:50 -0800 (PST)
Message-ID: <40231677-474d-494f-8651-77b15c7049bf@smile.fr>
Date: Thu, 14 Nov 2024 23:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-getvar: use finalizeData
 tinfoil API to get identical result to "bitbake -e"
To: bitbake-devel@lists.openembedded.org
References: <20241112230559.2035910-1-yoann.congal@smile.fr>
 <20241112230559.2035910-2-yoann.congal@smile.fr>
 <ZzS8nf1QeJ1oU7Ob@bootlin-mathieu>
Content-Language: en-US
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <ZzS8nf1QeJ1oU7Ob@bootlin-mathieu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 22:22:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16803

Le 13/11/2024 à 15:50, Mathieu Dubois-Briand a écrit :
> On Wed, Nov 13, 2024 at 12:05:59AM +0100, Yoann Congal via lists.openembedded.org wrote:
>> From: Yoann Congal <yoann.congal@smile.fr>
>>
>> Fixes [YOCTO #15638]
>>
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> 
> Hi Yoann,
> 
> I believe this commit is responsible of build failures on the
> autobuilder, on oe-selftest* and *-tc builders:
> 
> RuntimeError: core-image-minimal - FAILED to start qemu - check the task
> log and the boot log
> 
> https://valkyrie.yoctoproject.org/#/builders/28/builds/402/steps/12/logs/stdio
> https://valkyrie.yoctoproject.org/#/builders/28/builds/402/steps/12/logs/stdio
> 
> Can you have a look at this issue please ?

It was indeed my patches that created the above issues. Nice catch!
I've now sent a v2 that fixes the failing test locally.

Thanks!
-- 
Yoann Congal
Smile ECS - Tech Expert

