Return-Path: <elliot.smith@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BCC076FFD4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Mar 2016 08:24:33 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 16 Mar 2016 01:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,343,1455004800"; d="scan'208";a="911775174"
Received: from tzawadzk-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.3.12])
	by orsmga001.jf.intel.com with ESMTP; 16 Mar 2016 01:24:32 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 16 Mar 2016 08:24:27 +0000
Message-Id: <1458116667-1100-1-git-send-email-elliot.smith@intel.com>
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
X-List-Received-Date: Wed, 16 Mar 2016 08:24:34 -0000

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
index 7805086..28c7353 100644
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


