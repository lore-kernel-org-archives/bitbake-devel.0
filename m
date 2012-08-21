Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1T3yJg-0000IC-9L
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 01:57:00 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7LJH3m5002462
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2012 12:17:03 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Tue, 21 Aug 2012 12:17:03 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 21 Aug 2012 14:17:00 -0500
Message-ID: <1345576620-9407-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] ui: Improve error message if bitbake cannot import python curses module
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: Mark Hatle <mark.hatle@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 21 Aug 2012 23:57:00 -0000
Content-Type: text/plain

From: Konrad Scherer <Konrad.Scherer@windriver.com>

On some SuSE systems, the curses python module is not installed by default.
Instead of a python failure, we want a nicer error message.

(On SuSE systems the package is typically python-curses.)

Signed-off-by: Konrad Scherer <Konrad.Scherer@windriver.com>
Signed-off-by: Jeff Polk <jeff.polk@windriver.com>

Reword commit message, rebase to latest bitbake.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/ui/knotty.py  |    6 +++++-
 lib/bb/ui/ncurses.py |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b01daee..858cacf 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -141,7 +141,11 @@ class TerminalFilter(object):
         if not self.interactive:
             return
 
-        import curses
+        try:
+            import curses
+        except ImportError:
+            sys.exit("FATAL: The knotty ui could not load the required curses python module.")
+	
         import termios
         self.curses = curses
         self.termios = termios
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index 1425bbd..f573b95 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -47,7 +47,13 @@
 
 from __future__ import division
 import logging
-import os, sys, curses, itertools, time, subprocess
+import os, sys, itertools, time, subprocess
+
+try:
+    import curses
+except ImportError:
+    sys.exit("FATAL: The ncurses ui could not load the required curses python module.")
+
 import bb
 import xmlrpclib
 from bb import ui
-- 
1.7.3.4



