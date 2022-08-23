Return-Path: <luca.ceresoli@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0720FC32772
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 14:34:52 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.32125.1661265289895547017
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Aug 2022 07:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=HUEM98nl;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: luca.ceresoli@bootlin.com)
Received: from booty (unknown [77.244.183.192])
	(Authenticated sender: luca.ceresoli@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8E6DAE0002;
	Tue, 23 Aug 2022 14:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1661265287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcfpYQEQIOX4/Aek+6jUpU7d339FUIQU/Ct5HLjmTIg=;
	b=HUEM98nl1nz9wncowVEfsshjhmKQmgml9O1z0U9kMTzJAM+Jc4r0BYfHIzOIYjj6YejeIy
	UNy2AZwjZIlPf7DS+AMGRDg3R52wxA95XaHHNyYGQAa3Z5XImDkpX/4Rz/rOUZilUJcaFg
	C3JjJtqQa3fOiBPIwWb10E8SErAABj1erX8vLV31mIKPvl5VJcsOs0gHfdwurEYzhsFYSJ
	jSF28OC6tp4LUuiuhe2QFqqSJg3aMGJRpmNpA2FMgO+CjmwuOL2p4WRXrkP5uWNKSj2t8t
	oDeAcghfq7b4/KOCbc0wuoanbQ9bianDq4O3OusVH1KoBagmE1JEej9RxmrYlg==
Date: Tue, 23 Aug 2022 16:34:45 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Cc: Marek Vasut <marex@denx.de>, bitbake-devel@lists.openembedded.org,
 Martin Jansa <Martin.Jansa@gmail.com>, Peter Kjellerstedt
 <peter.kjellerstedt@axis.com>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Message-ID: <20220823163445.5b2f49ed@booty>
In-Reply-To: 
 <1488fe161adc25a2c35d35a72db0c26ba974b12c.camel@linuxfoundation.org>
References: <20220819165455.270130-1-marex@denx.de>
	<20220822180241.5f625ed3@booty>
	<1488fe161adc25a2c35d35a72db0c26ba974b12c.camel@linuxfoundation.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Aug 2022 14:34:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13931

Hi Richard, Peter,

On Mon, 22 Aug 2022 17:07:50 +0100
"Richard Purdie" <richard.purdie@linuxfoundation.org> wrote:

> On Mon, 2022-08-22 at 18:02 +0200, Luca Ceresoli wrote:
> > Hi Marek,
> > 
> > On Fri, 19 Aug 2022 18:54:55 +0200
> > "Marek Vasut" <marex@denx.de> wrote:
> >   
> > > The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> > > single object in the remote repository. This works poorly with gitlab
> > > and github, which use the remote git repository to track its metadata
> > > like merge requests, CI pipelines and such.
> > > 
> > > Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> > > and refs/keep-around/* and they all contain massive amount of data that
> > > are useless for the bitbake build purposes. The amount of useless data
> > > can in fact be so massive (e.g. with FDO mesa.git repository) that some
> > > proxies may outright terminate the 'git fetch' connection, and make it
> > > appear as if bitbake got stuck on 'git fetch' with no output.
> > > 
> > > To avoid fetching all these useless metadata, tweak the git fetcher such
> > > that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
> > > refspecs as those are only available in new git versions.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>  
> > 
> > Of course this might become irrelevant with whatever implementation
> > will be in v2, however when testing with this patch applied I got the
> > following warning and wonder whether they are related:
> > 
> > WARNING: mesa-2_22.1.6-r0 do_package_qa: QA Issue: File /usr/lib/dri/nouveau_dri.so in package mesa-megadriver contains reference to TMPDIR
> > 
> > Full log:
> > https://autobuilder.yoctoproject.org/typhoon/#/builders/72/builds/5753/steps/32/logs/stdio
> >   
> 
> This is a known issue with an open bug assigned to me (unfortunately),
> it isn't related. It is intermittent as it is llvm-native related and
> we don't commonly rebuild this codepath.

Indeed, added to https://bugzilla.yoctoproject.org/show_bug.cgi?id=14897

Thanks for the hint and apologies for the noise.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

