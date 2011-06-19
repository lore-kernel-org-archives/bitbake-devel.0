Received: from masterfoo.zenlinux.com ([207.192.74.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <scott.a.garman@intel.com>) id 1QYRGs-0006ms-QK
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Jun 2011 01:19:15 +0200
Received: from localhost.localdomain (c-98-246-160-194.hsd1.or.comcast.net
	[98.246.160.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by masterfoo.zenlinux.com (Postfix) with ESMTP id 01B8D2FDA0;
	Sun, 19 Jun 2011 19:15:39 -0400 (EDT)
From: Scott Garman <scott.a.garman@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 19 Jun 2011 16:15:25 -0700
Message-Id: <1308525325-5432-1-git-send-email-scott.a.garman@intel.com>
X-Mailer: git-send-email 1.7.1
X-MasterFoo-MailScanner-Information: Please contact the ISP for more
	information
X-MailScanner-ID: 01B8D2FDA0.8F456
X-MasterFoo-MailScanner: Found to be clean
X-MasterFoo-MailScanner-SpamCheck: not spam
X-MasterFoo-MailScanner-From: scott.a.garman@intel.com
X-Spam-Status: No
Cc: Scott Garman <scott.a.garman@intel.com>
Subject: [PATCH] fetch2/git.py: improve error reporting when an invalid protocol is used
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
X-List-Received-Date: Sun, 19 Jun 2011 23:19:15 -0000

When an invalid 'protocol' parameter is used in a git SRC_URI,
the error reported was not helpful:

ERROR: Function 'Fetcher failure for URL: 'None'.
<environment dump>
fatal: Could not make temporary directory: No such file or directory

So instead check that ud.proto is set to something valid, and if not
raise a meaningful ParameterError which explains that the protocol
type is the source of the problem.

This fixes bug [YOCTO #1142]

Signed-off-by: Scott Garman <scott.a.garman@intel.com>
---
 lib/bb/fetch2/git.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 6979bea..f3bc793 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -88,6 +88,9 @@ class Git(FetchMethod):
         else:
             ud.proto = "git"
 
+        if not ud.proto in ('git', 'file', 'ssh', 'http', 'https'):
+            raise bb.fetch2.ParameterError("Invalid protocol type", ud.url)
+
         ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
 
         ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
-- 
1.7.1



