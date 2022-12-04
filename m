Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED347C4332F
	for <webhook@archiver.kernel.org>; Sun,  4 Dec 2022 22:32:00 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.174.1670193113690916509
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 04 Dec 2022 14:31:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Dy3bfDOQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 6B308E0005;
	Sun,  4 Dec 2022 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670193111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XfRVb6/6BXz7QW/2d9H12FYQz0FVzszN4UzUPx9gjyw=;
	b=Dy3bfDOQGdl/Cdv/A4Lg4Hh1X/Za9N8P7XynvcE2ea8I0D7WZwshJ7GVmabsYDSBWvbh5L
	hovkX+X/DKO80IHgGB+fUn6sueR91N+uFrBFzoBytYvcVY7gBHH8vaMbZLZYuIy2R9BvWd
	CI6JYHQ1AeRR9ePHRBMcmeYYgEED93YiX6/iCPTOXJ201vAFP/6URBHJmYtKDRDpRTYZzq
	M5bOg9Syj3yXuDAAHucyNEAiMdcaHeh0SO/lj8DyxRspPNsZo6eim8+73909eWLv8tJNqA
	kqQu3O8LvXNk+elVkARbrf1VAsmQ+FFDoK8ETHECJI153OUaBUC5DKEw2H1ksQ==
Date: Sun, 4 Dec 2022 23:31:51 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v2] cache/siggen: Simplify passing
 basehash data into the cache
Message-ID: <Y40f10T169tZBaSZ@mail.local>
References: <20221201221736.1207775-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201221736.1207775-1-richard.purdie@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 04 Dec 2022 22:32:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14133

Hello Richard,

I believe this caused the following bitbake-selftest failures:
https://autobuilder.yoctoproject.org/typhoon/#/builders/79/builds/4467/steps/12/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/127/builds/559/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/80/builds/4412/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#builders/87/builds/4493/steps/11/logs/stdio
https://autobuilder.yoctoproject.org/typhoon/#/builders/86/builds/4434/steps/11/logs/stdio

On 01/12/2022 22:17:36+0000, Richard Purdie wrote:
> The basehash data is really internal bitbake data and passing an object
> directly is more efficient than creating and then extracting variables.
> 
> This will match the format of other data we may optionally wish to
> store in the cache so more to the more efficient method. Nothing I
> can see is using this data today (and nothing should be).
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cache.py  | 4 ++--
>  lib/bb/siggen.py | 5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index cb6cf21727..e1214d6ad2 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -28,7 +28,7 @@ import shutil
>  
>  logger = logging.getLogger("BitBake.Cache")
>  
> -__cache_version__ = "154"
> +__cache_version__ = "155"
>  
>  def getCacheFile(path, filename, mc, data_hash):
>      mcspec = ''
> @@ -105,7 +105,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
>  
>          self.tasks = metadata.getVar('__BBTASKS', False)
>  
> -        self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
> +        self.basetaskhashes = metadata.getVar('__siggen_basehashes', False)
>          self.hashfilename = self.getvar('BB_HASHFILENAME', metadata)
>  
>          self.task_deps = metadata.getVar('_task_deps', False) or {'tasks': [], 'parents': {}}
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 72b906c153..34b71d596a 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -247,8 +247,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
>          #for task in self.taskdeps[fn]:
>          #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
>  
> +        basehashes = {}
>          for task in taskdeps:
> -            d.setVar("BB_BASEHASH:task-%s" % task, self.basehash[fn + ":" + task])
> +            basehashes[task] = self.basehash[fn + ":" + task]
> +
> +        d.setVar("__siggen_basehashes", basehashes)
>  
>      def postparsing_clean_cache(self):
>          #
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14130): https://lists.openembedded.org/g/bitbake-devel/message/14130
> Mute This Topic: https://lists.openembedded.org/mt/95394525/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

