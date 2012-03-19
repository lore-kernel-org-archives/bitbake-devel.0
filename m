Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9buo-0002lc-BX
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 13:42:22 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9bmG-0004fb-Ei; Mon, 19 Mar 2012 08:33:32 -0400
Date: Mon, 19 Mar 2012 08:33:23 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <3102852.3L1QBP4gsd@helios>
Message-ID: <alpine.DEB.2.02.1203190828240.24654@oneiric>
References: <alpine.DEB.2.02.1203190741220.22293@oneiric>
	<1927112.bGsHOkriYo@helios>
	<alpine.DEB.2.02.1203190809400.23861@oneiric>
	<3102852.3L1QBP4gsd@helios>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: some preliminary questions about bitbake manual
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
X-List-Received-Date: Mon, 19 Mar 2012 12:42:22 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Mon, 19 Mar 2012, Paul Eggleton wrote:

> On Monday 19 March 2012 08:15:32 Robert P. J. Day wrote:
> > > Yes, we acknowledge it is quite out of date. The problem with
> > > the BitBake manual is it must cover only BitBake generically,
> > > and not OE. Of course there's a lot that could be added to it,
> > > but having complete documentation there is less important than
> > > documenting OE. That's not to say we won't welcome patches
> > > though ;)
> >
> >   yes, i can see the problem.  but rather than try to be a purist
>
> The thing is, BitBake was originally separated out of OE years ago
> so that it could be kept as a fairly pure task executor. If the code
> is to remain that way then the documentation should continue to
> reflect that.

  fair enough ... i'll ponder on how i want to do this.  since i'm
writing my own tutorial, i don't need to try to restructure the
current bitbake manual -- i'll just send in patches that really
reflect fixes to the bitbake manual.

> > why not just accept that the best way to document bitbake is to do
> > it within the context of oe-core?  that's the approach i'm going
> > to take with what i'm writing.
>
> Why not just document OE then (which will include documenting those
> aspects of BitBake that are important in OE in the appropriate
> context)?

  i'm pretty sure that's the approach i'm going to use, since it's so
much easier to explain things by using examples pulled straight out of
oe-core.  i'm already designing a newbie's guide to oe-core which will
mix bitbake explanations in there.

  anyway, back to proofreading ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


