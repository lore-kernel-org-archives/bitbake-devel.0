Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 807AE70101
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Oct 2016 10:04:04 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 04 Oct 2016 03:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,442,1473145200"; d="scan'208";a="1040078054"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.29.8])
	by orsmga001.jf.intel.com with ESMTP; 04 Oct 2016 03:04:05 -0700
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Oct 2016 11:03:55 +0100
Message-Id: <1475575435-11098-1-git-send-email-joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] event: prevent unclosed file warning in print_ui_queue
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
X-List-Received-Date: Tue, 04 Oct 2016 10:04:07 -0000

Use logger.addHandler(), rather than assigning an array of Handlers
to the loggers handlers property directly, to avoid a warning from
Python 3 about unclosed files:

$ bitbake
Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.
WARNING: /home/joshuagl/Projects/poky/bitbake/lib/bb/event.py:143: ResourceWarning: unclosed file <_io.TextIOWrapper name='/home/joshuagl/Projects/poky/build/tmp/log/cooker/qemux86/20161004094928.log' mode='a' encoding='UTF-8'>
  logger.handlers = [stdout]

Signed-off-by: Joshua Lock <joshua.g.lock@intel.com>
---
 lib/bb/event.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 42745e2..e35b932 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -131,16 +131,16 @@ def print_ui_queue():
             if isinstance(event, logging.LogRecord):
                 if event.levelno > logging.DEBUG:
                     if event.levelno >= logging.WARNING:
-                        logger.handlers = [stderr]
+                        logger.addHandler(stderr)
                     else:
-                        logger.handlers = [stdout]
+                        logger.addHandler(stdout)
                     logger.handle(event)
                     msgprint = True
         if msgprint:
             return
 
         # Nope, so just print all of the messages we have (including debug messages)
-        logger.handlers = [stdout]
+        logger.addHandler(stdout)
         for event in ui_queue:
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
-- 
2.7.4


