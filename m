Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AB8C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 16:37:27 +0000 (UTC)
Received: from smarthost01c.ixn.mail.zen.net.uk (smarthost01c.ixn.mail.zen.net.uk [212.23.1.22])
 by mx.groups.io with SMTP id smtpd.web11.54549.1748882242885869206
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 09:37:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=UcchaoAe;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.22, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01c.ixn.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uM8A3-00EEhd-Rw;
	Mon, 02 Jun 2025 16:37:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:CC:Content-ID:
	Content-Description; bh=EvPZjwzJLxf16xC1c86eqSxAKVtYbo+6VqGwuWtNbck=; b=Uccha
	oAegEriIVPmqKVSiuiW+N6SBge8FikQW8Tjo7EipETuHv3USo28LNvJ2knI9MXshhKq12FbHIBrvz
	9VBbcOqlOGQ7DQ32oXGlQiOiPhu2ONoiaXwYdGgF8DU5Pl0G5VaPhUExp7SkTQK0ezt22he50f3qT
	d9hhx4P01eG5cQdbPWjC5cuqACdhp2UFrhjKZ0Jdsx9a8deQJpOGJG23WTq+g+lWiREzdnFv0YsCh
	8ayncaHDwKbCmUs+rDdbRbxFAUXzaAKWCF9Nah+O64ZIOcFCkgrQc2OtcRYgBWtU65qLNmqDYN9TX
	4r0EQ8a8yU4N0wDw/1fdJdc+ZRhhA==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uM8A3-006DyU-1d;
	Mon, 02 Jun 2025 17:37:19 +0100
Date: Mon, 2 Jun 2025 17:37:19 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
Message-ID: <aD3TP6hIE9vvFaAo@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
 <aD2ByO73juj7zy7I@mcrowe.com>
 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
X-Originating-smarthost01c-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 16:37:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17674

On Monday 02 June 2025 at 15:17:44 +0100, Richard Purdie wrote:
> On Mon, 2025-06-02 at 11:49 +0100, Mike Crowe via lists.openembedded.org wrote:
> > On Monday 02 June 2025 at 12:15:57 +0200, Quentin Schulz wrote:
> > > Hi Mike,
> > > 
> > > On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > > > I seem to be running into a problem in Scarthgap that relates to outdated
> > > > stamp files not being removed. I think this results in tasks not running
> > > > when they should in later builds. I don't believe that this problem happens
> > > > with Dunfell[1], though it does still happen with current master (both
> > > > Bitbake and openembedded-core) too[2].
> > > > 
> > > > In case my description below isn't clear, the files required are available
> > > > in
> > > > https://github.com/mikecrowe/openembedded-core/tree/stamps-not-removed-repro
> > > > though
> > > > https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e1d2d429c6076481952bace251750c
> > > > is probably the most interesting to look at.
> > > > 
> > > > My reproduction requires a package to have two different recipes with
> > > > different COMPATIBLE_MACHINEs and swapping between building for those two
> > > > different MACHINEs. I'm using dummy recipes called lictest_one.bb and
> > > > lictest_two.bb because I'm able to reproduce this problem with licence
> > > > files, though I suspect that it is not limited to them. I have two machines
> > > > named qemuarm64 and qemuarm64b.
> > > > 
> > > > # PREPARATION
> > > > 
> > > > I first start by running the cleansstate task for the recipe for both
> > > > MACHINEs in order to ensure we're starting from a sensible state:
> > > > 
> > > > � MACHINE=qemuarm64 bitbake -c cleansstate lictest
> > > > � MACHINE=qemuarm64b bitbake -c cleansstate lictest
> > > > 
> > > > # FIRST MACHINE BUILD 1
> > > > 
> > > > I build for the first machine:
> > > > 
> > > > � MACHINE=qemuarm64 bitbake core-image-minimal
> > > > 
> > > > At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains the
> > > > licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contains
> > > 
> > > Intuitively I would say that your recipes also need to have PACKAGE_ARCH =
> > > "${MACHINE_ARCH}" set and then this wouldn't be an issue at all I believe
> > > (because different directories for each recipe). I'm not entirely sure what
> > > is the recommendation for when to start using PACKAGE_ARCH =
> > > "${MACHINE_ARCH}", like what's the thing that should trigger this addition
> > > in the recipe?
> > 
> > Hi Quentin,
> > 
> > Thanks. I had been holding that back as a somewhat-hacky solution to the
> > problem. It would reduce the amount setscene tasks running when switching
> > though.
> > 
> > In reality the situation is more complex than the one I described above. We
> > actually have multiple machines and two sets of recipes. Some machines use
> > one set of recipes and some use the other set. Using PACKAGE_ARCH =
> > "${MACHINE_ARCH}" might work, but it would result in more builds than
> > necessary. I had considered changing setting PACKAGE_ARCH =
> > "${TUNE_PKGARCH}-suffix" or PACKAGE_ARCH:append = "-suffix" or similar
> > would work, but I haven't tested that.
> > 
> > It's also not been clear to me where the divide between PACKAGE_ARCH =
> > "${TUNE_PKGARCH}" and PACKAGE_ARCH = "${MACHINE_ARCH}" is. There are lots
> > of ways (e.g. setting PACKAGECONFIG:pn-package) that could cause a
> > PACKAGE_ARCH = "${TUNE_PKGARCH}"-specific recipe to vary between MACHINEs.
> > 
> > > I'm also not saying that this isn't a bug or a bigger issue, even if my
> > > suggestion may work around the issue.
> > 
> > Thanks for the suggestion. If Dunfell had behaved as Scarthgap or master
> > currently do then we probably would have just considered that to be the
> > expected behaviour.
> 
> I have a feeling there were some changes in this area to fix bugs but
> I'm not remembering specifics. It sounds like some issue could have
> crept in.
> 
> What you're supposed to be able to do is define your own package
> architectures so that you could have two here, one for each of your
> configs. You could then switch between them and the appropriate
> packages would be used.

The trouble with this is it requires everything that depends on these
packages to also use those package architectures otherwise the problem just
moves up a level. Recipes changing for the same PACKAGE_ARCH is also not
very discoverable in the general case (though in this one it is quite
obvious).

> As it stands, you're relying on the sstate code to swap things out,
> which is meant to be a fallback, not a default way of operating. Far
> too many people rely on that doing the right thing now though.

Our situation is actually even worse than I described above. One set of
machines has multilib enabled and one doesn't, yet they share a
TUNE_PKGARCH so the sstate shuffling happens for every package! Given your
response it sounds like we should stop doing this.

How would you recommend defining our own package architecture in this case?

1. TUNE_PKGARCH:append = "-oursuffix"? (Which would also affect
   SSTATE_ARCHS_TUNEPKG.)

2. Set the default PACKAGE_ARCH ?= "${TUNE_PKGARCH}-oursuffix" overriding
   the ??= default in bitbake.conf unless someone else overrides it?

3. Something else?

(I had a look through the docs but couldn't find any advice and the
multilib examples don't appear to do this.)

> So I'd say there is probably a bug somewhere here but you're also not
> using the system quite as intended.

> Thanks for a test case btw, that really helps. I will try and take a
> look if I can find time but that is hard atm :/.

In my original message I wrote:
>>> My guess is that the problem here is that the stamps from the first
>>> machine build weren't removed during the "SECOND MACHINE BUILD 1" step
>>> above. If I remove them myself then the problem goes away. Is that
>>> theory correct? If so, then I can start trying to work out why and any
>>> advice would be welcome. If that theory is not correct then does anyone
>>> have any idea where I should start investigating?

I was hoping that someone would just know the answer to my first question
above off the top of their head. If so then I'm willing to try digging into
this myself to see what I can discover. I just need to make sure that I'm
chasing the right part of the problem.

Thanks.

Mike.

