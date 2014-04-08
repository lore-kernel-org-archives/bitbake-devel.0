Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2390865DC5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 14:34:00 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 06:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,818,1389772800"; d="scan'208";a="489275262"
Received: from paulonei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.244])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2014 07:03:24 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 15:03:10 +0100
Message-Id: <0dabe179e605bc4d777431c7740dd4a53d9572fa.1396965331.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396965331.git.paul.eggleton@linux.intel.com>
References: <cover.1396965331.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1396965331.git.paul.eggleton@linux.intel.com>
References: <cover.1396965331.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] fetch2: fix traceback when a wildcard matches a directory
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
X-List-Received-Date: Tue, 08 Apr 2014 14:34:00 -0000

If there is a directory matching a wildcard in SRC_URI when getting file
checksums, we should recurse into that instead of producing an error.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/__init__.py | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a9ab75e..5a03a0e 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -962,24 +962,32 @@ def get_file_checksums(filelist, pn):
             return None
         return checksum
 
+    def checksum_dir(pth):
+        # Handle directories recursively
+        dirchecksums = []
+        for root, dirs, files in os.walk(pth):
+            for name in files:
+                fullpth = os.path.join(root, name)
+                checksum = checksum_file(fullpth)
+                if checksum:
+                    dirchecksums.append((fullpth, checksum))
+        return dirchecksums
+
     checksums = []
     for pth in filelist.split():
         checksum = None
         if '*' in pth:
             # Handle globs
             for f in glob.glob(pth):
-                checksum = checksum_file(f)
-                if checksum:
-                    checksums.append((f, checksum))
+                if os.path.isdir(f):
+                    checksums.extend(checksum_dir(f))
+                else:
+                    checksum = checksum_file(f)
+                    if checksum:
+                        checksums.append((f, checksum))
             continue
         elif os.path.isdir(pth):
-            # Handle directories
-            for root, dirs, files in os.walk(pth):
-                for name in files:
-                    fullpth = os.path.join(root, name)
-                    checksum = checksum_file(fullpth)
-                    if checksum:
-                        checksums.append((fullpth, checksum))
+            checksums.extend(checksum_dir(pth))
             continue
         else:
             checksum = checksum_file(pth)
-- 
1.9.0


