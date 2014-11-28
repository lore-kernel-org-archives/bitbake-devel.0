Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A614A723CA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 01:12:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 27 Nov 2014 17:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="491044059"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga003.jf.intel.com with ESMTP; 27 Nov 2014 17:09:17 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 19:12:03 -0600
Message-Id: <73c7d3c331c1a136c4b937b366a8aad8e11526c7.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 05/12] fetch/wget.php: latest version string only try to find latest directory when REGEX_URI isn't specified to avoid unnecessary processing and makes code easier
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
X-List-Received-Date: Fri, 28 Nov 2014 01:12:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 55 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index b6b1339..85485bf 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -197,7 +197,7 @@ class Wget(FetchMethod):
         bb.debug(3, "DirURL: %s, %s" % (url, versionstring))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
         if not soup:
-            return ""
+            return None
 
         valid = 0
         prefix = ''
@@ -225,21 +225,21 @@ class Wget(FetchMethod):
             return prefix+version[1]
         else:
             bb.debug(3, "Not Valid")
-            return ""
+            return None
 
-    def _check_latest_version(self, url, packagename, ud, d):
+    def _check_latest_version(self, url, package, ud, d):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
         """
         valid = 0
-        version = self._parse_path(self.package_regex_comp, packagename)
+        version = self._parse_path(self.package_regex_comp, package)
 
         bb.debug(3, "VersionURL: %s" % (url))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
         if not soup:
-            bb.debug(3, "*** %s NO SOUP" % (packagename))
-            return ""
+            bb.debug(3, "*** %s NO SOUP" % (package))
+            return None
 
         pn_regex = d.getVar('REGEX', True)
         if pn_regex:
@@ -269,10 +269,12 @@ class Wget(FetchMethod):
             version = ('', '', '')
         if not pn_regex:
             testversion = ('', '', '')
-        bb.debug(3, "*** %s -> %s (TestVersion = %s)" % (packagename, version[1], testversion[1]))
+        bb.debug(3, "*** %s -> %s (TestVersion = %s)" % (package, version[1], testversion[1]))
         if valid and version:
             return re.sub('_', '.', version[1])
 
+        return None
+
     def _init_regexes(self):
         """
         Match as many patterns as possible such as:
@@ -321,36 +323,37 @@ class Wget(FetchMethod):
 
         sanity check to ensure same name and type.
         """
+        package = ud.path.split("/")[-1]
         regex_uri = d.getVar("REGEX_URI", True)
-        newpath = ud.path
+        newpath = regex_uri or ud.path
         pupver = ""
 
         self._init_regexes()
 
-        m = self.dirver_regex_comp.search(ud.path)
-        bb.debug(3, "path = %s" % (ud.path))
-        bb.debug(3, "Regex: %s" % (self.package_regex_comp.pattern))
-        if m and not regex_uri:
-            dirver = m.group('dirver')
-            # generate the new uri after removing version directory name
-            newuri = bb.fetch.encodeurl([ud.type, ud.host, ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
-            newversion = self._check_latest_dir(newuri, dirver, ud, d)
-            if newversion and dirver != newversion:
-                newpath = ud.path.replace(dirver, newversion, True)
-
-        # try to acquire all remote files in current directory
-        packagename = newpath.split("/")[-1]            # current package name
-        newpath = newpath.split(packagename)[0] or "/"  # path to directory
+        if not regex_uri:
+            # generate the new uri with the appropriate latest directory
+            m = self.dirver_regex_comp.search(ud.path)
+            if m:
+                dirver = m.group('dirver')
+                newuri = bb.fetch.encodeurl([ud.type, ud.host,
+                            ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
+                new_dirver = self._check_latest_dir(newuri, dirver, ud, d)
+                if new_dirver and dirver != new_dirver:
+                    newpath = ud.path.replace(dirver, new_dirver, True)
+
+            newpath = newpath.split(package)[0] or "/"  # path to directory
+            newuri = bb.fetch.encodeurl([ud.type, ud.host, newpath, ud.user, ud.pswd, {}])
+        else:
+            newuri = newpath
 
         # generate the new uri with the appropriate latest directory
         newuri = regex_uri or bb.fetch.encodeurl([ud.type, ud.host, newpath, ud.user, ud.pswd, {}])
-        newversion = self._check_latest_version(newuri, packagename, ud, d)
+        newversion = self._check_latest_version(newuri, package, ud, d)
         while not newversion:
             # maybe it's hiding in a download directory so try there
             newuri = "/".join(newuri.split("/")[0:-2]) + "/download"
             if newuri == "/download" or newuri == "http://download":
                 break
-            newversion = self._check_latest_version(newuri, packagename, ud, d)
-
-        return newversion
+            newversion = self._check_latest_version(newuri, package, ud, d)
 
+        return newversion or ""
-- 
1.9.1


