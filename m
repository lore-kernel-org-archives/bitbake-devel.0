Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 22C146B5E0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 22:38:46 +0000 (UTC)
Received: from [99.240.204.5] (port=56784 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxOVD-00066j-0G; Wed, 18 Jun 2014 18:38:47 -0400
Date: Wed, 18 Jun 2014 18:35:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <3485367.eXfHHFnm7Z@peggleto-mobl5.ger.corp.intel.com>
Message-ID: <alpine.LFD.2.11.1406181834470.11766@localhost>
References: <alpine.LFD.2.11.1406180908370.25541@localhost>
	<3485367.eXfHHFnm7Z@peggleto-mobl5.ger.corp.intel.com>
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
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: curious about setting of PROVIDES in bitbake.conf
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
X-List-Received-Date: Wed, 18 Jun 2014 22:38:52 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 18 Jun 2014, Paul Eggleton wrote:

> On Wednesday 18 June 2014 09:10:00 Robert P. J. Day wrote:
> >   from current bitbake.conf file:
> >
> > PROVIDES = ""
> > PROVIDES_prepend = "${PN} "
> >
> > is there a reason that PROVIDES is set to null, only to immediately
> > set it based on the following line? is there some subtle issue this is
> > meant to address?
>
> I think the intention is to set the initial value to blank, and
> ensure that ${PN} is the first item in the list (since _prepend gets
> applied later). If you just simply had PROVIDES = "${PN}" then it
> could be overridden somewhere else such that ${PN} was not in
> PROVIDES at all, which would be counter-intuitive.

  ah, of course, i should have thought of that. duh.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

