Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8h-00064Q-2t
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:47:59 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997893"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:25 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:17 -0800
Message-Id: <8bd3c205e17913dd3fe85e95d9ef2f28a01f123e.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
Subject: [PATCH 1/6] crumbs/persistenttooltip: a new Gtk+ widget for use in Hob
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
X-List-Received-Date: Sat, 03 Mar 2012 00:47:59 -0000

The Hob interaction design calls for a top level widget which shows a
persistent tooltip. This tooltip will not disappear until the user
explicitly closes it.

This allows us to provide clickable hyperlinks, longer instructions and
deeper information in the tooltips.

Note: by design the tooltip should dismiss when the user clicks off it,
this implementation does include that functionality. It's a to do item.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |  127 +++++++++++++++++++++++++++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/persistenttooltip.py

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
new file mode 100644
index 0000000..f3f55b1
--- /dev/null
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -0,0 +1,127 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2012   Intel Corporation
+#
+# Authored by Joshua Lock <josh@linux.intel.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import gobject
+import gtk
+
+class PersistentTooltip(gtk.Window):
+	"""
+	A tooltip which persists once shown until the user dismisses it with the Esc
+	key or by clicking the close button.
+
+	# FIXME: the PersistentTooltip should be disabled when the user clicks anywhere off
+	# it. We can't do this with focus-out-event becuase modal ensures we have focus?
+
+	markup: some Pango text markup to display in the tooltip
+	"""
+	def __init__(self, markup):
+		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
+
+		# We need to ensure we're only shown once
+		self.shown = False
+
+		# We don't want any WM decorations
+		self.set_decorated(False)
+		# We don't want to show in the taskbar or window switcher
+		self.set_skip_pager_hint(True)
+		self.set_skip_taskbar_hint(True)
+		# We must be modal to ensure we grab focus when presented from a gtk.Dialog
+		self.set_modal(True)
+
+		self.set_border_width(6)
+		self.set_position(gtk.WIN_POS_MOUSE)
+		self.set_opacity(0.95)
+
+		# Draw our label and close buttons
+		hbox = gtk.HBox(False, 0)
+		hbox.show()
+		vbox = gtk.VBox(False, 0)
+		vbox.show()
+		vbox.pack_start(hbox, True, True, 0)
+
+		img = gtk.Image()
+		img.set_from_stock(gtk.STOCK_CLOSE, gtk.ICON_SIZE_BUTTON)
+
+		self.button = gtk.Button()
+		self.button.set_image(img)
+		self.button.connect("clicked", self._dismiss_cb)
+		self.button.set_can_default(True)
+		self.button.grab_focus()
+		self.button.show()
+		hbox.pack_end(self.button, False, False, 0)
+
+		self.set_default(self.button)
+
+		self.label = gtk.Label()
+		self.label.set_markup(markup)
+		self.label.show()
+		vbox.pack_end(self.label, True, True, 6)
+
+		self.connect("key-press-event", self._catch_esc_cb)
+
+		# Inherit the system theme for a tooltip
+		style = gtk.rc_get_style_by_paths(gtk.settings_get_default(),
+			'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
+		self.set_style(style)
+
+		self.add(vbox)
+
+	"""
+	Modify the displayed message once the PersistentTooltip has been created.
+
+	markup: the Pango Markup of the new message
+	"""
+	def set_tooltip(self, markup):
+		self.label.set_markup(markup)
+
+
+	"""
+	Callback when the PersistentTooltip's close button is clicked.
+	Hides the PersistentTooltip.
+	"""
+	def _dismiss_cb(self, button):
+		self.hide()
+		return True
+
+	"""
+	Callback when the Esc key is detected. Hides the PersistentTooltip.
+	"""
+	def _catch_esc_cb(self, widget, event):
+		keyname = gtk.gdk.keyval_name(event.keyval)
+		if keyname == "Escape":
+			self.hide()
+		return True
+
+	"""
+	Called to present the PersistentTooltip.
+	Overrides the superclasses show() method to include state tracking.
+	"""
+	def show(self):
+		if not self.shown:
+			self.shown = True
+			gtk.Window.show(self)
+
+	"""
+	Called to hide the PersistentTooltip.
+	Overrides the superclasses hide() method to include state tracking.
+	"""
+	def hide(self):
+		self.shown = False
+		gtk.Window.hide(self)
-- 
1.7.7.6



