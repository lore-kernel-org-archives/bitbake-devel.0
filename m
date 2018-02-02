Return-Path: <nathan@nathanrossi.com>
Received: from mail-pg0-f49.google.com (mail-pg0-f49.google.com [74.125.83.49])
	by mail.openembedded.org (Postfix) with ESMTP id 1545677D6D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Feb 2018 11:23:17 +0000 (UTC)
Received: by mail-pg0-f49.google.com with SMTP id f6so2724897pga.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Feb 2018 03:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=nathanrossi.com; s=google;
	h=date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=27QfsDfLfK/a1chW/7WXe1Zlob4L3e9/6p2K2l6A8Oc=;
	b=RDnx6GkLfK15ERKMSkfEeaZql5Y2YO5jnYY3wjtvUAhM6mCq2qDMrwkqwpwqXqTZDj
	+XCWld2LXtDeL5QceTNVkbM6DNxvJO4t16ZXkwA2m/IOh1nPhfThRqdpxhV74tSaB6v+
	1TNavASC2RI6IRtu0Ka8c4fPbZfWFpzy1ZJMt9NlMnJzzVSu4jncNF02NHRWCIS3C0lF
	J8Nx2nUnLwVvQk+FBn3uQxMqwyR7IJLOP4dOiLVKtwDDb+qALoCWL4PzwSAmJjALUlhu
	2FOoV06lXVBJLqaCfNAOxCgharGf8/ELAs9rF2u2P0Yb9XTpV+rC8R2GsklCu1jzfpYi
	3Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=27QfsDfLfK/a1chW/7WXe1Zlob4L3e9/6p2K2l6A8Oc=;
	b=P52weX7Cm4X18Kx6cf/cQOeZtZC9fsFMvud01WrpczZ91aUc8yqJRRwHUTWYGM279w
	nlPhn5+U4U1ZoshDU69MvzZDPzxXz7Nfh8kqjCNfHQ4tZL0tiRkVM75YREN6XToXEUn/
	BXviNLamiXenAJgGFyuxEOutoF8DsRgeTY+PdrCbiQWcUvUILYjdlUP9F8DHU7wANq8A
	2ItpK9UlbEgDmJKUzeUJ0y6dz4MdH/HFZqe07xxul8RBlk/vXPbXDMzNrjgFBEl3dY03
	z7wWFeGLPUd3Tc5IF9IJ3s/lko8JQrnSte6MrPSIDKKW0EU74NTwiloXzY1t4wuzGYG5
	C2kw==
X-Gm-Message-State: AKwxyteGyhbvGfMdAe2r6+mNPDTjp4FjDs3DDvYYi6mojhdhH45goDa1
	oI+n9Cz9/4JeWDIpAXU9zD3y8YZ2m8I=
X-Google-Smtp-Source: AH8x227U+EDkSg/Z1cYVRUY5o+V5XVAkP+LI/GiSrDSIdX54PqbNgJRK7W3svRaSxIuC+QzVsu9pZA==
X-Received: by 10.98.194.212 with SMTP id w81mr39119811pfk.232.1517570599109; 
	Fri, 02 Feb 2018 03:23:19 -0800 (PST)
Received: from [127.0.1.1] (CPE-101-163-12-83.lnse6.cha.bigpond.net.au.
	[101.163.12.83]) by smtp.gmail.com with ESMTPSA id
	x8sm3397589pfk.123.2018.02.02.03.23.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Feb 2018 03:23:18 -0800 (PST)
Date: Fri, 02 Feb 2018 21:23:09 +1000
Message-Id: <20180202112309.32044-1-nathan@nathanrossi.com>
From: Nathan Rossi <nathan@nathanrossi.com>
To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Subject: [PATCH v2] fetch2: Handle missing donestamp file when content is valid
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
X-List-Received-Date: Fri, 02 Feb 2018 11:23:18 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In order to allow users to manually populate the download directory with
valid content change the assumption that missing the donestamp file
means unfetched content.

This allows users to populate the download dir without needing to create
dummy .done files such that a user does not need a PREMIRROR when using
BB_NO_NETWORK to provide valid content files in the download directory.

Also added test cases to cover this use case and additional use cases
where for example the fetcher does not support checksums.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
Changes in v2:
  * Added test cases for the 4 common donestamp cases
---
 lib/bb/fetch2/__init__.py | 13 ++++-----
 lib/bb/tests/fetch.py     | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6bd040493e..7f290bb930 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -643,16 +643,13 @@ def verify_donestamp(ud, d, origud=None):
     if not ud.needdonestamp or (origud and not origud.needdonestamp):
         return True
 
-    if not os.path.exists(ud.donestamp):
-        return False
-
     if (not ud.method.supports_checksum(ud) or
         (origud and not origud.method.supports_checksum(origud))):
-        # done stamp exists, checksums not supported; assume the local file is
-        # current
-        return True
+        # if done stamp exists and checksums not supported; assume the local
+        # file is current
+        return os.path.exists(ud.donestamp)
 
-    if not os.path.exists(ud.localpath):
+    if not os.path.exists(ud.localpath) and os.path.exists(ud.donestamp):
         # done stamp exists, but the downloaded file does not; the done stamp
         # must be incorrect, re-trigger the download
         bb.utils.remove(ud.donestamp)
@@ -662,7 +659,7 @@ def verify_donestamp(ud, d, origud=None):
     # Only re-use the precomputed checksums if the donestamp is newer than the
     # file. Do not rely on the mtime of directories, though. If ud.localpath is
     # a directory, there will probably not be any checksums anyway.
-    if (os.path.isdir(ud.localpath) or
+    if os.path.exists(ud.donestamp) and (os.path.isdir(ud.localpath) or
             os.path.getmtime(ud.localpath) < os.path.getmtime(ud.donestamp)):
         try:
             with open(ud.donestamp, "rb") as cachefile:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 11698f2091..e6c228f789 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -20,6 +20,7 @@
 #
 
 import unittest
+import hashlib
 import tempfile
 import subprocess
 import collections
@@ -522,6 +523,73 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
+class FetcherNoNetworkTest(FetcherTest):
+    def setUp(self):
+        super().setUp()
+        # all test cases are based on not having network
+        self.d.setVar("BB_NO_NETWORK", "1")
+
+    def test_valid_missing_donestamp(self):
+        # create the file in the download directory with correct hash
+        string = "this is a test file\n".encode("utf-8")
+        with open(os.path.join(self.dldir, "test-file.tar.gz"), "wb") as f:
+            f.write(string)
+
+        self.d.setVarFlag("SRC_URI", "md5sum", hashlib.md5(string).hexdigest())
+        self.d.setVarFlag("SRC_URI", "sha256sum", hashlib.sha256(string).hexdigest())
+
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        fetcher.download()
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+
+    def test_invalid_missing_donestamp(self):
+        # create an invalid file in the download directory with incorrect hash
+        string = "this is a test file\n".encode("utf-8")
+        with open(os.path.join(self.dldir, "test-file.tar.gz"), "wb"):
+            pass
+
+        self.d.setVarFlag("SRC_URI", "md5sum", hashlib.md5(string).hexdigest())
+        self.d.setVarFlag("SRC_URI", "sha256sum", hashlib.sha256(string).hexdigest())
+
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        fetcher.download()
+        # the existing file should not exist or should have be moved to "bad-checksum"
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+
+    def test_nochecksums_missing_donestamp(self):
+        # create a file in the download directory
+        with open(os.path.join(self.dldir, "test-file.tar.gz"), "wb"):
+            pass
+
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        # ssh fetch does not support checksums
+        fetcher = bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        # attempts to download with missing donestamp
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
+
+    def test_nochecksums_has_donestamp(self):
+        # create a file in the download directory with the donestamp
+        with open(os.path.join(self.dldir, "test-file.tar.gz"), "wb"):
+            pass
+        with open(os.path.join(self.dldir, "test-file.tar.gz.done"), "wb"):
+            pass
+
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        # ssh fetch does not support checksums
+        fetcher = bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        # should not fetch
+        fetcher.download()
+        # both files should still exist
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+
 class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch(self):
-- 
2.15.1


