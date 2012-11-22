Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TbcEj-0006oZ-Fd
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 20:14:57 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:60924 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77) (envelope-from <rpjday@crashcourse.ca>)
	id 1Tbc15-0002OT-VQ for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 14:00:52 -0500
Date: Thu, 22 Nov 2012 14:00:49 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1211221354240.6298@oneiric>
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
Subject: how easy to extend "bitbake -e" to print *selected* subset of variables?
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
X-List-Received-Date: Thu, 22 Nov 2012 19:14:57 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  if there's already a simple way to do this, then i'll be slightly
embarrassed.

  i would find it *massively* useful to have a variation of "bitbake
-e" print only the values of the variables that i'm interested in;
this would be incredibly useful in a classroom if i wanted students to
take a look at just those variables related to, say, the kernel.

  rather than having to hack up something using grep, it would be nice
if a user could, say, define an extra variable or class and say
something like:

  $ bitbake -e core-image-minimal --area kernel  (or similar)

where i could define that the "kernel area" represents the variables
such as MACHINE, KMACHINE, KBRANCH, LINUX_KERNEL_TYPE and whatever
variables i decide should belong to that "area."  then when i'm
discussing the kernel, i have a simple command that immediately allows
the students to see how the kernel was configured.

  i realize this can't be hard -- just add some filtering code to that
part of bitbake that prints everything.  thoughts?  is there a way to
do this that i'm not seeing?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


