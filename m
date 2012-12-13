Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mihaix.lindner@linux.intel.com>) id 1Tj6hH-0004Ov-19
	for bitbake-devel@lists.openembedded.org;
	Thu, 13 Dec 2012 12:11:23 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 13 Dec 2012 02:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,273,1355126400"; d="scan'208";a="263454089"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2012 02:55:41 -0800
Received: from mlindnex-mobl1.ger.corp.intel.com (unknown [10.252.122.248])
	by linux.intel.com (Postfix) with ESMTP id 62D392C8001;
	Thu, 13 Dec 2012 02:55:39 -0800 (PST)
From: Mihai Lindner <mihaix.lindner@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Dec 2012 12:55:25 +0200
Message-Id: <1355396125-13866-1-git-send-email-mihaix.lindner@linux.intel.com>
X-Mailer: git-send-email 1.8.0.2
Subject: [PATCH] knotty: use bb.error instead of print
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
X-List-Received-Date: Thu, 13 Dec 2012 11:11:23 -0000
X-List-Received-Date: Thu, 13 Dec 2012 11:11:23 -0000

Change to use bb.error instead of print, or maybe that was desired (?)
Also remove a tab, while in the neighborhood.

Signed-off-by: Mihai Lindner <mihaix.lindner@linux.intel.com>
---
 bitbake/lib/bb/ui/knotty.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index be63e73..a2983ca 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -146,7 +146,7 @@ class TerminalFilter(object):
             import curses
         except ImportError:
             sys.exit("FATAL: The knotty ui could not load the required curses python module.")
-	
+
         import termios
         self.curses = curses
         self.termios = termios
@@ -329,7 +329,7 @@ def main(server, eventHandler, tf = TerminalFilter):
                 logfile = event.logfile
                 if logfile and os.path.exists(logfile):
                     termfilter.clearFooter()
-                    print("ERROR: Logfile of failure stored in: %s" % logfile)
+                    bb.error("Logfile of failure stored in: %s" % logfile)
                     if includelogs and not event.errprinted:
                         print("Log data follows:")
                         f = open(logfile, "r")
-- 
1.8.0.2



