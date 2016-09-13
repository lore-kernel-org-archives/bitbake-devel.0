Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A0D9477206
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Sep 2016 02:12:07 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 12 Sep 2016 19:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,326,1470726000"; d="scan'208";a="1055111533"
Received: from wooi-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.156.68])
	by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2016 19:12:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2016 14:11:41 +1200
Message-Id: <c721b0e15df71fff0dc17122d128ded0195751c3.1473732670.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473732670.git.paul.eggleton@linux.intel.com>
References: <cover.1473732670.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473732670.git.paul.eggleton@linux.intel.com>
References: <cover.1473732670.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] fetch2/npm: don't download same URL multiple times
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
X-List-Received-Date: Tue, 13 Sep 2016 02:12:07 -0000

If we've already fetched a particular URL then we do not need to do so
again within in the same operation. Maintain an internal list of fetched
URLs to avoid doing that.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 43929ce..699ae72 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -165,7 +165,9 @@ class Npm(FetchMethod):
             pdata = json.loads('\n'.join(datalines))
         return pdata
 
-    def _getdependencies(self, pkg, data, version, d, ud, optional=False):
+    def _getdependencies(self, pkg, data, version, d, ud, optional=False, fetchedlist=None):
+        if fetchedlist is None:
+            fetchedlist = []
         pkgfullname = pkg
         if version != '*' and not '/' in version:
             pkgfullname += "@'%s'" % version
@@ -187,7 +189,9 @@ class Npm(FetchMethod):
         outputurl = pdata['dist']['tarball']
         data[pkg] = {}
         data[pkg]['tgz'] = os.path.basename(outputurl)
-        self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
+        if not outputurl in fetchedlist:
+            self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
+            fetchedlist.append(outputurl)
 
         dependencies = pdata.get('dependencies', {})
         optionalDependencies = pdata.get('optionalDependencies', {})
@@ -200,9 +204,9 @@ class Npm(FetchMethod):
             else:
                 depsfound[dep] = dependencies[dep]
         for dep, version in optdepsfound.items():
-            self._getdependencies(dep, data[pkg]['deps'], version, d, ud, optional=True)
+            self._getdependencies(dep, data[pkg]['deps'], version, d, ud, optional=True, fetchedlist=fetchedlist)
         for dep, version in depsfound.items():
-            self._getdependencies(dep, data[pkg]['deps'], version, d, ud)
+            self._getdependencies(dep, data[pkg]['deps'], version, d, ud, fetchedlist=fetchedlist)
 
     def _getshrinkeddependencies(self, pkg, data, version, d, ud, lockdown, manifest, toplevel=True):
         logger.debug(2, "NPM shrinkwrap file is %s" % data)
-- 
2.5.5


