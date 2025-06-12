Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EC7C61CE8
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 14:33:15 +0000 (UTC)
Received: from smarthost01a.sbp.mail.zen.net.uk (smarthost01a.sbp.mail.zen.net.uk [212.23.1.1])
 by mx.groups.io with SMTP id smtpd.web10.14856.1749738792091727027
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Jun 2025 07:33:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=J7TSjpR/;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.1, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01a.sbp.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uPizH-00C60J-1V;
	Thu, 12 Jun 2025 14:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=jv243kjrFJM8JHUCbe6sCDwpuKMzA2ePdk0PuEFnmvk=; b=J7TSj
	pR/y0iF9JcezaQPnYzo9bcKYlt0LVXUTipHinKWRBwAPUMKH2NPilYPoNOOiVIb9rRH2eGQjY0hMW
	1RSCTXFm09dsE/ND9YnE4bY/6XoWjZdLpYNoBEtUNyXfJ+3UHSGnkZ1KArRVw8lUwuorexZiYqac0
	osm4WgHx2kWV7BoHZwo4BLO1o8lddYMW7MPgA2A3747hreiazb78bHX4TNsPSNGm8YA7hEjpkjVsv
	qiIz0KGuuh755okRFQCLPkKXw5xD0CJL/JW/YfOAI3qAJ0Y0L7W3TQqp6qXoI73hCT8S4SQmIyy+K
	G058DvJXCQBOwHmnrRo1EWkWiTM0w==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uPizN-001ouA-1x;
	Thu, 12 Jun 2025 15:33:09 +0100
Date: Thu, 12 Jun 2025 15:33:09 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
Message-ID: <aErlJVHB8_AbsYqH@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
 <aD2ByO73juj7zy7I@mcrowe.com>
 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
 <aD3TP6hIE9vvFaAo@mcrowe.com>
 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
 <aEXier1YxgCzOv1F@mcrowe.com>
 <518ee0f0eef4e155c93ccba344a5ea1e6102b37b.camel@linuxfoundation.org>
 <1847671617FAC7D3.17668@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1847671617FAC7D3.17668@lists.openembedded.org>
X-Originating-smarthost01a-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jun 2025 14:33:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17700

[
 Snip explanation of problems with recipes that have the same PACKAGE_ARCH
 but different task hashes. My understanding of Richard's view was that
 although doing this may have worked in the past, it is to be avoided. I
 wrote a script to detect tasks with the same PACKAGE_ARCH and differing
 hashes.
]

On Monday 09 June 2025 at 15:45:21 +0100, Mike Crowe via lists.openembedded.org wrote:
> Instead I hacked together a Python script that reads the locked-sigs.inc
> files, that are already conveniently arranged by PACKAGE_ARCH. It seems to
> detect problematic recipes for me. At the very least it might help work out
> whether this problem is common enough that more work would be worthwhile.

Hi Richard,

Unfortunately this script revealed that there are various problems that are
difficult to address.

1. CC for allarch packages

We have slightly different values for CC on different MACHINEs. (32-bit
ARMs get -mfp16-format= and particularly-contrained MACHINEs get reduced
SECURITY_CFLAGS. All with the same DEFAULTTUNE are consistent though.) CC
is always exported by bitbake.conf (among several other places). This
taints all task hashes for all recipes, even allarch ones. Setting CC =
"no-cc-for-allarch" in allarch.bbclass works around this problem for
allarch packages.

2. multilib changes baselib for native and allarch packages

The task hashes for native packages change when multilib changes baselib
for the primary (i.e. non-MLPREFIX) architecture. This ends up tainting the
hashes of some allarch packages which depend on -native packages too, such
as ca-certificates.

This can be solved if we can avoid baselib being different. I'm hoping that
we can do this which will make this a non-problem for us. It may be more of
a problem for others.

3. RECIPE_SYSROOT changes its dependencies when using multilib

Between multilib-using and non-multilib-using machines RECIPE_SYSROOT
changes which variables it depends on, even if its expanded version doesn't
change value. This causes the hashes to change:

 basehash changed from 7e0c5fd84cfb6c12da76d35af73b20ad139213fe8d3d66c9efb934ad5da2c73a to f3644c0dfa625fc1b60782e4e32afb622abf0620bd3235d07a543b3bb4de4d65
 List of dependencies for variable RECIPE_SYSROOT changed from 'frozenset()' to 'frozenset({'MLPREFIX'})'
 Dependency on variable MLPREFIX was added
 Variable RECIPE_SYSROOT value changed from '${WORKDIR}/recipe-sysroot' to '${WORKDIR}/${MLPREFIX}recipe-sysroot'

The only way I can think of to avoid this is to always set RECIPE_SYSROOT
to "${WORKDIR}/${MLPREFIX}recipe-sysroot" in bitbake.conf (which means
setting RECIPE_SYSROOT:class-native too), even when not using multilib.

4. gcc-source is sensitive to TARGET_CC_ARCH, SECURITY_CFLAGS and
   SECURITY_LDFLAGS.

gcc-source.inc already has a list of variables that it has to sanitise. It
can sanitise these too.

5. cross packages are PACKAGE_ARCH = "${BUILD_ARCH}", but they depend on
   non-cross packages with the default PACKAGE_ARCH.

This means that changing PACKAGE_ARCH for MACHINEs that have differences in
(e.g.) multilib or SECURITY_CFLAGS isn't sufficient to ensure that they are
kept separate. That different value of PACKAGE_ARCH in (e.g.)
linux-libc-headers taints the hashes for (e.g.) gcc-cross-aarch64.

6. :append breaks the variable sanitising done by native.bbclass,
   allarch.bbclass, gcc-source.inc etc.

The :append happens after the variable has been sanitised. The only way I
can see around this is to invent new "EXTRA_" variables included in the
default value.


Assuming we can't fix all of these we're left unable to rely on a tool to
identify more serious contraventions. I think this leaves us with four
options:

A. Fix all the serious contraventions of recipes changing behaviour with
   the same PACKAGE_ARCH we know about and hope that if any new ones appear
   we'll be able to work out what's going wrong and fix them. This isn't
   great because it will probably be members of the team who have less
   understanding of this stuff that encounter the problems. This assumes
   that any problems cause actual build failures rather than silent
   misbehaviour.

B. Find some way to fix all the above problems, and any new ones that are
   then revealed. Keep using a tool on the autobuilder to make sure that no
   new contraventions appear. Encourage use of the tool in other layers
   too.

C. Find a way to fix the Bitbake problem that I originally identified at
   the start of this thread. I think that I was on the right track by
   suggesting that we need to do what sstate_clean does to clean up old
   stamps even when running a non-setscene task, but I suspect that this
   got muddled up with my confusion over stamp filenames.

D. Use a distinct TMPDIR for each group of "similar" MACHINEs and rely on
   sstate to avoid needing to rebuild packages that truly are identical.
   I'm not keen on this option because it will require reworking a lot of
   the tooling we have around Bitbake. I also think it would preclude the
   hope that I have that one day we'd be able to use multiconfig to build
   all of our MACHINEs at once in parallel.


In the short term I think that I'm going to have a go at option C, but with
the fallback that I can just hack around oe-core#5634f2fb17 to fix the
problem for us in the short term.

Thanks.

Mike.

