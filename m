Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08290C3ABB2
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 12:22:18 +0000 (UTC)
Received: from smarthost01b.ixn.mail.zen.net.uk (smarthost01b.ixn.mail.zen.net.uk [212.23.1.21])
 by mx.groups.io with SMTP id smtpd.web11.14263.1748434934704613042
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 May 2025 05:22:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=hGn6JWVq;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.21, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01b.ixn.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uKFnQ-00CBxk-My;
	Wed, 28 May 2025 12:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=xx2MBcJavQMlaZEYQcGXeyU7OxrjT/1TkuobmvP28mY=; b=hGn6J
	WVqsC9WzXu6wpPWldiZcvspXaV3ZNpmQXe83GLLnHyvqKUHKZjTVEVD14XqqFNti22O2tla+WWEOe
	zt8W7gAX3riSVCRHD935g1REI5+c8tdmN/tsixqihd+Ii0fm0DrkW3A1wwO4tccLnqe1eKfTQeXNu
	bPJDkRcKY0xOIixlqdDu2zbzx+avzjPhMegxv7quOMqtCxr9eTKFARxkbDpxfdbQGwqnFdxuLyeuZ
	lHQWy8Vx7qpgVSvY8+uT8uxKWvA0r/KQge5JBbwIyxaG5iCchJ/JTOsiqzJGio6VcGvQJ/oGmAsUs
	+G2UFjk8ipV0LmRBDAKMBxx8q+t0w==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uKFnQ-00AHLj-1a;
	Wed, 28 May 2025 13:22:12 +0100
Date: Wed, 28 May 2025 13:22:12 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Jack Mitchell <jack@embed.me.uk>
Subject: Tuning BB_PRESSURE_ values (was Re: [bitbake-devel] [PATCH]
 runqueue: Allow pressure state change notifications to be disabled)
Message-ID: <aDb_9E_ZqiOb_zz8@mcrowe.com>
References: <20250523145205.3542264-1-mac@mcrowe.com>
 <d317516d9184fc3d304f1c21577d0503e06e93cb.camel@linuxfoundation.org>
 <aDXY_Vp48EnDDP9-@mcrowe.com>
 <adfa0b4e7e456937f9fe5cea524ddb0f773c4c6c.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfa0b4e7e456937f9fe5cea524ddb0f773c4c6c.camel@linuxfoundation.org>
X-Originating-smarthost01b-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 May 2025 12:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17650

[snip]

On Tuesday 27 May 2025 at 17:07:45 +0100, Richard Purdie wrote:
> On Tue, 2025-05-27 at 16:23 +0100, Mike Crowe wrote:
> > I get hundreds of lines of pressure monitor changes when building even a
> > single large recipe that can take about an hour. It's always the CPU
> > pressure that has changed.
> > 
> > The last time I looked I couldn't find much guidance for setting
> > BB_NUMBER_THREADS, BB_NUMBER_PARSE_THREADS, PARALLEL_MAKE and
> > BB_PRESSURE_*.
> > 
> > We currently set PARALLEL_MAKE, BB_NUMBER_THREADS and
> > BB_NUMBER_PARSE_THREADS to the number of CPUs on the host. (Our build
> > machines tend to have about 32 logical CPUs though we originally set these
> > values when they only had eight.)
> 
> That is usually about the right amount until you get to larger numbers
> of cores. On the autobuilder which has 96 cores, we use:
> 
> BB_NUMBER_THREADS = '16'
> BB_NUMBER_PARSE_THREADS = '16'
> PARALLEL_MAKE = '-j 16 -l 75'
> BB_PRESSURE_MAX_CPU = '20000'
> BB_PRESSURE_MAX_IO = '20000'
> BB_LOADFACTOR_MAX = '1.5'
> 
> (see meta/conf/fragments/yocto-autobuilder/autobuilder-resource-
> constraints.conf)

I would have expected that value for PARALLEL_MAKE to be stopping a single
instance of make from using anywhere near enough CPUs to cause CPU pressure
with that configuration. With 96 cores you'd need to be running six copies
of make in parallel, and even then the load average limit stands a good
chance of kicking in before the CPU pressure will rise too high.

> >  We set BB_PRESSURE_MAX_* to 2000 (though
> > it seems that I had it overridden to 20000 in my personal configuration - I
> > may have got this from
> > https://wiki.yoctoproject.org/wiki/images/0/04/Yocto_Project_Autobuilder.pdf
> > or similar). All machines have NVMe storage.
> > 
> > In addition to stock oe-core stuff, we also build various
> > embarrassingly-parallel large C++ recipes. These are often blocking
> > dependencies so they run on their own. We end up doing quite a lot of
> > incremental builds too, where some stuff comes from sstate and when
> > compilation does happen ccache is often well populated.
> > 
> > This all means that we'd like an individual task to use as many CPUs as
> > possible but ideally we wouldn't run multiple such massively-parallel tasks
> > in parallel. Of course, Bitbake, Make & Ninja don't know about each other
> > so there's no good solution.
> 
> That is something we might be able to change with a shared job pool.
> Ninja is now able to share make's job pool as of the last week or two
> and once that happens, sharing with bitbake could be possible too.

That's good progress then. Last time I looked the Ninja people were pushing
back a bit.

> > With the above settings I tend to see Bitbake kicking off many tasks all at
> > once, which pushes the pressure too high and it backs off whilst those
> > tasks finish and then the same happens again. It makes the knotty output
> > on console look rather like a spring bouncing up and down. This is clearly
> > not ideal. Luckily there aren't too many really huge tasks that get to run
> > in parallel, so the smaller ones finish and free up resources.
> 
> It is tough, bitbake could perhaps have a startup/backoff algorithm to
> try and avoid it. T

Yes, I did wonder whether it would make sense to wait for a little while
before launching another task to give the first one a chance to get going.
That's bound to make things worse in some situations though.

> That said, the idea has been that it should be able to run
> BB_NUMBER_THREADS in parallel without issue and then the pressure
> regulation kicks in if one of those jobs is heavy and using system
> resources and avoids bitbake starting any new jobs until it is done.
> 
> I still suspect your pressure numbers may be low. How to work them out
> is trial and error though, I wish there was a better way.

I'll certainly try much higher pressure numbers. I could certainly try
reducing BB_NUMBER_THREADS, but reducing PARALLEL_MAKE's -j would slow down
the larger projects we build when they are the only task running. It's
probably worth experimenting with -l too though.

Thanks for your comments and advice.

Mike.

