Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B8DCD11C2
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 17:01:51 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.5569.1712768509287717303
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Apr 2024 10:01:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=k97oYz9F;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C424240002;
	Wed, 10 Apr 2024 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712768506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gbXMDISJtRVKb0oNTx/bjlGUz+neHNpAL0pTNu8XnBM=;
	b=k97oYz9Fa3PdVw4wi6ycWRimXqpb5M+bRK5EYO2BGNum0ViZZFHA0Xnje7YnlJURnPYAOd
	1gzlr45XktsAyr7O0+ng0Paa88B/3jPRGJq71oRO9B7KIb4lA4QywUAy5li4ZVm3yj5wub
	jIZsOqItBbLvSofPIg72C7zpHYekoUH/b55nsIz//FAfCxroZJjgyZWWjqYsbggJLYdBlO
	WVb33zyTQ56Vgm0oTL6IdXDU8t7WvzTkFviI/+h98RdVQDulNrKbp44zUa1qMPXJBHf/Ul
	8VLwexvUmBUPk1FseNL+uV3YNZpaDog41Ss3xCqk9Yfc3MlT6N9LtbgrJJ/rXw==
Date: Wed, 10 Apr 2024 19:01:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: liezhi.yang@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Fix File name too long
 error
Message-ID: <202404101701466483c16e@mail.local>
References: <cover.1712565610.git.liezhi.yang@windriver.com>
 <02074341b8914bf7d1bf44291ec50a77853a4c5b.1712565610.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02074341b8914bf7d1bf44291ec50a77853a4c5b.1712565610.git.liezhi.yang@windriver.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Apr 2024 17:01:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16067


I believe this causes the following error:

======================================================================
FAIL: test_shallow_submodules (bb.tests.fetch.GitShallowTest.test_shallow_submodules)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/tests/fetch.py", line 1946, in test_shallow_submodules
    self.assertRevCount(1, cwd=os.path.join(self.gitdir, 'gitsubmodule'))
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/tests/fetch.py", line 1728, in assertRevCount
    self.assertEqual(expected_count, actual_count, msg='Object count `%d` is not the expected `%d`' % (actual_count, expected_count))
AssertionError: 1 != 2 : Object count `2` is not the expected `1`

https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/6634/steps/11/logs/stdio

On 08/04/2024 01:42:58-0700, Robert Yang via lists.openembedded.org wrote:
> From: Robert Yang <liezhi.yang@windriver.com>
> 
> There are "File name too long" errors when local PREMIRROR/MIRROR
> is in a deep directory (len(path) > 255 (The NAME_MAX)).
> 
> This is becuase ud.path.replace() changes the path to filename, and
> the errors when happens when len(path) > 255.
> 
> Use hashlib.md5(ud.path.encode('utf-8')).hexdigest() can fix the problem and
> avoid potential file name conflicts, now the files are like:
> 
> $ bitbake mtd-utils-native -cfetch
> $ ls downloads/git2
> 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
> git.infradead.org.mtd-utils.git -> /path/to/build/downloads/git2/1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
> git.infradead.org.mtd-utils.git.done
> 
> The 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git is gitsrcname.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index c7ff769fdfe..7ed51af336d 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -83,6 +83,7 @@ import subprocess
>  import tempfile
>  import bb
>  import bb.progress
> +import hashlib
>  from contextlib import contextmanager
>  from   bb.fetch2 import FetchMethod
>  from   bb.fetch2 import runfetchcmd
> @@ -277,7 +278,10 @@ class Git(FetchMethod):
>                      ud.unresolvedrev[name] = ud.revisions[name]
>                  ud.revisions[name] = self.latest_revision(ud, d, name)
>  
> -        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
> +        if ud.proto == "file":
> +            gitsrcname = '%s.%s' % (hashlib.md5(ud.path.encode('utf-8')).hexdigest(), os.path.basename(ud.path))
> +        else:
> +            gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
>          if gitsrcname.startswith('.'):
>              gitsrcname = gitsrcname[1:]
>  
> -- 
> 2.42.0
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16064): https://lists.openembedded.org/g/bitbake-devel/message/16064
> Mute This Topic: https://lists.openembedded.org/mt/105397591/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

