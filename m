Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIpzm-0000YB-Hc
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 01:33:39 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Apr 2012 16:24:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130756359"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.191])
	by azsmga001.ch.intel.com with ESMTP; 13 Apr 2012 16:24:13 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:24:07 -0700
Message-Id: <81fe8f65330fb158a4719e3773eb017905518819.1334359238.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
In-Reply-To: <cover.1334359238.git.josh@linux.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
Subject: [PATCH 1/4] lib/bb/ui/crumbs/: replace custom HobNotebook
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
X-List-Received-Date: Fri, 13 Apr 2012 23:33:39 -0000

The custom HobNotebook widget was implemented to address perceived
deficiencies in the gtk.Notebook API.

Recent inspection reveals that the API is capable of all that Hob
requires of it and therefore maintaining a custom class to provide
similar functionality does not make sense.

Addresses [YOCTO #2276]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py     |    6 +-
 lib/bb/ui/crumbs/hobwidget.py            |  499 +++++++-----------------------
 lib/bb/ui/crumbs/packageselectionpage.py |    3 +-
 lib/bb/ui/crumbs/recipeselectionpage.py  |    5 +-
 4 files changed, 119 insertions(+), 394 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index 23aaacd..59d710e 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -144,7 +144,7 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view_config = gtk.ScrolledWindow ()
         self.scrolled_view_config.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_config.add(self.config_tv)
-        self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build configuration"))
+        self.notebook.append_page(self.scrolled_view_config, "Build configuration")
 
         self.failure_tv = BuildFailureTreeView()
         self.failure_model = self.builder.handler.build.model.failure_model()
@@ -152,14 +152,14 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view_failure = gtk.ScrolledWindow ()
         self.scrolled_view_failure.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_failure.add(self.failure_tv)
-        self.notebook.append_page(self.scrolled_view_failure, gtk.Label("Issues"))
+        self.notebook.append_page(self.scrolled_view_failure, "Issues")
 
         self.build_tv = RunningBuildTreeView(readonly=True, hob=True)
         self.build_tv.set_model(self.builder.handler.build.model)
         self.scrolled_view_build = gtk.ScrolledWindow ()
         self.scrolled_view_build.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_build.add(self.build_tv)
-        self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
+        self.notebook.append_page(self.scrolled_view_build, "Log")
 
         self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
 
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index a42cdec..f878263 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -23,6 +23,7 @@ import os
 import os.path
 import sys
 import pango, pangocairo
+import cairo
 import math
 
 from bb.ui.crumbs.hobcolor import HobColors
@@ -380,363 +381,130 @@ class HobInfoButton(gtk.EventBox):
     def mouse_out_cb(self, widget, event):
         self.image.set_from_file(hic.ICON_INFO_DISPLAY_FILE)
 
-class HobTabBar(gtk.DrawingArea):
-    __gsignals__ = {
-        "blank-area-changed" : (gobject.SIGNAL_RUN_LAST,
-                                gobject.TYPE_NONE,
-                               (gobject.TYPE_INT,
-                                gobject.TYPE_INT,
-                                gobject.TYPE_INT,
-                                gobject.TYPE_INT,)),
-
-        "tab-switched" : (gobject.SIGNAL_RUN_LAST,
-                          gobject.TYPE_NONE,
-                         (gobject.TYPE_INT,)),
-    }
-
-    def __init__(self):
+class HobIndicator(gtk.DrawingArea):
+    def __init__(self, count):
         gtk.DrawingArea.__init__(self)
-        self.children = []
-
-        self.tab_width = 140
-        self.tab_height = 52
-        self.tab_x = 10
-        self.tab_y = 0
-
-        self.width = 500
-        self.height = 53
-        self.tab_w_ratio = 140 * 1.0/500
-        self.tab_h_ratio = 52 * 1.0/53
-        self.set_size_request(self.width, self.height)
-
-        self.current_child = None
-        self.font = self.get_style().font_desc
-        self.font.set_size(pango.SCALE * 13) 
-        self.update_children_text_layout_and_bg_color()
-
-        self.blank_rectangle = None
-        self.tab_pressed = False
-
-        self.set_property('can-focus', True)
-        self.set_events(gtk.gdk.EXPOSURE_MASK | gtk.gdk.POINTER_MOTION_MASK |
-                        gtk.gdk.BUTTON1_MOTION_MASK | gtk.gdk.BUTTON_PRESS_MASK |
-                        gtk.gdk.BUTTON_RELEASE_MASK)
-
-        self.connect("expose-event", self.on_draw)
-        self.connect("button-press-event", self.button_pressed_cb)
-        self.connect("button-release-event", self.button_released_cb)
-        self.connect("query-tooltip", self.query_tooltip_cb)
-        self.show_all()
-
-    def button_released_cb(self, widget, event):
-        self.tab_pressed = False
-        self.queue_draw()
-
-    def button_pressed_cb(self, widget, event):
-        if event.type == gtk.gdk._2BUTTON_PRESS:
-            return
-
-        result = False
-        if self.is_focus() or event.type == gtk.gdk.BUTTON_PRESS:
-            x, y = event.get_coords()
-            # check which tab be clicked
-            for child in self.children:
-               if      (child["x"] < x) and (x < child["x"] + self.tab_width) \
-                   and (child["y"] < y) and (y < child["y"] + self.tab_height):
-                   self.current_child = child
-                   result = True
-                   self.grab_focus()
-                   break
-
-            # check the blank area is focus in or not
-            if (self.blank_rectangle) and (self.blank_rectangle.x > 0) and (self.blank_rectangle.y > 0):
-                if      (self.blank_rectangle.x < x) and (x < self.blank_rectangle.x + self.blank_rectangle.width) \
-                    and (self.blank_rectangle.y < y) and (y < self.blank_rectangle.y + self.blank_rectangle.height):
-                   self.grab_focus()
-
-        if result == True:
-            page = self.current_child["toggled_page"]
-            self.emit("tab-switched", page)
-            self.tab_pressed = True
-            self.queue_draw()
-
-    def update_children_size(self):
-        # calculate the size of tabs
-        self.tab_width = int(self.width * self.tab_w_ratio)
-        self.tab_height = int(self.height * self.tab_h_ratio)
-        for i, child in enumerate(self.children):
-            child["x"] = self.tab_x + i * self.tab_width
-            child["y"] = self.tab_y
-
-        if self.blank_rectangle:
-            self.resize_blank_rectangle()
-
-    def resize_blank_rectangle(self):
-        width = self.width - self.tab_width * len(self.children) - self.tab_x
-        x = self.tab_x + self.tab_width * len(self.children)
-        hpadding = vpadding = 5
-        self.blank_rectangle = self.set_blank_size(x + hpadding, self.tab_y + vpadding,
-            width - 2 * hpadding, self.tab_height - 2 * vpadding)
-
-    def update_children_text_layout_and_bg_color(self):
-        style = self.get_style().copy()
-        color = style.base[gtk.STATE_NORMAL]
-        for child in self.children:
-            pangolayout = self.create_pango_layout(child["title"])
-            pangolayout.set_font_description(self.font)
-            child["title_layout"] = pangolayout
-            child["r"] = color.red
-            child["g"] = color.green
-            child["b"] = color.blue
-
-    def append_tab_child(self, title, page, tooltip=""):
-        num = len(self.children) + 1
-        self.tab_width = self.tab_width * len(self.children) / num
-
-        i = 0
-        for i, child in enumerate(self.children):
-            child["x"] = self.tab_x + i * self.tab_width
-            i += 1
-
-        x = self.tab_x + i * self.tab_width
-        y = self.tab_y
-        pangolayout = self.create_pango_layout(title)
-        pangolayout.set_font_description(self.font)
-        color = self.style.base[gtk.STATE_NORMAL]
-        new_one = {
-            "x" : x,
-            "y" : y,
-            "r" : color.red,
-            "g" : color.green,
-            "b" : color.blue,
-            "title_layout" : pangolayout,
-            "toggled_page" : page,
-            "title"        : title,
-            "indicator_show"   : False,
-            "indicator_number" : 0,
-            "tooltip_markup"   : tooltip,
-        }
-        self.children.append(new_one)
-        if tooltip and (not self.props.has_tooltip):
-            self.props.has_tooltip = True
-        # set the default current child
-        if not self.current_child:
-            self.current_child = new_one
-
-    def on_draw(self, widget, event):
-        cr = widget.window.cairo_create()
-
-        self.width = self.allocation.width
-        self.height = self.allocation.height
-
-        self.update_children_size()
-
-        self.draw_background(cr)
-        self.draw_toggled_tab(cr)
-
-        for child in self.children:
-            if child["indicator_show"] == True:
-                self.draw_indicator(cr, child)
-
-        self.draw_tab_text(cr)
-
-    def draw_background(self, cr):
-        style = self.get_style()
-
-        if self.is_focus():
-            cr.set_source_color(style.base[gtk.STATE_SELECTED])
-        else:
-            cr.set_source_color(style.base[gtk.STATE_NORMAL])
-
-        y = 6
-        h = self.height - 6 - 1
-        gap = 1
-
-        w = self.children[0]["x"]
-        cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
-        cr.rectangle(0, y, w - gap, h) # start rectangle
-        cr.fill()
-
-        cr.set_source_color(style.base[gtk.STATE_NORMAL])
-        cr.rectangle(w - gap, y, w, h) #first gap
-        cr.fill()
 
-        w = self.tab_width
-        for child in self.children:
-            x = child["x"]
-            cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
-            cr.rectangle(x, y, w - gap, h) # tab rectangle
-            cr.fill()
-            cr.set_source_color(style.base[gtk.STATE_NORMAL])
-            cr.rectangle(x + w - gap, y, w, h) # gap
-            cr.fill()
-
-        cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
-        cr.rectangle(x + w, y, self.width - x - w, h) # last rectangle
-        cr.fill()
-
-    def draw_tab_text(self, cr):
-        style = self.get_style()
-
-        for child in self.children:
-            pangolayout = child["title_layout"]
-            if pangolayout:
-                fontw, fonth = pangolayout.get_pixel_size()
-                # center pos
-                off_x = (self.tab_width - fontw) / 2
-                off_y = (self.tab_height - fonth) / 2
-                x = child["x"] + off_x
-                y = child["y"] + off_y
-                if not child == self.current_child:
-                    self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout, gtk.gdk.Color(HobColors.WHITE))
-                else:
-                    self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), pangolayout)
-
-    def draw_toggled_tab(self, cr):
-        if not self.current_child:
-            return
-        x = self.current_child["x"]
-        y = self.current_child["y"]
-        width = self.tab_width
-        height = self.tab_height
-        style = self.get_style()
-        color = style.base[gtk.STATE_NORMAL]
-
-        r = height / 10
-        if self.tab_pressed == True:
-            for xoff, yoff, c1, c2 in [(1, 0, HobColors.SLIGHT_DARK, HobColors.DARK), (2, 0, HobColors.GRAY, HobColors.LIGHT_GRAY)]:
-                cr.set_source_color(gtk.gdk.color_parse(c1))
-                cr.move_to(x + xoff, y + height + yoff)
-                cr.line_to(x + xoff, r + yoff)
-                cr.arc(x + r + xoff, y + r + yoff, r, math.pi, 1.5*math.pi)
-                cr.move_to(x + r + xoff, y + yoff)
-                cr.line_to(x + width - r + xoff, y + yoff)
-                cr.arc(x + width - r + xoff, y + r + yoff, r, 1.5*math.pi, 2*math.pi)
-                cr.stroke()
-                cr.set_source_color(gtk.gdk.color_parse(c2))
-                cr.move_to(x + width + xoff, r + yoff)
-                cr.line_to(x + width + xoff, y + height + yoff)
-                cr.line_to(x + xoff, y + height + yoff)
-                cr.stroke()
-            x = x + 2
-            y = y + 2
-        cr.set_source_rgba(color.red, color.green, color.blue, 1)
-        cr.move_to(x + r, y)
-        cr.line_to(x + width - r , y)
-        cr.arc(x + width - r, y + r, r, 1.5*math.pi, 2*math.pi)
-        cr.move_to(x + width, r)
-        cr.line_to(x + width, y + height)
-        cr.line_to(x, y + height)
-        cr.line_to(x, r)
-        cr.arc(x + r, y + r, r, math.pi, 1.5*math.pi)
-        cr.fill()
-
-    def draw_indicator(self, cr, child):
-        text = ("%d" % child["indicator_number"])
-        layout = self.create_pango_layout(text)
-        layout.set_font_description(self.font)
-        textw, texth = layout.get_pixel_size()
-        # draw the back round area
-        tab_x = child["x"]
-        tab_y = child["y"]
-        dest_w = int(32 * self.tab_w_ratio)
-        dest_h = int(32 * self.tab_h_ratio)
-        if dest_h < self.tab_height:
-            dest_w = dest_h
-        # x position is offset(tab_width*3/4 - icon_width/2) + start_pos(tab_x)
-        x = tab_x + self.tab_width * 3/4 - dest_w/2
-        y = tab_y + self.tab_height/2 - dest_h/2
-
-        r = min(dest_w, dest_h)/2
-        if not child == self.current_child:
-            color = cr.set_source_color(gtk.gdk.color_parse(HobColors.DEEP_RED))
-        else:
-            color = cr.set_source_color(gtk.gdk.color_parse(HobColors.GRAY))
-        # check round back area can contain the text or not
-        back_round_can_contain_width = float(2 * r * 0.707)
-        if float(textw) > back_round_can_contain_width:
-            xoff = (textw - int(back_round_can_contain_width)) / 2
-            cr.move_to(x + r - xoff, y + r + r)
-            cr.arc((x + r - xoff), (y + r), r, 0.5*math.pi, 1.5*math.pi)
-            cr.fill() # left half round
-            cr.rectangle((x + r - xoff), y, 2 * xoff, 2 * r)
-            cr.fill() # center rectangle
-            cr.arc((x + r + xoff), (y + r), r, 1.5*math.pi, 0.5*math.pi)
-            cr.fill() # right half round
+        # We want to composite the transparent indicator onto the parent
+        # HBox
+        screen = self.get_screen()
+        rgba = screen.get_rgba_colormap()
+        self.set_colormap(rgba)
+        self.set_app_paintable(True)
+        self.set_size_request(38,38)
+        # We need to pass through button clicks
+        self.add_events(gtk.gdk.BUTTON_PRESS_MASK | gtk.gdk.BUTTON_RELEASE_MASK)
+
+        self.connect('expose-event', self.expose)
+        self.connect_after('realize', self.composite)
+
+        self.count = count
+        self.color = HobColors.GRAY
+
+    def composite(self, widget):
+        # This property must be set after the widget has been realised
+        self.window.set_composited(True)
+
+    def expose(self, widget, event):
+        # Transparent background
+        ctx = widget.window.cairo_create()
+        ctx.set_operator(cairo.OPERATOR_CLEAR)
+        region = gtk.gdk.region_rectangle(event.area)
+
+        ctx.region(region)
+        ctx.fill()
+
+        if self.count and self.count > 0:
+            w = self.allocation.width
+            h = self.allocation.height
+
+            ctx.set_operator(cairo.OPERATOR_OVER)
+            ctx.set_source_color(gtk.gdk.color_parse(self.color))
+            ctx.translate(w/2, h/2)
+            ctx.arc(1, 1, min(w,h)/2 - 2, 0, 2*math.pi)
+            ctx.fill_preserve()
+
+            layout = self.create_pango_layout(str(self.count))
+            textw, texth = layout.get_pixel_size()
+            x = (w/2)-(textw/2) + 1
+            y = (h/2) - (texth/2) + 1
+            ctx.move_to(x, y)
+            self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout)
+
+    def set_count(self, count):
+        self.count = count
+
+    def set_active(self, active):
+        if active:
+            self.color = HobColors.DEEP_RED
         else:
-            cr.arc((x + r), (y + r), r, 0, 2*math.pi)
-            cr.fill()
-        # draw the number text
-        x = x + (dest_w/2)-(textw/2)
-        y = y + (dest_h/2) - (texth/2)
-        cr.move_to(x, y)
-        self.window.draw_layout(self.style.fg_gc[gtk.STATE_NORMAL], int(x), int(y), layout, gtk.gdk.Color(HobColors.WHITE))
-
-    def show_indicator_icon(self, child, number):
-        child["indicator_show"] = True
-        child["indicator_number"] = number
-        self.queue_draw()
-
-    def hide_indicator_icon(self, child):
-        child["indicator_show"] = False
-        self.queue_draw()
-
-    def set_blank_size(self, x, y, w, h):
-        if not self.blank_rectangle or self.blank_rectangle.x != x or self.blank_rectangle.width != w:
-            self.emit("blank-area-changed", x, y, w, h)
-
-        return gtk.gdk.Rectangle(x, y, w, h)
-
-    def query_tooltip_cb(self, widget, x, y, keyboardtip, tooltip):
-        if keyboardtip or (not tooltip):
-            return False
-        # check which tab be clicked
-        for child in self.children:
-           if      (child["x"] < x) and (x < child["x"] + self.tab_width) \
-               and (child["y"] < y) and (y < child["y"] + self.tab_height):
-               tooltip.set_markup(child["tooltip_markup"])
-               return True
+            self.color = HobColors.GRAY
+
+class HobTabLabel(gtk.HBox):
+    def __init__(self, text, count=0):
+        gtk.HBox.__init__(self, False, 0)
+        self.indicator = HobIndicator(count)
+        self.indicator.show()
+        self.pack_end(self.indicator, False, False)
+        self.lbl = gtk.Label(text)
+        self.lbl.set_alignment(0.0, 0.5)
+        self.lbl.show()
+        self.pack_end(self.lbl, True, True, 6)
+        self.connect_after('expose-event', self.expose_event)
+
+    def expose_event(self, widget, event):
+        # Composite the child indicator onto the Box
+        child = self.indicator
+        ctx = widget.window.cairo_create()
+
+        ctx.set_source_pixmap(child.window, child.allocation.x, child.allocation.y)
+
+        region = gtk.gdk.region_rectangle(child.allocation)
+        r = gtk.gdk.region_rectangle(event.area)
+        region.intersect(r)
+        ctx.region(region)
+        ctx.clip()
+
+        ctx.paint()
 
         return False
 
-class HobNotebook(gtk.VBox):
+    def set_count(self, count):
+        self.indicator.set_count(count)
 
-    def __init__(self):
-        gtk.VBox.__init__(self, False, 0)
+    def set_active(self, active=True):
+        self.indicator.set_active(active)
 
-        self.notebook = gtk.Notebook()
-        self.notebook.set_property('homogeneous', True)
-        self.notebook.set_property('show-tabs', False)
+class HobNotebook(gtk.Notebook):
+    def __init__(self):
+        gtk.Notebook.__init__(self)
+        self.set_property('homogeneous', True)
 
-        self.tabbar = HobTabBar()
-        self.tabbar.connect("tab-switched",   self.tab_switched_cb)
-        self.notebook.connect("page-added",   self.page_added_cb)
-        self.notebook.connect("page-removed", self.page_removed_cb)
+        self.pages = []
 
         self.search = None
         self.search_name = ""
 
-        self.tb = gtk.Table(1, 100, False)
-        self.hbox= gtk.HBox(False, 0)
-        self.hbox.pack_start(self.tabbar, True, True)
-        self.tb.attach(self.hbox, 0, 100, 0, 1)
-
-        self.pack_start(self.tb, False, False)
-        self.pack_start(self.notebook)
+        self.connect("switch-page", self.page_changed_cb)
 
         self.show_all()
 
-    def append_page(self, child, tab_label):
-        self.notebook.set_current_page(self.notebook.append_page(child, tab_label))
-
-    def set_entry(self, name="Search:"):
-        for child in self.tb.get_children(): 
-            if child:
-                self.tb.remove(child)
+    def page_changed_cb(self, nb, page, page_num):
+        for p, lbl in enumerate(self.pages):
+            if p == page_num:
+                lbl.set_active()
+            else:
+                lbl.set_active(False)
 
-        hbox_entry = gtk.HBox(False, 0)
-        hbox_entry.show()
+    def append_page(self, child, tab_label, tab_tooltip=None):
+        label = HobTabLabel(tab_label)
+        if tab_tooltip:
+            label.set_tooltip_text(tab_tooltip)
+        label.set_active(False)
+        self.pages.append(label)
+        gtk.Notebook.append_page(self, child, label)
 
+    def set_entry(self, name="Search:"):
         self.search = gtk.Entry()
         self.search_name = name
         style = self.search.get_style()
@@ -747,59 +515,20 @@ class HobNotebook(gtk.VBox):
         self.search.set_icon_from_stock(gtk.ENTRY_ICON_SECONDARY, gtk.STOCK_CLEAR)
         self.search.connect("icon-release", self.set_search_entry_clear_cb)
         self.search.show()
-        self.align = gtk.Alignment(xalign=1.0, yalign=0.7)
-        self.align.add(self.search)
-        self.align.show()
-        hbox_entry.pack_end(self.align, False, False)
-        self.tabbar.resize_blank_rectangle()
 
-        self.tb.attach(hbox_entry, 75, 100, 0, 1, xpadding=5)
-        self.tb.attach(self.hbox, 0, 100, 0, 1)
-
-        self.tabbar.connect("blank-area-changed", self.blank_area_resize_cb)
         self.search.connect("focus-in-event", self.set_search_entry_editable_cb)
         self.search.connect("focus-out-event", self.set_search_entry_reset_cb)
- 
-        self.tb.show()
+        self.set_action_widget(self.search, gtk.PACK_END)
 
     def show_indicator_icon(self, title, number):
-        for child in self.tabbar.children:
-            if child["toggled_page"] == -1:
-                continue
-            if child["title"] == title:
-                self.tabbar.show_indicator_icon(child, number)
+        for child in self.pages:
+            if child.lbl.get_label() == title:
+                child.set_count(number)
 
     def hide_indicator_icon(self, title):
-        for child in self.tabbar.children:
-            if child["toggled_page"] == -1:
-                continue
-            if child["title"] == title:
-                self.tabbar.hide_indicator_icon(child)
-
-    def tab_switched_cb(self, widget, page):
-        self.notebook.set_current_page(page)
-
-    def page_added_cb(self, notebook, notebook_child, page):
-        if not notebook:
-            return
-        title = notebook.get_tab_label_text(notebook_child)
-        label = notebook.get_tab_label(notebook_child)
-        tooltip_markup = label.get_tooltip_markup()
-        if not title:
-            return
-        for child in self.tabbar.children:
-            if child["title"] == title:
-                child["toggled_page"] = page
-                return
-        self.tabbar.append_tab_child(title, page, tooltip_markup)
-
-    def page_removed_cb(self, notebook, notebook_child, page, title=""):
-        for child in self.tabbar.children:
-            if child["title"] == title:
-                child["toggled_page"] = -1
-
-    def blank_area_resize_cb(self, widget, request_x, request_y, request_width, request_height):
-        self.search.set_size_request(request_width, request_height)
+        for child in self.pages:
+            if child.lbl.get_label() == title:
+                child.set_count(0)
 
     def set_search_entry_editable_cb(self, search, event):
         search.set_editable(True)
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 104d49d..9e6f10a 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -120,8 +120,7 @@ class PackageSelectionPage (HobPage):
             if page['name'] == "Included":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            label = gtk.Label(page['name'])
-            self.ins.append_page(tab, label)
+            self.ins.append_page(tab, page['name'])
             self.tables.append(tab)
 
         self.ins.set_entry("Search packages:")
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 6ecc796..fff8a88 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -153,10 +153,7 @@ class RecipeSelectionPage (HobPage):
             if page['name'] == "Included":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
-            label = gtk.Label(page['name'])
-            label.set_selectable(False)
-            label.set_tooltip_text(page['tooltip'])
-            self.ins.append_page(tab, label)
+            self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
         self.ins.set_entry("Search recipes:")
-- 
1.7.7.6



