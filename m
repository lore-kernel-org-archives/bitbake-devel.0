Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502BAD730BD
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 08:07:11 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7080.1775203629635713394
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2026 01:07:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=v7wFbFUa;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1FF304E428CE
	for <bitbake-devel@lists.openembedded.org>; Fri,  3 Apr 2026 08:07:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9E07603C1;
	Fri,  3 Apr 2026 08:07:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFAC0104502AB;
	Fri,  3 Apr 2026 10:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775203627; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NAY2NN02oRLhy2ltKPneURyOaaWGZ51Uhg2LOmXL7Ow=;
	b=v7wFbFUaY9H3WqYY3SX+GMPAoXP54HMRUJEAmrmX43pBW7npinfWX2KS0ZeGem9/qty6Ga
	/JmG9B2I0p9Okc+sfgcpRe02P11Mo3rUe7PPMCFNv6SLmT+yy/Oc6bPtF+j78AB81lTY7G
	mMCGvtmLc/OQ40HPKz2Qd91yNaFCweQkO4ViY7a1eCPqBbsXWlQ6u0xwj3goJ/MFUr+0tj
	pwapPwW+2zror+7dRD+4R/aJDvu8ATEPogiVHtJWkGkbo2FiMVuqQtitHCG6ilR/7CIDBe
	k5bWiVtYuwxHYc08vKH2jwconDjI25VpOUOd1lHuy+TfQ/8D9clGf+Cy5lGyuw==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 10:07:05 +0200
Message-Id: <DHJD5ZA0XGWN.3LDDWNE9PDM1X@bootlin.com>
Subject: Re: [bitbake-devel] [docs] [PATCH 1/2] bitbake-setup: rename
 "abort" rebase conflict stragegy to "halt"
Cc: <quentin.schulz@cherry.de>, <bitbake-devel@lists.openembedded.org>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>,
 <richard.purdie@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
References: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
 <20260331-docs-fixes-v1-1-45ee34341e72@bootlin.com>
 <6f743774-fe4b-4e9e-ba99-6ffe1d76a51b@cherry.de>
 <57bb4e5300a4be34f4cfddcf41d9a21b5b7bc579.camel@linuxfoundation.org>
 <CANNYZj9U3BYUv-cvQvmu7d=8O82Gdg-2GSon6vNJ71BMi6bKsg@mail.gmail.com>
In-Reply-To: <CANNYZj9U3BYUv-cvQvmu7d=8O82Gdg-2GSon6vNJ71BMi6bKsg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 08:07:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19315

On Tue Mar 31, 2026 at 1:36 PM CEST, Alexander Kanavin wrote:
> There=E2=80=99s a simpler rationale too: this follows =E2=80=98git rebase=
 =E2=80=94abort=E2=80=99. If git
> upstream finds a better word, we will follow. And I agree that all of the
> proposed alternatives are less accurate.

This goes against previous efforts to convert the documentation and other
components to not use these words :/
https://lists.openembedded.org/g/openembedded-architecture/topic/inclusive_=
language_summary/75821819

[...]
>> > This is not what halt means. Maybe 'reset' would be a better choice? O=
r
>> > if you really want to follow the recommendations from that website, I
>> > guess "cancel"?
>>
>> The trouble is none of these alternatives really match what abort
>> means, reset and cancel do mean something different. "abandon" might be
>> closer but still isn't right. "attempt" maybe? If we get too creative
>> with this, users just won't understand what it means :(

I had the impression, from the documentation, that bitbake-setup would leav=
e the
repository in the middle of a rebase, to let you deal with conflict, and th=
en
continue on the next bitbake-setup update call.

It appears to use --abort instead, so a misunderstanding from my part.

Out of these options, I think "reset" might be the best one, I agree with
Quentin. But I'm not a native speaker, so I might not have an understanding=
 as
subtle as others.

I'll let Richard decide on what to do here.

Antonin

