Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXck-0000N0-Fr
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:34 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778611"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:29 -0700
Message-Id: <849242571751e9afdbcc0eb548d43a38774e2c20.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 04/10] ui/crumbs/persistenttooltip: fix whitespace
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:34 -0000

We use 4 spaces, not a tab, in BitBake

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |  264 ++++++++++++++++----------------
 1 files changed, 132 insertions(+), 132 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index d065ab2..8ba0043 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -26,135 +26,135 @@ except:
     pass
 
 class PersistentTooltip(gtk.Window):
-	"""
-	A tooltip which persists once shown until the user dismisses it with the Esc
-	key or by clicking the close button.
-
-	# FIXME: the PersistentTooltip should be disabled when the user clicks anywhere off
-	# it. We can't do this with focus-out-event becuase modal ensures we have focus?
-
-	markup: some Pango text markup to display in the tooltip
-	"""
-	def __init__(self, markup):
-		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
-
-		# Inherit the system theme for a tooltip
-		style = gtk.rc_get_style_by_paths(gtk.settings_get_default(),
-						'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
-		self.set_style(style)
-
-		# The placement of the close button on the tip should reflect how the
-		# window manager of the users system places close buttons. Try to read
-		# the metacity gconf key to determine whether the close button is on the
-		# left or the right.
-		# In the case that we can't determine the users configuration we default
-		# to close buttons being on the right.
-		__button_right = True
-		try:
-		    client = gconf.client_get_default()
-		    order = client.get_string("/apps/metacity/general/button_layout")
-		    if order and order.endswith(":"):
-		        __button_right = False
-		except NameError:
-			pass
-
-		# We need to ensure we're only shown once
-		self.shown = False
-
-		# We don't want any WM decorations
-		self.set_decorated(False)
-		# We don't want to show in the taskbar or window switcher
-		self.set_skip_pager_hint(True)
-		self.set_skip_taskbar_hint(True)
-		# We must be modal to ensure we grab focus when presented from a gtk.Dialog
-		self.set_modal(True)
-
-		self.set_border_width(0)
-		self.set_position(gtk.WIN_POS_MOUSE)
-		self.set_opacity(0.95)
-
-		# Draw our label and close buttons
-		hbox = gtk.HBox(False, 0)
-		hbox.show()
-		vbox = gtk.VBox(False, 0)
-		vbox.show()
-		vbox.pack_start(hbox, True, True, 0)
-
-		img = gtk.Image()
-		img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
-
-		self.button = gtk.Button()
-		self.button.set_image(img)
-		self.button.connect("clicked", self._dismiss_cb)
-		self.button.set_can_default(True)
-		self.button.grab_focus()
-		self.button.show()
-		if __button_right:
-		    hbox.pack_end(self.button, False, False, 0)
-		else:
-		    hbox.pack_start(self.button, False, False, 0)
-
-		self.set_default(self.button)
-
-		hbox = gtk.HBox(True, 6)
-		hbox.set_border_width(6)
-		hbox.show()
-		vbox.pack_end(hbox, True, True, 6)
-		self.label = gtk.Label()
-		# We want to match the colours of the normal tooltips, as dictated by
-		# the users gtk+-2.0 theme, wherever possible - on some systems this
-		# requires explicitly setting a fg_color for the label which matches the
-		# tooltip_fg_color
-		settings = gtk.settings_get_default()
-		colours = settings.get_property('gtk-color-scheme').split('\n')
-		# remove any empty lines, there's likely to be a trailing one after
-		# calling split on a dictionary-like string
-		colours = filter(None, colours)
-		for col in colours:
-			item, val = col.split(': ')
-			if item == 'tooltip_fg_color':
-				style = self.label.get_style()
-				style.fg[gtk.STATE_NORMAL] = gtk.gdk.color_parse(val)
-				self.label.set_style(style)
-				break # we only care for the tooltip_fg_color
-		self.label.set_markup(markup)
-		self.label.show()
-		hbox.pack_end(self.label, True, True, 6)
-
-		self.connect("key-press-event", self._catch_esc_cb)
-
-		self.add(vbox)
-
-	"""
-	Callback when the PersistentTooltip's close button is clicked.
-	Hides the PersistentTooltip.
-	"""
-	def _dismiss_cb(self, button):
-		self.hide()
-		return True
-
-	"""
-	Callback when the Esc key is detected. Hides the PersistentTooltip.
-	"""
-	def _catch_esc_cb(self, widget, event):
-		keyname = gtk.gdk.keyval_name(event.keyval)
-		if keyname == "Escape":
-			self.hide()
-		return True
-
-	"""
-	Called to present the PersistentTooltip.
-	Overrides the superclasses show() method to include state tracking.
-	"""
-	def show(self):
-		if not self.shown:
-			self.shown = True
-			gtk.Window.show(self)
-
-	"""
-	Called to hide the PersistentTooltip.
-	Overrides the superclasses hide() method to include state tracking.
-	"""
-	def hide(self):
-		self.shown = False
-		gtk.Window.hide(self)
+    """
+    A tooltip which persists once shown until the user dismisses it with the Esc
+    key or by clicking the close button.
+
+    # FIXME: the PersistentTooltip should be disabled when the user clicks anywhere off
+    # it. We can't do this with focus-out-event becuase modal ensures we have focus?
+
+    markup: some Pango text markup to display in the tooltip
+    """
+    def __init__(self, markup):
+        gtk.Window.__init__(self, gtk.WINDOW_POPUP)
+
+        # Inherit the system theme for a tooltip
+        style = gtk.rc_get_style_by_paths(gtk.settings_get_default(),
+                        'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
+        self.set_style(style)
+
+        # The placement of the close button on the tip should reflect how the
+        # window manager of the users system places close buttons. Try to read
+        # the metacity gconf key to determine whether the close button is on the
+        # left or the right.
+        # In the case that we can't determine the users configuration we default
+        # to close buttons being on the right.
+        __button_right = True
+        try:
+            client = gconf.client_get_default()
+            order = client.get_string("/apps/metacity/general/button_layout")
+            if order and order.endswith(":"):
+                __button_right = False
+        except NameError:
+            pass
+
+        # We need to ensure we're only shown once
+        self.shown = False
+
+        # We don't want any WM decorations
+        self.set_decorated(False)
+        # We don't want to show in the taskbar or window switcher
+        self.set_skip_pager_hint(True)
+        self.set_skip_taskbar_hint(True)
+        # We must be modal to ensure we grab focus when presented from a gtk.Dialog
+        self.set_modal(True)
+
+        self.set_border_width(0)
+        self.set_position(gtk.WIN_POS_MOUSE)
+        self.set_opacity(0.95)
+
+        # Draw our label and close buttons
+        hbox = gtk.HBox(False, 0)
+        hbox.show()
+        vbox = gtk.VBox(False, 0)
+        vbox.show()
+        vbox.pack_start(hbox, True, True, 0)
+
+        img = gtk.Image()
+        img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
+
+        self.button = gtk.Button()
+        self.button.set_image(img)
+        self.button.connect("clicked", self._dismiss_cb)
+        self.button.set_can_default(True)
+        self.button.grab_focus()
+        self.button.show()
+        if __button_right:
+            hbox.pack_end(self.button, False, False, 0)
+        else:
+            hbox.pack_start(self.button, False, False, 0)
+
+        self.set_default(self.button)
+
+        hbox = gtk.HBox(True, 6)
+        hbox.set_border_width(6)
+        hbox.show()
+        vbox.pack_end(hbox, True, True, 6)
+        self.label = gtk.Label()
+        # We want to match the colours of the normal tooltips, as dictated by
+        # the users gtk+-2.0 theme, wherever possible - on some systems this
+        # requires explicitly setting a fg_color for the label which matches the
+        # tooltip_fg_color
+        settings = gtk.settings_get_default()
+        colours = settings.get_property('gtk-color-scheme').split('\n')
+        # remove any empty lines, there's likely to be a trailing one after
+        # calling split on a dictionary-like string
+        colours = filter(None, colours)
+        for col in colours:
+            item, val = col.split(': ')
+            if item == 'tooltip_fg_color':
+                style = self.label.get_style()
+                style.fg[gtk.STATE_NORMAL] = gtk.gdk.color_parse(val)
+                self.label.set_style(style)
+                break # we only care for the tooltip_fg_color
+        self.label.set_markup(markup)
+        self.label.show()
+        hbox.pack_end(self.label, True, True, 6)
+
+        self.connect("key-press-event", self._catch_esc_cb)
+
+        self.add(vbox)
+
+    """
+    Callback when the PersistentTooltip's close button is clicked.
+    Hides the PersistentTooltip.
+    """
+    def _dismiss_cb(self, button):
+        self.hide()
+        return True
+
+    """
+    Callback when the Esc key is detected. Hides the PersistentTooltip.
+    """
+    def _catch_esc_cb(self, widget, event):
+        keyname = gtk.gdk.keyval_name(event.keyval)
+        if keyname == "Escape":
+            self.hide()
+        return True
+
+    """
+    Called to present the PersistentTooltip.
+    Overrides the superclasses show() method to include state tracking.
+    """
+    def show(self):
+        if not self.shown:
+            self.shown = True
+            gtk.Window.show(self)
+
+    """
+    Called to hide the PersistentTooltip.
+    Overrides the superclasses hide() method to include state tracking.
+    """
+    def hide(self):
+        self.shown = False
+        gtk.Window.hide(self)
-- 
1.7.7.6



