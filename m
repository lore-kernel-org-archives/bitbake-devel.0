Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F8C61CE8
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 20:14:48 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.3935.1692303277289718043
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Aug 2023 13:14:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=e3XOg8+C;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 136881BF205;
	Thu, 17 Aug 2023 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692303275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BE3Z65n+R+ND1rAdD5PzZGAKoUjU3VTsVj8YsPBFcU=;
	b=e3XOg8+CvFjdfp7G9F/dP6qB4O0Th5jjh3t1MmI2ewyo5CucLyTZ/JTnR7mWKShnHLz1eN
	2pzy1AeTFlFxQg/QCQGnpkTTYGaPxyISOGJSxmDzN9PfLt3ZHOyWGht8pbyo476P2uPJ2Z
	12A9wpn6hClf7cWNfv0yqf3xPDkTsQPtRac7PcfZyP6ix98sqMP9pfDPW642PZ7W6+FpXg
	BJkbH4QbkV6t3uF4gTNkKvIiL25yRFUDRKN6TDEk8iu1Nwhy/Gp2SR2jSmA8plqasKxv0D
	5canDA0J1fiCuogFZbFa7mA2DvA7/WwU5Z21lQBaNkF8OuI6KODddVOu3zi0JA==
Date: Thu, 17 Aug 2023 22:14:34 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH] fetch2: git: Check if directory is a bare
 git repo
Message-ID: <2023081720143457867d64@mail.local>
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
 <2023080901520013144e1b@mail.local>
 <CAJdd5GYK-dr6vf3a_O_hgQ-gLt1WkHwcwwyH5fD4+d423MzAcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJdd5GYK-dr6vf3a_O_hgQ-gLt1WkHwcwwyH5fD4+d423MzAcg@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 20:14:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14952

On 17/08/2023 13:19:56-0600, Joshua Watt wrote:
> Alexandre,
> 
> I'm not sure that's quite correct; I was able to run the test fine
> locally, and that failure looks like a 502 error from the server,
> which really shouldn't have anything to do with this patch?
> 

I'm pretty sure you are right...

> On Tue, Aug 8, 2023 at 7:52 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hello Joshua,
> >
> > I'm fairly sure this causes the following bitbake-selftest failure:
> >
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/2307/steps/11/logs/stdio
> >
> > On 04/08/2023 09:54:24-0600, Joshua Watt wrote:
> > > If the clone target directory exists, but isn't the valid top level of a
> > > bare git repo, it needs to be erased and re-cloned. One example of how
> > > this can happen is if a clone creates the directory, but then fails to
> > > actual clone and make it a git repository. This left-over directory can
> > > be particularly problematic if the download directory is a descent of
> > > some top layer git repo (e.g. the default with poky), as the commands
> > > that operate on the remote later will then mangle the layers git
> > > repository instead of the download git repo.
> > >
> > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > ---
> > >  bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > > index 2a3c06fe4e9..112bed294f0 100644
> > > --- a/bitbake/lib/bb/fetch2/git.py
> > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > @@ -65,6 +65,7 @@ import fnmatch
> > >  import os
> > >  import re
> > >  import shlex
> > > +import shutil
> > >  import subprocess
> > >  import tempfile
> > >  import bb
> > > @@ -365,8 +366,29 @@ class Git(FetchMethod):
> > >                  runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
> > >          repourl = self._get_repo_url(ud)
> > >
> > > +        needs_clone = False
> > > +        if os.path.exists(ud.clonedir):
> > > +            # The directory may exist, but not be the top level of a bare git
> > > +            # repository in which case it needs to be deleted and re-cloned.
> > > +            try:
> > > +                # Since clones are bare, use --absolute-git-dir instead of --show-toplevel
> > > +                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
> > > +            except bb.fetch2.FetchError as e:
> > > +                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
> > > +                needs_clone = True
> > > +            else:
> > > +                toplevel = output.rstrip()
> > > +                if os.path.abspath(toplevel) != os.path.abspath(ud.clonedir):
> > > +                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > > +                    needs_clone = True
> > > +
> > > +            if needs_clone:
> > > +                shutil.rmtree(ud.clonedir)
> > > +        else:
> > > +            needs_clone = True
> > > +
> > >          # If the repo still doesn't exist, fallback to cloning it
> > > -        if not os.path.exists(ud.clonedir):
> > > +        if needs_clone:
> > >              # We do this since git will use a "-l" option automatically for local urls where possible,
> > >              # but it doesn't work when git/objects is a symlink, only works when it is a directory.
> > >              if repourl.startswith("file://"):
> > > --
> > > 2.33.0
> > >
> >
> > >
> > > -=-=-=-=-=-=-=-=-=-=-=-
> > > Links: You receive all messages sent to this group.
> > > View/Reply Online (#14915): https://lists.openembedded.org/g/bitbake-devel/message/14915
> > > Mute This Topic: https://lists.openembedded.org/mt/100548945/3617179
> > > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> > > -=-=-=-=-=-=-=-=-=-=-=-
> > >
> >
> >
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

