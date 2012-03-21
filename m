Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SA9Lc-0004j3-8i
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 01:24:16 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 20 Mar 2012 17:15:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119778616"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.207])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 17:15:21 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 17:15:17 -0700
Message-Id: <b39b5de38cc17eb5e2970693e70ba4aa2837dcbc.1332288516.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
In-Reply-To: <cover.1332288516.git.josh@linux.intel.com>
References: <cover.1332288516.git.josh@linux.intel.com>
Subject: [PATCH 4/5] ui/crumbs/persistenttooltip: fix colours on darker themes
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
X-List-Received-Date: Wed, 21 Mar 2012 00:24:16 -0000

Darker gtk+ themes, such as the one used in Ubuntu Unity, revealed that the
PersistentTooltip styling wasn't setting the label colour correctly.

Set the label foreground colour to the tooltip_fg_colour value as read from
gtk-color-scheme property of the system settings.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/persistenttooltip.py |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/persistenttooltip.py b/lib/bb/ui/crumbs/persistenttooltip.py
index e9cc380..d065ab2 100644
--- a/lib/bb/ui/crumbs/persistenttooltip.py
+++ b/lib/bb/ui/crumbs/persistenttooltip.py
@@ -38,6 +38,11 @@ class PersistentTooltip(gtk.Window):
 	def __init__(self, markup):
 		gtk.Window.__init__(self, gtk.WINDOW_POPUP)
 
+		# Inherit the system theme for a tooltip
+		style = gtk.rc_get_style_by_paths(gtk.settings_get_default(),
+						'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
+		self.set_style(style)
+
 		# The placement of the close button on the tip should reflect how the
 		# window manager of the users system places close buttons. Try to read
 		# the metacity gconf key to determine whether the close button is on the
@@ -96,17 +101,28 @@ class PersistentTooltip(gtk.Window):
 		hbox.show()
 		vbox.pack_end(hbox, True, True, 6)
 		self.label = gtk.Label()
+		# We want to match the colours of the normal tooltips, as dictated by
+		# the users gtk+-2.0 theme, wherever possible - on some systems this
+		# requires explicitly setting a fg_color for the label which matches the
+		# tooltip_fg_color
+		settings = gtk.settings_get_default()
+		colours = settings.get_property('gtk-color-scheme').split('\n')
+		# remove any empty lines, there's likely to be a trailing one after
+		# calling split on a dictionary-like string
+		colours = filter(None, colours)
+		for col in colours:
+			item, val = col.split(': ')
+			if item == 'tooltip_fg_color':
+				style = self.label.get_style()
+				style.fg[gtk.STATE_NORMAL] = gtk.gdk.color_parse(val)
+				self.label.set_style(style)
+				break # we only care for the tooltip_fg_color
 		self.label.set_markup(markup)
 		self.label.show()
 		hbox.pack_end(self.label, True, True, 6)
 
 		self.connect("key-press-event", self._catch_esc_cb)
 
-		# Inherit the system theme for a tooltip
-		style = gtk.rc_get_style_by_paths(gtk.settings_get_default(),
-			'gtk-tooltip', 'gtk-tooltip', gobject.TYPE_NONE)
-		self.set_style(style)
-
 		self.add(vbox)
 
 	"""
-- 
1.7.7.6



