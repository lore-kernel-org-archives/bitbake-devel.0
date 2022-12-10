Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F0C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 15:55:43 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.18053.1670687735379634170
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Dec 2022 07:55:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Y+O7xU3S;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E4B571C0007;
	Sat, 10 Dec 2022 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670687733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVkWkJp82/xq+d2/KgQcCQelg83GgQbXJOv6N6F+sxM=;
	b=Y+O7xU3SZ8wIYPW79iWsCtjNHqZJFLNCyfaiVIpRyiBhYeZG3w1BJkTtMID8vrnAgA3ynN
	fC169grlVzyj7FpV3sdVWHz4otlPE5N1NtXxnBjLRzURypHMXQgQUnuhnzz/fCactjZ4gh
	SckWV9bnDSlrIq/PdwA1KeizmKdS6lt6U782uyyKNB9YXOWmQBTOLR8a6Agx9ywPxqvDw9
	CWmKvQzqD77GGvOm/p67/uH+OaihyMaA00nKJn4E7hkSW2dfUqQ1L/0qVrSQ6bdvk02CHT
	0wO4X+yEI88UwJh+5EpxmXyEOGDjwVi4KrWrpFNu3Go7s9MTprtBKAtIlAO5kQ==
Date: Sat, 10 Dec 2022 16:55:32 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	bitbake-devel@lists.openembedded.org,
	Alexander Kanavin <alex@linutronix.de>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/wget.py: correctly match
 versioned directories
Message-ID: <Y5Sr9HSWIc5LVzl9@mail.local>
References: <20221209085840.3733809-1-alex@linutronix.de>
 <Y5NJPlVxNR7kQsG1@mail.local>
 <CANNYZj_WLrfAUWjDu1Bqd+MTc+JO9p7YMH0qaQMFpe212Bx=0A@mail.gmail.com>
 <Y5NLdKDFJXGo7X/R@mail.local>
 <CANNYZj8yB7ThFEnssxReBi919zrN6qqbtNQR=psKYioCNYJqQQ@mail.gmail.com>
 <172F29E70A8CA3CF.5373@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172F29E70A8CA3CF.5373@lists.openembedded.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Dec 2022 15:55:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14167

On 09/12/2022 16:34:16+0100, Alexandre Belloni via lists.openembedded.org wrote:
> On 09/12/2022 16:23:49+0100, Alexander Kanavin wrote:
> > On Fri, 9 Dec 2022 at 15:51, Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > On 09/12/2022 15:46:39+0100, Alexander Kanavin wrote:
> > > > That is not a failure. It tries ipv6 first, then ipv4 - the former
> > > > fails, the latter succeeds. Are you getting an actual red result, and
> > > > can I see the link?
> > >
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/4493/steps/12/logs/stdio
> > >
> > > I guess the correct one is:
> > >
> > > Resolving localhost (localhost)... ::1, 127.0.0.1
> > > Connecting to localhost (localhost)|::1|:46501... failed: Connection refused.
> > > Connecting to localhost (localhost)|127.0.0.1|:46501... connected.
> > > HTTP request sent, awaiting response... 404 File not found
> > > 2022-12-09 13:21:18 ERROR 404: File not found.
> > 
> > I was scratching my head, until I looked at the commit in your branch:
> > https://git.yoctoproject.org/poky-contrib/commit/?h=abelloni/master-next&id=7b3866c5f4a92fb9013402813c38c1592769cc68
> > 
> > The test data somehow gained an additional 'bitbake/' in its path, and
> > so ends up in the wrong folder.
> > 
> 
> Hum, right, I'll fix that up

Note that the issue is that you are sending a patch for poky which then
doesn't apply properly on bitbake


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

