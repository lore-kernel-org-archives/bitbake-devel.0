Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB088C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 10:49:55 +0000 (UTC)
Received: from smarthost01a.sbp.mail.zen.net.uk (smarthost01a.sbp.mail.zen.net.uk [212.23.1.1])
 by mx.groups.io with SMTP id smtpd.web10.46779.1748861388435447805
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 03:49:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=FDTgZx+m;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.1, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01a.sbp.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uM2jf-00Az5w-4q;
	Mon, 02 Jun 2025 10:49:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:CC:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=qIDUEp4A+JNtqJt3MAbIKEaOhDslJXCFq3cFPZ7Ugbg=; b=FDTgZ
	x+mU0GHjDd9bwjmE9M8NYnI/hXPFGjMtfsaSMPSSb3GAGN5Iyr08GI6S0g/uWO8Gz0iIywCUUbKSb
	JsodwrOmxibqd2A00fULTzirb/rKC8sB4cV15/6H7vbQIOgWLEReHl8hR0xBgBotDOALmakV7gLM1
	znjWu1HkeLVyuGNWef8kqbWv+bm3mU2t/l06+4JTvW8QSVriaPAQIWm2YMSqVAIP9C7ku+rk8QVg4
	/MNDtJi8u1Cox5BCug127o5TnnM72nVJpNVQSjTvVIsQZzs0AF41LmuzbeNn428ZV5MpLPz13DhO3
	BjyJuZFgpQRiHw8HBlhvn19SIDhug==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uM2jg-005nEK-1l;
	Mon, 02 Jun 2025 11:49:44 +0100
Date: Mon, 2 Jun 2025 11:49:44 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Quentin Schulz <quentin.schulz@cherry.de>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
Message-ID: <aD2ByO73juj7zy7I@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
X-Originating-smarthost01a-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 10:49:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17671

On Monday 02 June 2025 at 12:15:57 +0200, Quentin Schulz wrote:
> Hi Mike,
> 
> On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > I seem to be running into a problem in Scarthgap that relates to outdated
> > stamp files not being removed. I think this results in tasks not running
> > when they should in later builds. I don't believe that this problem happens
> > with Dunfell[1], though it does still happen with current master (both
> > Bitbake and openembedded-core) too[2].
> > 
> > In case my description below isn't clear, the files required are available
> > in
> > https://github.com/mikecrowe/openembedded-core/tree/stamps-not-removed-repro
> > though
> > https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e1d2d429c6076481952bace251750c
> > is probably the most interesting to look at.
> > 
> > My reproduction requires a package to have two different recipes with
> > different COMPATIBLE_MACHINEs and swapping between building for those two
> > different MACHINEs. I'm using dummy recipes called lictest_one.bb and
> > lictest_two.bb because I'm able to reproduce this problem with licence
> > files, though I suspect that it is not limited to them. I have two machines
> > named qemuarm64 and qemuarm64b.
> > 
> > # PREPARATION
> > 
> > I first start by running the cleansstate task for the recipe for both
> > MACHINEs in order to ensure we're starting from a sensible state:
> > 
> >   MACHINE=qemuarm64 bitbake -c cleansstate lictest
> >   MACHINE=qemuarm64b bitbake -c cleansstate lictest
> > 
> > # FIRST MACHINE BUILD 1
> > 
> > I build for the first machine:
> > 
> >   MACHINE=qemuarm64 bitbake core-image-minimal
> > 
> > At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains the
> > licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contains
> 
> Intuitively I would say that your recipes also need to have PACKAGE_ARCH =
> "${MACHINE_ARCH}" set and then this wouldn't be an issue at all I believe
> (because different directories for each recipe). I'm not entirely sure what
> is the recommendation for when to start using PACKAGE_ARCH =
> "${MACHINE_ARCH}", like what's the thing that should trigger this addition
> in the recipe?

Hi Quentin,

Thanks. I had been holding that back as a somewhat-hacky solution to the
problem. It would reduce the amount setscene tasks running when switching
though.

In reality the situation is more complex than the one I described above. We
actually have multiple machines and two sets of recipes. Some machines use
one set of recipes and some use the other set. Using PACKAGE_ARCH =
"${MACHINE_ARCH}" might work, but it would result in more builds than
necessary. I had considered changing setting PACKAGE_ARCH =
"${TUNE_PKGARCH}-suffix" or PACKAGE_ARCH:append = "-suffix" or similar
would work, but I haven't tested that.

It's also not been clear to me where the divide between PACKAGE_ARCH =
"${TUNE_PKGARCH}" and PACKAGE_ARCH = "${MACHINE_ARCH}" is. There are lots
of ways (e.g. setting PACKAGECONFIG:pn-package) that could cause a
PACKAGE_ARCH = "${TUNE_PKGARCH}"-specific recipe to vary between MACHINEs.

> I'm also not saying that this isn't a bug or a bigger issue, even if my
> suggestion may work around the issue.

Thanks for the suggestion. If Dunfell had behaved as Scarthgap or master
currently do then we probably would have just considered that to be the
expected behaviour.

Mike.

