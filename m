Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArc8-0001yz-HM
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:17 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076809"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:10 -0700
Message-Id: <573593c0c86b47a0ccec5a3c87c96eaebd05817d.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 5/9] lib/bb/ui/crumbs: add colour for HobAltButton per visual design
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:17 -0000

The visual design calls for the alternative button to have a pale blue
colour.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobcolor.py  |    1 +
 lib/bb/ui/crumbs/hobwidget.py |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobcolor.py b/lib/bb/ui/crumbs/hobcolor.py
index f767d22..4595dc1 100644
--- a/lib/bb/ui/crumbs/hobcolor.py
+++ b/lib/bb/ui/crumbs/hobcolor.py
@@ -31,6 +31,7 @@ class HobColors:
     BLACK        = "#000000"
     LIGHT_ORANGE = "#f7a787"
     YELLOW       = "#ffff00"
+    PALE_BLUE    = "#53b8ff"
 
     OK = WHITE
     RUNNING = PALE_GREEN
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index e8549a1..b93e9d4 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -200,8 +200,9 @@ class HobAltButton(gtk.Button):
     """
     A gtk.Button subclass which has no relief, and so is more discrete
     """
-    def __init__(self, label=None):
-        gtk.Button.__init__(self, label)
+    def __init__(self, label):
+        gtk.Button.__init__(self, "<span color='%s'><b>%s</b></span>" % (HobColors.PALE_BLUE, gobject.markup_escape_text(label)))
+        self.child.set_use_markup(True)
         self.set_relief(gtk.RELIEF_NONE)
 
 class HobImageButton(gtk.Button):
-- 
1.7.7.6



