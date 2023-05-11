Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20838C77B7C
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 15:55:47 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.223.1683820543680102482
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 May 2023 08:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=fNGNkpkk;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2B2E6FF804;
	Thu, 11 May 2023 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1683820541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MHDUi63ln7lR/K4NF+swJk6JCbRxwuvPHWBgL+TMPbc=;
	b=fNGNkpkk2H1X5/4WYzohJf2v1OCIcy6m6Fb+K7tJXV9mSGm0h67T9irs0mksZDHIFP7BJ+
	m/dzg78al4Y8n66eL9aCVyQGVqAKt6DbRUXSfOafHrxUQSy4bpF7OUkKMEWczo2kjTzRFO
	cN3dfjG3Zk2f2MllPxoyZhippop3M591szNXlmceOHb1uRKNUtONfw502+nEXKYwhiDbl9
	AU4soVyokkDJlwjN/3xYzZWdMNLS3Xb8TL2v82KQv8P5lBZws8GgUdShKw34Qdt9C0H27g
	Sen7DZ08FCfKg6BlqEgvfMM5UMpzaxzixx4HbFXz1q3+byj2H7R+c9sVseqfBA==
Date: Thu, 11 May 2023 17:55:40 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Peter Bergin <peter@berginkonsult.se>
Cc: bitbake-devel@lists.openembedded.org,
	"Bergin, Peter" <Peter.Bergin@windriver.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/tests/fetch.py: set initial branch
Message-ID: <20230511155540e3a38c60@mail.local>
References: <20230509121717.1862519-1-peter@berginkonsult.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509121717.1862519-1-peter@berginkonsult.se>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 15:55:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14784

Hello,

This fails on the autobuilders:

https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/1397/steps/11/logs/stdio

error: unknown option `initial-branch=master'
usage: git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]


On 09/05/2023 14:17:17+0200, Peter Bergin wrote:
> From: "Bergin, Peter" <Peter.Bergin@windriver.com>
> 
> If you have a host where the git config for initial branch
> name is something else than 'master' the unittest will fail
> as they assume the default branch name is 'master'. Fix this
> by explicitly set the intial branch name at 'git init'.
> 
> Signed-off-by: Peter Bergin <peter.bergin@windriver.com>
> Signed-off-by: Peter Bergin <peter@berginkonsult.se>
> ---
>  lib/bb/tests/fetch.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 532adb941..f71d0d10c 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -423,7 +423,7 @@ class FetcherTest(unittest.TestCase):
>          return bb.process.run(cmd, cwd=cwd)[0]
>  
>      def git_init(self, cwd=None):
> -        self.git('init', cwd=cwd)
> +        self.git(['init', '--initial-branch=master'], cwd=cwd)
>          if not self.git(['config', 'user.email'], cwd=cwd):
>              self.git(['config', 'user.email', 'you@example.com'], cwd=cwd)
>          if not self.git(['config', 'user.name'], cwd=cwd):
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14769): https://lists.openembedded.org/g/bitbake-devel/message/14769
> Mute This Topic: https://lists.openembedded.org/mt/98782276/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

