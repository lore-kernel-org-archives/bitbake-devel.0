Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 118897345A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724293"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:15 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:10 -0600
Message-Id: <1423864694-24940-4-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 3/7] fetch2: wget add _check_latest_version_by_dir
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

Add _check_latest_version_by_dir this function provides support
for scan every directory newer than current dir in order to get
latest_versionstring, example:

	http://somedoamin.com/project/v2.1/
	http://somedoamin.com/project/v3.0/

Change return of _vercmp from True/False to -1/0/1 to provide test
when current directory is equal to newer directory this helps to
scan the same directory to get minor versions, example:

	http://somedoamin.com/project/v2.1/project-v2.1.2.tgz
	http://somedoamin.com/project/v2.1/project-v2.1.6.tgz

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 52 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 96d895d..c8b120c 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -179,10 +179,7 @@ class Wget(FetchMethod):
         oldpv = self._modelate_version(oldpv)
         newpv = self._modelate_version(newpv)
 
-        if bb.utils.vercmp(("0", oldpv, ""), ("0", newpv, "")) < 0:
-            return True
-        else:
-            return False
+        return bb.utils.vercmp(("0", oldpv, ""), ("0", newpv, ""))
 
     def _fetch_index(self, uri, ud, d):
         """
@@ -230,7 +227,7 @@ class Wget(FetchMethod):
             m = regex.search(href['href'].strip("/"))
             if m:
                 thisversion = ('', m.group(2), '')
-                if thisversion and self._vercmp(version, thisversion) == True:
+                if thisversion and self._vercmp(version, thisversion) < 0:
                     version = thisversion
 
         if valid:
@@ -267,7 +264,7 @@ class Wget(FetchMethod):
                 if valid == 0:
                     version = newver
                     valid = 1
-                elif self._vercmp(version, newver) == True:
+                elif self._vercmp(version, newver) < 0:
                     version = newver
                 
         # check whether a valid package and version were found
@@ -279,6 +276,49 @@ class Wget(FetchMethod):
 
         return ""
 
+    def _check_latest_version_by_dir(self, dirver, package, package_regex,
+            current_version, ud, d):
+        """
+            Scan every directory in order to get upstream version.
+        """
+        version_dir = ['', '', '']
+        version = ['', '', '']
+
+        dirver_regex = re.compile("(\D*)((\d+[\.\-_])+(\d+))")
+        s = dirver_regex.search(dirver)
+        if s:
+            version_dir[1] = s.group(2)
+        else:
+            version_dir[1] = dirver
+
+        dirs_uri = bb.fetch.encodeurl([ud.type, ud.host,
+                ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
+        bb.debug(3, "DirURL: %s, %s" % (dirs_uri, package))
+
+        soup = BeautifulSoup(self._fetch_index(dirs_uri, ud, d))
+        if not soup:
+            return version[1]
+
+        for line in soup.find_all('a', href=True):
+            s = dirver_regex.search(line['href'].strip("/"))
+            if s:
+                version_dir_new = ['', s.group(2), '']
+                if self._vercmp(version_dir, version_dir_new) <= 0:
+                    dirver_new = s.group(1) + s.group(2)
+                    path = ud.path.replace(dirver, dirver_new, True) \
+                        .split(package)[0]
+                    uri = bb.fetch.encodeurl([ud.type, ud.host, path,
+                        ud.user, ud.pswd, {}])
+
+                    pupver = self._check_latest_version(uri,
+                            package, package_regex, current_version, ud, d)
+                    if pupver:
+                        version[1] = pupver
+
+                    version_dir = version_dir_new
+
+        return version[1]
+
     def _init_regexes(self, package, ud, d):
         """
         Match as many patterns as possible such as:
-- 
1.9.1


