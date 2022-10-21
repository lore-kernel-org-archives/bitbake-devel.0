Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C2BC4332F
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 08:45:16 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web12.7938.1666341904544621480
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Oct 2022 01:45:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=UUrfOI0C;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 3C41D240003;
	Fri, 21 Oct 2022 08:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1666341902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tc8JBQu9UuoYEhn1HrpISkQ0plEcxfxD+TTg0zkySNw=;
	b=UUrfOI0Chis09PHlV8WNX7K62QLr2vtkXAGSYSW3qhUyAzbZcgdhzJU1NtRdUZ9Tx27hGz
	2SK5pmLzzkQeANM86YWlh7nFcrSQ1bUAyagq4XOGYE7H9j9sVmpM2CqKTcvWcHLUyWAiur
	PjylQB18HI+4Wat3ZiqCnOu96e4KArc7ZvCZktUGKPohcyv814oWdT3gBxqoGaIDkGCdyM
	5+588jBBQeo+tBsTYlV1VrGIXMNwEdh5la8pCCB99iJGmO9J2P2XG1mplxXJ/obobwVR82
	MA5pGcsBbjHWCCRE5NuoqWexyxPY5ChfreA/UvW4MLG8lbkwFnXGqMIhmzhHvw==
Date: Fri, 21 Oct 2022 10:45:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] bb.tests.fetch.GitShallowTest: always
 allow file transport
Message-ID: <Y1JcDUQZa3dbLYtB@mail.local>
References: <20221021083401.2940299-1-alexandre.belloni@bootlin.com>
 <CA+chaQeTRVgWi9GVFvoYAGuR5EZPWOVMdwii0Dpcf_aueNXokw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+chaQeTRVgWi9GVFvoYAGuR5EZPWOVMdwii0Dpcf_aueNXokw@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Oct 2022 08:45:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14046

On 21/10/2022 10:42:45+0200, Martin Jansa wrote:
> Not sure how to fix it, but before adding more "-c
> core.fsyncobjectfiles=0", please check
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14939
> 

Yeah, I just copied the default value, I should probably append instead

> On Fri, Oct 21, 2022 at 10:34 AM Alexandre Belloni via
> lists.openembedded.org <alexandre.belloni=bootlin.com@lists.openembedded.org>
> wrote:
> 
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
> > Following CVE-2022-39253, distributions are disabling file:// transport for
> > submodules. See
> > https://git.launchpad.net/ubuntu/+source/git/tree/debian/patches/CVE-2022-39253-11.patch?h=applied/ubuntu/jammy-security
> >
> > [YOCTO #14941]
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  lib/bb/tests/fetch.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> > index b4ed691f3319..4ef2ed2b66b8 100644
> > --- a/lib/bb/tests/fetch.py
> > +++ b/lib/bb/tests/fetch.py
> > @@ -1865,6 +1865,9 @@ class GitShallowTest(FetcherTest):
> >          # Make this look like it was cloned from a remote...
> >          self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
> >          self.git('config --add remote.origin.fetch
> > "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
> > +
> > +        self.d.setVar('FETCHCMD_git', "git -c core.fsyncobjectfiles=0 -c
> > gc.autoDetach=false -c core.pager=cat -c protocol.file.allow=always")
> > +
> >          self.add_empty_file('asub', cwd=smdir)
> >          self.add_empty_file('bsub', cwd=smdir)
> >
> > @@ -1898,6 +1901,8 @@ class GitShallowTest(FetcherTest):
> >          self.add_empty_file('asub', cwd=smdir)
> >          self.add_empty_file('bsub', cwd=smdir)
> >
> > +        self.d.setVar('FETCHCMD_git', "git -c core.fsyncobjectfiles=0 -c
> > gc.autoDetach=false -c core.pager=cat -c protocol.file.allow=always")
> > +
> >          self.git('submodule init', cwd=self.srcdir)
> >          self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
> >          self.git('submodule update', cwd=self.srcdir)
> > --
> > 2.37.3
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#14044):
> > https://lists.openembedded.org/g/bitbake-devel/message/14044
> > Mute This Topic: https://lists.openembedded.org/mt/94472006/3617156
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> > Martin.Jansa@gmail.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

