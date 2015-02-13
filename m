Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 155047346D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724299"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:16 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:11 -0600
Message-Id: <1423864694-24940-5-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 4/7] fetch2: wget latest_versionstring improvments in get version by dir
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

Add support for scan every version directory using _check_latest_version
makes code more robust because sometimes upstream projects publish
new directories without files, causing don't find version.

To support this new behaviour remove _check_latest_dir and replace for
_check_latest_version_by_dir,

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 108 +++++++++++++++++---------------------------------
 1 file changed, 37 insertions(+), 71 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index c8b120c..809e9fc 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -113,7 +113,6 @@ class Wget(FetchMethod):
         """
         Find and group name, version and archive type in the given string s
         """
-        bb.debug(3, "_parse_path(%s, %s)" % (regex.pattern, s))
 
         m = regex.search(s)
         if m:
@@ -199,44 +198,6 @@ class Wget(FetchMethod):
         f.close()
         return fetchresult
 
-    def _check_latest_dir(self, url, versionstring, ud, d):
-        """
-        Return the name of the directory with the greatest package version
-        If error or no version, return None
-        """
-        bb.debug(3, "DirURL: %s, %s" % (url, versionstring))
-        soup = BeautifulSoup(self._fetch_index(url, ud, d))
-        if not soup:
-            return None
-
-        valid = 0
-        prefix = ''
-        regex = re.compile("(\D*)((\d+[\.\-_])+(\d+))")
-        m = regex.search(versionstring)
-        if m:
-            version = ('', m.group(2), '')
-            prefix = m.group(1)
-            bb.debug(3, "version: %s, prefix: %s" % (version, prefix))
-        else:
-            version = ('', versionstring, '')
-
-        for href in soup.find_all('a', href=True):
-            bb.debug(3, "href: %s" % (href['href']))
-            if href['href'].find(versionstring) >= 0:
-                valid = 1
-            m = regex.search(href['href'].strip("/"))
-            if m:
-                thisversion = ('', m.group(2), '')
-                if thisversion and self._vercmp(version, thisversion) < 0:
-                    version = thisversion
-
-        if valid:
-            bb.debug(3, "Would return %s" % (prefix+version[1]))
-            return prefix+version[1]
-        else:
-            bb.debug(3, "Not Valid")
-            return None
-
     def _check_latest_version(self, url, package, package_regex, current_version, ud, d):
         """
         Return the latest version of a package inside a given directory path
@@ -252,8 +213,8 @@ class Wget(FetchMethod):
             return ""
 
         for line in soup.find_all('a', href=True):
-            bb.debug(3, "line = '%s'" % (str(line)))
             bb.debug(3, "line['href'] = '%s'" % (line['href']))
+            bb.debug(3, "line = '%s'" % (str(line)))
 
             newver = self._parse_path(package_regex, line['href'])
             if not newver:
@@ -267,12 +228,13 @@ class Wget(FetchMethod):
                 elif self._vercmp(version, newver) < 0:
                     version = newver
                 
-        # check whether a valid package and version were found
+        pupver = re.sub('_', '.', version[1])
+
         bb.debug(3, "*** %s -> UpstreamVersion = %s (CurrentVersion = %s)" %
-                (package, version[1] or "N/A", current_version[1]))
+                (package, pupver or "N/A", current_version[1]))
 
         if valid:
-            return re.sub('_', '.', version[1])
+            return pupver
 
         return ""
 
@@ -353,14 +315,10 @@ class Wget(FetchMethod):
         psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
-        package_regex_comp = re.compile("(?P<name>%s?)\.?v?(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
+        package_regex_comp = re.compile("(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
                                                     % (pn_regex, pver_regex, parch_regex, psuffix_regex))
         self.suffix_regex_comp = re.compile(psuffix_regex)
 
-        # search for version matches on folders inside the path, like:
-        # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
-        self.dirver_regex_comp = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
-
         # compile regex, can be specific by package or generic regex
         pn_regex = d.getVar('REGEX', True)
         if pn_regex:
@@ -369,10 +327,10 @@ class Wget(FetchMethod):
             version = self._parse_path(package_regex_comp, package)
             if version:
                 package_custom_regex_comp = re.compile(
-                    "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
+                    "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)" %
                     (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
             else:
-                package_custom_regex_comp = package_regex_comp
+                package_custom_regex_comp = None
 
         return package_custom_regex_comp
 
@@ -383,33 +341,41 @@ class Wget(FetchMethod):
         sanity check to ensure same name and type.
         """
         package = ud.path.split("/")[-1]
-        regex_uri = d.getVar("REGEX_URI", True)
-        newpath = regex_uri or ud.path
-        pupver = ""
-
-        package_regex = self._init_regexes(package, ud, d)
-
-        current_version = ('', d.getVar('PV', True), '')
+        current_version = ['', d.getVar('PV', True), '']
 
         """possible to have no version in pkg name, such as spectrum-fw"""
         if not re.search("\d+", package):
-            return re.sub('_', '.', current_version[1])
+            current_version[1] = re.sub('_', '.', current_version[1])
+            current_version[1] = re.sub('-', '.', current_version[1])
+            return current_version[1]
 
+        package_regex = self._init_regexes(package, ud, d)
+        if package_regex is None:
+            bb.warn("latest_versionstring: package %s don't match pattern" % (package))
+            return ""
+        bb.debug(3, "latest_versionstring, regex: %s" % (package_regex.pattern))
+
+        uri = ""
+        regex_uri = d.getVar("REGEX_URI", True)
         if not regex_uri:
-            # generate the new uri with the appropriate latest directory
-            m = self.dirver_regex_comp.search(ud.path)
+            path = ud.path.split(package)[0]
+
+            # search for version matches on folders inside the path, like:
+            # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
+            dirver_regex = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
+            m = dirver_regex.search(path)
             if m:
+                pn = d.getVar('PN', True)
                 dirver = m.group('dirver')
-                newuri = bb.fetch.encodeurl([ud.type, ud.host,
-                            ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
-                new_dirver = self._check_latest_dir(newuri, dirver, ud, d)
-                if new_dirver and dirver != new_dirver:
-                    newpath = ud.path.replace(dirver, new_dirver, True)
-
-            newpath = newpath.split(package)[0] or "/"  # path to directory
-            newuri = bb.fetch.encodeurl([ud.type, ud.host, newpath, ud.user, ud.pswd, {}])
+
+                dirver_pn_regex = re.compile("%s\d?" % (re.escape(pn)))
+                if not dirver_pn_regex.search(dirver):
+                    return self._check_latest_version_by_dir(dirver,
+                        package, package_regex, current_version, ud, d)
+
+            uri = bb.fetch.encodeurl([ud.type, ud.host, path, ud.user, ud.pswd, {}])
         else:
-            newuri = newpath
+            uri = regex_uri
 
-        return self._check_latest_version(newuri, package, package_regex,
-                        current_version, ud, d)
+        return self._check_latest_version(uri, package, package_regex,
+                current_version, ud, d)
-- 
1.9.1


