Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3F45B75C90
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jun 2015 14:37:17 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 30 Jun 2015 07:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,378,1432623600"; d="scan'208";a="753307232"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.55])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2015 07:37:16 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jun 2015 09:39:11 -0500
Message-Id: <1435675155-3431-3-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435675155-3431-1-git-send-email-anibal.limon@linux.intel.com>
References: <1435675155-3431-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCHv3 2/6] fetch2: Add fetch parameter to checkstatus
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
X-List-Received-Date: Tue, 30 Jun 2015 14:37:20 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to pass connection cache object to checkstatus function
add fetch parameter.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 20 ++++++++++----------
 lib/bb/fetch2/git.py      |  2 +-
 lib/bb/fetch2/local.py    |  2 +-
 lib/bb/fetch2/wget.py     |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7fd9ec7..8d0221d 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -907,12 +907,12 @@ def rename_bad_checksum(ud, suffix):
     bb.utils.movefile(ud.localpath, new_localpath)
 
 
-def try_mirror_url(origud, ud, ld, check = False):
+def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
     try:
         if check:
-            found = ud.method.checkstatus(ud, ld)
+            found = ud.method.checkstatus(fetch, ud, ld)
             if found:
                 return found
             return False
@@ -975,7 +975,7 @@ def try_mirror_url(origud, ud, ld, check = False):
             pass
         return False
 
-def try_mirrors(d, origud, mirrors, check = False):
+def try_mirrors(fetch, d, origud, mirrors, check = False):
     """
     Try to use a mirrored version of the sources.
     This method will be automatically called before the fetchers go.
@@ -989,7 +989,7 @@ def try_mirrors(d, origud, mirrors, check = False):
     uris, uds = build_mirroruris(origud, mirrors, ld)
 
     for index, uri in enumerate(uris):
-        ret = try_mirror_url(origud, uds[index], ld, check)
+        ret = try_mirror_url(fetch, origud, uds[index], ld, check)
         if ret != False:
             return ret
     return None
@@ -1473,7 +1473,7 @@ class FetchMethod(object):
         """
         return True
 
-    def checkstatus(self, urldata, d):
+    def checkstatus(self, fetch, urldata, d):
         """
         Check the status of a URL
         Assumes localpath was called first
@@ -1577,7 +1577,7 @@ class Fetch(object):
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
                     mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
-                    localpath = try_mirrors(self.d, ud, mirrors, False)
+                    localpath = try_mirrors(self, self.d, ud, mirrors, False)
 
                 if premirroronly:
                     self.d.setVar("BB_NO_NETWORK", "1")
@@ -1616,7 +1616,7 @@ class Fetch(object):
                         m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
                         mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
-                        localpath = try_mirrors (self.d, ud, mirrors)
+                        localpath = try_mirrors(self, self.d, ud, mirrors)
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
                     if firsterr:
@@ -1648,15 +1648,15 @@ class Fetch(object):
             logger.debug(1, "Testing URL %s", u)
             # First try checking uri, u, from PREMIRRORS
             mirrors = mirror_from_string(self.d.getVar('PREMIRRORS', True))
-            ret = try_mirrors(self.d, ud, mirrors, True)
+            ret = try_mirrors(self, self.d, ud, mirrors, True)
             if not ret:
                 # Next try checking from the original uri, u
                 try:
-                    ret = m.checkstatus(ud, self.d)
+                    ret = m.checkstatus(self, ud, self.d)
                 except:
                     # Finally, try checking uri, u, from MIRRORS
                     mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
-                    ret = try_mirrors(self.d, ud, mirrors, True)
+                    ret = try_mirrors(self, self.d, ud, mirrors, True)
 
             if not ret:
                 raise FetchError("URL %s doesn't work" % u, u)
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2e53882..0abd679 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -423,7 +423,7 @@ class Git(FetchMethod):
         else:
             return True, str(rev)
 
-    def checkstatus(self, ud, d):
+    def checkstatus(self, fetch, ud, d):
         try:
             self._lsremote(ud, d, "")
             return True
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 0785236..2d921f7 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -112,7 +112,7 @@ class Local(FetchMethod):
 
         return True
 
-    def checkstatus(self, urldata, d):
+    def checkstatus(self, fetch, urldata, d):
         """
         Check the status of the url
         """
diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 162a6bd..abacbcf 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -100,7 +100,7 @@ class Wget(FetchMethod):
 
         return True
 
-    def checkstatus(self, ud, d):
+    def checkstatus(self, fetch, ud, d):
 
         uri = ud.url.split(";")[0]
         fetchcmd = self.basecmd + " --spider '%s'" % uri
-- 
1.9.1


