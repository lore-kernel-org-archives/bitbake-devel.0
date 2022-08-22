Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E586AC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 16:02:45 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web12.19891.1661184165129950338
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 09:02:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=TaGySe02;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B0935FF802;
	Mon, 22 Aug 2022 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1661184163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYhXPL8bly3qqbxT/vaOWpIVirdKkJXp+uDocDNZAk8=;
	b=TaGySe02zgw7PEVfRDHLexCYI/Cxqa9S2u814DLltXIdW/cZ0sp6tH/V0EI3Jd7A6K8hvb
	M6PTYb/N2Kraf35FZfEnAWXYF+V6KIZI/UekX2u5bUETeCZIokuMyudNSo8w2o6awjB9/v
	CUcbjM2ERiHZKOromfMy1lPBPrCnSaMA2npDhwX7EM7rzLIbOXVsgOHZDVaNy8bimj4FoU
	Z0OQtHEWWUyVZq9BEZM+ZryPqYNFucEz8BHXJE+L4wommER1UMRBXjuYGRsPSySzwx0CI2
	1V2mYXO0eg5lQfMrFfT/PAqTxDXyIj0mXmzdi2/XO1Y6MYQNpJ4nN3cJ2Dx/Dw==
Date: Mon, 22 Aug 2022 18:02:41 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Marek Vasut" <marex@denx.de>
Cc: bitbake-devel@lists.openembedded.org, Martin Jansa
 <Martin.Jansa@gmail.com>, Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Message-ID: <20220822180241.5f625ed3@booty>
In-Reply-To: <20220819165455.270130-1-marex@denx.de>
References: <20220819165455.270130-1-marex@denx.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 16:02:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13924

Hi Marek,

On Fri, 19 Aug 2022 18:54:55 +0200
"Marek Vasut" <marex@denx.de> wrote:

> The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> single object in the remote repository. This works poorly with gitlab
> and github, which use the remote git repository to track its metadata
> like merge requests, CI pipelines and such.
> 
> Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> and refs/keep-around/* and they all contain massive amount of data that
> are useless for the bitbake build purposes. The amount of useless data
> can in fact be so massive (e.g. with FDO mesa.git repository) that some
> proxies may outright terminate the 'git fetch' connection, and make it
> appear as if bitbake got stuck on 'git fetch' with no output.
> 
> To avoid fetching all these useless metadata, tweak the git fetcher such
> that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
> refspecs as those are only available in new git versions.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Of course this might become irrelevant with whatever implementation
will be in v2, however when testing with this patch applied I got the
following warning and wonder whether they are related:

WARNING: mesa-2_22.1.6-r0 do_package_qa: QA Issue: File /usr/lib/dri/nouveau_dri.so in package mesa-megadriver contains reference to TMPDIR

Full log:
https://autobuilder.yoctoproject.org/typhoon/#/builders/72/builds/5753/steps/32/logs/stdio

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

