Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG8-0001pn-Se
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:37 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344106"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:47 -0700
Message-Id: <15cc4fe5051dcb6ac5915e10228b5f3d3ed845bd.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 5/8] ui/crumbs/hobeventhandler: emit a signal when a command fails
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:37 -0000

If a CommandFailed event is seen emit a signal with the error message.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 1163cba..0b5b318 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -54,11 +54,13 @@ class HobHandler(gobject.GObject):
                                   gobject.TYPE_NONE,
                                   (gobject.TYPE_STRING,
                                    gobject.TYPE_STRING,)),
+         "command-failed"      : (gobject.SIGNAL_RUN_LAST,
+                                  gobject.TYPE_NONE,
                                   (gobject.TYPE_STRING,)),
          "reload-triggered"    : (gobject.SIGNAL_RUN_LAST,
                                   gobject.TYPE_NONE,
                                   (gobject.TYPE_STRING,
-                                   gobject.TYPE_STRING)),
+                                   gobject.TYPE_STRING,)),
     }
 
     (CFG_PATH_LOCAL, CFG_PATH_HOB, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDK, FILES_MATCH_CLASS, GENERATE_TGTS, REPARSE_FILES, BUILD_IMAGE) = range(10)
@@ -172,6 +174,7 @@ class HobHandler(gobject.GObject):
             self.current_phase = None
             self.run_next_command()
         elif isinstance(event, bb.command.CommandFailed):
+            self.emit("command-failed", event.error)
         elif isinstance(event, bb.event.CacheLoadStarted):
             self.current_phase = "cache loading"
             bb.ui.crumbs.hobeventhandler.progress_total = event.total
-- 
1.7.6



