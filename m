Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id A0822723BC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 01:12:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 27 Nov 2014 17:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="491044066"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga003.jf.intel.com with ESMTP; 27 Nov 2014 17:09:18 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 19:12:05 -0600
Message-Id: <a218f99fabd656f0ed891ba9f81ad6a388788a21.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 07/12] fetch2/wget.py: latest_versionstring improvments in searching
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
X-List-Received-Date: Fri, 28 Nov 2014 01:12:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate if package contain version string if not return the current
version cases for spectrum-fw and corpus recipes.

_check_latest_version return the latest version available don't
take into account the current version previous this only return
the upstream version if it greater than the current version.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 1a585a5..7e4f432 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -227,18 +227,18 @@ class Wget(FetchMethod):
             bb.debug(3, "Not Valid")
             return None
 
-    def _check_latest_version(self, url, package, ud, d):
+    def _check_latest_version(self, url, package, current_version, ud, d):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return ""
         """
         valid = 0
-        version = self._parse_path(self.package_custom_regex_comp, package)
+        version = ('', '', '')
 
         bb.debug(3, "VersionURL: %s" % (url))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
         if not soup:
-            bb.debug(3, "*** %s NO SOUP" % (package))
+            bb.debug(3, "*** %s NO SOUP" % (url))
             return None
 
         pn_regex = d.getVar('REGEX', True)
@@ -248,7 +248,7 @@ class Wget(FetchMethod):
             bb.debug(3, "pn_regex = '%s'" % (pn_regex.pattern))
             
         for line in soup.find_all('a', href=True):
-            newver = ('', '', '')
+            newver = None
             bb.debug(3, "line = '%s'" % (line['href']))
             if pn_regex:
                 m = pn_regex.search(line['href'])
@@ -259,17 +259,19 @@ class Wget(FetchMethod):
                     continue
             else:
                 newver = self._parse_path(self.package_custom_regex_comp, line['href'])
-            valid = 1
-            if newver and self._vercmp(version, newver) == True:
-                version = newver
+
+            if newver:
+                bb.debug(3, "Upstream version found: %s" % newver[1])
+                if valid == 0:
+                    version = newver
+                    valid = 1
+                elif self._vercmp(version, newver) == True:
+                    version = newver
                 
         # check whether a valid package and version were found
+        bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
+                (package, version[1] or "N/A", current_version[1]))
 
-        if not valid:
-            version = ('', '', '')
-        if not pn_regex:
-            testversion = ('', '', '')
-        bb.debug(3, "*** %s -> %s (TestVersion = %s)" % (package, version[1], testversion[1]))
         if valid and version:
             return re.sub('_', '.', version[1])
 
@@ -336,6 +338,11 @@ class Wget(FetchMethod):
         pupver = ""
 
         self._init_regexes(package)
+        current_version = ('', d.getVar('PV', True), '')
+
+        """possible to have no version in pkg name, such as spectrum-fw"""
+        if not re.search("\d+", package):
+            return re.sub('_', '.', current_version[1])
 
         if not regex_uri:
             # generate the new uri with the appropriate latest directory
@@ -355,12 +362,14 @@ class Wget(FetchMethod):
 
         # generate the new uri with the appropriate latest directory
         newuri = regex_uri or bb.fetch.encodeurl([ud.type, ud.host, newpath, ud.user, ud.pswd, {}])
-        newversion = self._check_latest_version(newuri, package, ud, d)
+        newversion = self._check_latest_version(newuri, package,
+                        current_version, ud, d)
         while not newversion:
             # maybe it's hiding in a download directory so try there
             newuri = "/".join(newuri.split("/")[0:-2]) + "/download"
             if newuri == "/download" or newuri == "http://download":
                 break
-            newversion = self._check_latest_version(newuri, package, ud, d)
+            newversion = self._check_latest_version(newuri, package,
+                            current_version, ud, d)
 
         return newversion or ""
-- 
1.9.1


