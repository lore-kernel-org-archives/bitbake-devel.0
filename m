Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 913E370100
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Apr 2016 11:53:17 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 01 Apr 2016 04:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,427,1455004800"; d="scan'208";a="946005164"
Received: from cmjones2-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.22.222])
	by orsmga002.jf.intel.com with ESMTP; 01 Apr 2016 04:53:16 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Apr 2016 12:53:12 +0100
Message-Id: <1459511592-1641-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: buildinfohelper Create target list for all types of build
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
X-List-Received-Date: Fri, 01 Apr 2016 11:53:18 -0000

From: Michael Wood <michael.g.wood@intel.com>

Create the target list cache for command line builds and toaster
triggered builds. This fixes a regression where the target is not
identified as an image after building as the target cache is empty for
toaster triggered builds

[YOCTO #9266]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 9021c63..7b8b1a5 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -977,15 +977,16 @@ class BuildInfoHelper(object):
         event: a TargetsAcquired event with a task property (e.g. "build")
         and a targetsList property (e.g. ["zlib", "dropbear"])
         """
-        if self.internal_state['build'].project.is_default:
-            targets = map(lambda target: target + ':' + event.task, event.targetsList)
+        targets = map(lambda target: target + ':' + event.task,
+                      event.targetsList)
 
-            target_information = {
-              'targets': targets,
-              'build': self.internal_state['build']
-            }
+        target_information = {
+            'targets': targets,
+            'build': self.internal_state['build']
+        }
 
-            self.internal_state['targets'] = self.orm_wrapper.get_or_create_targets(target_information)
+        self.internal_state['targets'] = \
+            self.orm_wrapper.get_or_create_targets(target_information)
 
     def update_build(self, event):
         """
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


