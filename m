Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 070E4701C9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 11:31:28 +0000 (UTC)
Received: from [69.196.158.250] (port=33423 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4TcP-0008B3-4c for bitbake-devel@lists.openembedded.org;
	Tue, 08 Jul 2014 07:31:29 -0400
Date: Tue, 8 Jul 2014 07:31:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407080725470.32352@localhost>
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
Subject: how much effort is going into updating bitbake user manual?
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
X-List-Received-Date: Tue, 08 Jul 2014 11:31:32 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  i ask since i'm teaching an OE/yocto course in a couple weeks, and i
want to make the bitbake user manual part of the student kit, which is
why i'm currently clawing my way through it, being pedantic and all
and doing lots of (admittedly picky) touchups.

  case in point -- there are at least some BB variables that aren't
listed in the glossary, such as PARALLEL_MAKE. i'm making a list of
these, but i know that the yocto project also has a massive reference
manual which includes a variable glossary. so where should i
concentrate my efforts? personally, if something is BB-specific, i'd
rather it go into the BB user manual.

  also, what's the timeframe for getting my patches into the repo? the
course isn't til the week of jul 21-24 so there's lots of time for the
patches to be applied, it would just be nice to know that they'll be
incorporated by the time the course starts.

  thanks, back to proofreading ...

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

