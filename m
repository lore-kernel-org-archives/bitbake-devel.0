Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 93DFF723BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Nov 2014 01:12:20 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga102.jf.intel.com with ESMTP; 27 Nov 2014 17:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,691,1406617200"; d="scan'208";a="491044064"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.148])
	by orsmga003.jf.intel.com with ESMTP; 27 Nov 2014 17:09:18 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 19:12:04 -0600
Message-Id: <488102402611719c65e5b81e054fb2afded9fbec.1417134564.git.anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
In-Reply-To: <cover.1417134564.git.anibal.limon@linux.intel.com>
References: <cover.1417134564.git.anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 06/12] fetch2/wget.py: latest_versionstring add package_custom_regex_comp
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

package_custom_regex_comp is built with the current package name and
then used to search upstream version this reduces custom regex'es in
sites that have different packages in the same directory.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 85485bf..1a585a5 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -233,7 +233,7 @@ class Wget(FetchMethod):
         If error or no version, return ""
         """
         valid = 0
-        version = self._parse_path(self.package_regex_comp, package)
+        version = self._parse_path(self.package_custom_regex_comp, package)
 
         bb.debug(3, "VersionURL: %s" % (url))
         soup = BeautifulSoup(self._fetch_index(url, ud, d))
@@ -258,7 +258,7 @@ class Wget(FetchMethod):
                 else:
                     continue
             else:
-                newver = self._parse_path(self.package_regex_comp, line['href'])
+                newver = self._parse_path(self.package_custom_regex_comp, line['href'])
             valid = 1
             if newver and self._vercmp(version, newver) == True:
                 version = newver
@@ -275,7 +275,7 @@ class Wget(FetchMethod):
 
         return None
 
-    def _init_regexes(self):
+    def _init_regexes(self, package):
         """
         Match as many patterns as possible such as:
                 gnome-common-2.20.0.tar.gz (most common format)
@@ -317,6 +317,13 @@ class Wget(FetchMethod):
         # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
         self.dirver_regex_comp = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
 
+        # get current version and make custom regex for search in uri's
+        version = self._parse_path(self.package_regex_comp, package)
+        if version:
+            self.package_custom_regex_comp = re.compile(
+                "(?P<name>%s)(?P<ver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)$" %
+                (version[0], pver_regex, parch_regex, psuffix_regex))
+
     def latest_versionstring(self, ud, d):
         """
         Manipulate the URL and try to obtain the latest package version
@@ -328,7 +335,7 @@ class Wget(FetchMethod):
         newpath = regex_uri or ud.path
         pupver = ""
 
-        self._init_regexes()
+        self._init_regexes(package)
 
         if not regex_uri:
             # generate the new uri with the appropriate latest directory
-- 
1.9.1


