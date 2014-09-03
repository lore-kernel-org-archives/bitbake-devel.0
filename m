Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A70F271353
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Sep 2014 16:07:32 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 03 Sep 2014 09:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,458,1406617200"; d="scan'208";a="597376818"
Received: from svgunawa-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.16])
	by orsmga002.jf.intel.com with ESMTP; 03 Sep 2014 09:06:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Sep 2014 17:06:42 +0100
Message-Id: <b9b5e21c8bcf28766bc6804639e69f0e527d4286.1409760364.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1409760364.git.paul.eggleton@linux.intel.com>
References: <cover.1409760364.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1409760364.git.paul.eggleton@linux.intel.com>
References: <cover.1409760364.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] tinfoil: add a means of enabling variable history tracking
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
X-List-Received-Date: Wed, 03 Sep 2014 16:07:32 -0000

Unfortunately it seems like the external use of the cooker
enableDataTracking() function broke at some point since the code that
reads it now runs within BBCooker's constructor. Since this now has to
be done early, add a parameter to Tinfoil's constructor to allow
enabling variable history tracking.

Fixes [YOCTO #6676].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 751a2d7..6bcbd47 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -25,12 +25,12 @@ import bb.cache
 import bb.cooker
 import bb.providers
 import bb.utils
-from bb.cooker import state, BBCooker
+from bb.cooker import state, BBCooker, CookerFeatures
 from bb.cookerdata import CookerConfiguration, ConfigParameters
 import bb.fetch2
 
 class Tinfoil:
-    def __init__(self, output=sys.stdout):
+    def __init__(self, output=sys.stdout, tracking=False):
         # Needed to avoid deprecation warnings with python 2.6
         warnings.filterwarnings("ignore", category=DeprecationWarning)
 
@@ -48,7 +48,10 @@ class Tinfoil:
         configparams = TinfoilConfigParameters(parse_only=True)
         self.config.setConfigParameters(configparams)
         self.config.setServerRegIdleCallback(self.register_idle_function)
-        self.cooker = BBCooker(self.config)
+        features = []
+        if tracking:
+            features.append(CookerFeatures.BASEDATASTORE_TRACKING)
+        self.cooker = BBCooker(self.config, features)
         self.config_data = self.cooker.data
         bb.providers.logger.setLevel(logging.ERROR)
         self.cooker_data = None
-- 
1.9.3


