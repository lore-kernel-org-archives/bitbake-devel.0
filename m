Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S9bmJ-0002h1-9l
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 13:33:35 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 19 Mar 2012 05:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130498862"
Received: from unknown (HELO helios.localnet) ([10.252.123.198])
	by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2012 05:24:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 19 Mar 2012 12:24:41 +0000
Message-ID: <3102852.3L1QBP4gsd@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.1; i686; ; )
In-Reply-To: <alpine.DEB.2.02.1203190809400.23861@oneiric>
References: <alpine.DEB.2.02.1203190741220.22293@oneiric>
	<1927112.bGsHOkriYo@helios>
	<alpine.DEB.2.02.1203190809400.23861@oneiric>
MIME-Version: 1.0
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
X-List-Received-Date: Mon, 19 Mar 2012 12:33:35 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 19 March 2012 08:15:32 Robert P. J. Day wrote:
> > Yes, we acknowledge it is quite out of date. The problem with the
> > BitBake manual is it must cover only BitBake generically, and not
> > OE. Of course there's a lot that could be added to it, but having
> > complete documentation there is less important than documenting OE.
> > That's not to say we won't welcome patches though ;)
> 
>   yes, i can see the problem.  but rather than try to be a purist

The thing is, BitBake was originally separated out of OE years ago so that it 
could be kept as a fairly pure task executor. If the code is to remain that 
way then the documentation should continue to reflect that.

> why not just accept that the best way to document bitbake is to do it
> within the context of oe-core?  that's the approach i'm going to take
> with what i'm writing.

Why not just document OE then (which will include documenting those aspects of 
BitBake that are important in OE in the appropriate context)?

> what would also be useful is to point out that the "OVERRIDES =" directive
> doesn't occur all that frequently.

Perhaps. It's a key advantage of how BitBake works though. Again, if you're 
starting from the point of view of BitBake being a generic tool you need to 
know about OVERRIDES. In fact you should probably have a basic understanding 
of how OVERRIDES works within OE, even though you will almost never need to 
set or refer to it directly.

>   personally, when i'm reading docs, i like to have the source tree at
> hand so i can search for examples of whatever i'm reading about, and
> what i notice is that "OVERRIDES =" appears only in a .conf file.  a
> reader might want to know that sort of thing to know that he/she needs
> to examine only a single .conf file to see all of the current
> OVERRIDES settings.

From BitBake's perspective, OVERRIDES can have anything in it - it's just a 
list of switches. The power comes when you put the value of some other 
significant variable into it (e.g. MACHINE, in the context of OE) and then make 
use of values of that variable in overrides elsewhere.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


