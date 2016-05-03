Return-Path: <leonardo.sandoval.gonzalez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id CF9D67002B
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 May 2016 19:55:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 03 May 2016 12:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,573,1455004800"; d="scan'208";a="696314882"
Received: from yctb05.ostc.intel.com ([10.54.69.59])
	by FMSMGA003.fm.intel.com with ESMTP; 03 May 2016 12:55:02 -0700
From: leonardo.sandoval.gonzalez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 May 2016 14:55:48 -0500
Message-Id: <1462305348-41127-1-git-send-email-leonardo.sandoval.gonzalez@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] bitbake: fetch2: Safer check for BB_ORIGENV datastore
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
X-List-Received-Date: Tue, 03 May 2016 19:55:02 -0000

From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>

BB_ORIGENV value on the datastore can be NoneType thus raising an AttributeError
exception when calling the getVar method. To avoid this, a check is done before
accesing it.

[YOCTO #9567]

Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e8fbe89..6ef0c6f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -813,8 +813,9 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None):
     if not cleanup:
         cleanup = []
 
+    origenv = d.getVar("BB_ORIGENV", False)
     for var in exportvars:
-        val = d.getVar(var, True) or d.getVar("BB_ORIGENV", False).getVar(var, True)
+        val = d.getVar(var, True) or (origenv and origenv.getVar(var, True))
         if val:
             cmd = 'export ' + var + '=\"%s\"; %s' % (val, cmd)
 
-- 
2.6.6


