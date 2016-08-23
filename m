Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 86C5576651
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 15:09:00 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 23 Aug 2016 08:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,566,1464678000"; d="scan'208";a="869934832"
Received: from yctb01.ostc.intel.com (HELO yctb01.otcr.intel.com)
	([10.54.69.55])
	by orsmga003.jf.intel.com with ESMTP; 23 Aug 2016 08:09:00 -0700
From: mariano.lopez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Aug 2016 07:06:11 +0000
Message-Id: <4948ba266e0dbc588c3c81dd845bd2ee1a343587.1471935918.git.mariano.lopez@linux.intel.com>
X-Mailer: git-send-email 2.6.6
In-Reply-To: <cover.1471935918.git.mariano.lopez@linux.intel.com>
References: <cover.1471935918.git.mariano.lopez@linux.intel.com>
Subject: [PATCH 1/1] cooker.py: Catch when stdout doesn't have a file descriptor
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
X-List-Received-Date: Tue, 23 Aug 2016 15:09:00 -0000

From: Mariano Lopez <mariano.lopez@linux.intel.com>

Currently, there is a check to remove the TOSTOP attribute from
a tty to avoid hangs. It assumes that sys.stdout will have a
file descriptor and this is not always true, some IO classes
will throw exceptions when trying to get its file descriptor.

This will add a check for such cases and avoid throwing an
exception.

[YOCTO #10162]

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
 bitbake/lib/bb/cooker.py | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index d1ab4aa..b7d7a7e 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -30,7 +30,7 @@ import logging
 import multiprocessing
 import sre_constants
 import threading
-from io import StringIO
+from io import StringIO, UnsupportedOperation
 from contextlib import closing
 from functools import wraps
 from collections import defaultdict, namedtuple
@@ -230,14 +230,17 @@ class BBCooker:
             pass
 
         # TOSTOP must not be set or our children will hang when they output
-        fd = sys.stdout.fileno()
-        if os.isatty(fd):
-            import termios
-            tcattr = termios.tcgetattr(fd)
-            if tcattr[3] & termios.TOSTOP:
-                buildlog.info("The terminal had the TOSTOP bit set, clearing...")
-                tcattr[3] = tcattr[3] & ~termios.TOSTOP
-                termios.tcsetattr(fd, termios.TCSANOW, tcattr)
+        try:
+            fd = sys.stdout.fileno()
+            if os.isatty(fd):
+                import termios
+                tcattr = termios.tcgetattr(fd)
+                if tcattr[3] & termios.TOSTOP:
+                    buildlog.info("The terminal had the TOSTOP bit set, clearing...")
+                    tcattr[3] = tcattr[3] & ~termios.TOSTOP
+                    termios.tcsetattr(fd, termios.TCSANOW, tcattr)
+        except UnsupportedOperation:
+            pass
 
         self.command = bb.command.Command(self)
         self.state = state.initial
-- 
2.6.6


