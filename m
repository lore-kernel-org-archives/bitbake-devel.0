Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SZhhi-0003oJ-Op
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 14:08:42 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 May 2012 04:58:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="149445100"
Received: from hp.sh.intel.com ([10.239.47.6])
	by azsmga001.ch.intel.com with ESMTP; 30 May 2012 04:58:22 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 20:01:10 +0800
Message-Id: <b362fa18604b2fb5ab1053800b7e76693b094d3a.1338379209.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338379209.git.limingx.l.an@intel.com>
References: <cover.1338379209.git.limingx.l.an@intel.com>
Subject: [PATCH 1/2] Hob: Fixed a compatible issue for indicator icon view
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
X-List-Received-Date: Wed, 30 May 2012 12:08:43 -0000

Because some screen not support the alpha visual channel, so the function
'screen.get_rgba_colormap()' will return None, it's a compatible issue, so
change it by another way.

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py |   51 +++++---------------------------
 1 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index f8e97ad..bd9e2e2 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -400,50 +400,33 @@ class HobInfoButton(gtk.EventBox):
 class HobIndicator(gtk.DrawingArea):
     def __init__(self, count):
         gtk.DrawingArea.__init__(self)
-
-        # We want to composite the transparent indicator onto the parent
-        # HBox
-        screen = self.get_screen()
-        rgba = screen.get_rgba_colormap()
-        self.set_colormap(rgba)
-        self.set_app_paintable(True)
+        # Set no window for transparent background
+        self.set_has_window(False)
         self.set_size_request(38,38)
         # We need to pass through button clicks
         self.add_events(gtk.gdk.BUTTON_PRESS_MASK | gtk.gdk.BUTTON_RELEASE_MASK)
 
         self.connect('expose-event', self.expose)
-        self.connect_after('realize', self.composite)
 
         self.count = count
         self.color = HobColors.GRAY
 
-    def composite(self, widget):
-        # This property must be set after the widget has been realised
-        self.window.set_composited(True)
-
     def expose(self, widget, event):
-        # Transparent background
-        ctx = widget.window.cairo_create()
-        ctx.set_operator(cairo.OPERATOR_CLEAR)
-        region = gtk.gdk.region_rectangle(event.area)
-
-        ctx.region(region)
-        ctx.fill()
-
         if self.count and self.count > 0:
-            w = self.allocation.width
-            h = self.allocation.height
+            ctx = widget.window.cairo_create()
+
+            x, y, w, h = self.allocation
 
             ctx.set_operator(cairo.OPERATOR_OVER)
             ctx.set_source_color(gtk.gdk.color_parse(self.color))
             ctx.translate(w/2, h/2)
-            ctx.arc(1, 1, min(w,h)/2 - 2, 0, 2*math.pi)
+            ctx.arc(x, y, min(w,h)/2 - 2, 0, 2*math.pi)
             ctx.fill_preserve()
 
             layout = self.create_pango_layout(str(self.count))
             textw, texth = layout.get_pixel_size()
-            x = (w/2)-(textw/2) + 1
-            y = (h/2) - (texth/2) + 1
+            x = (w/2)-(textw/2) + x
+            y = (h/2) - (texth/2) + y
             ctx.move_to(x, y)
             self.window.draw_layout(self.style.light_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
 
@@ -466,24 +449,6 @@ class HobTabLabel(gtk.HBox):
         self.lbl.set_alignment(0.0, 0.5)
         self.lbl.show()
         self.pack_end(self.lbl, True, True, 6)
-        self.connect_after('expose-event', self.expose_event)
-
-    def expose_event(self, widget, event):
-        # Composite the child indicator onto the Box
-        child = self.indicator
-        ctx = widget.window.cairo_create()
-
-        ctx.set_source_pixmap(child.window, child.allocation.x, child.allocation.y)
-
-        region = gtk.gdk.region_rectangle(child.allocation)
-        r = gtk.gdk.region_rectangle(event.area)
-        region.intersect(r)
-        ctx.region(region)
-        ctx.clip()
-
-        ctx.paint()
-
-        return False
 
     def set_count(self, count):
         self.indicator.set_count(count)
-- 
1.7.5.4



