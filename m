Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHFC5-0008SR-Uh
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:03:46 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Apr 2012 06:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126875452"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 06:54:30 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:46 +0800
Message-Id: <6009c7f44039e608dce70df84a48616231a65cb9.1333980506.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 16/21] Hob: clean up and reword stop_parse()
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
X-List-Received-Date: Mon, 09 Apr 2012 14:03:46 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |    6 +++---
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index b052d99..afd1d1b 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -387,6 +387,9 @@ class Builder(gtk.Window):
     def generate_configuration_async(self):
         self.handler.generate_configuration()
 
+    def cancel_parse_sync(self):
+        self.handler.cancel_parse()
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -1008,9 +1011,6 @@ class Builder(gtk.Window):
     def show_configuration(self):
         self.switch_page(self.BASEIMG_SELECTED)
 
-    def stop_parse(self):
-        self.handler.cancel_parse()
-
     def stop_build(self):
         if self.stopping:
             lbl = "<b>Force Stop build?</b>\nYou've already selected Stop once,"
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index 204d1c6..c2e0f5f 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -250,7 +250,7 @@ class ImageConfigurationPage (HobPage):
         return button_box
 
     def stop_button_clicked_cb(self, button):
-        self.builder.stop_parse()
+        self.builder.cancel_parse_sync()
 
     def machine_combo_changed_cb(self, machine_combo):
         combo_item = machine_combo.get_active_text()
-- 
1.7.6



