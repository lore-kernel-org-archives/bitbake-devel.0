Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141E8EE4993
	for <webhook@archiver.kernel.org>; Sat, 19 Aug 2023 12:21:31 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.8101.1692447689103621887
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 19 Aug 2023 05:21:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mr9xR8Rz;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3F811C0003;
	Sat, 19 Aug 2023 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1692447686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqIBtdAwdYFhWSyB9wT/1a5KfWVlHJ3cW20a+d2XB/8=;
	b=mr9xR8Rzo3uP0tZ9TcbyXSbUCf+u6L0HTKMxWncWIA/n0eOF48mn0qfK7JJJNfsGxEw325
	l//sGxLX87lVH7R+BqkqTPqHlo2kUVC0N7yT+JfOq1tp5MTcCK6wiTJc5aGKoOGMj8/1dt
	HyTvi/71Pcvx6b3u+v4xp3Da36vVTL6lq+J3cXes6bEUmta+Mr4RK4EuKDpBRLwHqnW7i8
	UduSBHMQzX7pz6Ia6kJIz52EL/dMvXVzFhZb4QO/dLeZCcpqATCaJkk7A7y+iriH2OOBka
	40ucsJoc7Dx+srCX9bK9ieqbzMg0w/NORmp07KG4lE8SrtqgTWmfYnkXPmzDGg==
Date: Sat, 19 Aug 2023 14:21:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <jpewhacker@gmail.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH] fetch2: git: Check if directory is a bare
 git repo
Message-ID: <202308191221252f22058b@mail.local>
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
 <2023080901520013144e1b@mail.local>
 <CAJdd5GYK-dr6vf3a_O_hgQ-gLt1WkHwcwwyH5fD4+d423MzAcg@mail.gmail.com>
 <177C44DDA5F18A0D.21730@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177C44DDA5F18A0D.21730@lists.openembedded.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 19 Aug 2023 12:21:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14955

This was because I didn't point to the correct build error:

======================================================================
ERROR: test_mirror_commit_exists (bb.tests.fetch.FetchPremirroronlyLocalTest.test_mirror_commit_exists)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/tests/fetch.py", line 3075, in test_mirror_commit_exists
    fetcher.download()
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/fetch2/__init__.py", line 1746, in download
    done = m.try_mirrors(self, ud, self.d, mirrors)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/fetch2/__init__.py", line 1612, in try_mirrors
    return bool(try_mirrors(fetch, d, urldata, mirrors, check))
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/fetch2/__init__.py", line 1136, in try_mirrors
    ret = try_mirror_url(fetch, origud, uds[index], ld, check)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/fetch2/__init__.py", line 1065, in try_mirror_url
    origud.method.download(origud, ld)
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/fetch2/git.py", line 401, in download
    bb.fetch2.check_network_access(d, clone_cmd, ud.url)
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/fetch2/__init__.py", line 944, in check_network_access
    raise NetworkAccess(url, info)
bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (or set indirectly due to use of BB_FETCH_PREMIRRORONLY) but access requested with command LANG=C git -c gc.autoDetach=false -c core.pager=cat clone --bare --mirror https://git.fake.repo/bitbake /tmp/bitbake-fetch-xeon98ff/download/git2/git.fake.repo.bitbake --progress (for url git://git.fake.repo/bitbake;branch=master;protocol=https)


https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/5619/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/5577/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1935/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/5653/steps/11/logs/stdio


On 17/08/2023 22:14:34+0200, Alexandre Belloni via lists.openembedded.org wrote:
> On 17/08/2023 13:19:56-0600, Joshua Watt wrote:
> > Alexandre,
> > 
> > I'm not sure that's quite correct; I was able to run the test fine
> > locally, and that failure looks like a 502 error from the server,
> > which really shouldn't have anything to do with this patch?
> > 
> 
> I'm pretty sure you are right...
> 
> > On Tue, Aug 8, 2023 at 7:52 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > Hello Joshua,
> > >
> > > I'm fairly sure this causes the following bitbake-selftest failure:
> > >
> > > https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/2307/steps/11/logs/stdio
> > >
> > > On 04/08/2023 09:54:24-0600, Joshua Watt wrote:
> > > > If the clone target directory exists, but isn't the valid top level of a
> > > > bare git repo, it needs to be erased and re-cloned. One example of how
> > > > this can happen is if a clone creates the directory, but then fails to
> > > > actual clone and make it a git repository. This left-over directory can
> > > > be particularly problematic if the download directory is a descent of
> > > > some top layer git repo (e.g. the default with poky), as the commands
> > > > that operate on the remote later will then mangle the layers git
> > > > repository instead of the download git repo.
> > > >
> > > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > > ---
> > > >  bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++++++++++-
> > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > > > index 2a3c06fe4e9..112bed294f0 100644
> > > > --- a/bitbake/lib/bb/fetch2/git.py
> > > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > > @@ -65,6 +65,7 @@ import fnmatch
> > > >  import os
> > > >  import re
> > > >  import shlex
> > > > +import shutil
> > > >  import subprocess
> > > >  import tempfile
> > > >  import bb
> > > > @@ -365,8 +366,29 @@ class Git(FetchMethod):
> > > >                  runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
> > > >          repourl = self._get_repo_url(ud)
> > > >
> > > > +        needs_clone = False
> > > > +        if os.path.exists(ud.clonedir):
> > > > +            # The directory may exist, but not be the top level of a bare git
> > > > +            # repository in which case it needs to be deleted and re-cloned.
> > > > +            try:
> > > > +                # Since clones are bare, use --absolute-git-dir instead of --show-toplevel
> > > > +                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
> > > > +            except bb.fetch2.FetchError as e:
> > > > +                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
> > > > +                needs_clone = True
> > > > +            else:
> > > > +                toplevel = output.rstrip()
> > > > +                if os.path.abspath(toplevel) != os.path.abspath(ud.clonedir):
> > > > +                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > > > +                    needs_clone = True
> > > > +
> > > > +            if needs_clone:
> > > > +                shutil.rmtree(ud.clonedir)
> > > > +        else:
> > > > +            needs_clone = True
> > > > +
> > > >          # If the repo still doesn't exist, fallback to cloning it
> > > > -        if not os.path.exists(ud.clonedir):
> > > > +        if needs_clone:
> > > >              # We do this since git will use a "-l" option automatically for local urls where possible,
> > > >              # but it doesn't work when git/objects is a symlink, only works when it is a directory.
> > > >              if repourl.startswith("file://"):
> > > > --
> > > > 2.33.0
> > > >
> > >
> > > >
> > > > 
> > > >
> > >
> > >
> > > --
> > > Alexandre Belloni, co-owner and COO, Bootlin
> > > Embedded Linux and Kernel engineering
> > > https://bootlin.com
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14952): https://lists.openembedded.org/g/bitbake-devel/message/14952
> Mute This Topic: https://lists.openembedded.org/mt/100548945/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

