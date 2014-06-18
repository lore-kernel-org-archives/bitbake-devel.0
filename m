Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 0F36E6FC48
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 15:14:29 +0000 (UTC)
Received: from [69.196.158.250] (port=39629 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxHZF-0000xm-Sx for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jun 2014 11:14:29 -0400
Date: Wed, 18 Jun 2014 11:10:47 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406181050550.28390@localhost>
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
Subject: more pedantry involving the proper use of PREFERRED_PROVIDER_*
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
X-List-Received-Date: Wed, 18 Jun 2014 15:14:40 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  and now, some picky questions about the use and processing of
PREFERRED_PROVIDER, once again using actual examples pulled from the
poky repository.

  first, is there anything magical about the use of the prefix
"virtual/" when defining and selecting providers? i'm well aware of
the most common usage of this -- "virtual/kernel". and there are other
good examples like "virtual/bootloader", "virtual/xserver" and so on.

  but there are other non-virtual definitions, such as:

  PREFERRED_PROVIDER_console-tools ?= "kbd"

so if i select "console-tools" to be incorporated into my eventual
image, that line will end up selecting the "kbd" recipe. so why are
some of these preferences using "virtual/" and some not? is it just a
philosophical choice? could i do something goofy like define and
select names like "rday/recipename" just as well?

  next, wouldn't the preferred provider for a recipe be, by default,
that same name? it seems odd to see something like:

  PREFERRED_PROVIDER_ltp ?= "ltp"

even if something else provides "ltp", isn't the above redundant? or
is there something subtle here i'm missing?

  finally, i found this simple example i want to use as a teaching
example involving make and remake. there's a definition for the "make"
recipe that looks perfectly normal, and there is also a recipe
definition for an alternative, remake, whose .bb file contains:

  PROVIDES += "make"

and whose remake.inc file includes:

  ALTERNATIVE_${PN} = "make"
  ALTERNATIVE_LINK_NAME[make] = "${bindir}/make"
  ALTERNATIVE_TARGET[make] = "${bindir}/remake"
  ALTERNATIVE_PRIORITY = "100"

so i'm assuming i could just do something like:

  PREFERRED_PROVIDER_make = "remake"

yes? is this explained anywhere in the yocto docs in more detail?
thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


