Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 575DE6ABBB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Jul 2013 08:07:59 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 01 Jul 2013 01:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,972,1363158000"; d="scan'208";a="338231999"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 01 Jul 2013 01:07:59 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Jul 2013 11:09:52 +0300
Message-Id: <1372666192-31059-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: save button from settings called a nonexisting method
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 01 Jul 2013 08:08:00 -0000

The method was removed when the process for saving configuration
in Hob was changed. Replace the call with the right function.

[YOCTO #4793]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    6 +++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index d5df60f..8571014 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -191,7 +191,7 @@ class Configuration:
         self.split_proxy("socks", params["socks_proxy"])
         self.split_proxy("cvs", params["cvs_proxy_host"] + ":" + params["cvs_proxy_port"])
 
-    def save(self, handler, template, defaults=False):
+    def save(self, handler, defaults=False):
         # bblayers.conf
         handler.set_var_in_file("BBLAYERS", self.layers, "bblayers.conf")
         # local.conf
@@ -1229,7 +1229,7 @@ class Builder(gtk.Window):
         settings_changed = False
         if response == gtk.RESPONSE_YES:
             self.configuration = dialog.configuration
-            self.save_defaults() # remember settings
+            self.configuration.save(self.handler, True) # remember settings
             settings_changed = dialog.settings_changed
         dialog.destroy()
         return response == gtk.RESPONSE_YES, settings_changed
@@ -1257,7 +1257,7 @@ class Builder(gtk.Window):
         settings_changed = False
         if response == gtk.RESPONSE_YES:
             self.configuration = dialog.configuration
-            self.save_defaults() # remember settings
+            self.configuration.save(self.handler, True) # remember settings
             settings_changed = dialog.settings_changed
             if dialog.proxy_settings_changed:
                 self.set_user_config_proxies()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 1b9596f..8788083 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -146,7 +146,9 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_MATCH_CLASS:
             self.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
         elif next_command == self.SUB_PARSE_CONFIG:
+            self.runCommand(["enableDataTracking"])
             self.runCommand(["parseConfigurationFiles", "conf/.hob.conf", ""])
+            self.runCommand(["disableDataTracking"])
         elif next_command == self.SUB_GNERATE_TGTS:
             self.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.SUB_GENERATE_PKGINFO:
-- 
1.7.9.5


