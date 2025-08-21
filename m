Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC0CA0EF8
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 14:23:22 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.10788.1755786195655245386
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 07:23:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZQpuCo0w;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61a94bd82a5so1958491a12.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755786194; x=1756390994; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUqsHcpyjTQf2ySIUYtkjPsIPOgj8D+xVkc7y0m1o8Y=;
        b=ZQpuCo0w25LAzvf3k645dSY5o0vuRt64QDYh2SWEG6U1WuKutbwewVpZbljlBk4h49
         +vumctYWtC2cB8D28FQ6QFBbB+9Y5h6nWFT0hi6JVv3g2jK5QKeMqJep5COzjMOUaEBc
         +b/hhVZkCzZ1kPZOGrblprKLadZFRrug26M4LG74GrpTbPVwdVXpNDFS+f0jtqAUKN6j
         Ef+lCpVVIahWiWq5M0p3fcM+Iz9orzPu0HJU8BSSiW8gpfSAukVIDsPMEoRIx5StQejA
         QRORUyGp/BTQrWaSbzrSscpW8H/2L7vIU5S6AuWfDz9BNFFSLyTxq0nM+L5Ih1NVnFjJ
         YdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786194; x=1756390994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUqsHcpyjTQf2ySIUYtkjPsIPOgj8D+xVkc7y0m1o8Y=;
        b=nBT+YJ/ArcFNfJClIrHh6KJ2RwTJOxVV5+kFbUP0LrskcrB72ySt1/3J1uQ3aOj7qa
         7cqPIJIpqACor+eP3ylnMIA54+oFAJdzEarC6UvOWZ1NtLXVGxu0WfZL3nwJRVTZ17fQ
         fXpDiYTq+hWwuka/wikv1hBXmfEJPISkt+NJfzqtuzi18wshCh/PcbxhMmqR1IIwdz/g
         CQT6B9bhAQktcJ2mHOiGBZyr3/1souwg/sQjKi2wXUCe0LCfzV/k5a+r67zdWf6JamTM
         8XoV5dqo25F66joPjJdgUP95jNa6mIIFYq05He+dGzldoyLlGKwUtfc6Wd0ACKQO5Lj9
         0ayg==
X-Gm-Message-State: AOJu0YxQIHuU6g66Zy885JaamovAAooQ0Dvq1inEe/vqneVIdb3/alG7
	WnhjxHfgzNiaIQ0Eq3xdBZYlwSNv6FtRoNPivISLBhlnyjDUh0J/9vhn
X-Gm-Gg: ASbGncvb9ThptKWO65wcAwMw96GMRTKPSd+vnJKoxfEtsjirQZFtScFMaroFNJMvrYR
	yodHJ4ruYVpU3X2n9ptvb96f1vMKCp3JLleGFhjgFkcclb4FinumT3OO8AbVOrUtjXva8w4XbDT
	XbxGOZFRBaALeqsQSpRTLQq9KnoBCEf+SbHKTiM22+WatT7XHA4IR4Ww4TOiRvmO0samDQAec2y
	ZgEk7IFmnfYffeI+Ggx9ANgm2MlvEOsSE+P2htfO0/EdJt750ul0p9SL+mdESY5tZHCp5EGUa+l
	RcIpVv+5EFb++0Mkr5gttw6qqZ8/YGHUkrfiUv6j8o8kO2zYgjyvwnbF1lkjhcJ9+x/Vp2iy4Lp
	bRarq2GFhndTnLc664btyOU3xqa6xIY2WLk7ezyjSzg==
X-Google-Smtp-Source: AGHT+IHraStAf9Udgo/4bizrk2dSz+YADa6iwDZ8RDOMXDJLUM7gmnv9GpYZ8nvnrNfY25wCN3Buhg==
X-Received: by 2002:a17:907:a089:b0:afc:e710:a3dd with SMTP id a640c23a62f3a-afe07e20a53mr268480666b.53.1755786193483;
        Thu, 21 Aug 2025 07:23:13 -0700 (PDT)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded5353cdsm400363166b.106.2025.08.21.07.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:23:13 -0700 (PDT)
Message-ID: <a38ebcb3-5cc5-439f-b572-7706955a4e9c@gmail.com>
Date: Thu, 21 Aug 2025 16:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 Alexander Kanavin <alex@linutronix.de>
References: <20250821130715.1904574-1-alex.kanavin@gmail.com>
 <9cfa7c31-cbbc-43a3-a65b-fcb9984c6757@gmail.com>
 <185DCE00410AEB1B.11247@lists.openembedded.org>
 <CANNYZj-j5KLGwhzCHyU1t_+gVr=tVF8CTtc4+FpR6eOhgq6E-w@mail.gmail.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <CANNYZj-j5KLGwhzCHyU1t_+gVr=tVF8CTtc4+FpR6eOhgq6E-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 14:23:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17909

On 8/21/25 16:21, Alexander Kanavin wrote:
> On Thu, 21 Aug 2025 at 16:18, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
> wrote:
>>>> +    bb.process.run("git -C {} init -b main".format(confdir))
>>>> +    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'".format(confdir))
>>> Possible bug: This throws an error if git email and name are not
>>> configured ("Author identity unknown"). I tried "bitbake-setup init" in
>>> a docker image, where I use git with untouched config. But when I ran
>>> the same command right away once again, it succeeded, saying that it was
>>> already initialized
>> Yes. bitbake-setup assumes that 'git init' and 'git commit' work, as
>> it maintains a local history of configuration revisions with it. Can
>> you look into how this can be better handled?
> I suspect this can be fixed by passing a hardcoded --author=...
> parameter to git commit. Can you check if that works?

Yup, will do.

>
> Alex


