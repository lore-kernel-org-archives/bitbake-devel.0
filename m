Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 423E8757F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Jul 2015 20:38:24 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 03 Jul 2015 13:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,402,1432623600"; d="scan'208";a="755652966"
Received: from mctremel-mobl1.amr.corp.intel.com (HELO
	alimon-ThinkPad-W540.amr.corp.intel.com) ([10.254.180.106])
	by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2015 13:38:22 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jul 2015 15:40:27 -0500
Message-Id: <1435956027-26996-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435956027-26996-1-git-send-email-anibal.limon@linux.intel.com>
References: <1435956027-26996-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] tinfoil.py: Add shutdown method.
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
X-List-Received-Date: Fri, 03 Jul 2015 20:38:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When run tinfoil in a loop it causing problems for don't
free resources like OS max fd exception.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/tinfoil.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 8fc9be3..5025e62 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -28,6 +28,7 @@ import bb.utils
 from bb.cooker import state, BBCooker, CookerFeatures
 from bb.cookerdata import CookerConfiguration, ConfigParameters
 import bb.fetch2
+from bb import BBHandledException
 
 class Tinfoil:
     def __init__(self, output=sys.stdout, tracking=False):
@@ -84,6 +85,13 @@ class Tinfoil:
             else:
                 self.parseRecipes()
 
+    def shutdown(self):
+        try:
+            self.cooker.shutdown()
+            self.cooker.updateCache()
+        except BBHandledException:
+            pass
+
 class TinfoilConfigParameters(ConfigParameters):
 
     def __init__(self, **options):
-- 
1.9.1


