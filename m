Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9bEo-00060l-Ai
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 12:58:58 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9b6G-0001fW-Hx for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 07:50:08 -0400
Date: Mon, 19 Mar 2012 07:49:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1203190741220.22293@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
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
Subject: some preliminary questions about bitbake manual
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 19 Mar 2012 11:58:58 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  i'm about to write some tutorials on OE/bitbake/poky/yocto (from a
position of moderate ignorance, hoping that will change), so a couple
questions/observations before i get started.

  at risk of repetition, i already noted that if you google on
"bitbake user manual", you end up here:

  http://bitbake.berlios.de/manual/

which is *way* out of date, so perhaps a link to something newer would
be useful.

  next, is it fair to say that the current version of the bitbake
manual is the one that's part of bitbake itself, in the doc/
directory?  so if i want to submit some patches, i'd post them to this
list and those patches would always be relative to my current "git
pull" of bitbake?

  finally (for now), over at yocto, here's a quick tutorial on getting
started with oe-core:

  https://wiki.yoctoproject.org/wiki/OpenEmbedded-Core

it all looks reasonable but what you end up with in the oe-core
directory is two "bitbake.conf" files:

$ find . -name bitbake.conf
./meta/conf/bitbake.conf
./bitbake/conf/bitbake.conf
$

  i'm assuming that's by design and there are no weird conflicts
between the two files, right?

  more soon.  real soon.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


