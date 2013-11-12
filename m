Return-Path: <stefanx.stanacar@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id E5F426D8AE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Nov 2013 14:07:08 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 12 Nov 2013 06:07:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,685,1378882800"; d="scan'208";a="432078351"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 12 Nov 2013 06:07:02 -0800
Received: from firebird.rb.intel.com (firebird.rb.intel.com [10.237.105.73])
	by linux.intel.com (Postfix) with ESMTP id A11836A4007;
	Tue, 12 Nov 2013 06:07:00 -0800 (PST)
From: Stefan Stanacar <stefanx.stanacar@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Nov 2013 16:07:29 +0200
Message-Id: <1384265249-11307-1-git-send-email-stefanx.stanacar@intel.com>
X-Mailer: git-send-email 1.8.3.1
Subject: [PATCH] cooker: remove some redundant file manipulation code
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
X-List-Received-Date: Tue, 12 Nov 2013 14:07:09 -0000

There is no need to call close() for files opened in "with" statements.
Also, in some places files content was unnecessarily copied from a list to a string,
and there is no reason to do that.

Signed-off-by: Stefan Stanacar <stefanx.stanacar@intel.com>
---
 bitbake/lib/bb/cooker.py | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0af4558..3aa69ed 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -202,20 +202,16 @@ class BBCooker:
         #add append var operation to the end of default_file
         default_file = bb.cookerdata.findConfigFile(default_file, self.data)
 
+        total = ''
         with open(default_file, 'r') as f:
-            contents = f.readlines()
-        f.close()
-
-        total = ""
-        for c in contents:
-            total += c
+            for line in f:
+                total += line
 
         total += "#added by hob"
         total += "\n%s += \"%s\"\n" % (var, val)
 
         with open(default_file, 'w') as f:
             f.write(total)
-        f.close()
 
         #add to history
         loginfo = {"op":append, "file":default_file, "line":total.count("\n")}
@@ -244,7 +240,6 @@ class BBCooker:
             if topdir in conf_file:
                 with open(conf_file, 'r') as f:
                     contents = f.readlines()
-                f.close()
 
                 lines = self.data.varhistory.get_variable_lines(var, conf_file)
                 for line in lines:
@@ -270,12 +265,8 @@ class BBCooker:
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
@@ -284,13 +275,10 @@ class BBCooker:
             #add var to the end of default_file
             default_file = bb.cookerdata.findConfigFile(default_file, self.data)
 
-            with open(default_file, 'r') as f:
-                contents = f.readlines()
-            f.close()
-
             total = ""
-            for c in contents:
-                total += c
+            with open(default_file, 'r') as f:
+                for line in f:
+                    total += line
 
             #add the variable on a single line, to be easy to replace the second time
             total += "\n#added by hob"
@@ -298,7 +286,6 @@ class BBCooker:
 
             with open(default_file, 'w') as f:
                 f.write(total)
-            f.close()
 
             #add to history
             loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
@@ -312,7 +299,6 @@ class BBCooker:
             if topdir in conf_file:
                 with open(conf_file, 'r') as f:
                     contents = f.readlines()
-                f.close()
 
                 lines = self.data.varhistory.get_variable_lines(var, conf_file)
                 for line in lines:
@@ -335,12 +321,8 @@ class BBCooker:
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
1.8.3.1


