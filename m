Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bogdan.a.marinescu@intel.com>) id 1THcIp-0001sR-K0
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 17:16:31 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 28 Sep 2012 08:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,502,1344236400"; d="scan'208";a="227786740"
Received: from bogdanm (HELO localhost.localdomain) ([10.237.105.62])
	by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2012 08:03:36 -0700
From: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Sep 2012 18:06:06 +0300
Message-Id: <1348844766-6549-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] [hob] Fix bad merge of #2162
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
X-List-Received-Date: Fri, 28 Sep 2012 15:16:31 -0000

This patch fixes the bad merge of #2162 fixes on master.

Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index bdb3702..791fc01 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -271,7 +271,9 @@ class CrumbsMessageDialog(CrumbsDialog):
 class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
 
     (BUILD_ENV_PAGE_ID,
-     PROXIES_PAGE_ID) = range(2)
+     SHARED_STATE_PAGE_ID,
+     PROXIES_PAGE_ID,
+     OTHERS_PAGE_ID) = range(4)
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
@@ -616,27 +618,9 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.refresh_proxy_components()
         return advanced_vbox
 
-
-    def create_visual_elements(self):
-        self.nb = gtk.Notebook()
-        self.nb.set_show_tabs(True)
-        self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
-        self.nb.append_page(self.create_shared_state_page(), gtk.Label("Shared state"))
-        self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))
-        self.nb.set_current_page(0)
-        self.vbox.pack_start(self.nb, expand=True, fill=True)
-        self.vbox.pack_end(gtk.HSeparator(), expand=True, fill=True)
-
-        self.show_all()
-
     def switch_to_page(self, page_id):
         self.nb.set_current_page(page_id)
 
-#
-# AdvancedSettings Dialog
-#
-class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
-    
     def details_cb(self, button, parent, protocol):
         dialog = ProxyDetailsDialog(title = protocol.upper() + " Proxy Details",
             user = self.configuration.proxies[protocol][1],
@@ -806,6 +790,7 @@ class AdvancedSettingDialog (CrumbsDialog, SettingsUIHelper):
         self.nb = gtk.Notebook()
         self.nb.set_show_tabs(True)        
         self.nb.append_page(self.create_build_environment_page(), gtk.Label("Build environment"))
+        self.nb.append_page(self.create_shared_state_page(), gtk.Label("Shared state"))
         self.nb.append_page(self.create_proxy_page(), gtk.Label("Proxies"))        
         self.nb.append_page(self.create_others_page(), gtk.Label("Others"))
         self.nb.set_current_page(0)
-- 
1.7.9.5



