Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sleg3-0006LJ-Qj; Mon, 02 Jul 2012 13:20:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62B9Da1030479;
	Mon, 2 Jul 2012 12:09:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 29631-03; Mon,  2 Jul 2012 12:09:08 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62B95jj030473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2012 12:09:07 +0100
Message-ID: <1341227352.23146.224.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Mon, 02 Jul 2012 12:09:12 +0100
In-Reply-To: <ly8vf558di.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <ly8vf558di.fsf@ensc-virt.intern.sigma-chemnitz.de>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: do_fetchall broken by recent bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 02 Jul 2012 11:20:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2012-06-30 at 13:47 +0200, Enrico Scholz wrote:
> the 82d73423c57569b984ee0ae3d93e3c3bd5dc5216 "runqueue: Reimplement
> recrdepends so it works more correctly" bitbake commit breaks
> OpenEmbedded's 'do_fetchall' task.  Previously sources of all dependent
> tasks were downloaded.  Now, only a small subset gets fetched.
> 
> Before:
> 
> | $ ./bitbake my-image -c fetchall
> | NOTE: Running task 1 of 202 (ID: 201, ...openssl/ocf-linux_20100325.bb, do_fetch)

> After:
> 
> | $ ./bitbake my-image -c fetchall
> | NOTE: Running task 1 of 11 (ID: 10, ...opkg-collateral.bb, do_fetch)

> Any chance to fix bitbake or OE?

Hmm, that is broken :(.

We have a problem with recrdepends since it means different things in
different contexts. Its turning out to be very hard to unravel the
different issues. I'll try and summarise the different ways it could
work. 

Firstly, let me define some dependencies:

build - a build time dependencies from DEPENDS
runtime - a runtime dependency from RDEPENDS, RRECOMMENDS or similar
intertask - an intertask dependency do_a[depends] = "somerecipe:do_b"

So what does do_a[recrdeptask] = "do_b" in recipe A mean?

"""
Look though every build, runtime and intertask dependency recipe A has
and see if those dependencies have a task do_b which would be added as a
dependency. Whether they have or have not, then look through all the
dependency's build, runtime and intertask dependencies do a task do_b
and so on.
"""

However we have some corner cases to consider.

a) If some dependency of A does not have a do_b task, should we still
consider its dependencies? Should we consider build, runtime and
intertask dependencies?

b) Say recipe A has a dependency on recipe B which has a task do_b. Do
we consider all build, runtime and intertask dependencies recipe B has?
Or should we consider just the dependencies do_b has? Or a hybrid,
consider the build and runtime dependencies overall but only any
intertask dependencies do_b itself has?

c) Imagine some task do_c has some intertask dependencies in recipe A
but do_a and do_b don't depend on do_c. Should we consider those
intertask dependencies?


Changing c) in the commit was intentional. It seems that indirectly, the
behaviour of b) has changed too and we now only consider the
dependencies do_b has. Personally, having spent several days staring at
this code, I think this actually makes a lot more sense.

So how could we fix fetchall?

I'm wondering if we should support the syntax

do_fetchall[recrdeptask] = "do_fetchall do_fetch"

since that would pull in the build and runtime deps of any dependency.
The trouble is right now this will fail with circular dependency errors
(understandably).

Cheers,

Richard







