Return-Path: <cristiana.voicu@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B6C466DF55
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Dec 2013 12:17:04 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 06 Dec 2013 04:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,840,1378882800"; d="scan'208";a="420431706"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga001.jf.intel.com with ESMTP; 06 Dec 2013 04:16:58 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Dec 2013 14:23:04 +0200
Message-Id: <1386332584-12164-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: after adding a layer, hob do not parse the configuration
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
X-List-Received-Date: Fri, 06 Dec 2013 12:17:06 -0000

Moved the parseConfiguration method before obtaining the machines and
other configurations from bitbake. If not, Hob doesn't see the new machines
added by the new layer.

[YOCTO #5632]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e0fc0d1..1eae814 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -528,9 +528,9 @@ class Builder(gtk.Window):
         self.generate_configuration()
 
     def update_config_async(self):
-        self.switch_page(self.MACHINE_SELECTION)
         self.set_user_config()
         self.generate_configuration()
+        self.switch_page(self.MACHINE_SELECTION)
 
     def sanity_check(self):
         self.handler.trigger_sanity_check()
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7014935..b12f2d8 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -403,12 +403,12 @@ class HobHandler(gobject.GObject):
 
     def generate_configuration(self):
         self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_PATH_LAYERS)
         self.commands_async.append(self.SUB_FILES_DISTRO)
         self.commands_async.append(self.SUB_FILES_MACH)
         self.commands_async.append(self.SUB_FILES_SDKMACH)
         self.commands_async.append(self.SUB_MATCH_CLASS)
-        self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.run_next_command(self.GENERATE_CONFIGURATION)
 
     def generate_recipes(self):
-- 
1.7.9.5


