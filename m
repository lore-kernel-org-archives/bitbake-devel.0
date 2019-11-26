Return-Path: <matthias.schiffer@ew.tq-group.com>
Received: from mx1.tq-group.com (mx1.tq-group.com [62.157.118.193])
	by mail.openembedded.org (Postfix) with ESMTP id F23247EE86
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Nov 2019 08:43:39 +0000 (UTC)
IronPort-SDR: 445LnFViO35WhDzHMlvMlhh8L9SmanSCx2X53ZAZNGq0WkiUPfEYn9RY3QeL72mh87UmQHqf6N
	8jQy5ekLCQELheQwFui/NHRDUNnenxne1atnFjg1O+aT1A3OewQUCqKsuqbpzXK6/OpNsrlUAC
	cp/yTOhqENY5l3oypfE8+nkiE+KRzJ6oGNiK3mf4k/kPbXJYz8KNo/XbDgfEMom+bQLXdC6xL3
	EXdkIdlQW29uWdFomwJN9ayHEF0DCSIOhj0v4uI1uVwvyz/+7WcdRlvSEJ72HKh7sqYe7WXSQk
	c8c=
X-IronPort-AV: E=Sophos;i="5.69,245,1571695200"; 
   d="scan'208";a="9943513"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
	by mx1-pgp.tq-group.com with ESMTP; 26 Nov 2019 09:43:39 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
	by tq-pgp-pr1.tq-net.de (PGP Universal service);
	Tue, 26 Nov 2019 09:43:39 +0100
X-PGP-Universal: processed;
	by tq-pgp-pr1.tq-net.de on Tue, 26 Nov 2019 09:43:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
	t=1574757819; x=1606293819;
	h=message-id:subject:from:to:cc:date:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=QDlcATqxsYDi/NWSoqpx6TWWY+QLvTOwKc5ru2xDz9w=;
	b=PjWpEcMuZ+qgH70ley3AQfT2N67vPjCU+2K3+DK8PglHm+odZFfn2/Gg
	U2/KmrTP8zEV74G6IIw6ppJlCOceycuG6mCnM0t3eKjRH7wZkFKZ+t5af
	RpAOLcU9J9M4n5w4redVMYCJdf0FJrwDAZuWGB+zeTfbIJc4zSMe3zk1o
	Bv9v9t+s3nJxdIKrHDpqRbxdEzoT7Gvrq1igL+B0gsHXXENpyW6I5pwf/
	9C6La2ayLX8VVYGvtVB+nveNlZS9PaHCYXH0HvK8tJqcReBaadqHAzn+0
	Ir5JXZ1GDXmspQL9EoUam9E+otq5ZTtxkwldDKkRj1JgPTgoPxezu81a8 w==;
IronPort-SDR: BkT8JXLKGWBclZWZWVVdvsmX26mFb9jNLa6efxA9KGvbTv0sw0IBhvoKsax4fQZcrkCCarnUU3
	KLX//gKvyQcJU7ik6NHIvpdJVaQs9+Q0aGD+RPWZ2uGIfpqZgHH7YWeHXLnoO0XZQDUAmXn7Sv
	PaGspCmOLxT4BDTOFxq9J5k8YAeu8RXhofWH41dYhItua9I6Ud+fd/IfLYUPC5ltYPFCeDLeDE
	iAmcYiDuvlqMhqvVr0cI0DccJOTPeaebD+efnfZP1olvGdbRfGGOe+2L88sFXG5PEiQ8yY68gZ
	Sn4=
X-IronPort-AV: E=Sophos;i="5.69,245,1571695200"; 
   d="scan'208";a="9943512"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
	by mx1.tq-group.com with ESMTP; 26 Nov 2019 09:43:39 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de
	[10.117.49.26])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5CF29280065;
	Tue, 26 Nov 2019 09:43:56 +0100 (CET)
Message-ID: <19d11123cce3a537390c3fb82c3376fb28e34268.camel@ew.tq-group.com>
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Date: Tue, 26 Nov 2019 09:43:37 +0100
In-Reply-To: <7ae30f61-e69a-88f2-ad94-eb4638cf5804@kernel.crashing.org>
References: <7c0067a9e4ae762d8c0f8f9dc50e6d3b8891dc60.camel@ew.tq-group.com>
	<9c849d9b-ec91-a67f-284f-86c33c1e6d99@kernel.crashing.org>
	<20a5a2afc463bd7e29688bfba96a3206f6802f0f.camel@ew.tq-group.com>
	<7ae30f61-e69a-88f2-ad94-eb4638cf5804@kernel.crashing.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: (EXT) Re: (EXT) Re: Forcing the rebuild of dependent tasks across recipes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 26 Nov 2019 08:43:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-11-25 at 08:54 -0600, Mark Hatle wrote:
> 
> On 11/25/19 3:58 AM, Matthias Schiffer wrote:
> > On Fri, 2019-11-22 at 11:15 -0600, Mark Hatle wrote:
> > > 
> > > On 11/22/19 9:09 AM, Matthias Schiffer wrote:
> > > > Hi all,
> > > > 
> > > > is there a robust way to enforce the automatic rebuild of
> > > > dependent
> > > > tasks across recipes? I'm having the following issue:
> > > > 
> > > > - Recipe my-core-image has an output file that is copied to the
> > > > deploy
> > > > dir. The output file is not fully reproducible, so cleaning the
> > > > recipe
> > > > and rebuilding it will yield a different file even through the
> > > > sstate
> > > > signature of the recipe is unchanged (the file I'm interested
> > > > is
> > > > DMVerity hash data that I generate as an additional filesystem
> > > > type)
> > > > 
> > > > - Task do_compile of recipe my-initramfs-scripts depends on my-
> > > > core-
> > > > image:do_image_complete. I need to enforce rebuilding of this
> > > > task
> > > > whenever the deployed files of my-core-image have changed (the
> > > > recipe
> > > > uses the "root hash" generated by DMVerity as input, so that
> > > > the
> > > > filesystem can be verified on mount) - and of course also of
> > > > all
> > > > dependent tasks like the initramfs image and FIT kernel image
> > > > 
> > > > I've experimented with things like file-checksums and
> > > > BB_DONT_CACHE,
> > > > but everything I've tried fails when the rebuilds of my-core-
> > > > image
> > > > and
> > > > my-initramfs-scripts are supposed to happen in the same run of
> > > > Bitbake:
> > > > 
> > > > - file-checksums only seems to be taken into account at initial
> > > > recipe
> > > > parse time, not when the task I'm interested in is actually
> > > > executed? I
> > > > need to run bitbake twice to get the correct results.
> > > > - When I use an anonymous Python function to put the root hash
> > > > I'm
> > > > interested in into a variable, Bitbake complains about
> > > > nondeterministic
> > > > metadata.
> > > 
> > > There is a way of doing this, I've had to do it in the past.
> > > 
> > > The anonymous python function needs to product the same output on
> > > each and every
> > > run.  If it doesn't this will cause the non-deterministic
> > > behavior.  (It can't
> > > rely on another items to finish building for instance.)
> > > 
> > > So you end up having to have a recipe (with a file-checksum
> > > and/or
> > > anon python)
> > > that sets up variables that will keep the hash up-to-date for
> > > THAT
> > > recipe.. then
> > > your image (or other) recipes need to depend on that one.
> > 
> > Hello Mark,
> > 
> > I'm afraid I don't follow. How does doing something in another
> > recipe
> > fix the non-deterministic behaviour?
> 
> You must always compute your internal variables in -exactly- the same
> way.  You
> were saying you were passing in an external object and needed to have
> that
> influence the values.  (Unless I am understanding incorrectly.)
> 
> > I'd think that any solution based on the task signatures will have
> > the
> > same issue - that a hash correctly reflecting the inputs that go
> > into
> > my initramfs task would depend on the build results of my core
> > image
> > task, which is not available at recipe parse time.
> 
> All signatures are computed at parse time.  They either need to be
> computed
> based on external (non-changing) input, or other recipes (which
> themselves would
> have an static hash, but can change from build to build.)
> 
> > I think I'll have to go with nostamp after all - the unnessesary
> > rebuilds it causes in this case are ugly, but rather negligible in
> > terms of build time.
> 
> So is the input changing out from under the system?  I.e. during the
> build
> process did it change, or are you trying to use the output of one
> recipe to
> create input from another without standard recipe dependency
> behavior?

The latter. I have a regular core image built by Yocto, and I don't
want to care about full reproducibility - so rebuilding the core image
will give me a different image regarding timestamps etc. The second
recipe (and its dependents) needs to rerun when the hash of the built
image changes. This does not happen without nostamp, because no
variable known to Bitbake can contain this hash at parse time.

Matthias


> 
> --Mark
> 
> > 
> > Thanks,
> > 
> > Matthias
> > 
> > 
> > 
> > > 
> > > Unfortunately I no longer have access to the example where I had
> > > to
> > > do this in
> > > the past, or I could try to give you something more concrete to
> > > look
> > > at.
> > > 
> > > --Mark
> > > 
> > > > 
> > > > Using nostamp would be an option, but obviously an ugly one.
> > > > 
> > > > I'm currently on Yocto Thud / Bitbake 1.40.
> > > > 
> > > > 
> > > > Thanks in advance,
> > > > 
> > > > Matthias
> > > > 


