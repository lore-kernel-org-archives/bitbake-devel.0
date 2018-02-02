Return-Path: <nathan@nathanrossi.com>
Received: from mail-pl0-f54.google.com (mail-pl0-f54.google.com
	[209.85.160.54])
	by mail.openembedded.org (Postfix) with ESMTP id BCA537883A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Feb 2018 13:51:24 +0000 (UTC)
Received: by mail-pl0-f54.google.com with SMTP id 11so6233850plc.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Feb 2018 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=nathanrossi.com; s=google;
	h=date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=qxhlSKxI/fRrFlc7/mPiqra5Bq6Ow7m8EWjM+rOIJBw=;
	b=IjB0lEVs8cpn02kZUKKKysKGXAd86K2fazvZQfQ0oM0ebxOvd0MjGmQ+7NhHGZviSw
	OmlD/SGETmjz7ebOgMfVvLMoZL4SUJwt/bUrZCkaE3IXlVO+RKoW1NMl397dX9sbGXMa
	KGQnl3zrhhqXkFBQR5kWAmOkhiPRK8GOiP9iHodFqLJJH5+pExKNMSTV07i3uFJZkA+o
	dQ9D0FDXcqVZI0VY/SIn7+c6KlkzPnIe4FPDeNi98PlFKfiyDpB69NFw1aNvW+g+IGOp
	hZ1TfHQSmxEL3mHobv+p9iW9lHFKrLfiXOGcJ2ZJGmXZm6JHfIgxSYkQanha5AQD4xp4
	BYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:message-id:from:to:cc:subject:mime-version
	:content-transfer-encoding;
	bh=qxhlSKxI/fRrFlc7/mPiqra5Bq6Ow7m8EWjM+rOIJBw=;
	b=YS824LYGwCJJ0Z6mbbJCjfo6SiDtcGEEwt/T7CpFYIVZZYkDG2ir3ZLdwJl9NHYfKj
	AHWlibjkoQYlp9LRnMCcQjn7BarA486o4Y4SrCX9tAZ0xmWxDUiu4z1d0HPsxrztwdAj
	Blrbs2SERpX6aij8Hr6Wl9IlkQluRS4CBCWAtgryTTPpfid7/6tL0CBVkw9IJHC1Rd4Q
	dS8gMVsysm3U4ZCheRejV+3GvW4abGvt509LSezUAJPHMXj13H419arxBjatMjC8TPFG
	E6Fn2tv4KWY8T7bmQFY2UDwBp927/WJfw7nhCd30OqKghHy+toc6NpnHNRdluAHGy434
	LaIA==
X-Gm-Message-State: AKwxytd7Attybth3Z9OtrzHtwOXm5G3jeTykv0DWSqA7kfCaow7Mf8Gh
	zsT5ULTiI3VLVuxojT8VT66EOKPv+u4=
X-Google-Smtp-Source: AH8x227F7qZTpZJ/bClOAyUE6pkcU5EF7dkw3/tW+mo6AvLZUh3HNLuNtPt+B432r0XJFF2PIXJeww==
X-Received: by 2002:a17:902:2845:: with SMTP id
	e63-v6mr34344535plb.438.1517579485664; 
	Fri, 02 Feb 2018 05:51:25 -0800 (PST)
Received: from [127.0.1.1] (CPE-101-163-12-83.lnse6.cha.bigpond.net.au.
	[101.163.12.83]) by smtp.gmail.com with ESMTPSA id
	f21sm3130185pgv.42.2018.02.02.05.51.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Feb 2018 05:51:25 -0800 (PST)
Date: Fri, 02 Feb 2018 23:51:15 +1000
Message-Id: <20180202135115.31223-1-nathan@nathanrossi.com>
From: Nathan Rossi <nathan@nathanrossi.com>
To: bitbake-devel@lists.openembedded.org
MIME-Version: 1.0
Subject: [PATCH v3] fetch2: Handle missing donestamp file when content is valid
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
X-List-Received-Date: Fri, 02 Feb 2018 13:51:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In order to allow users to manually populate the download directory with
valid content change the assumption that missing the donestamp file
means unfetched content.

This allows users to populate the download dir without needing to create
dummy .done files such that a user does not need a PREMIRROR when using
BB_NO_NETWORK to provide valid content files in the download directory.

To ensure the correct result this change also fails first if the
localpath does not exist. This prevents further parts of the function
attempting to calculating the checksum on non-existent files. This also
fixes some edge conditions around where if the donestamp exists but the
localpath does not it returns, and did not remove the donestamp.

Also added test cases to cover this use case and additional use cases
where for example the fetcher does not support checksums.

Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
---
Changes in v2:
  * Added test cases for the 4 common donestamp cases
Changes in v3:
  * Add more test cases around edge conditions
  * Fix regression with previous versions where the verify would return
    true when there was no localpath and no donestamp (added tests for
    this too)
  * Check if the local file exists first, and fail first but also clean
    up the donestamp
---
 lib/bb/fetch2/__init__.py |  21 +++++-----
 lib/bb/tests/fetch.py     | 104 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 6bd040493e..72d6092deb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -643,26 +643,25 @@ def verify_donestamp(ud, d, origud=None):
     if not ud.needdonestamp or (origud and not origud.needdonestamp):
         return True
 
-    if not os.path.exists(ud.donestamp):
+    if not os.path.exists(ud.localpath):
+        # local path does not exist
+        if os.path.exists(ud.donestamp):
+            # done stamp exists, but the downloaded file does not; the done stamp
+            # must be incorrect, re-trigger the download
+            bb.utils.remove(ud.donestamp)
         return False
 
     if (not ud.method.supports_checksum(ud) or
         (origud and not origud.method.supports_checksum(origud))):
-        # done stamp exists, checksums not supported; assume the local file is
-        # current
-        return True
-
-    if not os.path.exists(ud.localpath):
-        # done stamp exists, but the downloaded file does not; the done stamp
-        # must be incorrect, re-trigger the download
-        bb.utils.remove(ud.donestamp)
-        return False
+        # if done stamp exists and checksums not supported; assume the local
+        # file is current
+        return os.path.exists(ud.donestamp)
 
     precomputed_checksums = {}
     # Only re-use the precomputed checksums if the donestamp is newer than the
     # file. Do not rely on the mtime of directories, though. If ud.localpath is
     # a directory, there will probably not be any checksums anyway.
-    if (os.path.isdir(ud.localpath) or
+    if os.path.exists(ud.donestamp) and (os.path.isdir(ud.localpath) or
             os.path.getmtime(ud.localpath) < os.path.getmtime(ud.donestamp)):
         try:
             with open(ud.donestamp, "rb") as cachefile:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 11698f2091..7051a54b42 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -20,6 +20,7 @@
 #
 
 import unittest
+import hashlib
 import tempfile
 import subprocess
 import collections
@@ -522,6 +523,109 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
+class FetcherNoNetworkTest(FetcherTest):
+    def setUp(self):
+        super().setUp()
+        # all test cases are based on not having network
+        self.d.setVar("BB_NO_NETWORK", "1")
+
+    def test_missing(self):
+        string = "this is a test file\n".encode("utf-8")
+        self.d.setVarFlag("SRC_URI", "md5sum", hashlib.md5(string).hexdigest())
+        self.d.setVarFlag("SRC_URI", "sha256sum", hashlib.sha256(string).hexdigest())
+
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
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
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
+        # the existing file should not exist or should have be moved to "bad-checksum"
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+
+    def test_nochecksums_missing(self):
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        # ssh fetch does not support checksums
+        fetcher = bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        # attempts to download with missing donestamp
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
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
+    def test_nochecksums_missing_has_donestamp(self):
+        # create a file in the download directory with the donestamp
+        with open(os.path.join(self.dldir, "test-file.tar.gz.done"), "wb"):
+            pass
+
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+        # ssh fetch does not support checksums
+        fetcher = bb.fetch.Fetch(["ssh://invalid@invalid.yoctoproject.org/test-file.tar.gz"], self.d)
+        with self.assertRaises(bb.fetch2.NetworkAccess):
+            fetcher.download()
+        # both files should still exist
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz")))
+        self.assertFalse(os.path.exists(os.path.join(self.dldir, "test-file.tar.gz.done")))
+
 class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch(self):
-- 
2.15.1


