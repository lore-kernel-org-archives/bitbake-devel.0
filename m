Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id CD8D172DC4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 04:28:13 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 06 Mar 2016 20:28:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,549,1449561600"; d="scan'208";a="918275398"
Received: from kgoh8-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.138.205])
	by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2016 20:28:12 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 17:27:36 +1300
Message-Id: <c0ed68eaeb064ac96a3d4533481367add1d3ad93.1457324829.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1457324829.git.paul.eggleton@linux.intel.com>
References: <cover.1457324829.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1457324829.git.paul.eggleton@linux.intel.com>
References: <cover.1457324829.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] fetch2/npm: handle alternative dependency syntax
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
X-List-Received-Date: Mon, 07 Mar 2016 04:28:13 -0000

npm allows you to specify a dependency as a Github username+path, or
omit the version entirely. You can hit these if you don't use a
shrinkwrap file, with the result that the code later fails due to the
output of "npm view" being empty; so handle this lazily by just ignoring
this part of the dependency if it's not really a version.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 59312f4..761c2e0 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -144,13 +144,15 @@ class Npm(FetchMethod):
 
     def _getdependencies(self, pkg, data, version, d, ud):
         pkgfullname = pkg
-        if version:
+        if version != '*' and not '/' in version:
             pkgfullname += "@%s" % version
         logger.debug(2, "Calling getdeps on %s" % pkg)
         fetchcmd = "npm view %s dist.tarball --registry %s" % (pkgfullname, ud.registry)
         output = runfetchcmd(fetchcmd, d, True)
         # npm may resolve multiple versions
         outputarray = output.strip().splitlines()
+        if not outputarray:
+            raise FetchError("The command '%s' returned no output" % fetchcmd)
         # we just take the latest version npm resolved
         #logger.debug(2, "Output URL is %s - %s - %s" % (ud.basepath, ud.basename, ud.localfile))
         outputurl = outputarray[len(outputarray)-1].rstrip()
-- 
2.5.0


