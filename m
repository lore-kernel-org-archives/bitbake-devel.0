Return-Path: <amanda.r.brindle@intel.com>
X-Greylist: delayed 575 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 07 Feb 2018 18:40:09 UTC
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by mail.openembedded.org (Postfix) with ESMTP id DEF8671ABD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Feb 2018 18:40:09 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Feb 2018 10:30:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000"; d="scan'208";a="32903898"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 07 Feb 2018 10:30:36 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Feb 2018 10:27:20 -0800
Message-Id: <a8fb20029bbcde6c221210242b853b96e592f84a.1517873329.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517873329.git.amanda.r.brindle@intel.com>
References: <cover.1517873329.git.amanda.r.brindle@intel.com>
Cc: stephano.cetola@intel.com
Subject: [PATCH v2 1/1] tinfoil.py: Check if BUILDDIR or .devtoolbase exists
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
X-List-Received-Date: Wed, 07 Feb 2018 18:40:10 -0000

Check if either BUILDDIR or .devtoolbase exists in order to deterimine
if a tinfoil using script is running without having called oe-init-build-env
(or similar). If not, raise an exception that a tinfoil using application
can catch to produce an error message. Before, tinfoil would hang for 30s
before erroring out.

Fixes [YOCTO #12096]

Signed-off-by: Amanda Brindle <amanda.r.brindle@intel.com>
---
 bitbake/lib/bb/tinfoil.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 368264f..013e7f6 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -54,6 +54,9 @@ class TinfoilUIException(Exception):
 class TinfoilCommandFailed(Exception):
     """Exception raised when run_command fails"""
 
+class TinfoilBuildEnvironmentException(Exception):
+    """Exception raised when build environment is not initialised"""
+
 class TinfoilDataStoreConnector:
     """Connector object used to enable access to datastore objects via tinfoil"""
 
@@ -372,6 +375,20 @@ class Tinfoil:
         """
         self.quiet = quiet
 
+        fixed_setup = False
+        basepath = os.path.dirname(os.path.abspath(__file__))
+        pth = basepath
+        while pth != '' and pth != os.sep:
+            if os.path.exists(os.path.join(pth, '.devtoolbase')):
+                fixed_setup = True
+                basepath = pth
+                break
+            pth = os.path.dirname(pth)
+        if not fixed_setup:
+            basepath = os.environ.get('BUILDDIR')
+            if not basepath:
+                raise TinfoilBuildEnvironmentException('Build environment not initialised')
+
         if self.tracking:
             extrafeatures = [bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING]
         else:
-- 
2.7.4


