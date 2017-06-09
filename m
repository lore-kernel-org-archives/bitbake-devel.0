Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 31C847828A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 13:35:29 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2017 06:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="1180388557"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2017 06:35:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 15:34:44 +0200
Message-Id: <dea2a2c913e05b77249485f1f0163279f99aa3e4.1497014984.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497014984.git.paul.eggleton@linux.intel.com>
References: <cover.1497014984.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] cooker: fix file changes not triggering task re-execution with memres
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
X-List-Received-Date: Fri, 09 Jun 2017 13:35:29 -0000

If you build a recipe, modify one of the files referred to in SRC_URI,
then build it again, it should re-run do_fetch and the tasks that depend
upon it to incorporate the modified file. With memory resident mode this
was not working unless you restarted the server, because the mtime of
the file was cached and thus we never checked the actual file. Clear out
the mtime caches in buildTargets() to ensure this isn't an issue. I did
a minor refactoring to break this out to its own function since we were
already clearing out the build mtime cache here.

(The test I used for this was . ./oe-init-build-env-memres,
bitbake -c fetch mdadm, modify the comments at the top of one of the
patches referred to in the recipe, and then bitbake -c fetch mdadm again
and it should re-execute the fetch task ("... 0 didn't need to be
re-run".)

Fixes [YOCTO #10732].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8846690..651b9c0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1313,6 +1313,18 @@ class BBCooker:
         self.data.setVar("DATE", time.strftime('%Y%m%d', t))
         self.data.setVar("TIME", time.strftime('%H%M%S', t))
 
+    def reset_mtime_caches(self):
+        """
+        Reset mtime caches - this is particularly important when memory resident as something
+        which is cached is not unlikely to have changed since the last invocation (e.g. a
+        file associated with a recipe might have been modified by the user).
+        """
+        build.reset_cache()
+        bb.fetch._checksum_cache.mtime_cache.clear()
+        siggen_cache = getattr(bb.parse.siggen, 'checksum_cache', None)
+        if siggen_cache:
+            bb.parse.siggen.checksum_cache.mtime_cache.clear()
+
     def matchFiles(self, bf):
         """
         Find the .bb files which match the expression in 'buildfile'.
@@ -1490,7 +1502,7 @@ class BBCooker:
                 return True
             return retval
 
-        build.reset_cache()
+        self.reset_mtime_caches()
         self.buildSetVars()
 
         # If we are told to do the None task then query the default task
-- 
2.9.4


