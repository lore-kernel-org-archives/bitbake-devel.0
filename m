Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0175965CF5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:15 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724287"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:14 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:08 -0600
Message-Id: <1423864694-24940-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 1/7] fetch2: wget latest_versionstring improve _parse_path
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

Add support for get group only if exist in regex, this enables to use
this function in _check_latestversion regardless if the regex is generic
or specified by REGEX_URI.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 9e4b443..04e2b33 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -109,16 +109,30 @@ class Wget(FetchMethod):
 
         return True
 
-
     def _parse_path(self, regex, s):
         """
         Find and group name, version and archive type in the given string s
         """
-        bb.debug(3, "parse_path(%s, %s)" % (regex.pattern, s))
+        bb.debug(3, "_parse_path(%s, %s)" % (regex.pattern, s))
+
         m = regex.search(s)
         if m:
-            bb.debug(3, "%s, %s, %s" % (m.group('name'), m.group('ver'), m.group('type')))
-            return (m.group('name'), m.group('ver'), m.group('type'))
+            pname = ''
+            pver = ''
+            ptype = ''
+
+            mdict = m.groupdict()
+            if 'name' in mdict.keys():
+                pname = mdict['name']
+            if 'pver' in mdict.keys():
+                pver = mdict['pver']
+            if 'type' in mdict.keys():
+                ptype = mdict['type']
+
+            bb.debug(3, "_parse_path: %s, %s, %s" % (pname, pver, ptype))
+
+            return (pname, pver, ptype)
+
         return None
 
     def _modelate_version(self, version):
@@ -243,25 +257,15 @@ class Wget(FetchMethod):
         pn_regex = d.getVar('REGEX', True)
         if pn_regex:
             pn_regex = re.compile(pn_regex)
+            package_regex = pn_regex
             bb.debug(3, "pn_regex = '%s'" % (pn_regex.pattern))
             
         for line in soup.find_all('a', href=True):
             newver = None
             bb.debug(3, "line = '%s'" % (line['href']))
-            if pn_regex:
-                m = pn_regex.search(line['href'])
-                if m:
-                    bb.debug(3, "Pver = '%s'" % (m.group('pver')))
-                    newver = ('', m.group('pver'), '')
-                else:
-                    m = pn_regex.search(str(line))
-                    if m:
-                        bb.debug(3, "Pver = '%s'" % (m.group('pver')))
-                        newver = ('', m.group('pver'), '')
-            else:
-                newver = self._parse_path(package_regex, line['href'])
-                if not newver:
-                    newver = self._parse_path(package_regex, str(line))
+            newver = self._parse_path(package_regex, line['href'])
+            if not newver:
+                newver = self._parse_path(package_regex, str(line))
 
             if newver:
                 bb.debug(3, "Upstream version found: %s" % newver[1])
@@ -314,7 +318,7 @@ class Wget(FetchMethod):
         psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
-        self.package_regex_comp = re.compile("(?P<name>%s?)\.?v?(?P<ver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
+        self.package_regex_comp = re.compile("(?P<name>%s?)\.?v?(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
                                                     % (pn_regex, pver_regex, parch_regex, psuffix_regex))
         self.suffix_regex_comp = re.compile(psuffix_regex)
 
@@ -327,7 +331,7 @@ class Wget(FetchMethod):
         version = self._parse_path(self.package_regex_comp, package)
         if version:
             package_custom_regex_comp = re.compile(
-                "(?P<name>%s)(?P<ver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
+                "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
                 (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
 
         return package_custom_regex_comp
-- 
1.9.1


