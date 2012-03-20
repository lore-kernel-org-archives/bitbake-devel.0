Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA09F-0000xv-IF
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:34:53 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 07:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="122950471"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 20 Mar 2012 07:25:59 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 22:41:09 +0800
Message-Id: <f1822f0961bd719de0827e361f7e6fa3bf872746.1332254194.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
References: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
In-Reply-To: <cover.1332254194.git.shane.wang@intel.com>
References: <cover.1332254194.git.shane.wang@intel.com>
Subject: [PATCH 08/11] Hob: add auto adjust background area function for long issue text
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
X-List-Received-Date: Tue, 20 Mar 2012 14:34:53 -0000

From: Liming An <limingx.l.an@intel.com>

To add auto expand the background area function for long issue text input.

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 4c4b059..bc27cd1 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -521,26 +521,38 @@ class HobTabBar(gtk.DrawingArea):
         cr.fill()
 
     def draw_indicator(self, cr, child):
+        text = ("%d" % child["indicator_number"])
+        layout = self.create_pango_layout(text)
+        layout.set_font_description(self.font)
+        textw, texth = layout.get_pixel_size()
+        # draw the back round area
         tab_x = child["x"]
         tab_y = child["y"]
-        number = child["indicator_number"]
         dest_w = int(32 * self.tab_w_ratio)
         dest_h = int(32 * self.tab_h_ratio)
         if dest_h < self.tab_height:
             dest_w = dest_h
-
         # x position is offset(tab_width*3/4 - icon_width/2) + start_pos(tab_x)
         x = tab_x + self.tab_width * 3/4 - dest_w/2
         y = tab_y + self.tab_height/2 - dest_h/2
+
         r = min(dest_w, dest_h)/2
         color = cr.set_source_color(gtk.gdk.color_parse(HobColors.ORANGE))
-        cr.arc(x + r, y + r, r, 0, 2*math.pi)
-        cr.fill()
-
-        text = ("%d" % number)
-        layout = self.create_pango_layout(text)
-        layout.set_font_description(self.font)
-        textw, texth = layout.get_pixel_size()
+        # check round back area can contain the text or not
+        back_round_can_contain_width = float(2 * r * 0.707)
+        if float(textw) > back_round_can_contain_width:
+            xoff = (textw - int(back_round_can_contain_width)) / 2
+            cr.move_to(x + r - xoff, y + r + r)
+            cr.arc((x + r - xoff), (y + r), r, 0.5*math.pi, 1.5*math.pi)
+            cr.fill() # left half round
+            cr.rectangle((x + r - xoff), y, 2 * xoff, 2 * r)
+            cr.fill() # center rectangle
+            cr.arc((x + r + xoff), (y + r), r, 1.5*math.pi, 0.5*math.pi)
+            cr.fill() # right half round
+        else:
+            cr.arc((x + r), (y + r), r, 0, 2*math.pi)
+            cr.fill()
+        # draw the number text
         x = x + (dest_w/2)-(textw/2)
         y = y + (dest_h/2) - (texth/2)
         cr.move_to(x, y)
-- 
1.7.6



