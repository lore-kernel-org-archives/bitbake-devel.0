Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id C2A8670194
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jun 2014 16:17:57 +0000 (UTC)
Received: from [69.196.158.250] (port=49844 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wxf2C-0004U9-C2 for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jun 2014 12:17:56 -0400
Date: Thu, 19 Jun 2014 12:14:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406191207440.12626@localhost>
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
Subject: "FETCHCMD" versus "FETCHCOMMAND" bitbake.conf variables
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
X-List-Received-Date: Thu, 19 Jun 2014 16:18:04 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  currently updating some of my wiki pages, and i am reminded that, in
the bitbake version of bitbake.conf, one finds the fetching variables:

FETCHCOMMAND = ""
FETCHCOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} co ${CVSCOOPTS} ${CVSMODULE}"
FETCHCOMMAND_svn = "/usr/bin/env svn co ${SVNCOOPTS} ${SVNROOT} ${SVNMODULE}"
FETCHCOMMAND_wget = "/usr/bin/env wget -t 5 --passive-ftp -P ${DL_DIR} ${URI}"

but the variable glossary of the bitbake user manual refers instead to
the variable "FETCHCMD" and its variations:

http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.html#var-FETCHCMD

  as i see it, it's the oe-core layer whose bitbake.conf file defines:

FETCHCMD_svn = "/usr/bin/env svn --non-interactive --trust-server-cert"
FETCHCMD_cvs = "/usr/bin/env cvs"
FETCHCMD_wget = "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
FETCHCMD_bzr = "/usr/bin/env bzr"
FETCHCMD_hg = "/usr/bin/env hg"

  also, there are a number of bitbake fetch-related variables
(RESUMECOMMAND, UPDATECOMMAND) that don't appear to be included in the
bitbake user manual variable glossary. should they be?

rday



-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

