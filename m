Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 189E4602D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Sep 2016 11:02:51 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga102.jf.intel.com with ESMTP; 08 Sep 2016 04:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,300,1470726000"; 
   d="scan'208";a="5973657"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga006.fm.intel.com with ESMTP; 08 Sep 2016 04:02:51 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 1AB506A4006;
	Thu,  8 Sep 2016 04:02:28 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 Sep 2016 14:02:33 +0300
Message-Id: <1473332553-26072-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] event.py: output errors and warnings to stderr
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
X-List-Received-Date: Thu, 08 Sep 2016 11:02:52 -0000

All logging messages are printed on stdout when processing
UI event queue. This makes it impossible to distinguish between
errors and normal bitbake output. Output to stderror or stdout
depending on log level should fix this.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/event.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 1f3200e..42745e2 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -119,21 +119,28 @@ def print_ui_queue():
     logger = logging.getLogger("BitBake")
     if not _uiready:
         from bb.msg import BBLogFormatter
-        console = logging.StreamHandler(sys.stdout)
-        console.setFormatter(BBLogFormatter("%(levelname)s: %(message)s"))
-        logger.handlers = [console]
+        stdout = logging.StreamHandler(sys.stdout)
+        stderr = logging.StreamHandler(sys.stderr)
+        formatter = BBLogFormatter("%(levelname)s: %(message)s")
+        stdout.setFormatter(formatter)
+        stderr.setFormatter(formatter)
 
         # First check to see if we have any proper messages
         msgprint = False
         for event in ui_queue:
             if isinstance(event, logging.LogRecord):
                 if event.levelno > logging.DEBUG:
+                    if event.levelno >= logging.WARNING:
+                        logger.handlers = [stderr]
+                    else:
+                        logger.handlers = [stdout]
                     logger.handle(event)
                     msgprint = True
         if msgprint:
             return
 
         # Nope, so just print all of the messages we have (including debug messages)
+        logger.handlers = [stdout]
         for event in ui_queue:
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
-- 
2.1.4


