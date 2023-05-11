Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69318C77B7F
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 20:45:48 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.7876.1683837946984548090
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 May 2023 13:45:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PJSHwKrT;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 85893C0002;
	Thu, 11 May 2023 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1683837944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMLXOsskbfOvBj2b78ilUnuMiaqP2+oB3ZbwU+R+fTs=;
	b=PJSHwKrToUk9udNkK6b3qPFfnGqOZ/q3IzUHsj6IgmSL0IvHtQi3os+nwvw6lJWLeSwXRi
	VLQKeqOG3nZgtuEJuOeBdz8eHVsyLQEWmqfdXNo82UcAMi9ltXol/+9+VWUNczH3EWof3P
	iLSyVn5eZr3uguXkVf0ChtcDsoSncqy4aQvcOaX/eNijvbABY5803BW9HACagPE+VNZVVb
	JYf2tNnh0RSPWhIlR3Um2w/V5d79YgfYgGm5YXxa8tmREc5TwKnOUC+dcrgfe9PjYBVlNY
	HgNiB0Mh7ke+pmTbMNTXnvzPfQrTiK5wY2h53+e7/kly6nOWetMp4NcqhAUTrw==
Date: Thu, 11 May 2023 22:45:43 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Peter Bergin <peter@berginkonsult.se>
Cc: bitbake-devel@lists.openembedded.org,
	"Bergin, Peter" <Peter.Bergin@windriver.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/tests/fetch.py: set initial branch
Message-ID: <20230511204543b965ac76@mail.local>
References: <20230509121717.1862519-1-peter@berginkonsult.se>
 <20230511155540e3a38c60@mail.local>
 <0b7eed30-97aa-92ff-732d-c2e78012b9b4@berginkonsult.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7eed30-97aa-92ff-732d-c2e78012b9b4@berginkonsult.se>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 20:45:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14786

On 11/05/2023 22:27:28+0200, Peter Bergin wrote:
> Hi,
> 
> On 2023-05-11 17:55, Alexandre Belloni via lists.openembedded.org wrote:
> > Hello,
> > 
> > This fails on the autobuilders:
> > 
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1397/steps/11/logs/stdio
> > 
> > error: unknown option `initial-branch=master'
> > usage: git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]
> > 
> Host is Ubuntu 20.04 and from what I found it is running git version 2.25.
> The argument '--initial-branch' to 'git-init' was added in version 2.28,
> some time mid 2020. That is most probably the root cause of the failure. My
> verification was done on Ubuntu 22.04 using git version 2.34.
> 
> The solution I can come up with at the moment is to do:
> 
> 'git init'
> 'git checkout -b master'
> 
> Is it worth sending a v2 on that? Or do you see a better solution?
> 

Well, this needs to work on all the autobuilder workers and this
currently includes ubuntu 18.04.

> /Peter
> 
> 
> > On 09/05/2023 14:17:17+0200, Peter Bergin wrote:
> > > From: "Bergin, Peter" <Peter.Bergin@windriver.com>
> > > 
> > > If you have a host where the git config for initial branch
> > > name is something else than 'master' the unittest will fail
> > > as they assume the default branch name is 'master'. Fix this
> > > by explicitly set the intial branch name at 'git init'.
> > > 
> > > Signed-off-by: Peter Bergin <peter.bergin@windriver.com>
> > > Signed-off-by: Peter Bergin <peter@berginkonsult.se>
> > > ---
> > >   lib/bb/tests/fetch.py | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> > > index 532adb941..f71d0d10c 100644
> > > --- a/lib/bb/tests/fetch.py
> > > +++ b/lib/bb/tests/fetch.py
> > > @@ -423,7 +423,7 @@ class FetcherTest(unittest.TestCase):
> > >           return bb.process.run(cmd, cwd=cwd)[0]
> > >       def git_init(self, cwd=None):
> > > -        self.git('init', cwd=cwd)
> > > +        self.git(['init', '--initial-branch=master'], cwd=cwd)
> > >           if not self.git(['config', 'user.email'], cwd=cwd):
> > >               self.git(['config', 'user.email', 'you@example.com'], cwd=cwd)
> > >           if not self.git(['config', 'user.name'], cwd=cwd):
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > > 
> > 
> > 
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14784): https://lists.openembedded.org/g/bitbake-devel/message/14784
> > Mute This Topic: https://lists.openembedded.org/mt/98782276/3617552
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [peter@berginkonsult.se]
> > -=-=-=-=-=-=-=-=-=-=-=-
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

