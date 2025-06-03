Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C191C5AD49
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 10:07:18 +0000 (UTC)
Received: from smarthost01b.ixn.mail.zen.net.uk (smarthost01b.ixn.mail.zen.net.uk [212.23.1.21])
 by mx.groups.io with SMTP id smtpd.web11.7704.1748945236108369274
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jun 2025 03:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=jLHIVn+b;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.21, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01b.ixn.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uMOY6-004oKo-2m;
	Tue, 03 Jun 2025 10:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:To:From:Date:Sender:Reply-To:CC:Content-ID:
	Content-Description; bh=vKFDriLXExCjSY3Fpsl8auWEjN21mjuYBcCYS4QuK+g=; b=jLHIV
	n+bUK7I7k9qzsBbU9E40nMSpBlaTzeDGkxfFS1r2nYX3+DBtiU536jtYc7U2cN3hcnhU/FwTefBpN
	GhYtszmKds9zGw8prtkZ2ZhCTk8qgRa3ydhQ5jStYAWrrKb7RaCFUtXXlq87DhHzZuXczQozmclZY
	xVHxFHKQ7nFCIN2dtcn3ChD7vVUgF2frt6+Jk6sjK1jCtp3bWDbeWsepy79+f0d7SlQSWCorCvyin
	V2IrS6a7alDmK09qjS81LOV8GrGWvHR7F4F8RN0PPqxFVcCveIXEi64qohlWwrHIMHH3toWCw7ZmA
	UrZY4WT05EGqyaGdDnPNE4zj2Lwag==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uMOY6-008QnB-09;
	Tue, 03 Jun 2025 11:07:14 +0100
Date: Tue, 3 Jun 2025 11:07:14 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] Should stamp files for different versions of a
 recipe exist at the same time?
Message-ID: <aD7JUkYhjqg70RAR@mcrowe.com>
References: <aDnoNJFkC535qqiI@mcrowe.com>
 <18dd4e56-87a5-4de3-a148-bd42f67ba57a@cherry.de>
 <aD2ByO73juj7zy7I@mcrowe.com>
 <418eea7bdcd9b528623498a6139ae42389ef192d.camel@linuxfoundation.org>
 <aD3TP6hIE9vvFaAo@mcrowe.com>
 <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9296bd359abc522a135cbaa37995d5b5633046e.camel@linuxfoundation.org>
X-Originating-smarthost01b-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jun 2025 10:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17676

On Monday 02 June 2025 at 22:04:39 +0100, Richard Purdie wrote:
> On Mon, 2025-06-02 at 17:37 +0100, Mike Crowe wrote:
> > On Monday 02 June 2025 at 15:17:44 +0100, Richard Purdie wrote:
> > > On Mon, 2025-06-02 at 11:49 +0100, Mike Crowe via lists.openembedded.org wrote:
> > > > On Monday 02 June 2025 at 12:15:57 +0200, Quentin Schulz wrote:
> > > > > Hi Mike,
> > > > > 
> > > > > On 5/30/25 7:17 PM, Mike Crowe via lists.openembedded.org wrote:
> > > > > > I seem to be running into a problem in Scarthgap that relates to outdated
> > > > > > stamp files not being removed. I think this results in tasks not running
> > > > > > when they should in later builds. I don't believe that this problem happens
> > > > > > with Dunfell[1], though it does still happen with current master (both
> > > > > > Bitbake and openembedded-core) too[2].
> > > > > > 
> > > > > > In case my description below isn't clear, the files required are available
> > > > > > in
> > > > > > https://github.com/mikecrowe/openembedded-core/tree/stamps-not-removed-repro
> > > > > > though
> > > > > > https://github.com/mikecrowe/openembedded-core/commit/8fd8055ab3e1d2d429c6076481952bace251750c
> > > > > > is probably the most interesting to look at.
> > > > > > 
> > > > > > My reproduction requires a package to have two different recipes with
> > > > > > different COMPATIBLE_MACHINEs and swapping between building for those two
> > > > > > different MACHINEs. I'm using dummy recipes called lictest_one.bb and
> > > > > > lictest_two.bb because I'm able to reproduce this problem with licence
> > > > > > files, though I suspect that it is not limited to them. I have two machines
> > > > > > named qemuarm64 and qemuarm64b.
> > > > > > 
> > > > > > # PREPARATION
> > > > > > 
> > > > > > I first start by running the cleansstate task for the recipe for both
> > > > > > MACHINEs in order to ensure we're starting from a sensible state:
> > > > > > 
> > > > > > � MACHINE=qemuarm64 bitbake -c cleansstate lictest
> > > > > > � MACHINE=qemuarm64b bitbake -c cleansstate lictest
> > > > > > 
> > > > > > # FIRST MACHINE BUILD 1
> > > > > > 
> > > > > > I build for the first machine:
> > > > > > 
> > > > > > � MACHINE=qemuarm64 bitbake core-image-minimal
> > > > > > 
> > > > > > At this point tmp-glibc/deploy/licenses/cortexa57/lictest contains the
> > > > > > licence files and tmp-glibc/stamps/cortexa57-oe-linux/lictest/ contains
> > > > > 
> > > > > Intuitively I would say that your recipes also need to have PACKAGE_ARCH =
> > > > > "${MACHINE_ARCH}" set and then this wouldn't be an issue at all I believe
> > > > > (because different directories for each recipe). I'm not entirely sure what
> > > > > is the recommendation for when to start using PACKAGE_ARCH =
> > > > > "${MACHINE_ARCH}", like what's the thing that should trigger this addition
> > > > > in the recipe?
> > > > 
> > > > Hi Quentin,
> > > > 
> > > > Thanks. I had been holding that back as a somewhat-hacky solution to the
> > > > problem. It would reduce the amount setscene tasks running when switching
> > > > though.
> > > > 
> > > > In reality the situation is more complex than the one I described above. We
> > > > actually have multiple machines and two sets of recipes. Some machines use
> > > > one set of recipes and some use the other set. Using PACKAGE_ARCH =
> > > > "${MACHINE_ARCH}" might work, but it would result in more builds than
> > > > necessary. I had considered changing setting PACKAGE_ARCH =
> > > > "${TUNE_PKGARCH}-suffix" or PACKAGE_ARCH:append = "-suffix" or similar
> > > > would work, but I haven't tested that.
> > > > 
> > > > It's also not been clear to me where the divide between PACKAGE_ARCH =
> > > > "${TUNE_PKGARCH}" and PACKAGE_ARCH = "${MACHINE_ARCH}" is. There are lots
> > > > of ways (e.g. setting PACKAGECONFIG:pn-package) that could cause a
> > > > PACKAGE_ARCH = "${TUNE_PKGARCH}"-specific recipe to vary between MACHINEs.
> > > > 
> > > > > I'm also not saying that this isn't a bug or a bigger issue, even if my
> > > > > suggestion may work around the issue.
> > > > 
> > > > Thanks for the suggestion. If Dunfell had behaved as Scarthgap or master
> > > > currently do then we probably would have just considered that to be the
> > > > expected behaviour.
> > > 
> > > I have a feeling there were some changes in this area to fix bugs but
> > > I'm not remembering specifics. It sounds like some issue could have
> > > crept in.
> > > 
> > > What you're supposed to be able to do is define your own package
> > > architectures so that you could have two here, one for each of your
> > > configs. You could then switch between them and the appropriate
> > > packages would be used.
> > 
> > The trouble with this is it requires everything that depends on these
> > packages to also use those package architectures otherwise the problem just
> > moves up a level. Recipes changing for the same PACKAGE_ARCH is also not
> > very discoverable in the general case (though in this one it is quite
> > obvious).
> 
> You've changed the configuration for them so it is only right they
> should have a different PACKAGE_ARCH. This kind of thing does ripple
> badly but that is the implication of a change like this.

I agree. I just worry that if nothing breaks most of the time when we fail
to set the different PACKAGE_ARCH on a reverse dependency then we'll not
notice the mistake. Maybe that doesn't matter until it breaks though?

The recipes involved in our case are gstreamer ones, which are depended
upon by many other random recipes in other layers. We _can_ add a .bbappend
for each of them that we use, but there's always a risk that we'll not
notice when someone adds a new dependency. Maybe we could come up with some
tooling to detect the situation?

> Let me explain this slightly differently. We once decided that it was
> ok to change MACHINE and build in the same TMPDIR (multimachine
> support). It was decided that changing DISTRO still meant a new TMPDIR
> though. The implication of this is that if you change the
> configuration/policy of a package (which is effectively distro policy),
> it should be in a different TMPDIR.
> 
> Over time, our error correction handling got better, to the point that
> if you don't change TMPDIR but change DISTRO, it does mostly work. The
> key bit is mostly. Ideally we'd catch all cases and we don't do badly
> but it sounds like we're missing something here.

At least in Dunfell, and probably for a while before that, I think that you
did such a good job that my expectations had been that this worked.

> The way to officially handle what you describe is through PACKAGE_ARCH,
> even if that is a bit painful (or separate TMPDIR).
>
> > > As it stands, you're relying on the sstate code to swap things out,
> > > which is meant to be a fallback, not a default way of operating. Far
> > > too many people rely on that doing the right thing now though.
> > 
> > Our situation is actually even worse than I described above. One set of
> > machines has multilib enabled and one doesn't, yet they share a
> > TUNE_PKGARCH so the sstate shuffling happens for every package! Given your
> > response it sounds like we should stop doing this.

I shouldn't have said 'every package' there. I should have said 'every
package where PACKAGE_ARCH = "${TUNE_PKGARCH}"'. In particular
${MACHINE_ARCH}, native and allarch packages don't need shuffling.

> > How would you recommend defining our own package architecture in this case?
> > 
> > 1. TUNE_PKGARCH:append = "-oursuffix"? (Which would also affect
> > �� SSTATE_ARCHS_TUNEPKG.)
> 
> You want sstate arch to be different so this is probably fine.

OK. I did run into some problems when I tried it. I think that option 2
will probably be better anyway.

> > 2. Set the default PACKAGE_ARCH ?= "${TUNE_PKGARCH}-oursuffix" overriding
> > �� the ??= default in bitbake.conf unless someone else overrides it?
> 
> That would change all recipes and you should only change the recipes
> affected and their dependencies.
> 
> If it is all recipes, you want a separate TMPDIR and it is really a
> different distro (or sub-distro).

All recipes that currently have PACKAGE_ARCH set to "${TUNE_PKGARCH}" are
affected. Not allarch ones, not "${MACHINE_ARCH}" ones and, most
importantly for saving time and space, not native ones, so using a
separate TMPDIR would be less than ideal.

> > 3. Something else?
> > 
> > (I had a look through the docs but couldn't find any advice and the
> > multilib examples don't appear to do this.)
> 
> FWIW multilib changes PACKAGE_ARCH.

I'm sorry but I realise now that I've been extremely unclear here. When I
said multilib, I didn't mean that side of multilib that has the
${MLPREFIX}, I meant the side that doesn't. You'd think that enabling
multilib wouldn't have an effect on the non-multilib recipes, but it does
for aarch64 because doing so changes (at least) libdir. :(

For the MACHINE that enables multilib, we have in our machine
configuration:

 DEFAULTTUNE = "cortexa72-cortexa53-crypto"
 require conf/machine/include/tune-cortexa72-cortexa53.inc
 MULTILIBS = "multilib:lib32"
 DEFAULTTUNE:virtclass-multilib-lib32 = "armv7at-neon"

tune-cortexa72-cortexa53.inc contains:

 BASE_LIB:tune-cortexa72-cortexa53-crypto="lib64"

which means that multilib.conf sets libdir based on that to "/usr/lib64".

For the MACHINE that doesn't enable multilib, we have none of that so
bitbake.conf just uses BASELIB to set libdir to "/usr/lib".

I'm not sure if this change is intentional, but it does mean that merely
enabling multilib and not using it changes behaviour.

For our use, we'd have been much happier with libdir always being
"/usr/lib" but we unfortunately got baked into the default behaviour early
on.

[snip]

> > In my original message I wrote:
> > > > > My guess is that the problem here is that the stamps from the first
> > > > > machine build weren't removed during the "SECOND MACHINE BUILD 1" step
> > > > > above. If I remove them myself then the problem goes away. Is that
> > > > > theory correct? If so, then I can start trying to work out why and any
> > > > > advice would be welcome. If that theory is not correct then does anyone
> > > > > have any idea where I should start investigating?
> > 
> > I was hoping that someone would just know the answer to my first question
> > above off the top of their head. If so then I'm willing to try digging into
> > this myself to see what I can discover. I just need to make sure that I'm
> > chasing the right part of the problem.
> 
> I've avoided answering this as I think you're right but I'm not 100%
> sure and I don't want to send you off in the wrong direction. There are
> reasons it might not wipe out stamps and those reasons may be
> intentional but without looking at what is going on I couldn't be
> completely sure. So I think you're right and I'd chase that way but...

Understood. Thank you for your patience with me.

Mike.

