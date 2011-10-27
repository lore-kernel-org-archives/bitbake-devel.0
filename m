Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RJK65-0007lN-6N
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Oct 2011 09:09:57 +0200
Received: by opal (Postfix, from userid 111)
	id 024651032A; Thu, 27 Oct 2011 07:09:22 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111027070922.024651032A@opal>
Date: Thu, 27 Oct 2011 07:09:22 +0000 (UTC)
From: git@git.openembedded.org
X-Mailman-Approved-At: Tue, 01 Nov 2011 08:48:59 +0100
Subject: Joshua Lock : fetch2: improve usability of checksums
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 27 Oct 2011 07:09:58 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 30ca41e596955fcbbe1ae6f4436ecf14cef96f8d
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=30ca41e596955fcbbe1ae6f4436ecf14cef96f8d

Author: Joshua Lock <josh@linux.intel.com>
Date:   Mon Oct 10 17:24:41 2011 -0700

fetch2: improve usability of checksums

This patch improves the usability of checksums by only requiring one checksum
be defined.

Further, checksum verification will provide as much information as possible
at, rather than a bit at a time. No longer will you need to run fetch, see an
md5sum mismatch, fix it, run fetch, seen an sha256sum mismatch, fix it and
fetch again. If neither checksum is defined we now report both missing sums
at once - rather than one after the other.
Finally, if both sums are incorrect, we'll report both incorrect sums at the
same time.

Fixes part of [YOCTO #1399]

Signed-off-by: Joshua Lock <josh@linux.intel.com>

---

 lib/bb/fetch2/__init__.py |   72 +++++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fb6138b..71be6f4 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -93,28 +93,6 @@ class ParameterError(BBFetchException):
          BBFetchException.__init__(self, msg)
          self.args = (message, url)
 
-class MD5SumError(BBFetchException):
-    """Exception raised when a MD5 checksum of a file does not match for a downloaded file"""
-    def __init__(self, path, wanted, got, url):
-         msg = "File: '%s' has md5 checksum %s when %s was expected (from URL: '%s')" % (path, got, wanted, url)
-         self.url = url
-         self.path = path
-         self.wanted = wanted
-         self.got = got
-         BBFetchException.__init__(self, msg)
-         self.args = (path, wanted, got, url)
-
-class SHA256SumError(MD5SumError):
-    """Exception raised when a SHA256 checksum of a file does not match for a downloaded file"""
-    def __init__(self, path, wanted, got, url):
-         msg = "File: '%s' has sha256 checksum %s when %s was expected (from URL: '%s')" % (path, got, wanted, url)
-         self.url = url
-         self.path = path
-         self.wanted = wanted
-         self.got = got
-         BBFetchException.__init__(self, msg)
-         self.args = (path, wanted, got, url)
-
 class NetworkAccess(BBFetchException):
     """Exception raised when network access is disabled but it is required."""
     def __init__(self, url, cmd):
@@ -271,8 +249,8 @@ def verify_checksum(u, ud, d):
     verify the MD5 and SHA256 checksum for downloaded src
 
     return value:
-        - True: checksum matched
-        - False: checksum unmatched
+        - True: a checksum matched
+        - False: neither checksum matched
 
     if checksum is missing in recipes file, "BB_STRICT_CHECKSUM" decide the return value.
     if BB_STRICT_CHECKSUM = "1" then return false as unmatched, otherwise return true as
@@ -285,20 +263,46 @@ def verify_checksum(u, ud, d):
     md5data = bb.utils.md5_file(ud.localpath)
     sha256data = bb.utils.sha256_file(ud.localpath)
 
-    if (ud.md5_expected == None or ud.sha256_expected == None):
-        logger.warn('Missing SRC_URI checksum for %s, consider adding to the recipe:\n'
-                    'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"',
-                    ud.localpath, ud.md5_name, md5data,
-                    ud.sha256_name, sha256data)
-        if bb.data.getVar("BB_STRICT_CHECKSUM", d, True) == "1":
-            raise FetchError("No checksum specified for %s." % u, u)
-        return
+    # If strict checking enabled and neither sum defined, raise error
+    strict = bb.data.getVar("BB_STRICT_CHECKSUM", d, True) or None
+    if (strict and ud.md5_expected == None and ud.sha256_expected == None):
+        raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
+                         'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"', u,
+                         ud.localpath, ud.md5_name, md5data,
+                         ud.sha256_name, sha256data)
+
+    # Log missing sums so user can more easily add them
+    if ud.md5_expected == None:
+        logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
+                    'SRC_URI[%s] = "%s"',
+                    ud.localpath, ud.md5_name, md5data)
+
+    if ud.sha256_expected == None:
+        logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
+                    'SRC_URI[%s] = "%s"',
+                    ud.localpath, ud.sha256_name, sha256data)
+
+    md5mismatch = False
+    sha256mismatch = False
 
     if ud.md5_expected != md5data:
-        raise MD5SumError(ud.localpath, ud.md5_expected, md5data, u)
+        md5mismatch = True
 
     if ud.sha256_expected != sha256data:
-        raise SHA256SumError(ud.localpath, ud.sha256_expected, sha256data, u)
+        sha256mismatch = True
+
+    # We want to alert the user if a checksum is defined in the recipe but
+    # it does not match.
+    msg = ""
+    if md5mismatch and ud.md5_expected:
+        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected (from URL: '%s')" % (ud.localpath, 'md5', md5data, ud.md5_expected, u)
+
+    if sha256mismatch and ud.sha256_expected:
+        msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected (from URL: '%s')" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected, u)
+
+    if len(msg):
+        raise FetchError('Checksum mismatch!%s' % msg, u)
+
 
 def update_stamp(u, ud, d):
     """



