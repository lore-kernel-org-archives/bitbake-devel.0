Return-Path: <valentin.popa@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id B9C3D610DC
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Sep 2013 11:16:43 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 25 Sep 2013 04:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,978,1371106800"; d="scan'208";a="365327385"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.58])
	by azsmga001.ch.intel.com with ESMTP; 25 Sep 2013 04:16:43 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 Sep 2013 14:18:20 +0300
Message-Id: <1380107900-4395-2-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1380107900-4395-1-git-send-email-valentin.popa@intel.com>
References: <1380107900-4395-1-git-send-email-valentin.popa@intel.com>
Subject: [PATCH 2/2] GUI error dialog for bitbake
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 25 Sep 2013 11:16:43 -0000

When the user starts HOB, he/she expects to see some GUI.
If bitbake signals an erros before HOB starts the error will
be visible only in console and hob script will terminate.
This patch allows bitbake to report errors inside a GUI dialog
when the user wants to use HOB.
WebHOB starts before bitbake's launch and  a common solution
for this problem that applies to both HOB and WebHOB is not so obvious.

Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/show_error_dialog | 62 +++++++++++++++++++++++++++++++++++++
 scripts/hob                         |  9 +++++-
 2 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100755 bitbake/lib/bb/ui/show_error_dialog

diff --git a/bitbake/lib/bb/ui/show_error_dialog b/bitbake/lib/bb/ui/show_error_dialog
new file mode 100755
index 0000000..09d0c5c
--- /dev/null
+++ b/bitbake/lib/bb/ui/show_error_dialog
@@ -0,0 +1,62 @@
+#!/usr/bin/env python
+#
+# BitBake graphical error reporting dialog used by hob script
+#
+# Copyright (C) 2013        Intel Corporation
+#
+# Authored by Valentin Popa <valentin.popa@lintel.com>
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
+import sys
+import os
+requirements = "FATAL: Gtk+ 2.20.0 or higher & PyGtk 2.21.0 or higher is required"
+try:
+    import gtk
+    import pygtk
+    pygtk.require('2.0') # to be certain we don't have gtk+ 1.x !?!
+    gtkver = gtk.gtk_version
+    pygtkver = gtk.pygtk_version
+    if gtkver  < (2, 20, 0) or pygtkver < (2, 21, 0):
+        sys.exit("%s,\nYou have Gtk+ %s and PyGtk %s." % (requirements,
+                ".".join(map(str, gtkver)),
+                ".".join(map(str, pygtkver))))
+except ImportError as exc:
+    sys.exit("%s (%s)." % (requirements, str(exc)))
+
+try:
+    import crumbs
+except RuntimeError as exc:
+    sys.exit(str(exc))
+sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
+
+from crumbs.hig.crumbsmessagedialog import CrumbsMessageDialog
+from crumbs.hobwidget import HobButton
+
+class HobError(gtk.Window):
+
+    def __init__(self, error_log_file):
+        message = open(error_log_file).readlines()
+        label = "<b>Hob found an error</b>"
+        dialog = CrumbsMessageDialog(self, label, gtk.MESSAGE_ERROR, "".join(message))
+        button = dialog.add_button("Close", gtk.RESPONSE_OK)
+        HobButton.style_button(button)
+        button.connect("clicked", lambda w:sys.exit())
+        dialog.run()
+        dialog.destroy()
+
+if __name__ == "__main__":
+    HobError(sys.argv[1])
+
diff --git a/scripts/hob b/scripts/hob
index 8d33ab1..bbb2366 100755
--- a/scripts/hob
+++ b/scripts/hob
@@ -1,6 +1,13 @@
 #!/usr/bin/env bash
 export BB_ENV_EXTRAWHITE="DISABLE_SANITY_CHECKS $BB_ENV_EXTRAWHITE"
-DISABLE_SANITY_CHECKS=1 bitbake -u hob $@
+ERROR_LOG=$BUILDDIR/tmp/log/saved_errors.log
+DISABLE_SANITY_CHECKS=1 bitbake -u hob $@ > $ERROR_LOG
 
 ret=$?
+
+if (( $ret == 1 )); then #there is an error and hob didn't start
+    $BUILDDIR/../bitbake/lib/bb/ui/show_error_dialog $ERROR_LOG
+    rm $ERROR_LOG
+fi
+
 exit $ret
-- 
1.8.1.2


