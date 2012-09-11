Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TBN6Y-0007EB-WC
	for bitbake-devel@lists.openembedded.org;
	Tue, 11 Sep 2012 11:50:03 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 11 Sep 2012 02:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,402,1344236400"; d="scan'208";a="220648288"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.164])
	by fmsmga001.fm.intel.com with ESMTP; 11 Sep 2012 02:37:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 10:37:22 +0100
Message-Id: <1347356243-7920-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] lib/bb/event: improve handling of event queue on exit
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
X-List-Received-Date: Tue, 11 Sep 2012 09:50:03 -0000

If BitBake exits before a UI handler (server) has been registered, we
print the event queue; if there are any errors or other non-debug
messages just print these and suppress the rest of the message queue.

This improves the output when sanity check failures occur with OE-Core
by avoiding printing a long stream of uninformative debug messages.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/event.py |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index fa179d8..ab62d4d 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -104,6 +104,18 @@ def print_ui_queue():
         console = logging.StreamHandler(sys.stdout)
         console.setFormatter(BBLogFormatter("%(levelname)s: %(message)s"))
         logger.handlers = [console]
+
+        # First check to see if we have any proper messages
+        msgprint = False
+        for event in ui_queue:
+            if isinstance(event, logging.LogRecord):
+                if event.levelno > logging.DEBUG:
+                    logger.handle(event)
+                    msgprint = True
+        if msgprint:
+            return
+
+        # Nope, so just print all of the messages we have (including debug messages)
         for event in ui_queue:
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
-- 
1.7.9.5



