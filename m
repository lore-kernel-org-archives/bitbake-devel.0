Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 66F89773FB
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:08 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310837"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:58:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:31 +1200
Message-Id: <62720ad1d26bb7d3212761b102e5fff49ac4a3e1.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/6] fetch2/npm: handle top-level shrinkwrap file
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
X-List-Received-Date: Mon, 05 Sep 2016 22:58:08 -0000

Allow using a top-level shrinkwrap file with one or more npm://
dependencies, i.e. if the module isn't found at the top level then look
one level down.

Part of the fix for [YOCTO #9537].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 134bd35..08d6876 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -204,8 +204,15 @@ class Npm(FetchMethod):
         for dep, version in depsfound.items():
             self._getdependencies(dep, data[pkg]['deps'], version, d, ud)
 
-    def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest):
+    def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest, toplevel=True):
         logger.debug(2, "NPM shrinkwrap file is %s" % data)
+        if toplevel:
+            name = data.get('name', None)
+            if name and name != pkg:
+                for obj in data.get('dependencies', []):
+                    if obj == pkg:
+                        self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest, False)
+                        return
         outputurl = "invalid"
         if ('resolved' not in data) or (not data['resolved'].startswith('http')):
             # will be the case for ${PN}
@@ -231,7 +238,7 @@ class Npm(FetchMethod):
         if 'dependencies' in data:
             for obj in data['dependencies']:
                 logger.debug(2, "Found dep is %s" % str(obj))
-                self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest[pkg]['deps'])
+                self._getshrinkeddependencies(obj, data['dependencies'][obj], data['dependencies'][obj]['version'], d, ud, lockdown, manifest[pkg]['deps'], False)
 
     def download(self, ud, d):
         """Fetch url"""
-- 
2.5.5


