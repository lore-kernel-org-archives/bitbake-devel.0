Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 2EF1476809
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:37 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616603"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:37 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:30 +0200
Message-Id: <1453815272-8303-5-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 4/6] FileChecksumCache: add get_checksums() method
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:37 -0000

Move the local file checksum functionality from bb.fetch2 into
bb.checksum module.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/checksum.py        | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/fetch2/__init__.py | 45 +--------------------------------------------
 2 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
index 514ff0b..7fb46d8 100644
--- a/lib/bb/checksum.py
+++ b/lib/bb/checksum.py
@@ -15,6 +15,8 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import glob
+import operator
 import os
 import stat
 import bb.utils
@@ -88,3 +90,48 @@ class FileChecksumCache(MultiProcessCache):
                     dest[0][h] = source[0][h]
             else:
                 dest[0][h] = source[0][h]
+
+    def get_checksums(self, filelist, pn):
+        """Get checksums for a list of files"""
+
+        def checksum_file(f):
+            try:
+                checksum = self.get_checksum(f)
+            except OSError as e:
+                bb.warn("Unable to get checksum for %s SRC_URI entry %s: %s" % (pn, os.path.basename(f), e))
+                return None
+            return checksum
+
+        def checksum_dir(pth):
+            # Handle directories recursively
+            dirchecksums = []
+            for root, dirs, files in os.walk(pth):
+                for name in files:
+                    fullpth = os.path.join(root, name)
+                    checksum = checksum_file(fullpth)
+                    if checksum:
+                        dirchecksums.append((fullpth, checksum))
+            return dirchecksums
+
+        checksums = []
+        for pth in filelist.split():
+            exist = pth.split(":")[1]
+            if exist == "False":
+                continue
+            pth = pth.split(":")[0]
+            if '*' in pth:
+                # Handle globs
+                for f in glob.glob(pth):
+                    if os.path.isdir(f):
+                        checksums.extend(checksum_dir(f))
+                    else:
+                        checksum = checksum_file(f)
+                        checksums.append((f, checksum))
+            elif os.path.isdir(pth):
+                checksums.extend(checksum_dir(pth))
+            else:
+                checksum = checksum_file(pth)
+                checksums.append((pth, checksum))
+
+        checksums.sort(key=operator.itemgetter(1))
+        return checksums
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 7d7bd58..6fca67a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -29,11 +29,9 @@ from __future__ import absolute_import
 from __future__ import print_function
 import os, re
 import signal
-import glob
 import logging
 import urllib
 import urlparse
-import operator
 import bb.persist_data, bb.utils
 import bb.checksum
 from bb import data
@@ -1118,48 +1116,7 @@ def get_file_checksums(filelist, pn):
     it proceeds
 
     """
-
-    def checksum_file(f):
-        try:
-            checksum = _checksum_cache.get_checksum(f)
-        except OSError as e:
-            bb.warn("Unable to get checksum for %s SRC_URI entry %s: %s" % (pn, os.path.basename(f), e))
-            return None
-        return checksum
-
-    def checksum_dir(pth):
-        # Handle directories recursively
-        dirchecksums = []
-        for root, dirs, files in os.walk(pth):
-            for name in files:
-                fullpth = os.path.join(root, name)
-                checksum = checksum_file(fullpth)
-                if checksum:
-                    dirchecksums.append((fullpth, checksum))
-        return dirchecksums
-
-    checksums = []
-    for pth in filelist.split():
-        exist = pth.split(":")[1]
-        if exist == "False":
-            continue
-        pth = pth.split(":")[0]
-        if '*' in pth:
-            # Handle globs
-            for f in glob.glob(pth):
-                if os.path.isdir(f):
-                    checksums.extend(checksum_dir(f))
-                else:
-                    checksum = checksum_file(f)
-                    checksums.append((f, checksum))
-        elif os.path.isdir(pth):
-            checksums.extend(checksum_dir(pth))
-        else:
-            checksum = checksum_file(pth)
-            checksums.append((pth, checksum))
-
-    checksums.sort(key=operator.itemgetter(1))
-    return checksums
+    return _checksum_cache.get_checksums(filelist, pn)
 
 
 class FetchData(object):
-- 
2.1.4


