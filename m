Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 640AF766DD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Oct 2015 09:32:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 09 Oct 2015 02:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,657,1437462000"; d="scan'208";a="788373680"
Received: from sarallen-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.18.21])
	by orsmga001.jf.intel.com with ESMTP; 09 Oct 2015 02:32:51 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Oct 2015 10:32:40 +0100
Message-Id: <8d8aafac1ce36e172d77d29367321f8848304b2b.1444383025.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
References: <fe0aee177626c475a3a863fa0a482f0319e341e5.1444383025.git.elliot.smith@intel.com>
In-Reply-To: <cover.1444383025.git.elliot.smith@intel.com>
References: <cover.1444383025.git.elliot.smith@intel.com>
Subject: [PATCH 2/5] toaster: Fix typo in returning pk list of layer versions in current project
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
X-List-Received-Date: Fri, 09 Oct 2015 09:32:50 -0000

From: Michael Wood <michael.g.wood@intel.com>

This was accidentally returning the primary key of the ProjectLayer
rather than the ProjectLayer.Layer_Version.pk

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 375985e..1cbf480 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -222,7 +222,7 @@ class Project(models.Model):
         if pk is False:
             return layer_versions
         else:
-            return layer_versions.values_list('pk', flat=True)
+            return layer_versions.values_list('layercommit__pk', flat=True)
 
 
     def get_available_machines(self):
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


