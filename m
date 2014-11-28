Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 86670723BA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 01:12:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 27 Nov 2014 17:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="491044055"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga003.jf.intel.com with ESMTP; 27 Nov 2014 17:09:16 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 19:12:02 -0600
Message-Id: <c37ad71e1ad7041c2e3f87c18e72219fdca48d38.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 04/12] fetch2/wget.py: _init_regexes rename variables to be more consistent and move dirver_regex into it
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

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 687d494..b6b1339 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -151,7 +151,7 @@ class Wget(FetchMethod):
         Check for a new suffix type that we have never heard of before
         """
         if (newsuffix):
-            m = self.suffixregex.search(newsuffix)
+            m = self.suffix_regex_comp.search(newsuffix)
             if not m:
                 bb.warn("%s has a possible unknown suffix: %s" % (newpn, newsuffix))
                 return False
@@ -233,7 +233,7 @@ class Wget(FetchMethod):
         If error or no version, return ""
         """
         valid = 0
-        version = self._parse_path(self.name_version_type_regex, packagename)
+        version = self._parse_path(self.package_regex_comp, packagename)
 
         bb.debug(3, "VersionURL: %s" % (url))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
@@ -258,7 +258,7 @@ class Wget(FetchMethod):
                 else:
                     continue
             else:
-                newver = self._parse_path(self.name_version_type_regex, line['href'])
+                newver = self._parse_path(self.package_regex_comp, line['href'])
             valid = 1
             if newver and self._vercmp(version, newver) == True:
                 version = newver
@@ -294,18 +294,26 @@ class Wget(FetchMethod):
         # a loose pattern such as for 80325-quicky-0.4.tar.gz
         pn_prefix3 = "[0-9]+[\-]?[a-zA-Z]+"
         # Save the Package Name (pn) Regex for use later
-        self.pn_regex = "(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
+        pn_regex = "(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
 
         # match version
-        version_regex = "(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
+        pver_regex = "(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
+
+        # match arch
+        parch_regex = "\-source|_all_"
 
         # src.rpm extension was added only for rpm package. Can be removed if the rpm
         # packaged will always be considered as having to be manually upgraded
-        suffixlist = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
-        self.suffixregex = re.compile(suffixlist)
+        psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
-        self.name_version_type_regex = re.compile("(?P<name>%s?)\.?v?(?P<ver>%s)(\-source)?[\.\-](?P<type>%s$)" % (self.pn_regex, version_regex, suffixlist))
+        self.package_regex_comp = re.compile("(?P<name>%s?)\.?v?(?P<ver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
+                                                    % (pn_regex, pver_regex, parch_regex, psuffix_regex))
+        self.suffix_regex_comp = re.compile(psuffix_regex)
+
+        # search for version matches on folders inside the path, like:
+        # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
+        self.dirver_regex_comp = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
 
     def latest_versionstring(self, ud, d):
         """
@@ -319,11 +327,9 @@ class Wget(FetchMethod):
 
         self._init_regexes()
 
-        # search for version matches on folders inside the path, like:
-        # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
-        m = re.search("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/", ud.path)
+        m = self.dirver_regex_comp.search(ud.path)
         bb.debug(3, "path = %s" % (ud.path))
-        bb.debug(3, "Regex: %s" % (self.name_version_type_regex.pattern))
+        bb.debug(3, "Regex: %s" % (self.package_regex_comp.pattern))
         if m and not regex_uri:
             dirver = m.group('dirver')
             # generate the new uri after removing version directory name
-- 
1.9.1


