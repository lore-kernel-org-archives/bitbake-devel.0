Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1THcLU-0001v5-IZ
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 17:19:16 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 Sep 2012 08:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,502,1344236400"; d="scan'208";a="228163628"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.37])
	by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2012 08:06:21 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Sep 2012 18:05:53 +0300
Message-Id: <1348844753-7604-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Error reports are done in a clearer way
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
X-List-Received-Date: Fri, 28 Sep 2012 15:19:17 -0000

For long errors (bigger than 200 letters),
the text box is scrollable and resizable
and text is selectable.

Additionaly, all message dialogs are modal.
Otherwise, a user could still interact with hob
even in an error case, leading to potential problems.

See design details in related bugs.

Fixes [YOCTO #2960], [YOCTO #2983]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    5 ++-
 bitbake/lib/bb/ui/crumbs/hig.py     |   59 ++++++++++++++++++++++++++---------
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e952aa8..fd555b0 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -849,9 +849,8 @@ class Builder(gtk.Window):
                 self.generate_image_async(True)
 
     def show_error_dialog(self, msg):
-        lbl = "<b>Error</b>\n"
-        lbl = lbl + "%s\n\n" % glib.markup_escape_text(msg)
-        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        lbl = "<b>Hob found an error</b>\n"
+        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_ERROR, msg)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
         HobButton.style_button(button)
         response = dialog.run()
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index bdb3702..3c8c1c9 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -21,6 +21,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import glob
+import glib
 import gtk
 import gobject
 import hashlib
@@ -236,18 +237,18 @@ class CrumbsMessageDialog(CrumbsDialog):
     A GNOME HIG compliant dialog widget.
     Add buttons with gtk.Dialog.add_button or gtk.Dialog.add_buttons
     """
-    def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO):
-        super(CrumbsMessageDialog, self).__init__("", parent, gtk.DIALOG_DESTROY_WITH_PARENT)
+    def __init__(self, parent=None, label="", icon=gtk.STOCK_INFO, msg=""):
+        super(CrumbsMessageDialog, self).__init__("", parent, gtk.DIALOG_MODAL)
 
         self.set_border_width(6)
         self.vbox.set_property("spacing", 12)
         self.action_area.set_property("spacing", 12)
         self.action_area.set_property("border-width", 6)
 
-        first_row = gtk.HBox(spacing=12)
-        first_row.set_property("border-width", 6)
-        first_row.show()
-        self.vbox.add(first_row)
+        first_column = gtk.HBox(spacing=12)
+        first_column.set_property("border-width", 6)
+        first_column.show()
+        self.vbox.add(first_column)
 
         self.icon = gtk.Image()
         # We have our own Info icon which should be used in preference of the stock icon
@@ -255,15 +256,43 @@ class CrumbsMessageDialog(CrumbsDialog):
         self.icon.set_from_stock(self.icon_chk.check_stock_icon(icon), gtk.ICON_SIZE_DIALOG)
         self.icon.set_property("yalign", 0.00)
         self.icon.show()
-        first_row.add(self.icon)
-
-        self.label = gtk.Label()
-        self.label.set_use_markup(True)
-        self.label.set_line_wrap(True)
-        self.label.set_markup(label)
-        self.label.set_property("yalign", 0.00)
-        self.label.show()
-        first_row.add(self.label)
+        first_column.pack_start(self.icon, expand=False, fill=True, padding=0)
+        
+        if 0 <= len(msg) < 200:
+            lbl = label + "%s" % glib.markup_escape_text(msg)
+            self.label_short = gtk.Label()
+            self.label_short.set_use_markup(True)
+            self.label_short.set_line_wrap(True)
+            self.label_short.set_markup(lbl)
+            self.label_short.set_property("yalign", 0.00)
+            self.label_short.show()
+            first_column.add(self.label_short)
+        else:
+            second_row = gtk.VBox(spacing=12)
+            second_row.set_property("border-width", 6)
+            self.label_long = gtk.Label()
+            self.label_long.set_use_markup(True)
+            self.label_long.set_line_wrap(True)
+            self.label_long.set_markup(label)
+            self.label_long.set_alignment(0.0, 0.0)
+            second_row.pack_start(self.label_long, expand=False, fill=False, padding=0)
+            self.label_long.show()
+            self.textWindow = gtk.ScrolledWindow()
+            self.textWindow.set_shadow_type(gtk.SHADOW_IN)
+            self.msgView = gtk.TextView()
+            self.msgView.set_editable(False)
+            self.msgView.set_wrap_mode(gtk.WRAP_WORD)
+            self.msgView.set_cursor_visible(False)
+            self.msgView.set_size_request(300, 300)
+            self.buf = gtk.TextBuffer()
+            self.buf.set_text(msg)
+            self.msgView.set_buffer(self.buf)
+            self.textWindow.add(self.msgView)
+            self.msgView.show()
+            second_row.add(self.textWindow)
+            self.textWindow.show()
+            first_column.add(second_row)
+            second_row.show()
 
 #
 # SimpleSettings Dialog
-- 
1.7.9.5



