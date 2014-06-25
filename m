Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3F0B865D49
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jun 2014 15:37:22 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 25 Jun 2014 08:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,546,1400050800"; d="scan'208";a="533981385"
Received: from unknown (HELO peggleto-mobl5.ger.corp.intel.com)
	([10.252.121.119])
	by orsmga001.jf.intel.com with ESMTP; 25 Jun 2014 08:32:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 25 Jun 2014 16:32:35 +0100
Message-ID: <1562414.FHrmCHUAZA@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.5 (Linux/3.14.8-200.fc20.x86_64; KDE/4.12.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406251101540.32233@localhost>
References: <alpine.LFD.2.11.1406201157320.11539@localhost>
	<2353794.PEErK2dypV@peggleto-mobl5.ger.corp.intel.com>
	<alpine.LFD.2.11.1406251101540.32233@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org,
	Christopher Larson <clarson@kergoth.com>,
	Ionut Chisanovici <ionutx.chisanovici@intel.com>
Subject: Re: are the fetch-related variables in bitbake's bitbake.conf of any value?
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
X-List-Received-Date: Wed, 25 Jun 2014 15:37:28 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 25 June 2014 11:03:44 Robert P. J. Day wrote:
> On Wed, 25 Jun 2014, Paul Eggleton wrote:
> > On Friday 20 June 2014 12:23:12 Robert P. J. Day wrote:
> > > On Fri, 20 Jun 2014, Christopher Larson wrote:
> > > > On Fri, Jun 20, 2014 at 9:00 AM, Robert P. J. Day
> > > > <rpjday@crashcourse.ca>
> > > > 
> > > > wrote:
> > > >   more specific question related to my earlier post -- is there any
> > > > 
> > > > value whatever in the variables in bitbake's bitbake.conf file of the
> > > > 
> > > > form:
> > > >   FETCHCOMMAND*
> > > >   RESUMECOMMAND*
> > > >   UPDATECOMMAND*
> > > >   MKTEMP*CMD
> > > > 
> > > > nothing seems to use any of those. can they all just be deleted?
> > > > certainly, the FETCHCOMMAND* variables have been superseded by the
> > > > FETCHCMD* variables, no? i don't know about the remainder of them.
> > > > 
> > > > As far as I know, as you say, those were deprecated in favor of the
> > > > FETCHCMD vars, so can almost certainly be dropped.
> > > > 
> > >   one more question before i submit a patch to do some cleaning.
> > > 
> > > AFAICT, the bitbake.conf settings for RESUMECOMMAND* and
> > > UPDATECOMMAND* variables can be removed as well since nothing in
> > > bitbake refers to those variables, and it seems logical that bitbake
> > > should not be setting variables that it doesn't directly use in some
> > > way.
> > 
> > Those look old to me as well.
> > 
> > >   however, i'm puzzled by this from the bitbake codebase:
> > > $ grep -r "MKTEMP.*CMD" *
> > > conf/bitbake.conf:MKTEMPCMD = "mktemp -q ${TMPBASE}"
> > > conf/bitbake.conf:MKTEMPDIRCMD = "mktemp -d -q ${TMPBASE}"
> > > lib/toaster/orm/fixtures/orm_views_testdata.json:       
> > > "variable_name":
> > > "MKTEMPCMD" lib/toaster/orm/fixtures/orm_views_testdata.json:
> > > "variable_name": "MKTEMPDIRCMD" $
> > > 
> > >   so the only reference to the MKTEMP-related variables are in the
> > > 
> > > toaster directory in some .json files. what does that mean? if one
> > > wanted to remove the MKTEMP* variables, would one also have to
> > > adjust those .json files accordingly?
> > 
> > The intention is to provide a way for QA verify that Toaster is
> > collecting the variable data correctly, but because the json files
> > contain every variable value, they are already out-of-date. We
> > probably ought to filter the list that is used for that test to make
> > it more maintainable.
> 
>   so, in short, it should be safe to ditch the
> {FETCH,RESUME,UPDATE}COMMAND variable settings, but i'm still unclear
> on what would need to be done re: the MKTEMP* variables -- i'll just
> submit a patch taking out the first set, and let someone else worry
> about the ones that show up in json files.

That sounds good to me.

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

