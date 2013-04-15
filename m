Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1URh4W-0004GJ-8L
	for bitbake-devel@lists.openembedded.org;
	Mon, 15 Apr 2013 12:55:49 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 15 Apr 2013 03:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,474,1363158000"; d="scan'208";a="286240211"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.147])
	by azsmga001.ch.intel.com with ESMTP; 15 Apr 2013 03:37:42 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Apr 2013 13:38:15 +0300
Message-Id: <1366022295-4744-4-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1366022295-4744-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 3/3] hoberror.py : new class in handling hob errors
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
X-List-Received-Date: Mon, 15 Apr 2013 10:55:51 -0000

When an error is present in starting hob, it is
displayed in an dialog, forcing you to close hob.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig/hoberror.py |   87 ++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 bitbake/lib/bb/ui/crumbs/hig/hoberror.py

diff --git a/bitbake/lib/bb/ui/crumbs/hig/hoberror.py b/bitbake/lib/bb/ui/crumbs/hig/hoberror.py
new file mode 100644
index 0000000..b15f9e5
--- /dev/null
+++ b/bitbake/lib/bb/ui/crumbs/hig/hoberror.py
@@ -0,0 +1,87 @@
+#
+# BitBake Graphical GTK User Interface
+#
+# Copyright (C) 2011-2013   Intel Corporation
+#
+# Authored by Andrei Dinu <andrei.adrianx.dinu@intel.com>
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
+import pygtk
+import gtk
+import sys
+import os
+from bb.ui.crumbs.hig.crumbsdialog import CrumbsDialog
+from bb.ui.crumbs.hig.settingsuihelper import SettingsUIHelper
+from bb.ui.crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
+from bb.ui.crumbs.hig.layerselectiondialog import LayerSelectionDialog
+
+class HobError():
+
+    def __init__(self,message):
+
+        self.message = message
+
+        self.create_visual_elements()
+
+    def run(self):
+        
+        self.dialog.run()
+
+    def create_visual_elements(self):
+
+        icon_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), ("icons/"))
+        icon_file = os.path.join(icon_dir, ('indicators/denied.png'))
+
+        self.dialog = gtk.Dialog("Hob - Image creator",
+                   None,
+                   gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT)
+
+        self.dialog.set_size_request(600,400)       
+        self.dialog.set_resizable(True)
+
+        table = gtk.Table(3,1,False)
+        table.set_row_spacings(0)
+        table.set_col_spacings(0)
+
+        image = gtk.Image()
+        image.set_from_file(icon_file)
+        image.set_property("xalign",0)
+
+        label_short = gtk.Label()
+        label_short.set_line_wrap(False)
+        label_short.set_markup("<span size='19000'>" + 'Hob found an error' + "</span>")
+        label_short.set_property("xalign", 0)
+
+        info_label = gtk.Label()
+        info_label.set_line_wrap(True)
+        info_label.set_selectable(True)
+        info_label.set_markup(self.message)
+        info_label.set_property("xalign",0)
+                
+        close_button = gtk.Button("Close Hob")
+        close_button.connect("clicked", lambda w:sys.exit())
+      
+        table.attach(image, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.EXPAND,xpadding=20,ypadding=20)
+        table.attach(label_short, 0,1,0,1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.SHRINK,xpadding=80,ypadding=20)
+        table.attach(info_label, 0,1,1,2, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.EXPAND,xpadding=80,ypadding=0)
+
+        alignment = gtk.Alignment()
+        alignment.add(close_button)
+        table.attach(alignment, 0,1,2,3, xoptions=gtk.EXPAND|gtk.FILL, yoptions=gtk.EXPAND,xpadding=75,ypadding=30)
+        
+        self.dialog.vbox.pack_start(table, expand=False, fill=False)
+        self.dialog.vbox.show_all()
+   
+        self.dialog.connect("delete-event", gtk.main_quit) 
-- 
1.7.9.5



