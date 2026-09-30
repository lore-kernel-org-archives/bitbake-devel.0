Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A0CA5FB1
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 08:34:43 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8946.1790757282097387269
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Sep 2026 01:34:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=G4au2R4j;
 spf=pass (domain: snapchat.com, ip: 74.125.225.140, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso15726325e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790757280; x=1791362080; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jUXsmbEju44Biu6rx3QfljyBSwLJBg7uNl174w1vRwM=;
        b=G4au2R4j5NSoBtU4fiT20Mc9PdnvGjLFaN5nceI/7WQ6zdmdTUpGlIi2zV46UtMrE/
         Mn+HEph/YEpEg0rkLF8ZGZrq1RDqMu7j8nJOjEcc2/8bA1J0AtybjMCm08eFh6l4gucU
         jG/3zTuERWZc5S9bw/I29fPYb3XpYB0X8B0Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790757280; x=1791362080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUXsmbEju44Biu6rx3QfljyBSwLJBg7uNl174w1vRwM=;
        b=MswtXBMvmgYmYRp8CD9hXMByjrg2ACmF5Vpqf1+YuO/jn/R059xBjYUd+QX5gEpzJe
         BI84ySahT8dfGCWLcjJIfL3MeciS/dXgJecY/Z6eQ0fr0OzBrFFzxxCEipS9jN3Nq0td
         BMbPzn6IZhzr7g6R+LDpcUbbG1i0ImGOpwhTzdSCgsXdjxb3LSc2P24dSJK4RZwPFTRC
         zogsxq6tayk/XU05P/qW3KjVMmzl0TS9IpkccQnLrgweBfCWquey/wg90UwGxbE3j3gb
         4uzzOVgEWbeyH2H8vLfHHnAWfqMeHwEoN6Cx2yUUeVMOxcciazWKi9mMLG2ihomwedFk
         Vlsg==
X-Gm-Message-State: AFuF++kz7O4SHqIpEaXNxsis3QLB7Klq19QQa8ioP0tAxKeGVifgmVDK
	eL7onj2AjVtEc52JeTcQvqZo2VfMSZh3TQ2VMToonKgnDzjekb5xIdPHlPUo0T3nHoC8YR4Y++9
	Jn/Y0h6U=
X-Gm-Gg: AYBFou3jx3mG4J7xJOeIKS3FE0rpSrw9svfWKtUjdZQBT5bzhNkuN+BNSGrmMHnHSiF
	bjvj5RpWh48fvj2vaIHZGqN2sZW+s+cUoq6RcdBWKYdoAgRF2SaaQ2GNWNzdWSRm+6JBhCK5JeH
	dJet37XVHqbBbJIAaoYFA2v+d2AAmBDGspiYQtyUozWRWuIwBJonFtlhwBISbRaKZwyn3EI6Q+5
	+W470IiaMkDA7Eg0BlB2A2IXNLDC0KdAkl1EPVaNVKp12RheGK9e+zHCt0xSub3CqEslNvjaNKx
	m139vaRqWI4dn9tkuj/eqbv+/ADJ5QEvMbxyyaoKsmMmAY1cE+LHsTzCZzI62LzdaRFXKnFUGNP
	espnm6/KaeXy53gxJbdfnyHN4nohp/f7k95nP7EsQdcs5vhSkoFPsVtOLoyU9ZhQ+J4rOQQ6Dam
	UmBWE9xuelzwPhKhZG26doo6hEl6KQQteu2dQR2sPJcCEA40TBmxnTke1llGxw73bNlqOAP+Rvx
	66EWMHJ/QBwG+rAsTwF1sBq67Y1VHikEkfx+JkinCM=
X-Received: by 2002:a05:600c:1c20:b0:4a0:25c:8af2 with SMTP id 5b1f17b1804b1-4a01afe073bmr11539605e9.17.1790757280100;
        Wed, 30 Sep 2026 01:34:40 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0175161c2sm42632115e9.4.2026.09.30.01.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:34:39 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH v2] cache: Cache missing files in the mtime cache
Date: Wed, 30 Sep 2026 10:34:37 +0200
Message-ID: <20260930083437.2242917-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Sep 2026 08:34:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20282

From: Etienne Cordonnier <ecordonnier@snap.com>

cacheValidUpdate() looks up file_depends entries with
bb.parse.cached_mtime_noerror() and file_checksums entries with
os.path.exists(). Neither caches a missing file, so the same non-existent
paths are stat()ed again on every lookup.

In a warm parse of 5,111 targets there are 585,773 file_checksums lookups
for 48,907 unique paths, and 300,648 file_depends lookups for only 545
missing files.

Record failed lookups in the mtime cache (as 0) and use it for the
file_checksums existence check as well. A warm 'bitbake -p' goes from 6.56s
to 5.82s (median of 12 runs).

AI-Generated: Uses Claude Code (Claude Sonnet 5.5)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/cache.py          | 3 ++-
 lib/bb/parse/__init__.py | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 24bde62a9..d05d341f4 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -619,7 +619,8 @@ class Cache(object):
                     if not f:
                         continue
                     f, exist = f.rsplit(":", 1)
-                    if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
+                    file_exists = bb.parse.cached_mtime_noerror(f) != 0
+                    if (exist == "True" and not file_exists) or (exist == "False" and file_exists):
                         self.logger.debug2("%s's file checksum list file %s changed",
                                              fn, f)
                         self.remove(fn)
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index d428d8a4b..815ff1279 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -48,18 +48,22 @@ class SkipPackage(SkipRecipe):
 
 __mtime_cache = {}
 def cached_mtime(f):
-    if f not in __mtime_cache:
+    # A cached 0 is a failure recorded by cached_mtime_noerror(), stat again
+    # to raise the real error (or pick up the file if it has appeared since)
+    if __mtime_cache.get(f, 0) == 0:
         res = os.stat(f)
         __mtime_cache[f] = (res.st_mtime_ns, res.st_size, res.st_ino)
     return __mtime_cache[f]
 
 def cached_mtime_noerror(f):
+    # Failures are cached as 0 so that repeated lookups of a missing file
+    # don't hit the filesystem again
     if f not in __mtime_cache:
         try:
             res = os.stat(f)
             __mtime_cache[f] = (res.st_mtime_ns, res.st_size, res.st_ino)
         except OSError:
-            return 0
+            __mtime_cache[f] = 0
     return __mtime_cache[f]
 
 def check_mtime(f, mtime):
-- 
2.43.0


