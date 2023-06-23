Return-Path: <wuzhenyu@ustc.edu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13170EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 09:14:04 +0000 (UTC)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
 by mx.groups.io with SMTP id smtpd.web11.38284.1687511638907423483
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jun 2023 02:14:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: ustc.edu, ip: 115.236.121.145, mailfrom: wuzhenyu@ustc.edu)
Received: from desktop (unknown [211.86.144.129])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 328018000B2;
	Fri, 23 Jun 2023 17:13:53 +0800 (CST)
Date: Fri, 23 Jun 2023 17:13:52 +0800
From: Wu Zhenyu <wuzhenyu@ustc.edu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: Re: [bitbake-devel] Support packaging
Message-ID: <z5kafm2tlrwgx3fe7ayv4gf46yr2hn27kw77uj4cmdc4z4nrmz@et7mvmr7e4qs>
References: <gu3erz2kuwv6e4nijjwavi2pci2ohlfcoaornwyicfsufgii7p@wsazr62z42tf>
 <243f996ab30e88244b73c0d6eb6c7d00e7766ac5.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243f996ab30e88244b73c0d6eb6c7d00e7766ac5.camel@linuxfoundation.org>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHRodVh5PH09PSExMHx1NTFUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlKSlVDTVVKT09VSklCWVdZFhoPEhUdFFlBWU9LSFVKSENMSEpVSktLVUtZBg++
X-HM-Tid: 0a88e7880dc1b03akuuu328018000b2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K006Qyo6Pj1JEAIIUSsZEwlK
	TUxPFC9VSlVKTUNMTkpKTUhIQkhPVTMWGhIXVQwOARMeFQIOOw4IDxhVHh8ORVlXWRILWUFZSUpK
	VUNNVUpPT1VKSUJZV1kIAVlBSElMQzcG
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jun 2023 09:14:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14856

Hi, I create a language server for bitbake in <https://github.com/Freed-Wu/bitbake-language-server>.
It really need bitbake as a python package to provide the full functions.
Now I have to use <https://aur.archlinux.org/packages/python-bitbake> as a dependency.
Can you rethink again about packaging it in PYPI?

On Fri, Jun 16, 2023 at 08:37:49AM +0100, Richard Purdie wrote:
> On Fri, 2023-06-16 at 14:44 +0800, Wu Zhenyu wrote:
> > use `python -m build` to package
> > ---
> >  .gitignore               | 130 ++++++++++++++++++++++++++++++++++++++-
> >  lib/bb/server/process.py |   5 +-
> >  pyproject.toml           | 109 ++++++++++++++++++++++++++++++++
> >  3 files changed, 240 insertions(+), 4 deletions(-)
> >  create mode 100644 pyproject.toml
> 
> I believe we said no to this in bugzilla recently.
> 
> The issue is that bitbake's version is tied to the release you're
> building. If you start including this on pypi or with packaging it with
> distros themselves, people will complain that the version doesn't match
> the one needed for the release they're currently building. Changing
> that requires API commitments we've not been able to make.
> 
> Yes, multiple versions on pypi and selecting the one you want in a
> python venv would be nice and one way to avoid that but once in pypi,
> the support issues arising from people using it in a way we've not
> intended would likely outweigh that.
> 
> By not having a pyproject.toml file, we make it clear that we don't
> support using bitbake in that way.
> 
> Cheers,
> 
> Richard
> 
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14837): https://lists.openembedded.org/g/bitbake-devel/message/14837
> Mute This Topic: https://lists.openembedded.org/mt/99565559/7696550
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/leave/12382373/7696550/1830237952/xyzzy [wuzhenyu@ustc.edu]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Best Regards
Wu Zhenyu



