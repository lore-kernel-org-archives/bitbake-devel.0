Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C0EB46D8FE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2013 16:06:54 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 12 Nov 2013 08:03:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="407526842"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by orsmga001.jf.intel.com with ESMTP; 12 Nov 2013 08:06:54 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Nov 2013 18:12:17 +0200
Message-Id: <1384272737-3299-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] cooker: replace "w" file opening mode with "a" mode
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
X-List-Received-Date: Tue, 12 Nov 2013 16:06:55 -0000

Also removed some redundant file manipulation code
Based on patch sent by Stefan Stanacar <stefanx.stanacar@intel.com>

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/cooker.py |   40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0af4558..0580cd5 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -202,20 +202,11 @@ class BBCooker:
         #add append var operation to the end of default_file
         default_file = bb.cookerdata.findConfigFile(default_file, self.data)
 
-        with open(default_file, 'r') as f:
-            contents = f.readlines()
-        f.close()
-
-        total = ""
-        for c in contents:
-            total += c
-
-        total += "#added by hob"
+        total = "#added by hob"
         total += "\n%s += \"%s\"\n" % (var, val)
 
-        with open(default_file, 'w') as f:
+        with open(default_file, 'a') as f:
             f.write(total)
-        f.close()
 
         #add to history
         loginfo = {"op":append, "file":default_file, "line":total.count("\n")}
@@ -244,7 +235,6 @@ class BBCooker:
             if topdir in conf_file:
                 with open(conf_file, 'r') as f:
                     contents = f.readlines()
-                f.close()
 
                 lines = self.data.varhistory.get_variable_lines(var, conf_file)
                 for line in lines:
@@ -270,12 +260,8 @@ class BBCooker:
                         for ii in range(begin_line, end_line):
                             contents[ii] = "#" + contents[ii]
 
-                total = ""
-                for c in contents:
-                    total += c
                 with open(conf_file, 'w') as f:
-                    f.write(total)
-                f.close()
+                    f.writelines(contents)
 
         if replaced == False:
             #remove var from history
@@ -284,21 +270,12 @@ class BBCooker:
             #add var to the end of default_file
             default_file = bb.cookerdata.findConfigFile(default_file, self.data)
 
-            with open(default_file, 'r') as f:
-                contents = f.readlines()
-            f.close()
-
-            total = ""
-            for c in contents:
-                total += c
-
             #add the variable on a single line, to be easy to replace the second time
-            total += "\n#added by hob"
+            total = "\n#added by hob"
             total += "\n%s %s \"%s\"\n" % (var, op, val)
 
-            with open(default_file, 'w') as f:
+            with open(default_file, 'a') as f:
                 f.write(total)
-            f.close()
 
             #add to history
             loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
@@ -312,7 +289,6 @@ class BBCooker:
             if topdir in conf_file:
                 with open(conf_file, 'r') as f:
                     contents = f.readlines()
-                f.close()
 
                 lines = self.data.varhistory.get_variable_lines(var, conf_file)
                 for line in lines:
@@ -335,12 +311,8 @@ class BBCooker:
                     #remove var from history
                     self.data.varhistory.del_var_history(var, conf_file, line)
 
-                total = ""
-                for c in contents:
-                    total += c
                 with open(conf_file, 'w') as f:
-                    f.write(total)
-                f.close()
+                    f.writelines(contents)
 
     def createConfigFile(self, name):
         path = os.getcwd()
-- 
1.7.9.5


