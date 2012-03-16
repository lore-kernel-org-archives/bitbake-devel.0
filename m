Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S8Yo7-0006wZ-EB
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 16:11:07 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 16 Mar 2012 08:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121681027"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 16 Mar 2012 08:02:18 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 23:10:16 +0800
Message-Id: <acd17e9087460e8e37930d98fc446fde2809e699.1331910234.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
In-Reply-To: <cover.1331910234.git.shane.wang@intel.com>
References: <cover.1331910234.git.shane.wang@intel.com>
Subject: [PATCH 11/12] Hob: change HobNoteBook tab edge color from green to gray
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
X-List-Received-Date: Fri, 16 Mar 2012 15:11:07 -0000

From: Liming An <limingx.l.an@intel.com>

To change the notebook tab pressed edge color from green to gray.

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobcolor.py  |    2 ++
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobcolor.py b/bitbake/lib/bb/ui/crumbs/hobcolor.py
index 402f022..f767d22 100644
--- a/bitbake/lib/bb/ui/crumbs/hobcolor.py
+++ b/bitbake/lib/bb/ui/crumbs/hobcolor.py
@@ -25,6 +25,8 @@ class HobColors:
     PALE_RED     = "#ffaaaa"
     GRAY         = "#aaaaaa"
     LIGHT_GRAY   = "#dddddd"
+    DEEP_GRAY    = "#7c7c77"
+    SLIGHT_DARK  = "#5f5f5f"
     DARK         = "#3c3b37"
     BLACK        = "#000000"
     LIGHT_ORANGE = "#f7a787"
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index dc0480a..d4ee94e 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -496,16 +496,19 @@ class HobTabBar(gtk.DrawingArea):
 
         r = height / 10
         if self.tab_pressed == True:
-            for xoff, yoff in [(1, 0), (2, 0)]:
-                cr.set_source_color(gtk.gdk.color_parse(HobColors.PALE_GREEN))
+            for xoff, yoff, c1, c2 in [(1, 0, HobColors.SLIGHT_DARK, HobColors.DARK), (2, 0, HobColors.GRAY, HobColors.LIGHT_GRAY)]:
+                cr.set_source_color(gtk.gdk.color_parse(c1))
+                cr.move_to(x + xoff, y + height + yoff)
+                cr.line_to(x + xoff, r + yoff)
+                cr.arc(x + r + xoff, y + r + yoff, r, math.pi, 1.5*math.pi)
                 cr.move_to(x + r + xoff, y + yoff)
                 cr.line_to(x + width - r + xoff, y + yoff)
-                cr.arc(x + width - r+ xoff, y + r + yoff, r, 1.5*math.pi, 2*math.pi)
+                cr.arc(x + width - r + xoff, y + r + yoff, r, 1.5*math.pi, 2*math.pi)
+                cr.stroke()
+                cr.set_source_color(gtk.gdk.color_parse(c2))
                 cr.move_to(x + width + xoff, r + yoff)
                 cr.line_to(x + width + xoff, y + height + yoff)
                 cr.line_to(x + xoff, y + height + yoff)
-                cr.line_to(x + xoff, r + yoff)
-                cr.arc(x + r + xoff, y + r + yoff, r, math.pi, 1.5*math.pi)
                 cr.stroke()
             x = x + 2
             y = y + 2
-- 
1.7.6



