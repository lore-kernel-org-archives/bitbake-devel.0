Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qx85t-0005Lx-LT
	for bitbake-devel@lists.openembedded.org;
	Sat, 27 Aug 2011 03:53:57 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 26 Aug 2011 18:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,288,1312182000"; d="scan'208";a="45524224"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.247])
	by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2011 18:49:06 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Aug 2011 18:48:59 -0700
Message-Id: <419b52e832f506504778d4d5957d1e77477bb513.1314409608.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1314409608.git.josh@linux.intel.com>
References: <cover.1314409608.git.josh@linux.intel.com>
In-Reply-To: <cover.1314409608.git.josh@linux.intel.com>
References: <cover.1314409608.git.josh@linux.intel.com>
Subject: [PATCH 2/2] ui/crumbs/runningbuild: add a 'Copy' item to the messages right-click menu
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
X-List-Received-Date: Sat, 27 Aug 2011 01:53:57 -0000

Add another item to the right-click menu enabled for log messages to copy
the message to the clipboard.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/runningbuild.py |   36 +++++++++++++++++++++++++++---------
 1 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index d9e9f26..97d1ebd 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -306,31 +306,49 @@ class RunningBuildTreeView (gtk.TreeView):
 
         if event.button == 3:
             selection = super(RunningBuildTreeView, self).get_selection()
-            (model, iter) = selection.get_selected()
-            if iter is not None:
-                can_paste = model.get(iter, model.COL_LOG)[0]
+            (model, it) = selection.get_selected()
+            if it is not None:
+                can_paste = model.get(it, model.COL_LOG)[0]
                 if can_paste == 'pastebin':
                     # build a simple menu with a pastebin option
                     menu = gtk.Menu()
+                    menuitem = gtk.MenuItem("Copy")
+                    menu.append(menuitem)
+                    menuitem.connect("activate", self.copy_handler, (model, it))
+                    menuitem.show()
                     menuitem = gtk.MenuItem("Send log to pastebin")
                     menu.append(menuitem)
-                    menuitem.connect("activate", self.pastebin_handler, (model, iter))
+                    menuitem.connect("activate", self.pastebin_handler, (model, it))
                     menuitem.show()
                     menu.show()
                     menu.popup(None, None, None, event.button, event.time)
 
+    def _add_to_clipboard(self, clipping):
+        """
+        Add the contents of clipping to the system clipboard.
+        """
+        clipboard = gtk.clipboard_get()
+        clipboard.set_text(clipping)
+        clipboard.store()
+
     def pastebin_handler(self, widget, data):
         """
         Send the log data to pastebin, then add the new paste url to the
         clipboard.
         """
-        (model, iter) = data
-        paste_url = do_pastebin(model.get(iter, model.COL_MESSAGE)[0])
+        (model, it) = data
+        paste_url = do_pastebin(model.get(it, model.COL_MESSAGE)[0])
 
         # @todo Provide visual feedback to the user that it is done and that
         # it worked.
         print paste_url
 
-        clipboard = gtk.clipboard_get()
-        clipboard.set_text(paste_url)
-        clipboard.store()
+        self._add_to_clipboard(paste_url)
+
+    def clipboard_handler(self, widget, data):
+        """
+        """
+        (model, it) = data
+        message = model.get(it, model.COL_MESSAGE)[0]
+
+        self._add_to_clipboard(message)
-- 
1.7.6



