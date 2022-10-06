Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A93C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 21:53:31 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.312.1665093207124053668
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Oct 2022 14:53:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net ([70.99.78.136])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 296LrPvp022228
	for <bitbake-devel@lists.openembedded.org>; Thu, 6 Oct 2022 16:53:25 -0500
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel][kirkstone,langdale,master][PATCH] utils/ply: Update
 md5 to better report errors with hashlib
Date: Thu,  6 Oct 2022 16:53:22 -0500
Message-Id: <1665093202-28238-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Oct 2022 21:53:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14027

In the case where hashlib is not available, the try would fail and fall
through resulting in a backtrace on the usage of the 'sig'.  The backtrace
itself was confusing and made it difficult to determine what went wrong.

Update the import to be in it's own try block with an appropriate
message to indicate what went wrong.

Note, the current version of ply all of this code has been restructured
so this is not applicable upstream.

Additionally, some versions of hashlib don't appear to implement the
second FIPS related argument.  Detect this and support both versions.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
This was found on an internal Ubuntu 18.04 container.  Unfortunately I
don't have access to the container itself but this resolves the issue.

 bitbake/lib/bb/utils.py | 7 ++++++-
 bitbake/lib/ply/yacc.py | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e6e21e20fe..64a004d0d8 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -547,7 +547,12 @@ def md5_file(filename):
     Return the hex string representation of the MD5 checksum of filename.
     """
     import hashlib
-    return _hasher(hashlib.new('MD5', usedforsecurity=False), filename)
+    try:
+        sig = hashlib.new('MD5', usedforsecurity=False)
+    except TypeError:
+        # Some configurations don't appear to support two arguments
+        sig = hashlib.new('MD5')
+    return _hasher(sig, filename)
 
 def sha256_file(filename):
     """
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index 767c4e4674..381b50cf0b 100644
--- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -2798,7 +2798,14 @@ class ParserReflect(object):
     def signature(self):
         try:
             import hashlib
+        except ImportError:
+            raise RuntimeError("Unable to import hashlib")
+        try:
             sig = hashlib.new('MD5', usedforsecurity=False)
+        except TypeError:
+            # Some configurations don't appear to support two arguments
+            sig = hashlib.new('MD5')
+        try:
             if self.start:
                 sig.update(self.start.encode('latin-1'))
             if self.prec:
-- 
2.17.1


