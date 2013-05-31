Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5A6B262222
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 10:54:50 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 31 May 2013 03:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="346204357"
Received: from unknown (HELO helios.localnet) ([10.252.121.185])
	by orsmga002.jf.intel.com with ESMTP; 31 May 2013 03:54:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 May 2013 11:54:47 +0100
Message-ID: <8305573.fN7bZe1l3B@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.2 (Linux/3.8.0-22-generic; KDE/4.10.2; i686; ; )
In-Reply-To: <1369985383.14887.341.camel@ted>
References: <1369799698-1417-1-git-send-email-mark.hatle@windriver.com>
	<1369985383.14887.341.camel@ted>
MIME-Version: 1.0
Subject: Re: [PATCH] cooker.py: Remove explicit build targets from the ignored list
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 10:54:50 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 31 May 2013 08:29:43 Richard Purdie wrote:
> On Tue, 2013-05-28 at 22:54 -0500, Mark Hatle wrote:
> > From: Peter Seebach <peter.seebach@windriver.com>
> > 
> > If something is in ASSUMED_PROVIDED, and a user tries to build it
> > explicitly, Nothing Happens. Bitbake just says it ran 0 out of 0
> > tasks. No diagnostics or explanations are offered.
> > 
> > In practice, the right thing is probably to assume that explicit
> > targets are intentional. So far as I can tell, cooker.buildTargets
> > is called only from the command line or from command.py, and both
> > cases seem to be explicit user actions.
> > 
> > Signed-off-by: Peter Seebach <peter.seebach@windriver.com>
> > Signed-off-by: Jeff Polk <jeff.polk@windriver.com>
> > 
> > Rename 'status' to 'recipecache' to match recent changes.
> > 
> > Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
> > ---
> > 
> >  lib/bb/cooker.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > index 2ae3e9d..8f0e90c 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > 
> > @@ -1067,6 +1067,11 @@ class BBCooker:
> >          universe = ('universe' in targets)
> >          targets = self.checkPackages(targets)
> > 
> > +        # Explicitly disignore things that have been requested.
> > +        for target in targets:
> > +            if target in self.recipecache.ignored_dependencies:
> > +                self.recipecache.ignored_dependencies.remove(target)
> > +
> > 
> >          def buildTargetsIdle(server, rq, abort):
> >              if abort or self.state == state.stop:
> >                  rq.finish_runqueue(True)
> 
> I'm not sure this is the right thing to do, the reason being
> determinism. I don't expect different results for X in the different
> cases:
> 
> bitbake X Y
> 
> bitbake X
> 
> (assuming Y is ASSUME_PROVIDED)
> 
> For example, X will rebuild between these two commands since the sstate
> and task checksums will be different between the two. This really needs
> more thought to make a consistent user experience...

It seems to me the most consistent behaviour would be to just report a warning 
that Y is in ASSUME_PROVIDED and carry on building.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

