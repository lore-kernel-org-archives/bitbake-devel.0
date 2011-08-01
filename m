Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qnv9y-0007DT-OW
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 18:16:07 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Aug 2011 09:11:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="32897429"
Received: from vorpal.jf.intel.com (HELO [10.7.199.75]) ([10.7.199.75])
	by orsmga002.jf.intel.com with ESMTP; 01 Aug 2011 09:11:20 -0700
From: Joshua Lock <josh@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 01 Aug 2011 09:16:00 -0700
In-Reply-To: <1312213617.2344.503.camel@rex>
References: <cover.1311876523.git.josh@linux.intel.com>
	<1312213617.2344.503.camel@rex>
X-Mailer: Evolution 3.0.2 (3.0.2-3.fc15) 
Message-ID: <1312215360.2104.0.camel@vorpal.jf.intel.com>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob preference fixes
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
X-List-Received-Date: Mon, 01 Aug 2011 16:16:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2011-08-01 at 16:46 +0100, Richard Purdie wrote:
> On Thu, 2011-07-28 at 11:10 -0700, Joshua Lock wrote:
> > Fixes some Yocto bugs reported agains the preferences window.
> > 
> > The following changes since commit eea5ff9f34bb9b2e29f5fa43deb80d4aa6ef7ddc:
> > 
> >   bitbake/providers: list PREFERRED_VERSION candidates when unavailable (2011-07-27 16:53:47 +0100)
> > 
> > are available in the git repository at:
> >   git://github.com/incandescant/bitbake hob
> >   https://github.com/incandescant/bitbake/tree/hob
> > 
> > Joshua Lock (2):
> >   hob: more reliable disabling of GPLv3 packages
> >   hob: fix save/restore of toolchain preferences
> > 
> >  lib/bb/ui/crumbs/configurator.py    |   25 +++++++++++++++++++++--
> >  lib/bb/ui/crumbs/hobeventhandler.py |   10 +-------
> >  lib/bb/ui/crumbs/hobprefs.py        |   36 +++++++++++++++++++++++++++++-----
> >  lib/bb/ui/hob.py                    |   11 +++++++++-
> >  4 files changed, 64 insertions(+), 18 deletions(-)
> 
> Merged to master, thanks.
> 
> I did notice a load of other commits on this branch. Since they weren't
> mentioned in the pull request I didn't take them though.

Thanks. I forgot I was branch recycling... There's a new pull request
due shortly.

Joshua
-- 
Joshua Lock
        Yocto Project "Johannes Factotum"
        Intel Open Source Technology Centre



