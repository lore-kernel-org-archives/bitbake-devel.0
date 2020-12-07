Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.1496.1607377161300151649
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Dec 2020 13:39:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=gc00Yq9N;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=axis.com; q=dns/txt; s=axis-central1; t=1607377161;
  x=1638913161;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8KO1dBbR8hgneN84DD5tO839HhW+r14BF5ZKNIwfy1U=;
  b=gc00Yq9NWz1ELavfxOisMDDCykO1m2S2M3PgKqOhbZFvonH08oaK+dpx
   FShnTUjLE+XsalSBebwdwZYoCNxf3oeAt1eR/ODuUwfasQClGLDiSer+Z
   MpeX/9IkbkYAqpkAVmYBi5wKpVxDcVI6PFbya0z8XCGLRzyB4qSJvg8jG
   cSBvFy4/CvHIZ2cK2iyPsnj/HeYMTgEQfezEt+3wuGGm/3/edjDmDrJ6k
   pCugTp2b9rgyHsvHTBJ9UqC05FdxW0kdIGDVgW9hmxomCgx8EIKCPdM8d
   N3PdyPEMy7vlEE/U3qk1S59/tpcrWGAZJSjXp4TX5QeWSai6kM7j2m8Jn
   w==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] cache: Make CoreRecipeInfo include rprovides_pkg for skipped recipes
Date: Mon, 7 Dec 2020 22:38:50 +0100
Message-ID: <20201207213851.3485-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This will be needed by SkippedPackage in the cooker.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cache.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index b8054e028b..36270d0093 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
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
