Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDEeR-00082u-QU
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:40:27 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Mar 2012 05:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="135084278"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2012 05:31:25 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:54:55 +0800
Message-Id: <6a49ca50da1ee02838bcb3486573a6856dae3c8c.1333025491.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
In-Reply-To: <cover.1333025490.git.shane.wang@intel.com>
References: <cover.1333025490.git.shane.wang@intel.com>
Subject: [PATCH 6/8] Hob: some color style changes to make HobTabBar more close to visual design
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
X-List-Received-Date: Thu, 29 Mar 2012 12:40:28 -0000

The change includes:
 - remove the colors which are not used
 - change the background of indicators to deep red
 - change the color style of the texts on HobTabBar, i.e., the tab text and the indicator background are gray when the tab is the current tab; the tab text is white and the indicator background is deep red when the tab is not the current tab.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobcolor.py  |    4 +---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   12 +++++++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobcolor.py b/bitbake/lib/bb/ui/crumbs/hobcolor.py
index 74a9d46..e10f546 100644
--- a/bitbake/lib/bb/ui/crumbs/hobcolor.py
+++ b/bitbake/lib/bb/ui/crumbs/hobcolor.py
@@ -25,13 +25,11 @@ class HobColors:
     PALE_RED     = "#ffaaaa"
     GRAY         = "#aaaaaa"
     LIGHT_GRAY   = "#dddddd"
-    DEEP_GRAY    = "#7c7c77"
     SLIGHT_DARK  = "#5f5f5f"
     DARK         = "#3c3b37"
     BLACK        = "#000000"
-    LIGHT_ORANGE = "#f7a787"
-    YELLOW       = "#ffff00"
     PALE_BLUE    = "#53b8ff"
+    DEEP_RED     = "#aa3e3e"
 
     OK = WHITE
     RUNNING = PALE_GREEN
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 413370e..8b176c6 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -558,7 +558,10 @@ class HobTabBar(gtk.DrawingArea):
                 off_y = (self.tab_height - fonth) / 2
                 x = child["x"] + off_x
                 y = child["y"] + off_y
-                self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout)
+                if not child == self.current_child:
+                    self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout, gtk.gdk.Color(HobColors.WHITE))
+                else:
+                    self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout)
 
     def draw_toggled_tab(self, cr):
         if not self.current_child:
@@ -616,7 +619,10 @@ class HobTabBar(gtk.DrawingArea):
         y = tab_y + self.tab_height/2 - dest_h/2
 
         r = min(dest_w, dest_h)/2
-        color = cr.set_source_color(gtk.gdk.color_parse(HobColors.ORANGE))
+        if not child == self.current_child:
+            color = cr.set_source_color(gtk.gdk.color_parse(HobColors.DEEP_RED))
+        else:
+            color = cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
         # check round back area can contain the text or not
         back_round_can_contain_width = float(2 * r * 0.707)
         if float(textw) > back_round_can_contain_width:
@@ -635,7 +641,7 @@ class HobTabBar(gtk.DrawingArea):
         x = x + (dest_w/2)-(textw/2)
         y = y + (dest_h/2) - (texth/2)
         cr.move_to(x, y)
-        self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
+        self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout, gtk.gdk.Color(HobColors.WHITE))
 
     def show_indicator_icon(self, child, number):
         child["indicator_show"] = True
-- 
1.7.6



