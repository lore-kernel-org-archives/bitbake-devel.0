Return-Path: <marius.avram@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E51DD6B25F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 13:03:33 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 25 Mar 2014 06:03:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,728,1389772800"; d="scan'208";a="479530131"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by orsmga001.jf.intel.com with ESMTP; 25 Mar 2014 06:02:34 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 15:02:35 +0200
Message-Id: <1395752555-24073-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 2/2] hob: fix set_extra_setting function
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
X-List-Received-Date: Tue, 25 Mar 2014 13:03:38 -0000

The function is used to save additional variables in the configuration file
when the user adds a new (key, value) pair from the Settings->Others. There
was a problem though when the function was trying to retrieve an older
instance of EXTRA_SETTINGS from the configuration file. Sometimes its value
was returned as a dictionary and sometimes a string, which caused a crash when
calling ast.literal_eval(). The reason of the problem must be a change in
bitbake's parsing system. The changes will fix this issues.

While analysing this problem I discovered that the variables were not saved
properly in the configuration file after consecutive changes to Settings->Others
because of the way saveConfigurationVar() from cooker.py works. This patch
will also solve this issue.

[YOCTO #5989]

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   30 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 73d5f98..890e05f 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -359,20 +359,32 @@ class HobHandler(gobject.GObject):
         self.set_var_in_file("EXTRA_SETTING", extra_setting, "local.conf")
 
     def set_extra_config(self, extra_setting):
-        old_extra_setting = ast.literal_eval(self.runCommand(["getVariable", "EXTRA_SETTING"]) or "{}")
-        if extra_setting:
-            self.set_var_in_file("EXTRA_SETTING", extra_setting, "local.conf")
-        else:
-            self.remove_var_from_file("EXTRA_SETTING")
+        old_extra_setting = self.runCommand(["getVariable", "EXTRA_SETTING"]) or {}
+        old_extra_setting = str(old_extra_setting)
+
+        old_extra_setting = ast.literal_eval(old_extra_setting)
+        if not type(old_extra_setting) == dict:
+            old_extra_setting = {}
+
+        # settings not changed
+        if old_extra_setting == extra_setting:
+            return
 
-        #remove not needed settings from conf
-        for key in old_extra_setting:
+        # remove the old EXTRA SETTING variable
+        self.remove_var_from_file("EXTRA_SETTING")
+
+        # remove old settings from conf
+        for key in old_extra_setting.keys():
             if key not in extra_setting:
                 self.remove_var_from_file(key)
-        for key in extra_setting.keys():
-            value = extra_setting[key]
+
+        # add new settings
+        for key, value in extra_setting.iteritems():
             self.set_var_in_file(key, value, "local.conf")
 
+        if extra_setting:
+            self.set_var_in_file("EXTRA_SETTING", extra_setting, "local.conf")
+
     def set_http_proxy(self, http_proxy):
         self.set_var_in_file("http_proxy", http_proxy, "local.conf")
 
-- 
1.7.9.5


