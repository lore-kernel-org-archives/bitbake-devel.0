Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id B8A59609C2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jun 2014 15:07:43 +0000 (UTC)
Received: from [99.240.204.5] (port=56431 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WzonV-000843-Pe; Wed, 25 Jun 2014 11:07:41 -0400
Date: Wed, 25 Jun 2014 11:03:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <2353794.PEErK2dypV@peggleto-mobl5.ger.corp.intel.com>
Message-ID: <alpine.LFD.2.11.1406251101540.32233@localhost>
References: <alpine.LFD.2.11.1406201157320.11539@localhost>
	<CABcZAN=qpQ3FEO-bzj0hiGrNGcoghkK8UT0G4RXyhFXgJSutNA@mail.gmail.com>
	<alpine.LFD.2.11.1406201215310.1690@localhost>
	<2353794.PEErK2dypV@peggleto-mobl5.ger.corp.intel.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
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
X-List-Received-Date: Wed, 25 Jun 2014 15:07:44 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 25 Jun 2014, Paul Eggleton wrote:

> On Friday 20 June 2014 12:23:12 Robert P. J. Day wrote:
> > On Fri, 20 Jun 2014, Christopher Larson wrote:
> > > On Fri, Jun 20, 2014 at 9:00 AM, Robert P. J. Day <rpjday@crashcourse.ca>
> > > wrote:
> > >
> > >   more specific question related to my earlier post -- is there any
> > > value whatever in the variables in bitbake's bitbake.conf file of the
> > > form:
> > >
> > >   FETCHCOMMAND*
> > >   RESUMECOMMAND*
> > >   UPDATECOMMAND*
> > >   MKTEMP*CMD
> > >
> > > nothing seems to use any of those. can they all just be deleted?
> > > certainly, the FETCHCOMMAND* variables have been superseded by the
> > > FETCHCMD* variables, no? i don't know about the remainder of them.
> > >
> > > As far as I know, as you say, those were deprecated in favor of the
> > > FETCHCMD vars, so can almost certainly be dropped.
> >
> >   one more question before i submit a patch to do some cleaning.
> > AFAICT, the bitbake.conf settings for RESUMECOMMAND* and
> > UPDATECOMMAND* variables can be removed as well since nothing in
> > bitbake refers to those variables, and it seems logical that bitbake
> > should not be setting variables that it doesn't directly use in some
> > way.
>
> Those look old to me as well.
>
> >   however, i'm puzzled by this from the bitbake codebase:
> >
> > $ grep -r "MKTEMP.*CMD" *
> > conf/bitbake.conf:MKTEMPCMD = "mktemp -q ${TMPBASE}"
> > conf/bitbake.conf:MKTEMPDIRCMD = "mktemp -d -q ${TMPBASE}"
> > lib/toaster/orm/fixtures/orm_views_testdata.json:        "variable_name":
> > "MKTEMPCMD" lib/toaster/orm/fixtures/orm_views_testdata.json:
> > "variable_name": "MKTEMPDIRCMD" $
> >
> >   so the only reference to the MKTEMP-related variables are in the
> > toaster directory in some .json files. what does that mean? if one
> > wanted to remove the MKTEMP* variables, would one also have to
> > adjust those .json files accordingly?
>
> The intention is to provide a way for QA verify that Toaster is
> collecting the variable data correctly, but because the json files
> contain every variable value, they are already out-of-date. We
> probably ought to filter the list that is used for that test to make
> it more maintainable.

  so, in short, it should be safe to ditch the
{FETCH,RESUME,UPDATE}COMMAND variable settings, but i'm still unclear
on what would need to be done re: the MKTEMP* variables -- i'll just
submit a patch taking out the first set, and let someone else worry
about the ones that show up in json files.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

