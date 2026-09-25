Return-Path: <git@cookiesoft.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DABC98321
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 16:56:49 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2930.1790355407038860342
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Sep 2026 09:56:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cookiesoft.de header.s=MBO0001 header.b=I9cq6F8W;
 spf=pass (domain: cookiesoft.de, ip: 80.241.56.172, mailfrom: git@cookiesoft.de)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hrxgZ20PczMlNH;
	Fri, 25 Sep 2026 18:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cookiesoft.de;
	s=MBO0001; t=1790355402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvXuX2qJ3LKz3Gc3Csr6HLjN/GfPJf0ybR2Wru9+NGw=;
	b=I9cq6F8W7qKjxvm7QTB17oOsapie6E6IvazQ7OUQ3nXM9bqT5PF4vr8z/cOwucCMfT0V+r
	niWfFTNW1Jg//gH7BNypqqwoT76Kbv+zCHgjJj1L2DAEyB5+1cQ9uhgqd+dEjWU1vuhn2R
	+1NSG/P80ezJKJxdd+0JaIKJFBdAiupjYHtMXfjie1j6IuNxKzalQFt+reyeFL12DKxYzy
	t0HmzaqrsUHANY6auVmG10JiL+Q0NoL8ll4jVebe1QHOLksJdCJw2N/WhOf5x5Ub0pLBP3
	RCrVDIKRmf9SahOjITiQacwGUdDIcW5eGLSKqz1KhDkwt3piB3zsRANwjRQyGg==
Message-ID: <5a5a2a4c-b64b-4709-8596-f722485e4468@cookiesoft.de>
Date: Fri, 25 Sep 2026 18:56:39 +0200
MIME-Version: 1.0
Subject: Re: [bitbake-devel] Add OSC 9;4 to bitbake terminal runner
To: richard.purdie@linuxfoundation.org,
 "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <719659404.262685.1790338566452@app.mailbox.org>
 <9f14d7c0579a4e72521d0a8e52c5d5c14ea64e84.camel@linuxfoundation.org>
Content-Language: en-US
From: Marcel Hellwig <git@cookiesoft.de>
In-Reply-To: <9f14d7c0579a4e72521d0a8e52c5d5c14ea64e84.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 16:56:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20257

On 9/25/26 16:57, Richard Purdie via lists.openembedded.org wrote:
> On Fri, 2026-09-25 at 14:16 +0200, git via lists.openembedded.org wrote=
:
>> Hey everyone,
>>
>> BitBake runs can take quite some time, and it bothers me that I don't
>> have any visual feedback while a build is running.
>> So, I tried to make use of the OSC 9;4 feature[0] to get some visual
>> feedback on what is happening.
>>
>> I managed to get a first draft working, but honestly, I'm not really
>> happy with how I integrated it into BitBake yet, and I could use some
>> help with that.
>>
>> I uploaded a diff that can be applied to the scarthgap branch[1].
>>
>> I would really appreciate some feedback on the patch and on how I
>> should go about getting this merged. If someone is willing to take a
>> look at it and maybe merge it directly, that would of course also be
>> great.
>>
>> Thank you very much!
>> Marcel
>>
>>
>> [0]:
>> https://learn.microsoft.com/en-us/windows/terminal/tutorials/progress-=
bar-sequences
>> [1]:=C2=A0https://gist.github.com/hellow554/257ffa02b4e236ede8f1a5a46c=
c9ae
> It looks like you might be able to make a subclass of ProgressBar with
> OSC9;4 support.
Yeah, that was my first thought too, but I did choose another (more=20
convoluted) route, because
a) there is a life before the first recipe task is started=C2=A0 -=20
downloading uninative, parsing recipes, sstate, things I don't know.
 =C2=A0 =C2=A0 I wanted the animation to start nevertheless because it ca=
n take=20
some time.
b) Detecting errors is not possible using a sole progressbar.

If you say my patch is way to noisy, then I will opt in for the subclass=20
route, just let me know :)

> You'd then just need to detect when in a windows
> powershell and trigger that. I don't use windows so I'm afraid I'm of l=
ittle help on this.
That's the neat part about the OSC codes - terminals that don't support=20
will just ignore them.
According to [this] for example konsole (kde terminal emulator) also=20
supports it, so you might give it a try.

If anyone else wants to comment on this, feel free I very much=20
appreciate it!

thanks,
Marcel

[this]: https://rockorager.dev/misc/osc-9-4-progress-bars/


