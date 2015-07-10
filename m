Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9FA99737F4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 09:04:51 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 10 Jul 2015 02:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,446,1432623600"; d="scan'208";a="726319067"
Received: from dawalker-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.7.62])
	by orsmga001.jf.intel.com with ESMTP; 10 Jul 2015 02:04:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Fri, 10 Jul 2015 10:04:49 +0100
Message-ID: <1928105.5KZnhtkH6z@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.0.6-200.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <559F0B23.7030208@windriver.com>
References: <cover.1436426161.git.liezhi.yang@windriver.com>
	<4577144.KC5lOY8eR9@peggleto-mobl.ger.corp.intel.com>
	<559F0B23.7030208@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] git.py: create a branch when checkout
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
X-List-Received-Date: Fri, 10 Jul 2015 09:04:53 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 10 July 2015 08:00:35 Robert Yang wrote:
> On 07/10/2015 12:54 AM, Paul Eggleton wrote:
> > On Thursday 09 July 2015 00:18:01 Robert Yang wrote:
> >> * Create a branch and named as upstream branch when checkout source
> >> * Set the branch to track remote branch.
> >> 
> >> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> >> ---
> >> 
> >>   bitbake/lib/bb/fetch2/git.py |    7 +++++++
> >>   1 file changed, 7 insertions(+)
> >> 
> >> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> >> index 2e53882..afa3d0a 100644
> >> --- a/bitbake/lib/bb/fetch2/git.py
> >> +++ b/bitbake/lib/bb/fetch2/git.py
> >> 
> >> @@ -279,8 +279,15 @@ class Git(FetchMethod):
> >>               if subdir != "":
> >>                   runfetchcmd("%s read-tree %s%s" % (ud.basecmd,
> >> 
> >> ud.revisions[ud.names[0]], readpathspec), d) runfetchcmd("%s
> >> checkout-index
> >> -q -f -a" % ud.basecmd, d)
> >> +            elif not ud.nobranch:
> >> +                branchname =  ud.branches[ud.names[0]]
> >> +                runfetchcmd("%s checkout -B %s %s" % (ud.basecmd,
> >> branchname, \
> >> +                            ud.revisions[ud.names[0]]), d)
> >> +                runfetchcmd("%s branch --set-upstream %s origin/%s" %
> >> (ud.basecmd, branchname, \
> >> +                            branchname), d)
> > 
> > Doesn't git checkout support a --track option so we could do this in one
> > command rather than two?
> 
> I'm afraid that we can use --track here, the supported commands are:
> git checkout -b <branch> --track <remote>/<branch>
> or
> git checkout -b <branch> <start point>
> 
> What we need is something like:
> git checkout -b <branch> --track <remote>/<branch> <start point>
> but git doesn't support this.

Ah ok, fair enough - thanks for checking.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

