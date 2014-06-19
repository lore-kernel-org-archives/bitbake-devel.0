Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 944986FC94
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jun 2014 17:15:04 +0000 (UTC)
Received: from [69.196.158.250] (port=34044 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxfvU-0008Gq-49 for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jun 2014 13:15:04 -0400
Date: Thu, 19 Jun 2014 13:11:20 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406191244230.14353@localhost>
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
Subject: potential confusion with inconsistency between bitbake and poky variable settings
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
X-List-Received-Date: Thu, 19 Jun 2014 17:15:07 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  i'm not sure if i'm looking at this the right way, but i see
potential confusion involving:

a) a bitbake user manual that should theoretically restrict itself to
talking about basic bitbake content, and

b) changes to bitbake settings when one chooses to use a
"higher-level" layer like poky.

let me explain.

  i already understand that the bitbake user manual should restrict
itself to covering bitbake-only topics, and not jump "up" the layer
stack and cover things in oe-core or poky or what have you -- that
should be outside the scope of that manual. the problem occurs because
lots of people *are* going to be building embedded systems based on
checking out, say, poky in its entirety, but will still want to read
the bitbake manual to understand how things work, and they're going to
be confused by the differences.

  case in point: if you look at bitbake's version of bitbake.conf, it
sets variables such as:

  GITDIR = "${DL_DIR}/git"

obviously suggesting that that is the git checkout directory, and the
bitbake user manual even says as much:

http://www.yoctoproject.org/docs/current/bitbake-user-manual/bitbake-user-manual.html#git-fetcher

"This fetcher submodule fetches code from the Git source control
system. The fetcher works by creating a bare clone of the remote into
GITDIR, which is usually DL_DIR/git."

  well, that's great, unless is someone is building based on poky,
whose bitbake.conf file (rather arbitrarily, it seems) redefines that
same variable:

CO_DIR = "${DL_DIR}"
CVSDIR = "${CO_DIR}/cvs"
SVNDIR = "${CO_DIR}/svn"
GITDIR = "${CO_DIR}/git2"

  yes, i understand that the bitbake manual states only that "git/" is
"usually" the checkout directory, bit it also means that people who
checkout oe-core and poky and who read the bitbake user manual are
guaranteed to notice mismatches in places.

  granted, that's a minor example, but i suspect there are others.
thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================




