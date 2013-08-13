Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 568E660667
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Aug 2013 20:46:33 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 13 Aug 2013 13:46:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,872,1367996400"; d="scan'208";a="380441316"
Received: from akagikob-mobl.ger.corp.intel.com (HELO helios.localnet)
	([10.252.122.214])
	by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2013 13:46:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Tue, 13 Aug 2013 21:46:31 +0100
Message-ID: <5256093.PeJ9nqN9tx@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-27-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <1376425098.1838.27.camel@ted>
References: <cover.1376403450.git.paul.eggleton@linux.intel.com>
	<3da24015e63e0ed7223d668790027ede24a5c02e.1376403450.git.paul.eggleton@linux.intel.com>
	<1376425098.1838.27.camel@ted>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] runqueue: report close matches for an invalid task name
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
X-List-Received-Date: Tue, 13 Aug 2013 20:46:33 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 13 August 2013 21:18:18 Richard Purdie wrote:
> On Tue, 2013-08-13 at 15:18 +0100, Paul Eggleton wrote:
> > Help to pick up mistakes such as "bitbake -c cleanstate xyz" (instead
> > of "bitbake -c cleansstate xyz".)
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> > 
> >  bitbake/lib/bb/runqueue.py | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> > index b2c9703..b3374f1 100644
> > --- a/bitbake/lib/bb/runqueue.py
> > +++ b/bitbake/lib/bb/runqueue.py
> > 
> > @@ -601,7 +601,11 @@ class RunQueueData:
> >                  continue
> >              
> >              if target[1] not in taskData.tasks_lookup[fnid]:
> > -                bb.msg.fatal("RunQueue", "Task %s does not exist for
> > target %s" % (target[1], target[0])) +                import difflib
> > +                close_matches = difflib.get_close_matches(target[1],
> > taskData.tasks_lookup[fnid], cutoff=0.7) +                if
> > close_matches:
> > +                    extra = ". Close matches:\n  %s" % "\n 
> > ".join(close_matches) +                bb.msg.fatal("RunQueue", "Task %s
> > does not exist for target %s%s" % (target[1], target[0], extra))
> Missing else: extra = ""?

Oops. Fixed on the branch.

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

