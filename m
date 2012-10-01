Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TIcDl-0007r2-VK
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Oct 2012 11:23:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Oct 2012 02:10:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,514,1344236400"; d="scan'208";a="200118946"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga001.jf.intel.com with ESMTP; 01 Oct 2012 02:10:26 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Oct 2012 12:11:29 +0300
Message-Id: <1349082689-7807-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/settings: Change the 'Delete' button behaviour in the shared state settings tab
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
X-List-Received-Date: Mon, 01 Oct 2012 09:23:26 -0000

-the tab shows an empty mirror row when no mirror is configured
-able to delete the mirror row even if it's not empty(if it's not
the first mirror)

[YOCTO #3189]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 2ef8e36..dc7dce3 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -159,7 +159,7 @@ class SettingsUIHelper():
 
         delete_button = HobAltButton("Delete")
         delete_button.connect("clicked", self.delete_cb, index, entry)
-        if content == "":
+        if content == "" and index == 0  and len(self.sstatemirrors_list) == 1:
             delete_button.set_sensitive(False)
 
         entry_match.connect("changed", self.insert_entry_match_cb, index)
@@ -188,7 +188,7 @@ class SettingsUIHelper():
 
     def insert_entry_cb(self, entry, index, button):
         self.sstatemirrors_list[index][1] = entry.get_text()
-        if entry.get_text() == "":
+        if entry.get_text() == "" and index == 0:
             button.set_sensitive(False)
         else:
             button.set_sensitive(True)
@@ -196,6 +196,7 @@ class SettingsUIHelper():
     def on_combo_changed(self, combo, index):
         if combo.get_active_text() == "Standard":
             self.sstatemirrors_list[index][0] = 0
+            self.sstatemirrors_list[index][2] = "file://(.*)"
         else:
             self.sstatemirrors_list[index][0] = 1
         self.refresh_shared_state_page()
@@ -450,7 +451,7 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         self.configuration.sstatedir = self.sstatedir_text.get_text()
         self.configuration.sstatemirror = ""
         for mirror in self.sstatemirrors_list:
-            if mirror[1] != "" or len(self.sstatemirrors_list)==1:
+            if mirror[1] != "":
                 if mirror[1].endswith("\\1"):
                     smirror = mirror[2] + " " + mirror[1] + " \\n "
                 else:
@@ -548,20 +549,24 @@ class SimpleSettingsDialog (CrumbsDialog, SettingsUIHelper):
         if self.sstatemirrors_changed == 0:
             self.sstatemirrors_changed = 1
             sstatemirrors = self.configuration.sstatemirror
-            while sstatemirrors.find(searched_string) != -1:
-                if sstatemirrors.find(searched_string,1) != -1:
-                    sstatemirror = sstatemirrors[:sstatemirrors.find(searched_string,1)]
-                    sstatemirrors = sstatemirrors[sstatemirrors.find(searched_string,1):]
-                else:
-                    sstatemirror = sstatemirrors
-                    sstatemirrors = sstatemirrors[1:]
-
-                sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
-                if sstatemirror_fields[0] == "file://(.*)":
-                    sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
-                else:
-                    sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
+            if sstatemirrors == "":
+                sm_list = [ 0, "", "file://(.*)"]
                 self.sstatemirrors_list.append(sm_list)
+            else:
+                while sstatemirrors.find(searched_string) != -1:
+                    if sstatemirrors.find(searched_string,1) != -1:
+                        sstatemirror = sstatemirrors[:sstatemirrors.find(searched_string,1)]
+                        sstatemirrors = sstatemirrors[sstatemirrors.find(searched_string,1):]
+                    else:
+                        sstatemirror = sstatemirrors
+                        sstatemirrors = sstatemirrors[1:]
+
+                    sstatemirror_fields = [x for x in sstatemirror.split(' ') if x.strip()]
+                    if sstatemirror_fields[0] == "file://(.*)":
+                        sm_list = [ 0, sstatemirror_fields[1], "file://(.*)"]
+                    else:
+                        sm_list = [ 1, sstatemirror_fields[1], sstatemirror_fields[0]]
+                    self.sstatemirrors_list.append(sm_list)
 
         index = 0
         for mirror in self.sstatemirrors_list:
-- 
1.7.9.5



