Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3CB0A60017
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Mar 2016 08:28:45 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2016 01:28:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; d="scan'208";a="769709397"
Received: from rmoran-mobl1.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.1.250])
	by orsmga003.jf.intel.com with ESMTP; 23 Mar 2016 01:28:43 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Mar 2016 08:28:36 +0000
Message-Id: <867f3199ac6e68411ba49fc0f20e6ad8f9a743f7.1458721297.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1458721297.git.elliot.smith@intel.com>
References: <cover.1458721297.git.elliot.smith@intel.com>
Subject: [PATCH 1/5] toaster: localhostbecontroller Don't clear out toaster custom layer dir
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
X-List-Received-Date: Wed, 23 Mar 2016 08:28:46 -0000

From: Michael Wood <michael.g.wood@intel.com>

We may have a recipe which is based on a custom image recipe that has
already been built so keep the recipe file around so that it can be read
by the generate recipe function.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index efd82c3..38e97a2 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -217,9 +217,9 @@ class LocalhostBEController(BuildEnvironmentController):
             raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
 
         # 5. create custom layer and add custom recipes to it
-        layerpath = os.path.join(self.be.sourcedir, "_meta-toaster-custom")
-        if os.path.isdir(layerpath):
-            shutil.rmtree(layerpath) # remove leftovers from previous builds
+        layerpath = os.path.join(self.be.sourcedir,
+                                 "_meta-toaster-custom_",
+                                 bitbake.req.project.name)
         for target in targets:
             try:
                 customrecipe = CustomImageRecipe.objects.get(name=target.target,
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


