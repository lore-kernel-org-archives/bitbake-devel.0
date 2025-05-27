Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5EEC54F30
	for <webhook@archiver.kernel.org>; Tue, 27 May 2025 15:23:53 +0000 (UTC)
Received: from smarthost01b.ixn.mail.zen.net.uk (smarthost01b.ixn.mail.zen.net.uk [212.23.1.21])
 by mx.groups.io with SMTP id smtpd.web11.54761.1748359424112079039
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 May 2025 08:23:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=qmpAYdOp;
 spf=pass (domain: mcrowe.com, ip: 212.23.1.21, mailfrom: mac@mcrowe.com)
Received: from [88.97.37.36] (helo=deneb.mcrowe.com)
	by smarthost01b.ixn.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <mac@mcrowe.com>)
	id 1uJw9W-007mJi-6Y;
	Tue, 27 May 2025 15:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description; bh=U5kRkyBMI4gMHaRokXbuk1V+ki3SqV1NiiwYcqI/k1w=; b=qmpAY
	dOpWQZwMK0qKG/Z5rsc1a0QhKEuVkro0j7MMimE10jcDqGrGxCjfIHcl4U5gKWzhg0v1GrVRD7U8L
	eZsSPfdFfFPpT9E6zsCRCJIvNF2h6ddwVsW2d5v+jATxvi2Nz+BZz993c3yn9OptesV/xicsK51sd
	NH2NSksVGlktrAxXgVWaiebHasdMZCulezW4SzM/O0ZEQDAS27csUJvMRfGVjxwdDTuBbzMKwjKfy
	N1mls+Ecs/TQJNOz4PItbRzQxiVJiYCQD5Bqji/abMdgnZpo5+jpfHn3IrQ9SJnuOAJqc7smZwm3P
	FTuZ6p71AuKZBxP75PrxIvHSjfE5A==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.96)
	(envelope-from <mac@mcrowe.com>)
	id 1uJw9V-007snt-34;
	Tue, 27 May 2025 16:23:41 +0100
Date: Tue, 27 May 2025 16:23:41 +0100
From: Mike Crowe <mac@mcrowe.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, Jack Mitchell <jack@embed.me.uk>
Subject: Re: [bitbake-devel] [PATCH] runqueue: Allow pressure state change
 notifications to be disabled
Message-ID: <aDXY_Vp48EnDDP9-@mcrowe.com>
References: <20250523145205.3542264-1-mac@mcrowe.com>
 <d317516d9184fc3d304f1c21577d0503e06e93cb.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d317516d9184fc3d304f1c21577d0503e06e93cb.camel@linuxfoundation.org>
X-Originating-smarthost01b-IP: [88.97.37.36]
Feedback-ID: 88.97.37.36
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 May 2025 15:23:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17648

On Tuesday 27 May 2025 at 09:11:03 +0100, Richard Purdie wrote:
> On Fri, 2025-05-23 at 15:52 +0100, Mike Crowe via lists.openembedded.org wrote:
> > Allow setting BB_PRESSURE_NOTE_CHANGE = "0" to disable NOTE messages
> > being emitted every time the pressure state changes. The previous
> > default behaviour is not changed.
> > 
> > Signed-off-by: Mike Crowe <mac@mcrowe.com>
> > Reviewed-by: Jack Mitchell <jack@embed.me.uk>
> > ---
> > �.../bitbake-user-manual-ref-variables.rst����������������� | 7 +++++++
> > �lib/bb/runqueue.py���������������������������������������� | 3 ++-
> > �2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index 477443e22..cd81a586e 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -574,6 +574,13 @@ overview of their function and contents.
> > ������ might be useful as a last resort to prevent OOM errors if they are
> > ������ occurring during builds.
> > �
> > +�� :term:`BB_PRESSURE_NOTE_CHANGE`
> > +
> > +����� By default Bitbake emits a note message each time the scheduler
> > +����� decides to stop or start scheduling new tasks due to pressure
> > +����� changes. Setting :term:`BB_PRESSURE_NOTE_CHANGE` to "0" stops these
> > +����� messages.
> > +
> > ��� :term:`BB_RUNFMT`
> > ������ Specifies the name of the executable script files (i.e. run files)
> > ������ saved into ``${``\ :term:`T`\ ``}``. By default, the

[snip]

Thanks for considering the patch.

> I've resisted taking a change like this in the past since firstly, we'd
> otherwise get complaints about "why is bitbake not executing anything?"

The comment in next_buildable_task implies that at least one task is always
running (or shortly will be). Perhaps you didn't mean the complaint to be
taken completely literally though? :)

> since it becomes unclear why bitbake isn't doing anything. The second
> issue is that if you're seeing large numbers of pressure messages, your
> configuration probably isn't right.

I get hundreds of lines of pressure monitor changes when building even a
single large recipe that can take about an hour. It's always the CPU
pressure that has changed.

The last time I looked I couldn't find much guidance for setting
BB_NUMBER_THREADS, BB_NUMBER_PARSE_THREADS, PARALLEL_MAKE and
BB_PRESSURE_*.

We currently set PARALLEL_MAKE, BB_NUMBER_THREADS and
BB_NUMBER_PARSE_THREADS to the number of CPUs on the host. (Our build
machines tend to have about 32 logical CPUs though we originally set these
values when they only had eight.) We set BB_PRESSURE_MAX_* to 2000 (though
it seems that I had it overridden to 20000 in my personal configuration - I
may have got this from
https://wiki.yoctoproject.org/wiki/images/0/04/Yocto_Project_Autobuilder.pdf
or similar). All machines have NVMe storage.

In addition to stock oe-core stuff, we also build various
embarrassingly-parallel large C++ recipes. These are often blocking
dependencies so they run on their own. We end up doing quite a lot of
incremental builds too, where some stuff comes from sstate and when
compilation does happen ccache is often well populated.

This all means that we'd like an individual task to use as many CPUs as
possible but ideally we wouldn't run multiple such massively-parallel tasks
in parallel. Of course, Bitbake, Make & Ninja don't know about each other
so there's no good solution.

With the above settings I tend to see Bitbake kicking off many tasks all at
once, which pushes the pressure too high and it backs off whilst those
tasks finish and then the same happens again. It makes the knotty output
on console look rather like a spring bouncing up and down. This is clearly
not ideal. Luckily there aren't too many really huge tasks that get to run
in parallel, so the smaller ones finish and free up resources.

> I'm also never that keen on single use variables like this.
> 
> I'm therefore torn on the patch. I can see why you're asking for it,
> that doesn't mean it is the right thing to do though...

Your position is understandable. We can keep this as a local change until
we can fathom out a better solution.

Thanks.

Mike.

