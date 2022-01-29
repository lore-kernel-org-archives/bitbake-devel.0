Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1FC4167D
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:46 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.1486.1643423385313383936
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=D21xAtwj;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423385;
  x=1674959385;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=1uoTPw+HChDwsAD73ihE9SNecrlYvBybpxHXVQXZsCw=;
  b=D21xAtwj8y3EYlCwMojD8DmYdkVKqAQcYiddo63nxl137CA0NFzbILKY
   dOga5Qda0YCW4wgRXOIUQ3CQpmGvtLfUUQ3XKkvKZTZjbVtLX90/KiHp3
   kJpByTWXCJbRwtKzYVotlxwTwmOU+S59xmvwHoB1cPPb/1kQhcRj6WBYF
   QbJTQLbFU2XFpyYZtv7eyEPbe/CAOgqKHdcSWe9nEdr7k4DuNtFLHopy2
   8gcQJG+htJQC/HyP2/dWevyPeJB0zWKDQEsdienhaFAZ1B4Jpx4swbZA/
   METXDGlET+4H4z5IsfENUWljNNWlC8jBIwNS+8efnI2g69KpsxZzug070
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 8/9] fetch2: Correct handling of replacing the basename in
 URIs
Date: Sat, 29 Jan 2022 03:29:38 +0100
Message-ID: <20220129022939.19329-8-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220129022939.19329-1-pkj@axis.com>
References: <20220129022939.19329-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13301

The solution implementated in commit 96c30007 (fetch2: fix
downloadfilename issue with premirror) missed two corner cases. The
first is if the basename of the original URI also appears somewhere
else in the replacement URI, in which case it would also be replaced.
The second is if the basename of the original URI partially matches
the basename of the replacement URI, in which case the inital part of
the basename from the replacement URI would be left behind.

The second case caused test_npm_premirrors_with_specified_filename to
fail.

The solution is to prefix the basename with a slash when matching to
avoid partial matches, and only replace the basename at the end of the
URI.

This also adds two test cases that test for these problems. Before
this they would give the following errors:

  - ['file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz']
  + ['file:///mirror/some-example-1.0.0.tgz/1.0.0/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz']
  ?                  +++++       ++++++++++

  - ['file:///mirror/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz']
  + ['file:///mirror/some-some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz']
  ?                  +++++

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 11 +++++----
 bitbake/lib/bb/tests/fetch.py     | 39 +++++++++++++++++--------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index d37174185a..28a3e54c7f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -473,10 +473,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     basename = os.path.basename(ud.localpath)
                 if basename:
                     uri_basename = os.path.basename(uri_decoded[loc])
-                    if uri_basename and basename != uri_basename and result_decoded[loc].endswith(uri_basename):
-                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
-                    elif not result_decoded[loc].endswith(basename):
-                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
+                    # Prefix with a slash as a sentinel in case
+                    # result_decoded[loc] does not contain one.
+                    path = "/" + result_decoded[loc]
+                    if uri_basename and basename != uri_basename and path.endswith("/" + uri_basename):
+                        result_decoded[loc] = path[1:-len(uri_basename)] + basename
+                    elif not path.endswith("/" + basename):
+                        result_decoded[loc] = os.path.join(path[1:], basename)
         else:
             return None
     result = encodeurl(result_decoded)
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 9fb6378fdc..8b13e178e6 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -412,34 +412,34 @@ class FetcherTest(unittest.TestCase):
 class MirrorUriTest(FetcherTest):
 
     replaceuris = {
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir/") 
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "http://somewhere.org/somedir/")
             : "http://somewhere.org/somedir/git2_git.invalid.infradead.org.mtd-utils.git.tar.gz",
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http") 
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http") 
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/\\2;protocol=http") 
-            : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/somedir/\\2;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/([^/]+/)*([^/]*)", "git://somewhere.org/\\2;protocol=http")
+            : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
         ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
             : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
-        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache") 
+        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache")
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
-        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/") 
+        ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/")
             : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
-        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org/somedir3") 
+        ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org/somedir3")
             : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
-        ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz") 
+        ("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz")
             : "http://somewhere2.org/somedir3/somefile_1.2.3.tar.gz",
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://www.apache.org/dist", "http://archive.apache.org/dist")
             : "http://archive.apache.org/dist/subversion/subversion-1.7.1.tar.bz2",
         ("http://www.apache.org/dist/subversion/subversion-1.7.1.tar.bz2", "http://.*/.*", "file:///somepath/downloads/")
             : "file:///somepath/downloads/subversion-1.7.1.tar.bz2",
-        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http") 
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http") 
-            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
-        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http") 
-            : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http", 
+        ("git://git.invalid.infradead.org/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/BASENAME;protocol=http")
+            : "git://somewhere.org/somedir/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
+        ("git://git.invalid.infradead.org/foo/mtd-utils.git;tag=1234567890123456789012345678901234567890", "git://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
+            : "git://somewhere.org/somedir/git.invalid.infradead.org.foo.mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org")
             : "http://somewhere2.org/somefile_1.2.3.tar.gz",
         ("http://somewhere.org/somedir1/somedir2/somefile_1.2.3.tar.gz", "http://.*/.*", "http://somewhere2.org/")
@@ -450,8 +450,11 @@ class MirrorUriTest(FetcherTest):
             : "git://user2@git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890;branch=master;protocol=http",
         ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890;protocol=git;branch=master", "git://someserver.org/bitbake", "git://someotherserver.org/bitbake;protocol=https")
             : "git://someotherserver.org/bitbake;tag=1234567890123456789012345678901234567890;protocol=https;branch=master",
-
         ("gitsm://git.qemu.org/git/seabios.git/;protocol=https;name=roms/seabios;subpath=roms/seabios;bareclone=1;nobranch=1;rev=1234567890123456789012345678901234567890", "gitsm://.*/.*", "http://petalinux.xilinx.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads") : "http://petalinux.xilinx.com/sswreleases/rel-v%24%7BXILINX_VER_MAIN%7D/downloads/git2_git.qemu.org.git.seabios.git..tar.gz",
+        ("https://somewhere.org/example/1.0.0/example;downloadfilename=some-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/PATH")
+            : "file:///mirror/example/1.0.0/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz",
+        ("https://somewhere.org/example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz", "https://.*/.*", "file:///mirror/some-example-1.0.0.tgz")
+            : "file:///mirror/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz",
 
         #Renaming files doesn't work
         #("http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere.org/somedir1/somefile_1.2.3.tar.gz", "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz") : "http://somewhere2.org/somedir3/somefile_2.3.4.tar.gz"

