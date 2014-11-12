Return-Path: <brendan.le.foll@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 300CD65C91
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 11:42:46 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 12 Nov 2014 03:42:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,368,1413270000"; d="scan'208";a="621128946"
Received: from unknown (HELO jupiter.iwi.intel.com) ([172.28.33.52])
	by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2014 03:42:44 -0800
From: Brendan Le Foll <brendan.le.foll@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Nov 2014 11:42:39 +0000
Message-Id: <1415792559-28696-1-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.1.2
Subject: [PATCH] cooker.py: fix loginfo op being set to an invalid value
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
X-List-Received-Date: Wed, 12 Nov 2014 11:42:58 -0000

loginfo "op" was being set to invalid values in saveConfigurationVar it was
working because set is a python global but append is not. This replaces both
the "op" with strings and removes the crash when calling appendConfigurationVar

Signed-off-by: Brendan Le Foll <brendan.le.foll@intel.com>
---
 lib/bb/cooker.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c6c69c3..087f72f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -240,7 +240,7 @@ class BBCooker:
             f.write(total)
 
         #add to history
-        loginfo = {"op":append, "file":default_file, "line":total.count("\n")}
+        loginfo = {"op":"append", "file":default_file, "line":total.count("\n")}
         self.data.appendVar(var, val, **loginfo)
 
     def saveConfigurationVar(self, var, val, default_file, op):
@@ -309,7 +309,7 @@ class BBCooker:
                 f.write(total)
 
             #add to history
-            loginfo = {"op":set, "file":default_file, "line":total.count("\n")}
+            loginfo = {"op":"set", "file":default_file, "line":total.count("\n")}
             self.data.setVar(var, val, **loginfo)
 
     def removeConfigurationVar(self, var):
-- 
2.1.2


