Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A612F716CE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Apr 2015 11:27:38 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 28 Apr 2015 04:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,663,1422950400"; d="scan'208";a="702057003"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2015 04:27:39 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id ACC836A4090;
	Tue, 28 Apr 2015 04:27:12 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Apr 2015 14:27:34 +0300
Message-Id: <1430220454-20570-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: Handle BBMainException
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
X-List-Received-Date: Tue, 28 Apr 2015 11:27:39 -0000

Some error messages were lost because BBMainException was
inherited from bb.BBHandledException. When bb.BBHandledException
is processed error messages are not printed as they suppose to
be printed before raising this exception.

Stopped to inherit BBMainException from bb.BBHandledException.
Handled BBMainException in bin/bitbake and printed error message
to the stderr.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/bin/bitbake    | 5 ++++-
 bitbake/lib/bb/main.py | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index af91507..3e1ca62 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -33,12 +33,15 @@ except RuntimeError as exc:
     sys.exit(str(exc))
 
 from bb import cookerdata
-from bb.main import bitbake_main, BitBakeConfigParameters
+from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 
 if __name__ == "__main__":
     try:
         ret = bitbake_main(BitBakeConfigParameters(sys.argv),
                            cookerdata.CookerConfiguration())
+    except BBMainException as err:
+        print >>sys.stderr, err
+        ret = 1
     except bb.BBHandledException:
         ret = 1
     except Exception:
diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index af067f7..2019d50 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -39,7 +39,7 @@ from bb import cookerdata
 __version__ = "1.27.0"
 logger = logging.getLogger("BitBake")
 
-class BBMainException(bb.BBHandledException):
+class BBMainException(Exception):
     pass
 
 def get_ui(config):
-- 
2.1.4


