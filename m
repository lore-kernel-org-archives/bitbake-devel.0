Return-Path: <anibal.limon@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 5034C728B6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Dec 2014 23:58:39 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga102.fm.intel.com with ESMTP; 18 Dec 2014 15:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; d="scan'208";a="430956959"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.60])
	by FMSMGA003.fm.intel.com with ESMTP; 18 Dec 2014 15:47:26 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Dec 2014 17:58:57 -0600
Message-Id: <1418947137-18813-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] bb/fetch2/wget.py: latest_versionstring fix multithread and remove deprecated code
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
X-List-Received-Date: Thu, 18 Dec 2014 23:58:44 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to fix multithread usage of latest_versionstring moves package_custom_regex_comp
from class to method level because need to be defined by package.

Remove code for build url's with /download suffix because it's deprecated since you can
specify the download directory using package_regex.inc file.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index d82e78c..2e6da48 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -227,7 +227,7 @@ class Wget(FetchMethod):
             bb.debug(3, "Not Valid")
             return None
 
-    def _check_latest_version(self, url, package, current_version, ud, d):
+    def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
         """
         Return the latest version of a package inside a given directory path
         If error or no version, return None
@@ -260,9 +260,9 @@ class Wget(FetchMethod):
                         bb.debug(3, "Pver = '%s'" % (m.group('pver')))
                         newver = ('', m.group('pver'), '')
             else:
-                newver = self._parse_path(self.package_custom_regex_comp, line['href'])
+                newver = self._parse_path(package_regex, line['href'])
                 if not newver:
-                    newver = self._parse_path(self.package_custom_regex_comp, str(line))
+                    newver = self._parse_path(package_regex, str(line))
 
             if newver:
                 bb.debug(3, "Upstream version found: %s" % newver[1])
@@ -323,13 +323,16 @@ class Wget(FetchMethod):
         # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
         self.dirver_regex_comp = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
 
-        # get current version and make custom regex for search in uri's
+        # make custom regex for search in uri's
+        package_custom_regex_comp = None
         version = self._parse_path(self.package_regex_comp, package)
         if version:
-            self.package_custom_regex_comp = re.compile(
+            package_custom_regex_comp = re.compile(
                 "(?P<name>%s)(?P<ver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
                 (version[0], pver_regex, parch_regex, psuffix_regex))
 
+        return package_custom_regex_comp
+
     def latest_versionstring(self, ud, d):
         """
         Manipulate the URL and try to obtain the latest package version
@@ -341,7 +344,8 @@ class Wget(FetchMethod):
         newpath = regex_uri or ud.path
         pupver = ""
 
-        self._init_regexes(package)
+        package_custom_regex_comp = self._init_regexes(package)
+
         current_version = ('', d.getVar('PV', True), '')
 
         """possible to have no version in pkg name, such as spectrum-fw"""
@@ -364,14 +368,6 @@ class Wget(FetchMethod):
         else:
             newuri = newpath
 
-        newversion = self._check_latest_version(newuri, package,
-                        current_version, ud, d)
-        while not newversion:
-            # maybe it's hiding in a download directory so try there
-            newuri = "/".join(newuri.split("/")[0:-2]) + "/download"
-            if newuri == "/download" or newuri == "http://download":
-                break
-            newversion = self._check_latest_version(newuri, package,
-                            current_version, ud, d)
-
-        return newversion or ""
+        return self._check_latest_version(newuri, package,
+                        package_custom_regex_comp or package_regex_comp,
+                        current_version, ud, d) or ""
-- 
1.9.1


