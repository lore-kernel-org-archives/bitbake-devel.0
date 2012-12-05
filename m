Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TgKGH-0001GN-4D
	for bitbake-devel@lists.openembedded.org;
	Wed, 05 Dec 2012 20:04:01 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:57735 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TgK2M-0004Au-0u for bitbake-devel@lists.openembedded.org;
	Wed, 05 Dec 2012 13:49:38 -0500
Date: Wed, 5 Dec 2012 13:49:35 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1212051341001.24855@oneiric>
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
Subject: is there a reason a bitbake "git" clone will hang while regular git works?
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
X-List-Received-Date: Wed, 05 Dec 2012 19:04:01 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  since the git fetcher code is part of bitbake, i figured i'd ask
here.  on more than one occasion now, when i've configured a build and
start fetching, the git fetch of the corresponding kernel source will
simply hang.

  for example, right now, i'm fetching for a dm814x-evm (using the
meta-ti layer), and the dir under git2 in the downloads directory
currently looks like this:

$ du -s *
4	branches
4	config
4	description
4	HEAD
40	hooks
8	info
12	objects
12	refs
$

and it hasn't changed for well over 10 minutes. the relevant part of
the recipe file:

SRC_URI +=
"git://arago-project.org/git/projects/linux-omap3.git;protocol=git;branch=ti81xx-master \
file://0001-ti814x-added-code-for-disabling-the-least-significan.patch \
            file://defconfig"

  however, as a test that git was still working properly, i simply
started a git clone of that SRC_URI and it's chugging away as i type.
and this has happened before -- that is, while the bitbake fetch/git
clone hangs almost immediately, i can generally use "git clone" from
the command line for that SRC_URI no problem.

  does that even make sense?  are the git options being used by
bitbake perhaps causing this?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


