Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4408C001B0
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 01:52:03 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.79314.1691545922589617523
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Aug 2023 18:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=k7UAUzkS;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 710D1E0005;
	Wed,  9 Aug 2023 01:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1691545920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27+btHTHELNVkuwrY5Eswzz/qFbnRtNbjw6c5n7heMM=;
	b=k7UAUzkSXSAS38oUDMe/u0XbnJUEowNpm2wJYVPgALf8e6nAK58R0MBom2y7/ORG51C4kL
	5obwq56sE3zdt2w41yBpOl9uP6/VG9bOPqjCtcgT9xOhZnLriNDWIxKKeXYz5r/Pvk+BiQ
	s4xq0jcq3TeHCZDD4DbMMiGvenzbce0aPq6pM9RMRCHdEoqFaCXSwJfTXIdhApH+iq5ZiH
	FQwaImGF9Es2vuaB5dmJexwOWOykFNuBlC1yfEWRRTX/sY8d6NkUVWIVP78Cky/YcCLeb/
	VwG2SbPWUvIGRG2hrzVJN2WV3401z0IzpFWbf0JyBVHTOzaQnLORIrb99Nc/+Q==
Date: Wed, 9 Aug 2023 03:52:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH] fetch2: git: Check if directory is a bare
 git repo
Message-ID: <2023080901520013144e1b@mail.local>
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804155424.1502010-1-JPEWhacker@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Aug 2023 01:52:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14930

Hello Joshua,

I'm fairly sure this causes the following bitbake-selftest failure:

https://autobuilder.yoctoproject.org/typhoon/#/builders/56/builds/2307/steps/11/logs/stdio

On 04/08/2023 09:54:24-0600, Joshua Watt wrote:
> If the clone target directory exists, but isn't the valid top level of a
> bare git repo, it needs to be erased and re-cloned. One example of how
> this can happen is if a clone creates the directory, but then fails to
> actual clone and make it a git repository. This left-over directory can
> be particularly problematic if the download directory is a descent of
> some top layer git repo (e.g. the default with poky), as the commands
> that operate on the remote later will then mangle the layers git
> repository instead of the download git repo.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 2a3c06fe4e9..112bed294f0 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -65,6 +65,7 @@ import fnmatch
>  import os
>  import re
>  import shlex
> +import shutil
>  import subprocess
>  import tempfile
>  import bb
> @@ -365,8 +366,29 @@ class Git(FetchMethod):
>                  runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
>          repourl = self._get_repo_url(ud)
>  
> +        needs_clone = False
> +        if os.path.exists(ud.clonedir):
> +            # The directory may exist, but not be the top level of a bare git
> +            # repository in which case it needs to be deleted and re-cloned.
> +            try:
> +                # Since clones are bare, use --absolute-git-dir instead of --show-toplevel
> +                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
> +            except bb.fetch2.FetchError as e:
> +                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
> +                needs_clone = True
> +            else:
> +                toplevel = output.rstrip()
> +                if os.path.abspath(toplevel) != os.path.abspath(ud.clonedir):
> +                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> +                    needs_clone = True
> +
> +            if needs_clone:
> +                shutil.rmtree(ud.clonedir)
> +        else:
> +            needs_clone = True
> +
>          # If the repo still doesn't exist, fallback to cloning it
> -        if not os.path.exists(ud.clonedir):
> +        if needs_clone:
>              # We do this since git will use a "-l" option automatically for local urls where possible,
>              # but it doesn't work when git/objects is a symlink, only works when it is a directory.
>              if repourl.startswith("file://"):
> -- 
> 2.33.0
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14915): https://lists.openembedded.org/g/bitbake-devel/message/14915
> Mute This Topic: https://lists.openembedded.org/mt/100548945/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

