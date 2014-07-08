Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id E5F6D60809
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 13:06:07 +0000 (UTC)
Received: from [69.196.158.250] (port=33849 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4V5z-0003QF-D4 for bitbake-devel@lists.openembedded.org;
	Tue, 08 Jul 2014 09:06:07 -0400
Date: Tue, 8 Jul 2014 09:06:06 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407080852470.3046@localhost>
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
Subject: looking for good example of PREFERRED_PROVIDER_* ... udev/systemd?
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
X-List-Received-Date: Tue, 08 Jul 2014 13:06:17 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  currently working through chapter 2 of the bitbake user manual, and
my first thought is that sections 2.3 and 2.4 -- Providers, followed
by Preferences, would make more sense in the reverse order. IMHO,
selecting a preferred version for a recipe is fairly straightforward
and a reader should be able to understand that easily, and there are
lots of good examples of that. the notion of recipes "providing" an
alternate name, however, strikes me as at least a bit more involved
and should take a little more explanation. anyway, that's just my
thinking.

  along those lines, i was looking through the oe-core layer for a
simple example of PREFERRED_PROVIDER and it seems that "systemd"
providing "udev" was a good example, so i took my sample build of
core-image-minimal for qemux86, and just added to my local.conf the
line:

  PREFERRED_PROVIDER_udev = "systemd"

but now, i'm curious ... is there a "bitbake" subcommand that will
show me the effect of that setting? i'm looking at the current bitbake
command-line options and don't immediately see a way to ask for a list
of preferred provider overrides. is there any bitbake command that
will now display that "udev" is being provided by "systemd"?

  my apologies if this is a silly question and i'm overlooking the
obvious.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

