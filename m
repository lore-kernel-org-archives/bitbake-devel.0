Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 0A2B96CED3
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Oct 2013 10:53:53 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 Oct 2013 03:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1056,1371106800"; d="scan'208";a="415677583"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga002.jf.intel.com with ESMTP; 08 Oct 2013 03:53:52 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Oct 2013 13:58:25 +0300
Message-Id: <1381229905-27676-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Hob should ask for ports only when Manual proxy is selected
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
X-List-Received-Date: Tue, 08 Oct 2013 10:53:55 -0000

[YOCTO #5307]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 .../lib/bb/ui/crumbs/hig/simplesettingsdialog.py   |   26 +++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
index de924b1..4a7cfad 100644
--- a/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
+++ b/bitbake/lib/bb/ui/crumbs/hig/simplesettingsdialog.py
@@ -211,18 +211,20 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
     def response_cb(self, dialog, response_id):
         if response_id == gtk.RESPONSE_YES:
-            # Check that all proxy entries have a corresponding port
-            for proxy, port in zip(self.all_proxy_addresses, self.all_proxy_ports):
-                if proxy.get_text() and not port.get_text():
-                    lbl = "<b>Enter all port numbers</b>\n\n"
-                    msg = "Proxy servers require a port number. Please make sure you have entered a port number for each proxy server."
-                    dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING, msg)
-                    button = dialog.add_button("Close", gtk.RESPONSE_OK)
-                    HobButton.style_button(button)
-                    response = dialog.run()
-                    dialog.destroy()
-                    self.emit_stop_by_name("response")
-                    return
+            if self.proxy_checkbox.get_active():
+                # Check that all proxy entries have a corresponding port 
+                for proxy, port in zip(self.all_proxy_addresses, self.all_proxy_ports):
+                    if proxy.get_text() and not port.get_text():
+                        lbl = "<b>Enter all port numbers</b>\n\n"
+                        msg = "Proxy servers require a port number. Please make sure "
+                        msg += "you have entered a port number for each proxy server."
+                        dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_WARNING, msg)
+                        button = dialog.add_button("Close", gtk.RESPONSE_OK)
+                        HobButton.style_button(button)
+                        response = dialog.run()
+                        dialog.destroy()
+                        self.emit_stop_by_name("response")
+                        return
 
         self.configuration.dldir = self.dldir_text.get_text()
         self.configuration.sstatedir = self.sstatedir_text.get_text()
-- 
1.7.9.5


