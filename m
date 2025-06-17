Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE971C71157
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 13:47:31 +0000 (UTC)
Received: from smarthost01c.sbp.mail.zen.net.uk (smarthost01c.sbp.mail.zen.net.uk [212.23.1.5])
 by mx.groups.io with SMTP id smtpd.web11.19400.1750168039743844966
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Jun 2025 06:47:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=TKEP15/r;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.5, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01c.sbp.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uRWej-000jpm-BW;
	Tue, 17 Jun 2025 13:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description; bh=6SDu1D6bSL6d00AwHEQG2xYTL/aCcQ6saaHY9D8X3PI=; b=TKEP1
	5/rbHCbgnVjEAuU1/xaW2JGrsq1fb5ZpeVLBV3zNyQv4htTu0h3f1uKbo1WyM3aWw67DoKZVaamNe
	DnKhoJzS13CDunXN1hk1JMXECxuwWpif4S4ZfnEOneV+huGhqJ1X05QAXspDXHs4/z6RWL8QY3c4f
	uCPgI260ITMy6uNHbBOOXmvr0I8CPFp6ES8RXK84pE9nRHbu1i4gdzthDeC5KGeP+GmmjRLVnxSuR
	AhHnp033ZMMYhkJ4s+Ci/UqseJi7Jx/8tF1ge2MB1LPGCqcbRy8phEO/ByF7QmTH8jqQzzvjoAte2
	0S8fjTxHwcOPzSJ3Rx3xmpbjLI4Ww==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uRWej-00GXyj-1P;
	Tue, 17 Jun 2025 14:47:17 +0100
Date: Tue, 17 Jun 2025 14:47:17 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
Message-ID: <aFFx5VcBF6QxUAW9@mcrowe.com>
References: <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
 <aD2ByO73juj7zy7I@mcrowe.com>
 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
 <aD3TP6hIE9vvFaAo@mcrowe.com>
 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
 <aEXier1YxgCzOv1F@mcrowe.com>
 <518ee0f0eef4e155c93ccba344a5ea1e6102b37b.camel@linuxfoundation.org>
 <1847671617FAC7D3.17668@lists.openembedded.org>
 <aErlJVHB8_AbsYqH@mcrowe.com>
 <2de0572b0f92ac2c0d0d065c488ce501d43afe2a.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2de0572b0f92ac2c0d0d065c488ce501d43afe2a.camel@linuxfoundation.org>
X-Originating-smarthost01c-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Jun 2025 13:47:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17705

On Friday 13 June 2025 at 16:20:46 +0100, Richard Purdie wrote:
> On Thu, 2025-06-12 at 15:33 +0100, Mike Crowe via lists.openembedded.org wrote:
> > [
> > �Snip explanation of problems with recipes that have the same PACKAGE_ARCH
> > �but different task hashes. My understanding of Richard's view was that
> > �although doing this may have worked in the past, it is to be avoided. I
> > �wrote a script to detect tasks with the same PACKAGE_ARCH and differing
> > �hashes.
> > ]
> > 
> > On Monday 09 June 2025 at 15:45:21 +0100, Mike Crowe via lists.openembedded.org wrote:
> > > Instead I hacked together a Python script that reads the locked-sigs.inc
> > > files, that are already conveniently arranged by PACKAGE_ARCH. It seems to
> > > detect problematic recipes for me. At the very least it might help work out
> > > whether this problem is common enough that more work would be worthwhile.
> > 
> > Hi Richard,
> > 
> > Unfortunately this script revealed that there are various problems that are
> > difficult to address.
> > 
> > 1. CC for allarch packages
> > 
> > We have slightly different values for CC on different MACHINEs. (32-bit
> > ARMs get -mfp16-format= and particularly-contrained MACHINEs get reduced
> > SECURITY_CFLAGS. All with the same DEFAULTTUNE are consistent though.) CC
> > is always exported by bitbake.conf (among several other places). This
> > taints all task hashes for all recipes, even allarch ones. Setting CC =
> > "no-cc-for-allarch" in allarch.bbclass works around this problem for
> > allarch packages.
> 
> Where are we adding flags to CC rather than CFLAGS? That sounds like
> the real bug somewhere...

We were doing that ourselves. I can switch to appending to TARGET_CC_ARCH
instead, but that is problematic too as described below.

> > 3. RECIPE_SYSROOT changes its dependencies when using multilib
> > 
> > Between multilib-using and non-multilib-using machines RECIPE_SYSROOT
> > changes which variables it depends on, even if its expanded version doesn't
> > change value. This causes the hashes to change:
> > 
> > �basehash changed from 7e0c5fd84cfb6c12da76d35af73b20ad139213fe8d3d66c9efb934ad5da2c73a to f3644c0dfa625fc1b60782e4e32afb622abf0620bd3235d07a543b3bb4de4d65
> > �List of dependencies for variable RECIPE_SYSROOT changed from 'frozenset()' to 'frozenset({'MLPREFIX'})'
> > �Dependency on variable MLPREFIX was added
> > �Variable RECIPE_SYSROOT value changed from '${WORKDIR}/recipe-sysroot' to '${WORKDIR}/${MLPREFIX}recipe-sysroot'
> > 
> > The only way I can think of to avoid this is to always set RECIPE_SYSROOT
> > to "${WORKDIR}/${MLPREFIX}recipe-sysroot" in bitbake.conf (which means
> > setting RECIPE_SYSROOT:class-native too), even when not using multilib.
> 
> One trick that may work for this is setting:
> 
> RECIPE_SYSROOT[vardepvalue] = "${RECIPE_SYSROOT}"

Thanks. That would be neater if it works. I'll try it.

> > 5. cross packages are PACKAGE_ARCH = "${BUILD_ARCH}", but they depend on
> > �� non-cross packages with the default PACKAGE_ARCH.
> > 
> > This means that changing PACKAGE_ARCH for MACHINEs that have differences in
> > (e.g.) multilib or SECURITY_CFLAGS isn't sufficient to ensure that they are
> > kept separate. That different value of PACKAGE_ARCH in (e.g.)
> > linux-libc-headers taints the hashes for (e.g.) gcc-cross-aarch64.
> 
> I suspect that is meant to be getting excluded from the hashes...

Perhaps. I don't think I understand enough to prove to myself that doing
this is correct. Maybe once I've solved all the other problems I can return
to this one.

> > 6. :append breaks the variable sanitising done by native.bbclass,
> > �� allarch.bbclass, gcc-source.inc etc.
> > 
> > The :append happens after the variable has been sanitised. The only way I
> > can see around this is to invent new "EXTRA_" variables included in the
> > default value.
> 
> Which variables are we appending and can we stop doing that? I keep
> telling people we need to avoid :append and friends...

We're doing it in a few places ourselves, such as:

 TARGET_CC_ARCH:append:armv7ve = " -mfp16-format=ieee"

I can work around this one by putting it only in the machine file so I can
use += rather than :append.

But oe-core also does this in meta/conf/distro/include/time64.inc:

 TARGET_CC_ARCH:append:x86 = "${@bb.utils.contains('TUNE_FEATURES', 'm32', '${GLIBC_64BIT_TIME_FLAGS}', '', d)}"

for example and I can't work around that one from outside.

Whilst addressing some of the above problems I ran into more problems with
gcc-source.inc's sanitising of variables being ineffective when those
variables are assigned using overrides. I was able to work around this by
making gcc-source.inc use :forcevariable for its assignments but I'm
worried that this just risks causing more problems than it solves. :(

[snip]

> I've done my best to give some ideas/thoughts above as best I can...

I'm very grateful for the time and effort you've put into providing advice.
It's become clear to me that we've ended up doing things in a rather
different way to others which means that we're bound to run into our own
unique problems.

Thanks.

Mike.

