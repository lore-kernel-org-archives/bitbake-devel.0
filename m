Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristian.iorga@intel.com>) id 1TRgNB-00032z-45
	for bitbake-devel@lists.openembedded.org;
	Fri, 26 Oct 2012 11:38:37 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 26 Oct 2012 02:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,653,1344236400"; d="scan'208";a="238699000"
Received: from sentry (HELO localhost.localdomain) ([10.237.105.37])
	by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2012 02:25:05 -0700
From: Cristian Iorga <cristian.iorga@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Oct 2012 12:24:19 +0300
Message-Id: <1351243459-12926-1-git-send-email-cristian.iorga@intel.com>
X-Mailer: git-send-email 1.7.10.4
Subject: [PATCH] hob/hig: Hob doesn't save properly proxy settings
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
X-List-Received-Date: Fri, 26 Oct 2012 09:38:37 -0000

User introduced proxy settings were not saved
when a proxy details input dialog was opened.
The proxy settings were lost upon return, and
restored from the previously stored one.

Also:
Code cleanup:
details_cb() function duplicate definition
removed

Fixes [YOCTO #3240]

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4f4fecb..f96fa4d 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -381,22 +381,6 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
             data += (key + ": " + self._get_sorted_value(self.configuration.extra_setting[key]))
         return hashlib.md5(data).hexdigest()
 
-    def details_cb(self, button, parent, protocol):
-        dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
-            user = self.configuration.proxies[protocol][1],
-            passwd = self.configuration.proxies[protocol][2],
-            parent = parent,
-            flags = gtk.DIALOG_MODAL
-                    | gtk.DIALOG_DESTROY_WITH_PARENT
-                    | gtk.DIALOG_NO_SEPARATOR)
-        dialog.add_button(gtk.STOCK_CLOSE, gtk.RESPONSE_OK)
-        response = dialog.run()
-        if response == gtk.RESPONSE_OK:
-            self.configuration.proxies[protocol][1] = dialog.user
-            self.configuration.proxies[protocol][2] = dialog.passwd
-            self.refresh_proxy_components()
-        dialog.destroy()
-
     def gen_proxy_entry_widget(self, protocol, parent, need_button=True, line=0):
         label = gtk.Label(protocol.upper() + " proxy")
         self.proxy_table.attach(label, 0, 1, line, line+1, xpadding=24)
@@ -826,6 +810,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.nb.set_current_page(page_id)
 
     def details_cb(self, button, parent, protocol):
+        self.save_proxy_data()
         dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
             user = self.configuration.proxies[protocol][1],
             passwd = self.configuration.proxies[protocol][2],
-- 
1.7.10.4



