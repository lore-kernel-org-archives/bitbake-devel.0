Return-Path: <git@cookiesoft.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA167CA5FFD
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:05 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28815.1791229204658227189
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2026 12:40:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cookiesoft.de header.s=MBO0001 header.b=ILtguh2C;
 spf=pass (domain: cookiesoft.de, ip: 80.241.56.171, mailfrom: git@cookiesoft.de)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hz8qM4d28zMlDv
	for <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2026 21:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cookiesoft.de;
	s=MBO0001; t=1791229199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eb1UTjxDkiqPUV23VIGnN1txnXQJJrbje5Up20Q0C0=;
	b=ILtguh2Cb2I6MHLj1e6exYp8IILbQUsN6mAOcv9C99NhHi8sOG3+DYdXmFKQ3MZkOkCPP4
	MTRrKbfp0z9nUFdFn7yGhI6LRBhgwMlcendHIx+ynfhbBbZ+0HqaWL5z7HVpSiv6rMKvSS
	K1wNzp//8GeQkdcq25LFMASX+dBb6rZqpnenz1VpXlYhjS3WxSywf+7tjIwgpQexLsU/8V
	5NIDjbqHqYXEe6JEQ8VsYcMrl5VrDqY8WYP7VD1BtwY/6QiK6QRYaiSG1rbJ89j8D99VTL
	h0+WlwcvN6v7qbBKpxf/RB88Vn5HZbMYR5zTCP2KnUUEisWgA2Vn/jb1Aw2FEg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@cookiesoft.de designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=git@cookiesoft.de
Message-ID: <dd233571-a1a7-4ac9-a98e-124c4beb5cfc@cookiesoft.de>
Date: Mon, 5 Oct 2026 21:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marcel Hellwig <git@cookiesoft.de>
Subject: Re: [bitbake-devel] [PATCH] knotty: add OSC 9;4 sequence for progress
 display
To: bitbake-devel@lists.openembedded.org
References: <20261005083628.1451356-1-git@cookiesoft.de>
 <2d1f4781057f4a1a58ad5f91fa0a2b5a1ec3c624.camel@pbarker.dev>
Content-Language: en-US
In-Reply-To: <2d1f4781057f4a1a58ad5f91fa0a2b5a1ec3c624.camel@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Rspamd-Queue-Id: 4hz8qM4d28zMlDv
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2026 19:40:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20297


On 10/5/26 16:31, Paul Barker wrote:
> On Mon, 2026-10-05 at 10:36 +0200, git@cookiesoft.de wrote:
>> From: Marcel Hellwig <git@cookiesoft.de>
>>
>> OSC 9;4[0] allows the terminal emulator to display a progress bar.
>> This is helpful for the long-running tasks in both Bitbake and Devtool=
.
>>
>> The most prominent supporters are Windows Terminal and KDE's Konsole.
>> Terminals that do not support the sequence simply ignore it, so no
>> special treament is required.
Hey Paul,
> Sadly I don't think we can assume this - not all terminal emulators
> handle these escape sequences properly. We've had issues with this when
> systemd started enabling OSC sequence output by default [1].
I'm not sure if we can directly compare these situations.
When we are talking about OSC in systemd, we are talking about embedded=20
devices and possible UART connections to them, e.g. via minicom.
When we are talking about Bitbake, we are generally talking about=20
desktop or workstation systems with graphical output and a somewhat=20
recent systems / terminal emulator.

I see your point though and perhaps it would be safer to not assume,=20
that the sequence is always handled correctly, but I would very much=20
like you to reconsider this.

> I would prefer this to be configurable, and probably off by default if
> there isn't a way to detect whether the current terminal supports these
> sequences.
Nevertheless, I can think of two possible solutions:
 =C2=A0 1. Provide a `supports_term_progress` function, similar to what t=
he=20
Rust crate anstyle-query implements[2].
This should cover most terminals that are supporting it for now,=20
although it would need to be adjusted as terminal support evolves.

 =C2=A0 2. introduce an environment / config variable, such as=20
`BB_ENABLE_OSC_PROGRESS` that can be used to control the feature.

I would very much prefer an opt-out mechanism instead of opt-in, but I=20
understand your concern about begin=C2=A0 compatible to as many environme=
nts=20
as possible.

Let me know which approach you would prefer.
I'm more than happy to contribute :)

Regards,
Marcel

[2]:=20
https://github.com/rust-cli/anstyle/blob/main/crates/anstyle-progress/src=
/query.rs


>
> [1]:=20
> https://lore.kernel.org/openembedded-core/20260415082949.3446677-1-Qi.C=
hen@windriver.com/
>
> Best regards,
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20295):=20
> https://lists.openembedded.org/g/bitbake-devel/message/20295
> Mute This Topic: https://lists.openembedded.org/mt/121588018/10661791
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub=20
> [git@cookiesoft.de]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


