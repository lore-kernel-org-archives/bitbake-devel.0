Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B45AD7731F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 13:48:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 13 Nov 2015 05:48:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,287,1444719600"; d="scan'208";a="836998400"
Received: from lquinn-mobl2.amr.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.6.239])
	by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2015 05:48:42 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 13:48:34 +0000
Message-Id: <8088ff54a9e386f47c332fa71d5db59efe2d5d34.1447422301.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1447422301.git.elliot.smith@intel.com>
References: <cover.1447422301.git.elliot.smith@intel.com>
Subject: [PATCH 1/4] toaster: orm Fix get_number_of_builds to count all apart from IN_PROGRESS
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
X-List-Received-Date: Fri, 13 Nov 2015 13:48:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

The count of a project's builds should not include those which are
currently in progress.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/orm/models.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3832905..0ac94b9 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -130,13 +130,12 @@ class Project(models.Model):
         try:
             return self.projectvariable_set.get(name="MACHINE").value
         except (ProjectVariable.DoesNotExist,IndexError):
-            return( "None" );
+            return None;
 
     def get_number_of_builds(self):
-        try:
-            return len(Build.objects.filter( project = self.id ))
-        except (Build.DoesNotExist,IndexError):
-            return( 0 )
+        """Return the number of builds which have ended"""
+
+        return self.build_set.filter(~Q(outcome=Build.IN_PROGRESS)).count()
 
     def get_last_build_id(self):
         try:
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


