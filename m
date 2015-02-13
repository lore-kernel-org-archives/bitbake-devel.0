Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 1EAB173472
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724308"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:17 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:13 -0600
Message-Id: <1423864694-24940-7-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 6/7] fetch2: wget remove scape of - in regexes don't needed
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

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 570bd47..162a6bd 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -141,7 +141,7 @@ class Wget(FetchMethod):
             else:
                 version = version[1:len(version)]
 
-        version = re.sub('\-', '.', version)
+        version = re.sub('-', '.', version)
         version = re.sub('_', '.', version)
         version = re.sub('(rc)+', '.1000.', version)
         version = re.sub('(beta)+', '.100.', version)
@@ -246,7 +246,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile("(\D*)((\d+[\.\-_])+(\d+))")
+        dirver_regex = re.compile("(\D*)((\d+[\.-_])+(\d+))")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group(2)
@@ -296,26 +296,26 @@ class Wget(FetchMethod):
                 gst-fluendo-mp3
         """
         # match most patterns which uses "-" as separator to version digits
-        pn_prefix1 = "[a-zA-Z][a-zA-Z0-9]*([\-_][a-zA-Z]\w+)*\+?[\-_]"
+        pn_prefix1 = "[a-zA-Z][a-zA-Z0-9]*([-_][a-zA-Z]\w+)*\+?[-_]"
         # a loose pattern such as for unzip552.tar.gz
         pn_prefix2 = "[a-zA-Z]+"
         # a loose pattern such as for 80325-quicky-0.4.tar.gz
-        pn_prefix3 = "[0-9]+[\-]?[a-zA-Z]+"
+        pn_prefix3 = "[0-9]+[-]?[a-zA-Z]+"
         # Save the Package Name (pn) Regex for use later
         pn_regex = "(%s|%s|%s)" % (pn_prefix1, pn_prefix2, pn_prefix3)
 
         # match version
-        pver_regex = "(([A-Z]*\d+[a-zA-Z]*[\.\-_]*)+)"
+        pver_regex = "(([A-Z]*\d+[a-zA-Z]*[\.-_]*)+)"
 
         # match arch
-        parch_regex = "\-source|_all_"
+        parch_regex = "-source|_all_"
 
         # src.rpm extension was added only for rpm package. Can be removed if the rpm
         # packaged will always be considered as having to be manually upgraded
         psuffix_regex = "(tar\.gz|tgz|tar\.bz2|zip|xz|rpm|bz2|orig\.tar\.gz|tar\.xz|src\.tar\.gz|src\.tgz|svnr\d+\.tar\.bz2|stable\.tar\.gz|src\.rpm)"
 
         # match name, version and archive type of a package
-        package_regex_comp = re.compile("(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s$)"
+        package_regex_comp = re.compile("(?P<name>%s?\.?v?)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s$)"
                                                     % (pn_regex, pver_regex, parch_regex, psuffix_regex))
         self.suffix_regex_comp = re.compile(psuffix_regex)
 
@@ -327,7 +327,7 @@ class Wget(FetchMethod):
             version = self._parse_path(package_regex_comp, package)
             if version:
                 package_custom_regex_comp = re.compile(
-                    "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.\-](?P<type>%s)" %
+                    "(?P<name>%s)(?P<pver>%s)(?P<arch>%s)?[\.-](?P<type>%s)" %
                     (re.escape(version[0]), pver_regex, parch_regex, psuffix_regex))
             else:
                 package_custom_regex_comp = None
@@ -362,7 +362,7 @@ class Wget(FetchMethod):
 
             # search for version matches on folders inside the path, like:
             # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
-            dirver_regex = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([\-_]r\d+)*)/")
+            dirver_regex = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
             m = dirver_regex.search(path)
             if m:
                 pn = d.getVar('PN', True)
-- 
1.9.1


