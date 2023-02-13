Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2890EC636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 23:37:31 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.31349.1676331448048220664
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Feb 2023 15:37:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VWnXdF5A;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B03B0E0003;
	Mon, 13 Feb 2023 23:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1676331446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aijXeimq118824vFGSE5EF0/391a4eppyTKMLs6L1Jw=;
	b=VWnXdF5ASpfZxCoj6hr3pfB0WFkaqeD9TU+x3COCXa94Xa+YqplcgLc8WUytBSKiOXwTlJ
	qdqyoQtOs/sObxNE+lMbyYhqSF9TK7C+D31cOuuTD/dCjpOEYoaAMEbKmsTV2yX/4NRKEh
	vOxQfjtWg2+VaQWCCyiIe+mzchUVcoee84/zYDX//KUIQM3ZfIiKDb8VG0ko0A26Eqw2sB
	FiMl6IFnznbVSs+4eBxhVnnSRKp9GbxU39NupSF1Ht6gNoPHb7+n63blfgDbM0VjiHhVIh
	KqV9MdC2mVgNs9Yv4wj4XgCY5SgevaBKOWMSJ26x4y4QnYH2KjY77WKPfRNz5Q==
Date: Tue, 14 Feb 2023 00:37:25 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Paulo Neves <paulo@myneves.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/3] tests: Make test_lfs_enabled
 actually test git-lfs
Message-ID: <Y+rJtR+pXaUUSSjK@mail.local>
References: <20230210133921.1268885-1-paulo@myneves.com>
 <20230210133921.1268885-2-paulo@myneves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210133921.1268885-2-paulo@myneves.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 23:37:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14403

Hello,

This fails on the AB with:

FAIL: test_lfs_enabled (bb.tests.fetch.GitLfsTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/oe-selftest-armhost/build/bitbake/lib/bb/tests/fetch.py", line 2246, in test_lfs_enabled
    self.assertTrue(ud.method._find_git_lfs(self.d),
AssertionError: False is not true : git-lfs not found. Cannot test git-lfs without git-lfs in the PATH


On 10/02/2023 13:39:32+0000, Paulo Neves wrote:
> Due to the datastore not having the PATH variable set, _find_git_lfs
> would never return true and thus fetcher's git lfs test logic was
> unreachable.
> 
> Now we set PATH on the datastore of the test and if the test host has
> git-lfs the test will actually test git-lfs logic.
> 
> Signed-off-by: Paulo Neves <paulo@myneves.com>
> ---
>  lib/bb/tests/fetch.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 122d7e05f..a9ad247d9 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2237,6 +2237,7 @@ class GitLfsTest(FetcherTest):
> 
>          uri = 'git://%s;protocol=file;branch=master' % self.srcdir
>          self.d.setVar('SRC_URI', uri)
> +        self.d.setVar('PATH', os.environ.get('PATH'))
> 
>          # Careful: suppress initial attempt at downloading until
>          # we know whether git-lfs is installed.
> --
> 2.34.1
> 
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14392): https://lists.openembedded.org/g/bitbake-devel/message/14392
> Mute This Topic: https://lists.openembedded.org/mt/96875983/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

