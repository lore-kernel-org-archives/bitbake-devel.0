Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QrxP0-0003WN-64
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 21:28:18 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 12 Aug 2011 12:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="37981066"
Received: from unknown (HELO [10.255.15.3]) ([10.255.15.3])
	by orsmga001.jf.intel.com with ESMTP; 12 Aug 2011 12:23:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Aug 2011 12:23:38 -0700
In-Reply-To: <359B10B9B28B294BAA6405D9320312E0111E934078@naemmail08.na.leapfrog.com>
References: <mailman.15.1313143204.31105.bitbake-devel@lists.openembedded.org>
	<359B10B9B28B294BAA6405D9320312E0111E934078@naemmail08.na.leapfrog.com>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1313177023.2228.3.camel@scimitar>
Mime-Version: 1.0
Subject: Re: [RFC] Do postfiles make sense?
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
X-List-Received-Date: Fri, 12 Aug 2011 19:28:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-08-12 at 11:01 -0700, Daniel Lazzari wrote:
> >-----Original Message-----
> >Date: Thu, 11 Aug 2011 16:27:34 -0700
> >From: Joshua Lock <josh@linux.intel.com>
> >Subject: [bitbake-devel] [RFC] Do postfiles make sense?
> >To: bitbake-devel@lists.openembedded.org
> >Message-ID: <1313105254.2506.8.camel@vorpal.jf.intel.com>
> >Content-Type: text/plain; charset="UTF-8"
> >
> >All,
> >
> >Some time ago I added an -R switch to bitbake for configuration files to
> >load after bitbake.conf[1].
> >
> >I'd been happily using this for the UI I've been working on without
> >fully realising that it's not safe to rely on postfiles to set variables
> >which affect the files included by bitbake.conf. For oe-core this
> >includes: BUILD_SYS, TARGET_SYS, MACHINE, SDKMACHINE and DISTRO.
> >
> >In light of this flaw do postfiles make sense?
> >
> >For the UI's purpose I think I'm going to have to switch to a prefile
> >(-r) in the wrapper script and add logic to hob to detect whether the
> >set variables differ from those in hob.local.conf - so that we can warn
> >those with a local.conf that uses = assignment that things won't work...
> >
> >Thoughts? Suggestions?
> >
> >Thanks,
> >Joshua
> >
> >1.
> >http://git.openembedded.org/cgit.cgi/bitbake/commit/?id=a8246ae5400c23df
> >0d3ee29c36f4d9f257d1e6d1
> >--
> >Joshua Lock
> >        Yocto Project "Johannes Factotum"
> >        Intel Open Source Technology Centre
> >
> 
> I actually have a decent use case for a postfile. We have several in
> house recipes that use an SVN repo for their SRC_URI. The URI contains
> a variable that points to what branch to build from. So the recipes
> default to pulling the head revision of trunk. It's nice to be able to
> have a collection of different conf files that we can post load to
> override the branch and revision variables without having to change the
> recipes themselves. So we have like a Release1.1.conf file that when
> post loaded builds Release 1.1 from the correct branches and revisions.
> We can do this with -r by using BRANCH ?= "TRUNK" in the recipes
> (that's how we did it in OE Classic), but when we sometimes forgot the
> question mark, it would end up building TRUNK no matter what was in the
> conf file.

Nice, you've convinced me that the feature should stay.

Thanks for responding,

Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



