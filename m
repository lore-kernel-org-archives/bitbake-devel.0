Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 9ED506B4F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jun 2014 15:51:18 +0000 (UTC)
Received: from [69.196.158.250] (port=53221 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1Wy15z-0006PI-Mp for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jun 2014 11:51:19 -0400
Date: Fri, 20 Jun 2014 11:47:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406200725340.5971@localhost>
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
Subject: distinguishing between bitbake and "higher" layers WRT fetching variables [LONG]
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
X-List-Received-Date: Fri, 20 Jun 2014 15:51:23 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


  (note: more annoying pedantry regarding bitbake configuration and
documentation but, if i'm going to explain this to my students, i
really need to understand it completely.)

  some questions and observations about how bitbake defines some
fetch-related variables as opposed to how those variables are defined
in higher layers such as oe-core and poky. as richard purdie(?)
pointed out recently, the goal should be to document bitbake as
independently as possible from what happens in layers such as oe and
poky, but it seems this is not as clean as it could be.

  consider first bitbake's current bitbake.conf file. first, can we
agree that this set of variables:

FETCHCOMMAND = ""
FETCHCOMMAND_cvs = "/usr/bin/env cvs -d${CVSROOT} co ${CVSCOOPTS} ${CVSMODULE}"
FETCHCOMMAND_svn = "/usr/bin/env svn co ${SVNCOOPTS} ${SVNROOT} ${SVNMODULE}"
FETCHCOMMAND_wget = "/usr/bin/env wget -t 5 --passive-ftp -P ${DL_DIR} ${URI}"

is entirely superfluous? i see nothing that uses them -- everything
seems to use the alternative "FETCHCMD_*" naming. can the above just
be deleted?

  with respect to the "FETCHCMD_*" variables, this is a bit messier.
the bitbake user manual defines that variable thusly:

file:///home/rpjday/oe/dist/layers/bitbake/doc/bitbake-user-manual/bitbake-user-manual.html#var-FETCHCMD

tossing out examples of FETCHCMD_git and FETCHCMD_svn, and here's the
messy part.

  who is responsible for setting the default values for those fetcher
commands? the first possibility is that bitbake itself can do that in
the fetcher code. for instance, here's the test from git.py:

ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"

what the above seems to be doing (based on my mediocre understanding
of python) is that either that fetcher variable is set, or it's set to
the subsequent git command, correct? in short, the fundamental bitbake
git fetcher code is responsible for setting the basic git fetch
command. perfectly reasonable, but there's another possibility.

  a number of other fetch variables appear to be defined in oe-core,
whose bitbake.conf file contains:

FETCHCMD_svn = "/usr/bin/env svn --non-interactive --trust-server-cert"
FETCHCMD_cvs = "/usr/bin/env cvs"
FETCHCMD_wget = "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
FETCHCMD_bzr = "/usr/bin/env bzr"
FETCHCMD_hg = "/usr/bin/env hg"

and, back in bitbake, the fetch command for, say, svn, is determined
in svn.py simply with:

  ud.basecmd = d.getVar('FETCHCMD_svn', True)

if i read this correctly, then, that code from bitbake simply
*assumes* that that variable for the svn fetcher is set -- there is no
error checking if it isn't. this suggests that the fetcher variables
for things like svn and hg and bzr are assumed by bitbake to come from
elsewhere -- in this case, oe-core or poky or what have you.

  this seems inconsistent -- in some cases, the bitbake fetch code
will guarantee that a fetcher variable is set (as with git or
perforce):

git.py:        ud.basecmd = data.getVar("FETCHCMD_git", d, True) or "git -c core.fsyncobjectfiles=0"
perforce.py:        p4cmd = d.getVar('FETCHCMD_p4', True) or "p4"

in other cases, bitbake seems to count on someone else setting the
appropriate fetcher variable (as in oe-core):

FETCHCMD_svn = "/usr/bin/env svn --non-interactive --trust-server-cert"
FETCHCMD_cvs = "/usr/bin/env cvs"
FETCHCMD_wget = "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
FETCHCMD_bzr = "/usr/bin/env bzr"
FETCHCMD_hg = "/usr/bin/env hg"

and in one case, both the bitbake layer and oe-core currently (and
redundantly) take responsibility for setting the correct fetcher
command for wget:

self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
FETCHCMD_wget = "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"

this just seems confusing, as there is no obvious basis for deciding
who gets to set those variables.

  oh, and one more (admittedly minor) observation related to the
above. in my courses, i really like to use chris larson's cool "bb"
utility to display environment and variables, and the above situation
causes the following glitch.

  if a fetcher variable is set explicitly (say, in oe-core), as in:

FETCHCMD_bzr = "/usr/bin/env bzr"
FETCHCMD_hg = "/usr/bin/env hg"

then the "bb" command will happily show me the value of that variable:

$ bb show FETCHCMD_bzr
FETCHCMD_bzr="/usr/bin/env bzr"
$ bb show FETCHCMD_hg
FETCHCMD_hg="/usr/bin/env hg"
$

but if the fetch variable is determined by the bitbake fetcher code at
run-time, as with git or perforce, well, i'm screwed:

$ bb show FETCHCMD_git
WARNING: Requested variable 'FETCHCMD_git' does not exist
$ bb show FETCHCMD_p4
WARNING: Requested variable 'FETCHCMD_p4' does not exist
$

  it just seems that there isn't a rigourously clean separation
between bitbake and oe-core, and it's entirely possible there *can't*
be, but some things seem unnecessarily confusing as to where certain
values or variables are defined.

  yes, there should be a bitbake user manual covering bitbake-only
content independent of higher layers like oe-core, but at the same
time, given that readers will be using bitbake *in the context* of
building with oe-core or poky, i think bitbake should avoid code or
documentation that is almost guaranteed to be different in the context
of those higher layers. case in point -- bitbake:

  GITDIR = "${DL_DIR}/git"

oe-core:

  GITDIR = "${CO_DIR}/git2"

anyway, i've rambled sufficiently. thoughts?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================




