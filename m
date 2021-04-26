Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.3888.1619422215543542574
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 00:30:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=TpQrGZLl;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1619422216;
  x=1650958216;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6OXIwfJfuxJROkWf/G6fJvvax6dyJeqSP4I4fwRu4AM=;
  b=TpQrGZLlDxXnG0O5vr7PsU8YH1yyFnPe3PGMHVwk4t7f3FOLnTN4w/PC
   URLwqzBTIZmFsIfkycGvaxNQQIMrJHnhHX/6lo7nNchLITJcE2YEua0YX
   Cme7A2Zxz/Y0Vt/Ga78kktoHC+QhjqetS17k0MaAZtCotVHR1DAb5SAmN
   OWbhRHFPBj1/7/vlwx2yyLsNCSCf4bo4soBuTel7x1UX6TVBLykp84wlU
   1JL1v08mhTtaAUg8yAvX1lR01BK2s1bFpHyxh/JVnFA0ivvGpM+7R3UTg
   KOX4tsz1FqqxWM29/wYqvXnvrigp32tnqeO4Fi6LIoyOUXyUHqgS2uMV1
   g==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [gatesgarth][PATCH 1/2] cache: Make CoreRecipeInfo include rprovides_pkg for skipped recipes
Date: Mon, 26 Apr 2021 09:30:02 +0200
Message-ID: <20210426073003.30489-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

This will be needed by SkippedPackage in the cooker.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 9e0c931a..029753fe 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -26,7 +26,7 @@ import re
 
 logger = logging.getLogger("BitBake.Cache")
 
-__cache_version__ = "153"
+__cache_version__ = "154"
 
 def getCacheFile(path, filename, mc, data_hash):
     mcspec = ''
@@ -94,6 +94,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         if not self.packages:
             self.packages.append(self.pn)
         self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
+        self.rprovides_pkg = self.pkgvar('RPROVIDES', self.packages, metadata)
 
         self.skipreason = self.getvar('__SKIPPED', metadata)
         if self.skipreason:
@@ -120,7 +121,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.depends          = self.depvar('DEPENDS', metadata)
         self.rdepends         = self.depvar('RDEPENDS', metadata)
         self.rrecommends      = self.depvar('RRECOMMENDS', metadata)
-        self.rprovides_pkg    = self.pkgvar('RPROVIDES', self.packages, metadata)
         self.rdepends_pkg     = self.pkgvar('RDEPENDS', self.packages, metadata)
         self.rrecommends_pkg  = self.pkgvar('RRECOMMENDS', self.packages, metadata)
         self.inherits         = self.getvar('__inherit_cache', metadata, expand=False)
