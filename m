Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 531C477254
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 14:26:02 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 25 Feb 2016 06:26:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="911115123"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.2.6])
	by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2016 06:25:57 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 14:25:55 +0000
Message-Id: <1456410355-31940-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: rename 'run again' button
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
X-List-Received-Date: Thu, 25 Feb 2016 14:26:03 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

I quite dislike the 'Run again' label we use in the button that rebuilds
things. Changing it to 'Rebuild', which is shorter and more specific.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/mrb_section.html | 2 +-
 bitbake/lib/toaster/toastergui/tests.py                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/mrb_section.html b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
index cceee7d..551e341 100644
--- a/bitbake/lib/toaster/toastergui/templates/mrb_section.html
+++ b/bitbake/lib/toaster/toastergui/templates/mrb_section.html
@@ -113,7 +113,7 @@
                         {% url 'project' build.project.id as purl %}{{purl|json}},
                         {{build.target_set.all|get_tasks|json}})'>
 
-                        Run again
+                        Rebuild
                   </button>
               {% endif %}
             </div>
diff --git a/bitbake/lib/toaster/toastergui/tests.py b/bitbake/lib/toaster/toastergui/tests.py
index 4e420ea..6b05916 100644
--- a/bitbake/lib/toaster/toastergui/tests.py
+++ b/bitbake/lib/toaster/toastergui/tests.py
@@ -951,7 +951,7 @@ class AllBuildsPageTests(TestCase):
 
     def test_run_again(self):
         """
-        "Run again" button should not be shown for command-line builds,
+        "Rebuild" button should not be shown for command-line builds,
         but should be shown for other builds
         """
         build1 = Build.objects.create(**self.project1_build_success)
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


