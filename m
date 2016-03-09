Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id A61BA6B6EA
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 04:22:55 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 08 Mar 2016 20:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,559,1455004800"; d="scan'208";a="905624141"
Received: from mlim-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.143.14])
	by orsmga001.jf.intel.com with ESMTP; 08 Mar 2016 20:22:54 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 17:22:13 +1300
Message-Id: <23d8eac5c2c6c5d72a68f9df45091801640e384b.1457497288.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1457497288.git.paul.eggleton@linux.intel.com>
References: <cover.1457497288.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1457497288.git.paul.eggleton@linux.intel.com>
References: <cover.1457497288.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] fetch2/npm: properly handle npm dependencies
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
X-List-Received-Date: Wed, 09 Mar 2016 04:22:56 -0000

The output of "npm view dependencies" isn't entirely JSON if there are
multiple results, but the code here was just discarding the output if
the entire thing didn't parse as JSON. Split the output into lines and
iterate over it, parsing JSON fragments as we find them; this way we end
up with the last package's dependencies since it'll be last in the
output.

Digging further, it seems that the dependencies field reported by "npm
view" also includes optional dependencies. That wouldn't be a problem
except some of these optional dependencies may be OS-specific; for
example the "chokidar" module has "fsevents" in its optional
dependencies, but fsevents only works on MacOS X (and is only needed
there). If we erroneously pull in fsevents, not only is it unnecessary
but it causes "npm shrinkwrap" to throw a tantrum. In the absence of a
better approach, look at the os field and discard the module (along with
any of its dependencies) if it isn't for Linux.

As part of this, we can reduce the calls to npm view to one per package
since we get the entire json output rather than querying twice for two
separate fields. Overall the time taken has probably increased since we
are being more thorough about dependencies, but it's not quite as bad as
it could have been.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 64 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index df27669..3ff11e9 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -142,36 +142,62 @@ class Npm(FetchMethod):
 
         self._unpackdep(ud, ud.pkgname, workobj,  "%s/npmpkg" % destdir, dldir, d)
 
-    def _getdependencies(self, pkg, data, version, d, ud):
+    def _parse_view(self, output):
+        '''
+        Parse the output of npm view --json; the last JSON result
+        is assumed to be the one that we're interested in.
+        '''
+        pdata = None
+        outdeps = {}
+        datalines = []
+        bracelevel = 0
+        for line in output.splitlines():
+            if bracelevel:
+                datalines.append(line)
+            elif '{' in line:
+                datalines = []
+                datalines.append(line)
+            bracelevel = bracelevel + line.count('{') - line.count('}')
+        if datalines:
+            pdata = json.loads('\n'.join(datalines))
+        return pdata
+
+    def _getdependencies(self, pkg, data, version, d, ud, optional=False):
         pkgfullname = pkg
         if version != '*' and not '/' in version:
             pkgfullname += "@'%s'" % version
         logger.debug(2, "Calling getdeps on %s" % pkg)
-        fetchcmd = "npm view %s dist.tarball --registry %s" % (pkgfullname, ud.registry)
+        fetchcmd = "npm view %s --json --registry %s" % (pkgfullname, ud.registry)
         output = runfetchcmd(fetchcmd, d, True)
-        # npm may resolve multiple versions
-        outputarray = output.strip().splitlines()
-        if not outputarray:
+        pdata = self._parse_view(output)
+        if not pdata:
             raise FetchError("The command '%s' returned no output" % fetchcmd)
-        # we just take the latest version npm resolved
+        if optional:
+            pkg_os = pdata.get('os', None)
+            if pkg_os:
+                if not isinstance(pkg_os, list):
+                    pkg_os = [pkg_os]
+                if 'linux' not in pkg_os or '!linux' in pkg_os:
+                    logger.debug(2, "Skipping %s since it's incompatible with Linux" % pkg)
+                    return
         #logger.debug(2, "Output URL is %s - %s - %s" % (ud.basepath, ud.basename, ud.localfile))
-        outputurl = outputarray[len(outputarray)-1].rstrip()
-        if (len(outputarray) > 1):
-            # remove the preceding version/name from npm output and then the
-            # first and last quotes
-            outputurl = outputurl.split(" ")[1][1:-1]
+        outputurl = pdata['dist']['tarball']
         data[pkg] = {}
         data[pkg]['tgz'] = os.path.basename(outputurl)
         self._runwget(ud, d, "%s %s" % (self.basecmd, outputurl), False)
-        #fetchcmd = "npm view %s@%s dependencies --json" % (pkg, version)
-        fetchcmd = "npm view %s dependencies --json --registry %s" % (pkgfullname, ud.registry)
-        output = runfetchcmd(fetchcmd, d, True)
-        try:
-          depsfound = json.loads(output)
-        except:
-            # just assume there is no deps to be loaded here
-            return
+
+        dependencies = pdata.get('dependencies', {})
+        optionalDependencies = pdata.get('optionalDependencies', {})
+        depsfound = {}
+        optdepsfound = {}
         data[pkg]['deps'] = {}
+        for dep in dependencies:
+            if dep in optionalDependencies:
+                optdepsfound[dep] = dependencies[dep]
+            else:
+                depsfound[dep] = dependencies[dep]
+        for dep, version in optdepsfound.iteritems():
+            self._getdependencies(dep, data[pkg]['deps'], version, d, ud, optional=True)
         for dep, version in depsfound.iteritems():
             self._getdependencies(dep, data[pkg]['deps'], version, d, ud)
 
-- 
2.5.0


