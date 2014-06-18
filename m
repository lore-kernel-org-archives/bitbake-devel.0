Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 405816FDD2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 14:19:51 +0000 (UTC)
Received: from [69.196.158.250] (port=38862 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxGiN-0006nD-C0 for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jun 2014 10:19:51 -0400
Date: Wed, 18 Jun 2014 10:16:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406180958160.27179@localhost>
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
Subject: trying to clarify PREFERRED_VERSION processing
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
X-List-Received-Date: Wed, 18 Jun 2014 14:19:58 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  still working my way through the bitbake user manual, currently in
section 2.3, "Preferences and Providers", and i think this section is
unnecessarily confusing as it tries to discuss both preferences and
providers at the same time, which i think are two separate concepts
that should be covered independently, so let me ask some questions
about just PREFERRED_VERSION processing using an actual example ripped
from the oe/poky codebase.

  (side note: i'm writing up a bunch of examples of bitbake processing
for my courses and, rather than use generic labels like "foo" and
"bar", i want to use actual examples from the codebase so i can show
the results with things like "bitbake -s".)

  consider (from my poky checkout) the two possibilities for the
busybox recipe:

  busybox_1.22.1.bb
  busybox_git.bb

obviously, there are two versions available to me and, if i examine
the respective .bb files, i can see in the git version:

  DEFAULT_PREFERENCE = "-1"

making that the *unpreferred* version. let's verify that with "bitbake
-s" (using my build for beaglebone/core-image-minimal):

$ bitbake -s
...
busybox                                           :1.22.1-r32
...
$

  good, that's what i expected -- the fixed version recipe is the one
that would be selected. now say i wanted to use the other (git)
version, what would be the appropriate line i would add to local.conf?
it seems i can just use wildcarding, as in:

  PREFERRED_VERSION_busybox = "1.22.1+git%"

at which point i can see:

$ bitbake -s
...
busybox                                           :1.22.1-r32 :1.22.1+gitAUTOINC+d9e0c438e1-r0
...
$

  from what i read from "bitbake -h", what is being printed is the
"current" version, followed by the "preferred" version, so i'm
interpreting that as the first value would be the version selected if
i didn't override it, and the second value is the version that will
actually be used given that i've explicitly preferred a version for
that recipe. is that the proper way to describe that?

  also, what would be the proper PREFERRED_VERSION line in my
local.conf if i wanted to prefer *precisely* that git version of
busybox? i know wildcarding works, as in:

  PREFERRED_VERSION_busybox = "1.22.1+git%"

but what value would i use to match *precisely* that git-based
version? something involving SRCREV or SRCPV or something like that?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

