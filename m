Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SHtjV-0007GE-71
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Apr 2012 11:20:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Apr 2012 02:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129552560"
Received: from unknown (HELO helios.localnet) ([10.252.120.50])
	by azsmga001.ch.intel.com with ESMTP; 11 Apr 2012 02:11:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Wed, 11 Apr 2012 10:11:35 +0100
Message-ID: <2184436.zSGmXoSkkF@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.2 (Linux/3.0.0-17-generic-pae; KDE/4.8.2; i686; ; )
In-Reply-To: <1334100324.10826.97.camel@ted>
References: <1333645638-9195-1-git-send-email-paul.eggleton@linux.intel.com>
	<1334100324.10826.97.camel@ted>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] lib/bb/fetch2: don't skip checksums when local mirror enabled
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
X-List-Received-Date: Wed, 11 Apr 2012 09:20:57 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 11 April 2012 00:25:24 Richard Purdie wrote:
> On Thu, 2012-04-05 at 18:07 +0100, Paul Eggleton wrote:
> > If you have PREMIRRORS set up to point to a local directory, the local
> > download function does nothing and always succeeds and the mirror code
> > was writing a .done stamp regardless, thus the checksum verification was
> > being skipped even if the file wasn't actually copied from the mirror.
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> > 
> >  lib/bb/fetch2/__init__.py |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index e5c4b34..414cc2b 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > 
> > @@ -476,9 +476,10 @@ def try_mirrors(d, origud, mirrors, check = False):
> >              if not os.path.exists(ud.donestamp) or 
ud.method.need_update(newuri, ud, ld):
> >                  ud.method.download(newuri, ud, ld)
> > 
> > -                open(ud.donestamp, 'w').close()
> > -                if hasattr(ud.method,"build_mirror_data"):
> > -                    ud.method.build_mirror_data(newuri, ud, ld)
> > +                if os.path.exists(ud.localpath):
> > +                    open(ud.donestamp, 'w').close()
> > +                    if hasattr(ud.method,"build_mirror_data"):
> > +                        ud.method.build_mirror_data(newuri, ud, ld)
> > 
> >              if not ud.localpath or not os.path.exists(ud.localpath):
> >                  continue
> 
> I messed up some commands and this ended up merged with the following
> commit I manipulated:
> 
> http://git.openembedded.org/bitbake/commit/?id=c9eed04c6275ef2c694f89e047f85
> c7de76f89b6
> 
> Since its pushed at this point I'm not sure what options I have to undo
> it. Sorry :(

No worries - but does this fix in any way help with the problem Gary was 
seeing?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


