Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 032E673448
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:16 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724290"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:14 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:09 -0600
Message-Id: <1423864694-24940-3-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 2/7] fetch2: wget latest_versionstring _check_latest_version improvments
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
X-List-Received-Date: Fri, 13 Feb 2015 21:58:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to reduce code duplication now compile package_regex in
_init_regexes instead of make this decision at _check_latest_version,

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 04e2b33..96d895d 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -243,26 +243,21 @@ class Wget(FetchMethod):
     def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
         """
         Return the latest version of a package inside a given directory path
-        If error or no version, return None
+        If error or no version, return ""
         """
         valid = 0
-        version = ('', '', '')
+        version = ['', '', '']
 
         bb.debug(3, "VersionURL: %s" % (url))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
         if not soup:
             bb.debug(3, "*** %s NO SOUP" % (url))
-            return None
+            return ""
 
-        pn_regex = d.getVar('REGEX', True)
-        if pn_regex:
-            pn_regex = re.compile(pn_regex)
-            package_regex = pn_regex
-            bb.debug(3, "pn_regex = '%s'" % (pn_regex.pattern))
-            
         for line in soup.find_all('a', href=True):
-            newver = None
-            bb.debug(3, "line = '%s'" % (line['href']))
+            bb.debug(3, "line = '%s'" % (str(line)))
+            bb.debug(3, "line['href'] = '%s'" % (line['href']))
+
             newver = self._parse_path(package_regex, line['href'])
             if not newver:
                 newver = self._parse_path(package_regex, str(line))
@@ -279,12 +274,12 @@ class Wget(FetchMethod):
         bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
                 (package, version[1] or "N/A", current_version[1]))
 
-        if valid and version:
+        if valid:
             return re.sub('_', '.', version[1])
 
-        return None
+        return ""
 
-    def _init_regexes(self, package):
+    def _init_regexes(self, package, ud, d):
         """
         Match as many patterns as possible such as:
                 gnome-common-2.20.0.tar.gz (most common format)
@@ -318,7 +313,7 @@ class Wget(FetchMethod):
         psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
-        self.package_regex_comp = re.compile("(?P<name>%s?)\.?v?(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
+        package_regex_comp = re.compile("(?P<name>%s?)\.?v?(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
                                                     % (pn_regex, pver_regex, parch_regex, psuffix_regex))
         self.suffix_regex_comp = re.compile(psuffix_regex)
 
@@ -326,13 +321,18 @@ class Wget(FetchMethod):
         # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
         self.dirver_regex_comp = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
 
-        # make custom regex for search in uri's
-        package_custom_regex_comp = None
-        version = self._parse_path(self.package_regex_comp, package)
-        if version:
-            package_custom_regex_comp = re.compile(
-                "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
-                (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
+        # compile regex, can be specific by package or generic regex
+        pn_regex = d.getVar('REGEX', True)
+        if pn_regex:
+            package_custom_regex_comp = re.compile(pn_regex)
+        else:
+            version = self._parse_path(package_regex_comp, package)
+            if version:
+                package_custom_regex_comp = re.compile(
+                    "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
+                    (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
+            else:
+                package_custom_regex_comp = package_regex_comp
 
         return package_custom_regex_comp
 
@@ -347,7 +347,7 @@ class Wget(FetchMethod):
         newpath = regex_uri or ud.path
         pupver = ""
 
-        package_custom_regex_comp = self._init_regexes(package)
+        package_regex = self._init_regexes(package, ud, d)
 
         current_version = ('', d.getVar('PV', True), '')
 
@@ -371,6 +371,5 @@ class Wget(FetchMethod):
         else:
             newuri = newpath
 
-        return self._check_latest_version(newuri, package,
-                        package_custom_regex_comp or package_regex_comp,
-                        current_version, ud, d) or ""
+        return self._check_latest_version(newuri, package, package_regex,
+                        current_version, ud, d)
-- 
1.9.1


