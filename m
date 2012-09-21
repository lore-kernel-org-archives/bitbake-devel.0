Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TF4iF-0004KT-3B
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 17:00:15 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Sep 2012 07:47:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,463,1344236400"; d="scan'208";a="209599748"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.241])
	by orsmga002.jf.intel.com with ESMTP; 21 Sep 2012 07:47:29 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 15:47:23 +0100
Message-Id: <cb9e4516cecd5299bb68a17238e4f83718bdb025.1348238757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1348238757.git.paul.eggleton@linux.intel.com>
References: <cover.1348238757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 1/4] hob: don't show error dialog for errors during building
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
X-List-Received-Date: Fri, 21 Sep 2012 15:00:15 -0000

During building we already report errors in a special tab and
indicate when the build has failed; bringing up a dialog was a
regression introduced in bitbake revision
5bab81b124087d63d6eb62a861e1241714fcd483.

Fixes [YOCTO #3151].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 8fc1732..49db2de 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -183,10 +183,11 @@ class HobHandler(gobject.GObject):
             self.emit("sanity-failed", event._msg)
 
         elif isinstance(event, logging.LogRecord):
-            if event.levelno >= logging.ERROR:
-                formatter = bb.msg.BBLogFormatter()
-                msg = formatter.format(event)
-                self.error_msg += msg + '\n'
+            if not self.building:
+                if event.levelno >= logging.ERROR:
+                    formatter = bb.msg.BBLogFormatter()
+                    msg = formatter.format(event)
+                    self.error_msg += msg + '\n'
 
         elif isinstance(event, bb.event.TargetsTreeGenerated):
             self.current_phase = "data generation"
-- 
1.7.9.5



