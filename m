Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 15E086E26B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Sep 2015 15:46:09 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 14 Sep 2015 08:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,529,1437462000"; d="scan'208";a="768760505"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.1.96])
	by orsmga001.jf.intel.com with ESMTP; 14 Sep 2015 08:46:07 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 14 Sep 2015 16:45:40 +0100
Message-Id: <1442245540-15066-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: delete multiple builds cleanup
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
X-List-Received-Date: Mon, 14 Sep 2015 15:46:11 -0000

From: brian avery <avery.brian@gmail.com>

This patch cleans up the multiple delete. It:

1) skips build id's that don't exist rather than giving a traceback.
2) let you pass in the ids as a space separated list
3) fixes the usage to match the space separated list format

[YOCTO #7726]

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastermain/management/commands/builddelete.py  | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/toastermain/management/commands/builddelete.py b/bitbake/lib/toaster/toastermain/management/commands/builddelete.py
index 343d311..ff93e54 100644
--- a/bitbake/lib/toaster/toastermain/management/commands/builddelete.py
+++ b/bitbake/lib/toaster/toastermain/management/commands/builddelete.py
@@ -1,4 +1,5 @@
 from django.core.management.base import BaseCommand, CommandError
+from django.core.exceptions import ObjectDoesNotExist
 from orm.models import Build
 from django.db import OperationalError
 import os
@@ -6,12 +7,16 @@ import os
 
 
 class Command(BaseCommand):
-    args    = "buildId"
+    args    = '<buildID1 buildID2 .....>'
     help    = "Deletes selected build(s)"
 
-    def handle(self, buildId, *args, **options):
-        for bid in buildId.split(","):
-            b = Build.objects.get(pk = bid)
+    def handle(self, *args, **options):
+        for bid in args:
+            try:
+                b = Build.objects.get(pk = bid)
+            except ObjectDoesNotExist:
+                print 'build %s does not exist, skipping...' %(bid)
+                continue
             # theoretically, just b.delete() would suffice
             # however SQLite runs into problems when you try to
             # delete too many rows at once, so we delete some direct
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


