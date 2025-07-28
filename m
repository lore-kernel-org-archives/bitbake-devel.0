Return-Path: <alexander.merkle@lauterbach.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A28C87FCE
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 05:31:04 +0000 (UTC)
Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
 by mx.groups.io with SMTP id smtpd.web11.75004.1753680656083463808
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Jul 2025 22:30:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: lauterbach.com, ip: 62.154.241.218, mailfrom: alexander.merkle@lauterbach.com)
Received: from [10.2.10.209] (unknown [10.2.10.209])
	(Authenticated sender: Alexander.Merkle@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id 5BE8211C568
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 07:30:53 +0200 (CEST)
Message-ID: <4a0876af-5654-4401-a8a5-f28a0ec725bb@lauterbach.com>
Date: Mon, 28 Jul 2025 07:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake: forward proxy env variables if
 network access is enabled
To: bitbake-devel@lists.openembedded.org
References: <20250725111347.1812105-1-alexander.merkle@lauterbach.com>
 <1855ED6D281A8A7B.1178@lists.openembedded.org>
 <CANNYZj8Es5-t7DChC+jZeLRkD6BaQZarpa9VOefGFZJbVoBzKg@mail.gmail.com>
Content-Language: en-US
From: Alexander Merkle <Alexander.Merkle@lauterbach.com>
In-Reply-To: <CANNYZj8Es5-t7DChC+jZeLRkD6BaQZarpa9VOefGFZJbVoBzKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1753680653378
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 05:31:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17812

As far as I understood the `fetch2` library sets up it's own 
environment,compare [1].

[1] 
https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/__init__.py#n873

On 27.07.2025 00:29, Alexander Kanavin via lists.openembedded.org wrote:
> On Sun, 27 Jul 2025 at 00:24, Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=gmail.com@lists.openembedded.org>
> wrote:
>> I don't quite understand. How does do_fetch work then, without having
>> to do this export_proxies call? It also relies on do_compile[network]
>> = "1".
> Specifically, there's do_fetch[network] = "1" in
> meta/classes-global/base.bbclass.
>
> Alex
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17811): https://lists.openembedded.org/g/bitbake-devel/message/17811
> Mute This Topic: https://lists.openembedded.org/mt/114335899/9941510
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexander.merkle@lauterbach.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

