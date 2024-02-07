Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36823C4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 22:27:52 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.3883.1707344863561861512
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Feb 2024 14:27:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lMGoNKI6;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B2BFC0002;
	Wed,  7 Feb 2024 22:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707344861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwmJId1awvzIYk5tvSWc8UQst8Nhnb1N//6iAw82SIw=;
	b=lMGoNKI6q6T2MXbAl3IfEeGRTwLiEPIfcJGXttTMZeQ0kvgKKR8z3n9M4woY/2VriBHIAJ
	jITOfxQf/2TV1Xt2m+DAvGUSf5QXMj8bekCiDm+uryoDBeG5JrR7VL4WZoUF3CKc1R1TfH
	sn7CYHdda9iBBN2lsHjfCit4VBvpZ/uVLJhapTOr3uYli1ng4bXYvajsGa6fSjtUa/YZ2x
	eRYeUnwg+M/gxfbPJ5uzwSPl7XTNZF51GVho/IyjdRy+uo+qxZsR6ltX0IswFOiPY61mSF
	CwJ0lUTdf9m9eb1IF1Uan9RaxiR9cX+0OIG9aQ4nY9TNrFqwaDYjH82yu6ECTQ==
Date: Wed, 7 Feb 2024 23:27:41 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: ecordonnier@snap.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] lib/bb: Drop BBFILE_PRIORITY support
Message-ID: <202402072227419c816a19@mail.local>
References: <20240206121528.2581233-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYbjs=_ijo2Jy5a1JCx5jrSJB5Ucoza99yBL2ya+qvwpRg@mail.gmail.com>
 <dfe902c9baab3bdc38bb7afae1455565ab8c0117.camel@linuxfoundation.org>
 <CAHUKmYY1fMCiNq36MzoeuQ5EKQYm_ZAEkkDuRUTeg94a+ZnubQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUKmYY1fMCiNq36MzoeuQ5EKQYm_ZAEkkDuRUTeg94a+ZnubQ@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Feb 2024 22:27:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15837

On 06/02/2024 17:31:03+0100, Etienne Cordonnier via lists.openembedded.org wrote:
> Is the BBFILE_PRIORITY not controlling the order in which bbappends from
> different layers gets applied? I thought it was important e.g. when
> applying kernel configuration files (the last one to be applied override
> the previous ones).

I'd rather think this is in BBLAYERS list order

> 
> On Tue, Feb 6, 2024 at 4:56 PM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> 
> > On Tue, 2024-02-06 at 16:26 +0100, Etienne Cordonnier wrote:
> > > Hi Richard, there is a word missing in the commit message:
> > > " The functionality had a and place" -> "the functionality had a time
> > and place"
> > > Also a typo: "comparibility" -> " compatibility "
> >
> > Thanks, I'll tweak those on the branch.
> >
> > > What is the correct way to set layer priorities after this patch (I'm
> > > asking because the BSP I'm using makes use of BBFILE_PRIORITY)?
> >
> > It may set it, but what is it trying to achieve by setting it?
> >
> > As far as I know, the potential issue is needing to set specific
> > PREFERRED_VERSION entries where older recipes need to be used.
> >
> > Cheers,
> >
> > Richard
> >

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15832): https://lists.openembedded.org/g/bitbake-devel/message/15832
> Mute This Topic: https://lists.openembedded.org/mt/104196430/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

