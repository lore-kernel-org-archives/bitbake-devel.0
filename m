Return-Path: <uvv.mail@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4605D4A5F4
	for <webhook@archiver.kernel.org>; Sun, 18 Jan 2026 08:48:32 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11515.1768726105236992087
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Jan 2026 00:48:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sk1k3U+c;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: uvv.mail@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8010b8f078so563236166b.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Jan 2026 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768726103; x=1769330903; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9WWCf5Kg7jOTQieK5vI/dKr7ishsye9VZNK1VqsAns=;
        b=Sk1k3U+c82Fb2Tg/SxlceGuNvPlMTQWcDbJqG/WY6sMjkLD2nbWzCf53+iS4rKxQN0
         6OLHt44cS0WtS1prKimGhnNX+5pFGgg4tQuX4RzFN4KWSPf162/zttFbW/hd7qIiwP0N
         KExoczb4aiP+AR95oHp2Fw/JbFuUjL9yVHqaXb9znMe5zixN3L7DMdVVVbZ4FSKocBqT
         XLhddujZgSr31ilziM5Gw/2rIIlXwqfnTY9uPDzMQas3OHDnQTMfXndBQg4SP9Fd93Iq
         TPl1L/c2XcBo4fo3vdHLnqHa833Gtar66UVM+wkY8cAOiCQ5r4wfNeLzplmNWuDxGDGH
         vwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768726103; x=1769330903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9WWCf5Kg7jOTQieK5vI/dKr7ishsye9VZNK1VqsAns=;
        b=d7ZfadNR+QGReAtHOgKXAiXXO/YFterEEOAtOtSxLrwVgdYGq8WAiufcXRv+DvliQv
         Nv3wH9uq9a16fAkacAphHqeTMVrPFabvtyYbdsZMXGvHxMJ1W2YzkyKYMUXhE9+Lqpal
         BASa1PDeqHMDiDO9r9utlAcHM7FtH9qrsd8LL0T7N7Z+j5X1lAzkopLnhtYYmAeCfMEV
         lCa4qxO0RdnKZyYLKdT/oivEnKRkueNipwvxMKQNYihEK5u8kS2Chhgpor9XS3OuFVFb
         zXGI5/ZmIQ9rjHomgjVy2BNMU8jRr6xEZiDGhDkqfKCmukC6bTp4Anws47Dp9Bxg8J8x
         ax9A==
X-Gm-Message-State: AOJu0Ywp+ZceeGt5SYhzowJcdd7hgN4Vi32EUcTJIK9fw2FsDYchxz3L
	NljbGlXAvNIQOZ0K35U4VQBGyBx4E8FThCFN8TUgmefPJD2C7wor+5wn
X-Gm-Gg: AY/fxX55vY1vWJ7djdx+/RHFfVrj5/MFvMmhkRZspoIkHOFaORvxuONpZ/i7aN1srge
	VZ0SAKCzwPAEhWYiewHErpGuuqq42wDKs5S4pjG7rRLm6qk1cuLlv2CH43AsbxvcIxUEyldX6Eh
	nbOFE8Wg7QamTaXoUg63DXzGTfQweAML2/yXd9lWW+JI65D/VfHpiaLCZ5Eaqwnfx+9zyMg/N/g
	/vpcn7CJojGjF7IF3tuIty7Q+SbMlJzuUMcwpm2ARPookm+pyC2rtlcJZQ9OMRjE+uxtgkiXS0i
	3tYI8FFkhnL80qM4D3iM+RwNGBM26LkF5guGxG4bzM+lwCN4n+pwblTKZxW7sGuujXnsJROl0P8
	0lhmsWWaHPSzc1jmy1uynHemjt4drqOnhO+RhmwFueFOwjTe/XU3aYPSGjIcOMkvb8QlTFNHKqe
	p0DCcKoLqiotWfRjWqIlWwtUkRtfObXfm8IVid
X-Received: by 2002:a17:907:94c4:b0:b87:7485:b4bf with SMTP id a640c23a62f3a-b87965c103amr644148166b.0.1768726103336;
        Sun, 18 Jan 2026 00:48:23 -0800 (PST)
Received: from [10.54.7.179] ([154.47.27.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e9f3sm771677066b.10.2026.01.18.00.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 00:48:22 -0800 (PST)
Message-ID: <df05a1fd-23ba-45be-886e-886e4a79cb74@gmail.com>
Date: Sun, 18 Jan 2026 09:48:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] bitbake-setup update problem
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Yoann Congal <yoann.congal@smile.fr>
References: <a0cf0864-dd61-48db-b856-575f8fc4c149@gmail.com>
 <CAMSfU+71B0VQvP7U5BPDcgY++q=PMY3pfTOWdOREXorwAAU9bA@mail.gmail.com>
 <1dc33b07-759f-499f-82cb-84e5c20f77ec@gmail.com>
 <1883858B93EFC423.1614991@lists.openembedded.org>
 <188385EDFF4B6429.1342979@lists.openembedded.org>
 <18870377D56AF168.1986633@lists.openembedded.org>
 <CANNYZj8+msix6SFiCH=4UcLogt-+zA6=keGtXtBPbTE8vKTqoA@mail.gmail.com>
Content-Language: en-US
From: Vyacheslav Yurkov <uvv.mail@gmail.com>
In-Reply-To: <CANNYZj8+msix6SFiCH=4UcLogt-+zA6=keGtXtBPbTE8vKTqoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Jan 2026 08:48:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18803

On 08.01.2026 13:14, Alexander Kanavin wrote:
> On Fri, 2 Jan 2026 at 21:19, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
> wrote:
>
>> I posted a patch which adds the local modifications check.
>> Unfortunately I couldn't figure out how to check for additional local
>> branches: it checks only if there are uncommitted changes, or changes
>> on the current branch. If you have ideas I'd appreciate (simply
>> running 'git branch' and counting the lines does not work, as git
>> fetcher's unpack first unpacks master, then checks out the final
>> branch if necessary, so both one and two branches can mean no local
>> modifications).
> The more I think about it, the more I'm convinced git repositories
> managed by bitbake-setup should have a commit hook that prevents
> making commits altogether and tells users to use 'bitbake-setup init
> -L repo local-path'.
>
> The local modifications check should remain, to guard for cases where
> there are uncommitted changes.
>
> I'll make a v3.
>
> Alex

This is why I don't like 'repo' and other wrappers that require that. I 
don't want to use another tool on top of git.

Slava

