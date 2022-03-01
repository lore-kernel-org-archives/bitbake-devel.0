Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E923C433EF
	for <webhook@archiver.kernel.org>; Tue,  1 Mar 2022 01:30:56 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web08.3310.1646098255008730618
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Feb 2022 17:30:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57,
 mailfrom: mark.hatle@kernel.crashing.org)
Received: from lons-builder.int.hatle.net (ip203.trans.bevcomm.net
 [76.164.132.203] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 2211Us7p019930
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Feb 2022 19:30:54 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] Change md5 usages to work on FIPS enabled hosts
Date: Mon, 28 Feb 2022 19:30:53 -0600
Message-Id: <20220301013053.1378917-1-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Mar 2022 01:30:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13402

hashlib.md5() is not permitted on a FIPS enabled host system.  This is due
to md5 not being an approved hash algorithm.

Instead use:
 hashlib.new('MD5', usedforsecurity=False)

This is allowed, as it's clear the hash is used for a non-security purpose.

Note: utils.py version should never be used to verify file integrity, but
instead be used to identify if the file may have changed.  sha256 should be
used for integrity purposes.

Signed-off-by: Mark Hatle <mark.hatle@xilinx.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 lib/bb/utils.py | 2 +-
 lib/ply/yacc.py | 7 ++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 2e825610..fcaeb991 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -538,7 +538,7 @@ def md5_file(filename):
     Return the hex string representation of the MD5 checksum of filename.
     """
     import hashlib
-    return _hasher(hashlib.md5(), filename)
+    return _hasher(hashlib.new('MD5', usedforsecurity=False), filename)
 
 def sha256_file(filename):
     """
diff --git a/lib/ply/yacc.py b/lib/ply/yacc.py
index 46e7dc96..767c4e46 100644
--- a/lib/ply/yacc.py
+++ b/lib/ply/yacc.py
@@ -2797,11 +2797,8 @@ class ParserReflect(object):
     # Compute a signature over the grammar
     def signature(self):
         try:
-            from hashlib import md5
-        except ImportError:
-            from md5 import md5
-        try:
-            sig = md5()
+            import hashlib
+            sig = hashlib.new('MD5', usedforsecurity=False)
             if self.start:
                 sig.update(self.start.encode('latin-1'))
             if self.prec:
-- 
2.25.1


