Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TpfSr-0007q2-UC
	for bitbake-devel@lists.openembedded.org;
	Mon, 31 Dec 2012 14:31:39 +0100
Received: from cpebcc81008dd2c-cmbcc81008dd29.cpe.net.cable.rogers.com
	([99.253.156.71]:44919 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TpfEN-0002MN-EG for bitbake-devel@lists.openembedded.org;
	Mon, 31 Dec 2012 08:16:39 -0500
Date: Mon, 31 Dec 2012 08:16:36 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1212310810410.23262@oneiric>
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
Subject: current status of "FETCHCOMMAND_" vs "FETCHCMD_"?
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
X-List-Received-Date: Mon, 31 Dec 2012 13:31:40 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  a few months back, i asked about the distinction between the two
forms of FETCH variables, and richard purdie answered thusly:

http://lists.linuxtogo.org/pipermail/openembedded-core/2012-July/025311.html

however, there are still settings of some FETCHCOMMAND_ variables in
bitbake's bitbake.conf file:

FETCHCOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} co ${CVSCOOPTS} ${CVSMODULE}"
FETCHCOMMAND_svn = "/usr/bin/env svn co ${SVNCOOPTS} ${SVNROOT} ${SVNMODULE}"
FETCHCOMMAND_wget = "/usr/bin/env wget -t 5 --passive-ftp -P ${DL_DIR} ${URI}"

and even usage of one that doesn't even appear to be set:

$ grep -r FETCHCOMMAND_p4 *
Binary file lib/bb/fetch2/perforce.pyc matches
lib/bb/fetch2/perforce.py:        p4cmd = data.getVar('FETCHCOMMAND_p4', d, True)
$

  is there still a plan to migrate everything to the FETCHCMD_
variations?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


