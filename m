Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1TjBX0-0005RS-GC
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Dec 2012 17:21:08 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([174.115.5.73]:51155 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1TjBIu-0006fU-Qf for bitbake-devel@lists.openembedded.org;
	Thu, 13 Dec 2012 11:06:32 -0500
Date: Thu, 13 Dec 2012 11:06:29 -0500 (EST)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1212131105210.8283@oneiric>
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
Subject: [PATCH] git.py: A bit of tidying up regarding grammar and supported protocols.
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
X-List-Received-Date: Thu, 13 Dec 2012 16:21:08 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Doc cleanup, no functional change.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fd0b2f..ba9f5fb 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -11,8 +11,8 @@ Supported SRC_URI options are:
 - branch
    The git branch to retrieve from. The default is "master"

-   this option also support multiple branches fetching, branches
-   are seperated by comma. in multiple branches case, the name option
+   This option also supports multiple branch fetching, with branches
+   separated by commas.  In multiple branches case, the name option
    must have the same number of names to match the branches, which is
    used to specify the SRC_REV for the branch
    e.g:
@@ -25,13 +25,13 @@ Supported SRC_URI options are:

 - protocol
    The method to use to access the repository. Common options are "git",
-   "http", "file" and "rsync". The default is "git"
+   "http", "https", "file", "ssh" and "rsync". The default is "git".

 - rebaseable
    rebaseable indicates that the upstream git repo may rebase in the future,
    and current revision may disappear from upstream repo. This option will
-   reminder fetcher to preserve local cache carefully for future use.
-   The default value is "0", set rebaseable=1 for rebaseable git repo
+   remind fetcher to preserve local cache carefully for future use.
+   The default value is "0", set rebaseable=1 for rebaseable git repo.

 - nocheckout
    Don't checkout source code when unpacking. set this option for the recipe

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


