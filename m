Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7DDC433FE
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:47 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.1520.1643423382741682585
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=FXwBuGVY;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423386;
  x=1674959386;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vE4M3bGPDw8yGo3rX4lR3FA0kxkDhcdEOXi/Z0S6+Kw=;
  b=FXwBuGVY3SkoEVYMSlSZF+vp3+QD7+Mq3vsfadXXUiSkPG+fGLAWRBR/
   yLjql4Gk7LmuQ7UFM1Pqtm6EHk5AyOuhcR7SUBU7IM4JKLLbc+zVSsWma
   viE+20Y+6LJFeeAXVnstSbZLFWvzQQ6d6gKlgjncoRi/75664gv0ErvJ/
   8vA5u9dm5YxeMwzNkz62YyhSbAoB5jqA1BfP1gHFBvpIchjwjCvRAehTv
   V4IbxEwuVtY2Rg3MEWCBXcS456mm87CD11OXfy37DoxudKFp/rHI8y/VE
   RCdSoAarJ7lXCYOS4Iw9aRcpenwdGcLwG9VOJnfcY8SkYrKBnnEu+nbvr
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 9/9] fetch2: npm: Put all downloaded files in the npm2
 directory
Date: Sat, 29 Jan 2022 03:29:39 +0100
Message-ID: <20220129022939.19329-9-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220129022939.19329-1-pkj@axis.com>
References: <20220129022939.19329-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13302

Previously npm files that specify downloadfilename= in the SRC_URI
would be downloaded to the root of ${DL_DIR} rather than in the
${DL_DIR}/npm2 directory where all other npm files are downloaded.
This should make it simpler when setting up and configuring a
premirror with the downloaded npm packages.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/npm.py   | 10 +++++++---
 bitbake/lib/bb/fetch2/npmsw.py |  2 +-
 bitbake/lib/bb/tests/fetch.py  |  2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/npm.py b/bitbake/lib/bb/fetch2/npm.py
index b3a3a444ee..8f7c10ac9b 100644
--- a/bitbake/lib/bb/fetch2/npm.py
+++ b/bitbake/lib/bb/fetch2/npm.py
@@ -52,9 +52,13 @@ def npm_filename(package, version):
     """Get the filename of a npm package"""
     return npm_package(package) + "-" + version + ".tgz"
 
-def npm_localfile(package, version):
+def npm_localfile(package, version=None):
     """Get the local filename of a npm package"""
-    return os.path.join("npm2", npm_filename(package, version))
+    if version is not None:
+        filename = npm_filename(package, version)
+    else:
+        filename = package
+    return os.path.join("npm2", filename)
 
 def npm_integrity(integrity):
     """
@@ -157,7 +161,7 @@ class Npm(FetchMethod):
         # Using the 'downloadfilename' parameter as local filename
         # or the npm package name.
         if "downloadfilename" in ud.parm:
-            ud.localfile = d.expand(ud.parm["downloadfilename"])
+            ud.localfile = npm_localfile(d.expand(ud.parm["downloadfilename"]))
         else:
             ud.localfile = npm_localfile(ud.package, ud.version)
 
diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw.py
index 879ba5de0f..a8c4d3528f 100644
--- a/bitbake/lib/bb/fetch2/npmsw.py
+++ b/bitbake/lib/bb/fetch2/npmsw.py
@@ -117,7 +117,7 @@ class NpmShrinkWrap(FetchMethod):
 
             # Handle http tarball sources
             elif version.startswith("http") and integrity:
-                localfile = os.path.join("npm2", os.path.basename(version))
+                localfile = npm_localfile(os.path.basename(version))
 
                 uri = URI(version)
                 uri.params["downloadfilename"] = localfile
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 8b13e178e6..3fd8fac229 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2399,7 +2399,7 @@ class NPMTest(FetcherTest):
         url = 'npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0;destsuffix=foo/bar;downloadfilename=foo-bar.tgz'
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'foo-bar.tgz')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'foo-bar.tgz')))
         fetcher.unpack(self.unpackdir)
         unpackdir = os.path.join(self.unpackdir, 'foo', 'bar')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))

