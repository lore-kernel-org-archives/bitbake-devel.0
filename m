Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id DC7036FF0E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 04:22:52 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 08 Mar 2016 20:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,559,1455004800"; d="scan'208";a="905624104"
Received: from mlim-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.143.14])
	by orsmga001.jf.intel.com with ESMTP; 08 Mar 2016 20:22:51 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 17:22:12 +1300
Message-Id: <867289220f6c09b9a794acb1b4a6efc5d7fdbc54.1457497288.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1457497288.git.paul.eggleton@linux.intel.com>
References: <cover.1457497288.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1457497288.git.paul.eggleton@linux.intel.com>
References: <cover.1457497288.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] fetch2/npm: fix errors with some version specifications
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
X-List-Received-Date: Wed, 09 Mar 2016 04:22:53 -0000

"2 || 3" is a valid version specification for a dependency in an npm
package.json file, but of course that looks like something else when
sent to a shell. Quote the version value to avoid this.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 457043f..df27669 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -145,7 +145,7 @@ class Npm(FetchMethod):
     def _getdependencies(self, pkg, data, version, d, ud):
         pkgfullname = pkg
         if version != '*' and not '/' in version:
-            pkgfullname += "@%s" % version
+            pkgfullname += "@'%s'" % version
         logger.debug(2, "Calling getdeps on %s" % pkg)
         fetchcmd = "npm view %s dist.tarball --registry %s" % (pkgfullname, ud.registry)
         output = runfetchcmd(fetchcmd, d, True)
-- 
2.5.0


