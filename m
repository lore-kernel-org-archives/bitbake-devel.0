Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 3678A60290
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 13:02:10 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 09 Mar 2016 05:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,311,1455004800"; d="scan'208";a="760913628"
Received: from minos.isw.intel.com ([10.237.224.84])
	by orsmga003.jf.intel.com with ESMTP; 09 Mar 2016 05:01:51 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 13:01:24 +0000
Message-Id: <1457528484-12464-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH] toaster: models List only have the specified project's imported layers
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
X-List-Received-Date: Wed, 09 Mar 2016 13:02:13 -0000

From: Michael Wood <michael.g.wood@intel.com>

When returning the compatible layers make sure that we are only
listing: All the layers which are for this release && configuration
layers (i.e. aren't part of the build history) and which aren't an
imported layer OR are this project's imported layer(s).

[YOCTO #8944]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/orm/models.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index cfc6ea8..add2ade 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -262,8 +262,10 @@ class Project(models.Model):
         """ Returns Queryset of all Layer_Versions which are compatible with
         this project"""
         queryset = Layer_Version.objects.filter(
-            (Q(up_branch__name=self.release.branch_name) & Q(build=None))
-            | Q(project=self))
+            (Q(up_branch__name=self.release.branch_name) &
+             Q(build=None) &
+             Q(project=None)) |
+             Q(project=self))
 
         return queryset
 
-- 
1.9.1

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


