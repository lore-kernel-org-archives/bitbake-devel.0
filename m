Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qomj5-0000xL-OF
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 03:27:56 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2011 18:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,313,1309762800"; d="scan'208";a="34155895"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.173])
	by orsmga002.jf.intel.com with ESMTP; 03 Aug 2011 18:23:29 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2011 18:23:20 -0700
Message-Id: <110d507c69c756657393809f57443b88841ad091.1312420894.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
Subject: [PATCH 4/6] bb/ui/crumbs/hobeventhandler: use generic loading message once cache loaded
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
X-List-Received-Date: Thu, 04 Aug 2011 01:27:56 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index e8265f1..2e0a999 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -187,7 +187,7 @@ class HobHandler(gobject.GObject):
             pbar.set_text("Loading cache: %s/%s" % (event.current, bb.ui.crumbs.hobeventhandler.progress_total))
         elif isinstance(event, bb.event.CacheLoadCompleted):
             self.current_phase = None
-            pbar.set_text("Loading cache: %s/%s" % (bb.ui.crumbs.hobeventhandler.progress_total, bb.ui.crumbs.hobeventhandler.progress_total))
+            pbar.set_text("Loading...")
         elif isinstance(event, bb.event.ParseStarted):
             self.current_phase = "recipe parsing"
             if event.total == 0:
@@ -200,6 +200,7 @@ class HobHandler(gobject.GObject):
         elif isinstance(event, bb.event.ParseCompleted):
             self.current_phase = None
             pbar.set_fraction(1.0)
+            pbar.set_text("Loading...")
         elif isinstance(event, logging.LogRecord):
             format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
             if event.levelno >= format.CRITICAL:
-- 
1.7.6



