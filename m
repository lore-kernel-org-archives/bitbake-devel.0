Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A8BC4167B
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 15:34:24 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.4408.1670600058659876089
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Dec 2022 07:34:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Vkt0PIhE;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4F5E3E0005;
	Fri,  9 Dec 2022 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670600056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5Oap/1VzNKN009vpF2b/vwkubZR6Z+2Yd9WhWdMNfw=;
	b=Vkt0PIhE+gaLxS9JzMDYPGfj4TNTKy+Q18ZvWEhcmqbhCX4R+oedSr1GEbGhRhRDYCLx0F
	lHWvFb0ei04LmjHEraR0TEvWebiEWFqsTzQxyG8EFOc0+MongY1uLpc4cLcpN1vSGFOKr8
	G4uaauQthRRozzevoYdTMLnziTsquLBHnq8IbtgBvQ431bKqf6X5ggeWOQhbbvtPFQ803Y
	fUrdpXW3hA64otwZaCWDrEqlEHQCMDnWAe6JZOiCRb6b3hESM7ueSLs+07nbjyvnm41uQ0
	e1g8N0VjMZEeTEZyddPvOUcYYxkkhWeYBpKBjphacuySNaCLK6VmdG0CAE+kXQ==
Date: Fri, 9 Dec 2022 16:34:16 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
	Alexander Kanavin <alex@linutronix.de>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/wget.py: correctly match
 versioned directories
Message-ID: <Y5NVeNwGqfQCc/Aq@mail.local>
References: <20221209085840.3733809-1-alex@linutronix.de>
 <Y5NJPlVxNR7kQsG1@mail.local>
 <CANNYZj_WLrfAUWjDu1Bqd+MTc+JO9p7YMH0qaQMFpe212Bx=0A@mail.gmail.com>
 <Y5NLdKDFJXGo7X/R@mail.local>
 <CANNYZj8yB7ThFEnssxReBi919zrN6qqbtNQR=psKYioCNYJqQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNYZj8yB7ThFEnssxReBi919zrN6qqbtNQR=psKYioCNYJqQQ@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 15:34:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14166

On 09/12/2022 16:23:49+0100, Alexander Kanavin wrote:
> On Fri, 9 Dec 2022 at 15:51, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 09/12/2022 15:46:39+0100, Alexander Kanavin wrote:
> > > That is not a failure. It tries ipv6 first, then ipv4 - the former
> > > fails, the latter succeeds. Are you getting an actual red result, and
> > > can I see the link?
> >
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/4493/steps/12/logs/stdio
> >
> > I guess the correct one is:
> >
> > Resolving localhost (localhost)... ::1, 127.0.0.1
> > Connecting to localhost (localhost)|::1|:46501... failed: Connection refused.
> > Connecting to localhost (localhost)|127.0.0.1|:46501... connected.
> > HTTP request sent, awaiting response... 404 File not found
> > 2022-12-09 13:21:18 ERROR 404: File not found.
> 
> I was scratching my head, until I looked at the commit in your branch:
> https://git.yoctoproject.org/poky-contrib/commit/?h=abelloni/master-next&id=7b3866c5f4a92fb9013402813c38c1592769cc68
> 
> The test data somehow gained an additional 'bitbake/' in its path, and
> so ends up in the wrong folder.
> 

Hum, right, I'll fix that up

> Alex

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

