Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 92D95701E3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 17:29:55 +0000 (UTC)
Received: from [69.196.158.250] (port=55679 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wy2dQ-0002pS-Ei for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jun 2014 13:29:56 -0400
Date: Fri, 20 Jun 2014 13:26:08 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406201322310.28485@localhost>
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
Subject: is there a TODO/issues list for bitbake user manual enhancements?
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
X-List-Received-Date: Fri, 20 Jun 2014 17:30:00 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  is there anywhere to track proposed changes to the bitbake user
manual? one of the things i've already noted is that the variable
glossary is somewhat incomplete. for example, at the very least, it
should include the following variables that are explicitly set in
bitbake's own bitbake.conf file:

 CVSDIR
 DEPLOY_DIR
 DEPLOY_DIR_IMAGE
 FILE_DIRNAME
 GITDIR
 IMAGE_CMD
 IMAGE_ROOTFS
 P
 S
 SVNDIR
 TARGET_ARCH
 TMPDIR
 WORKDIR

is there a list to add these to? or is most of the effort these days
being invested in the yocto version of the ref manual?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

