Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id BE3B4736BA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 12:52:21 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 28 Apr 2015 05:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,663,1422950400"; d="scan'208";a="702091153"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2015 05:52:23 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id D4D656A408F;
	Tue, 28 Apr 2015 05:51:55 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Apr 2015 15:52:18 +0300
Message-Id: <1430225538-15639-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: use sys.exit to simplify the code
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
X-List-Received-Date: Tue, 28 Apr 2015 12:52:23 -0000

Used sys.exit instead of assigning exit code to
variable. This way it's more clear when bitbake
exists and which exit code is used.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/bin/bitbake | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 88ac8c3..b6f19ef 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -41,16 +41,13 @@ if __name__ == "__main__":
     if __version__ != bb.__version__:
         sys.exit("Bitbake core version and program version mismatch!")
     try:
-        ret = bitbake_main(BitBakeConfigParameters(sys.argv),
-                           cookerdata.CookerConfiguration())
+        sys.exit(bitbake_main(BitBakeConfigParameters(sys.argv),
+                              cookerdata.CookerConfiguration()))
     except BBMainException as err:
-        print >>sys.stderr, err
-        ret = 1
+        sys.exit(err)
     except bb.BBHandledException:
-        ret = 1
+        sys.exit(1)
     except Exception:
-        ret = 1
         import traceback
         traceback.print_exc()
-    sys.exit(ret)
-
+        sys.exit(1)
-- 
2.1.4


