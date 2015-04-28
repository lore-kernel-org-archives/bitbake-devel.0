Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0ECB6736BA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 12:16:11 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 28 Apr 2015 05:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,663,1422950400"; d="scan'208";a="717063493"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga002.fm.intel.com with ESMTP; 28 Apr 2015 05:16:01 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 7D5E66A408F;
	Tue, 28 Apr 2015 05:15:34 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Apr 2015 15:15:57 +0300
Message-Id: <1430223357-9986-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: Check if bitbake versions match
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
X-List-Received-Date: Tue, 28 Apr 2015 12:16:17 -0000

Bitbake program and core versions must match.

Moved __version__ from main.py back to bin/bitbake.
Implemented check for version match in bin/bitbake.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

tbs

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/bin/bitbake    | 4 ++++
 bitbake/lib/bb/main.py | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 3e1ca62..88ac8c3 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -35,7 +35,11 @@ except RuntimeError as exc:
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
+__version__ = "1.27.0"
+
 if __name__ == "__main__":
+    if __version__ != bb.__version__:
+        sys.exit("Bitbake core version and program version mismatch!")
     try:
         ret = bitbake_main(BitBakeConfigParameters(sys.argv),
                            cookerdata.CookerConfiguration())
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 2019d50..49dc8d5 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -36,7 +36,6 @@ from bb import ui
 from bb import server
 from bb import cookerdata
 
-__version__ = "1.27.0"
 logger = logging.getLogger("BitBake")
 
 class BBMainException(Exception):
@@ -83,7 +82,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
     def parseCommandLine(self, argv=sys.argv):
         parser = optparse.OptionParser(
-            version = "BitBake Build Tool Core version %s, %%prog version %s" % (bb.__version__, __version__),
+            version = "BitBake Build Tool Core version %s" % bb.__version__,
             usage = """%prog [options] [recipename/target ...]
 
     Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
-- 
2.1.4


