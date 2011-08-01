Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG6-0001pg-A9
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:34 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344105"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:46 -0700
Message-Id: <04dbd80bbc9ffe2a566b8cc488f0feebadcdde60.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 4/8] ui/hob: show error and exit if we receive the fatal-error signal
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:34 -0000

If we receive the fatal-error signal from the handler display a dialog
informing the user of an error and displaying the error message. Dismissing
the dialog quits the application.

Fixes [YOCTO #1279]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 750ab28..919c06e 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -115,6 +115,21 @@ class MainWindow (gtk.Window):
         self.set_busy_cursor(False)
 
         gtk.main_quit()
+
+    """
+    In the case of a fatal error give the user as much information as possible
+    and then exit.
+    """
+    def fatal_error_cb(self, handler, errormsg, phase):
+        lbl = "<b>Error!</b>\nThere was an unrecoverable error during the"
+        lbl = lbl + " <i>%s</i> phase of BitBake. This must be" % phase
+        lbl = lbl + " rectified before the GUI will function. The error"
+        lbl = lbl + " message which which caused this is:\n\n\"%s\"" % errormsg
+        dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_ERROR)
+        dialog.add_button("Exit", gtk.RESPONSE_OK)
+        response = dialog.run()
+        dialog.destroy()
+        self.set_busy_cursor(False)
         gtk.main_quit()
 
     def scroll_tv_cb(self, model, path, it, view):
@@ -963,6 +978,7 @@ def main (server, eventHandler):
     configurator.connect("layers-loaded", layers.load_current_layers)
     configurator.connect("layers-changed", handler.reload_data)
     handler.connect("config-found", configurator.configFound)
+    handler.connect("fatal-error", window.fatal_error_cb)
 
     try:
         # kick the while thing off
-- 
1.7.6



