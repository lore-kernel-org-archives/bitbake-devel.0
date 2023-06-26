Return-Path: <wuzhenyu@ustc.edu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C9EB64D7
	for <webhook@archiver.kernel.org>; Mon, 26 Jun 2023 09:36:12 +0000 (UTC)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
 by mx.groups.io with SMTP id smtpd.web10.3924.1687772170118101591
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jun 2023 02:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ustc.edu, ip: 115.236.121.145, mailfrom: wuzhenyu@ustc.edu)
Received: from desktop (unknown [211.86.144.129])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 206288000A9;
	Mon, 26 Jun 2023 17:36:02 +0800 (CST)
Date: Mon, 26 Jun 2023 17:36:01 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: Re: [bitbake-devel] Support packaging
Message-ID: <b6paftjc3bwu3v3kp6zhjwvuahor5rbd6f2sni6opx6eolk23i@ckyfq6eitcym>
References: <gu3erz2kuwv6e4nijjwavi2pci2ohlfcoaornwyicfsufgii7p@wsazr62z42tf>
 <243f996ab30e88244b73c0d6eb6c7d00e7766ac5.camel@linuxfoundation.org>
 <z5kafm2tlrwgx3fe7ayv4gf46yr2hn27kw77uj4cmdc4z4nrmz@et7mvmr7e4qs>
 <9ff2cb26e2d63ba10255d665d44524ea7181f2d9.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff2cb26e2d63ba10255d665d44524ea7181f2d9.camel@linuxfoundation.org>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGk1NVh1IHUwdT0JNGR1MQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVDTVVKT09VSklCWVdZFhoPEhUdFFlBWU9LSFVKSktDSUNVSktLVUtZBg++
X-HM-Tid: 0a88f70f68ddb03akuuu206288000a9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46NAw6DD1MDEotGTEcNUwJ
	LCkaFFZVSlVKTUNMTExJSk1JQ0lJVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUpK
	VUNNVUpPT1VKSUJZV1kIAVlBSUxMTjcG
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jun 2023 09:36:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14859

> sounds really interesting and I'll have to take a look

Thanks for your interest. What is your thought after taking a look?

> There are some specific issues we'd need to solve if we were to put bitbake on PYPI

If you need some related help, you can @me.

On Fri, Jun 23, 2023 at 10:21:45AM +0100, Richard Purdie wrote:
> On Fri, 2023-06-23 at 17:13 +0800, Wu Zhenyu wrote:
> > Hi, I create a language server for bitbake in <https://github.com/Freed-Wu/bitbake-language-server>.
> > It really need bitbake as a python package to provide the full functions.
> > Now I have to use <https://aur.archlinux.org/packages/python-bitbake> as a dependency.
> > Can you rethink again about packaging it in PYPI?
> 
> A language server sounds really interesting and I'll have to take a
> look. If we add it to PYPI, who is going to deal with the usability
> issues I mentioned, the documentation problem and the resulting support
> where people mismatch bitbake versions?
> 
> There are some specific issues we'd need to solve if we were to put
> bitbake on PYPI and I'm not seeing any help or solutions being offered
> to that :(. I'm burning out with the project as things stand, I don't
> really want to create new issues.
> 
> Cheers,
> 
> Richard
> 
> 
> 

-- 
Best Regards
Wu Zhenyu

