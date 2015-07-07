Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 69E3873B10
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 16:57:09 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 07 Jul 2015 09:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,424,1432623600"; d="scan'208";a="759969845"
Received: from wrobbins-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.18.222])
	by orsmga002.jf.intel.com with ESMTP; 07 Jul 2015 09:56:58 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 07 Jul 2015 17:56:56 +0100
Message-ID: <10060998.dTQVzXkhxA@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.9 (Linux/4.0.6-200.fc21.x86_64; KDE/4.14.9; x86_64; ; )
In-Reply-To: <1436282262.27597.183.camel@linuxfoundation.org>
References: <cover.1436232786.git.liezhi.yang@windriver.com>
	<fc82e0723a4877cdcd92e97cd2cf19f4a5d0ff70.1436232786.git.liezhi.yang@windriver.com>
	<1436282262.27597.183.camel@linuxfoundation.org>
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
X-List-Received-Date: Tue, 07 Jul 2015 16:57:13 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 07 July 2015 16:17:42 Richard Purdie wrote:
> On Mon, 2015-07-06 at 18:33 -0700, Robert Yang wrote:
> > Create a branch named oebuild_SRCREV when checkout the source, this
> > makes debug easier than "(no branch)" when look into the source.
> > 
> > Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> > ---
> > 
> >  bitbake/lib/bb/fetch2/git.py |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> > index 2e53882..12087dd 100644
> > --- a/bitbake/lib/bb/fetch2/git.py
> > +++ b/bitbake/lib/bb/fetch2/git.py
> > 
> > @@ -280,7 +280,8 @@ class Git(FetchMethod):
> >                  runfetchcmd("%s read-tree %s%s" % (ud.basecmd,
> >                  ud.revisions[ud.names[0]], readpathspec), d)
> >                  runfetchcmd("%s checkout-index -q -f -a" % ud.basecmd,
> >                  d)
> >              
> >              else:
> > -                runfetchcmd("%s checkout %s" % (ud.basecmd,
> > ud.revisions[ud.names[0]]), d) +                runfetchcmd("%s checkout
> > %s -b oebuild_%s" % (ud.basecmd, \ +                           
> > ud.revisions[ud.names[0]], ud.revisions[ud.names[0]]), d)> 
> >          return True
> 
> Would it not make more sense to set the branch to the upstream branch
> name here?

I'd go one step further, use the upstream branch name and also set it to track 
the remote branch as well.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

