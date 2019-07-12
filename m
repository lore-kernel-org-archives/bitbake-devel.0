Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E0CAF7F03A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 03:02:32 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x6C328jp020785
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 20:02:24 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Thu, 11 Jul 2019 20:02:19 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 12 Jul 2019 11:26:14 +0800
Message-ID: <f11c09f963ec2ff2e31e41656ff34f4a2ccb9c50.1562901936.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1562901936.git.liezhi.yang@windriver.com>
References: <cover.1562901936.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] cache: Remove duplicated lines for provides and rprovides
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
X-List-Received-Date: Fri, 12 Jul 2019 03:02:33 -0000
Content-Type: text/plain

Whether skip or not, they are always set, so move the lines ahead to avoid
duplicated lines.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 5fb2f17..62d43ee 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -83,12 +83,12 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.appends = self.listvar('__BBAPPEND', metadata)
         self.nocache = self.getvar('BB_DONT_CACHE', metadata)
 
+        self.provides  = self.depvar('PROVIDES', metadata)
+        self.rprovides = self.depvar('RPROVIDES', metadata)
         self.skipreason = self.getvar('__SKIPPED', metadata)
         if self.skipreason:
             self.pn = self.getvar('PN', metadata) or bb.parse.vars_from_file(filename,metadata)[0]
             self.skipped = True
-            self.provides  = self.depvar('PROVIDES', metadata)
-            self.rprovides = self.depvar('RPROVIDES', metadata)
             return
 
         self.tasks = metadata.getVar('__BBTASKS', False)
@@ -115,9 +115,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.file_checksums = self.flaglist('file-checksums', self.tasks, metadata, True)
         self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
         self.depends          = self.depvar('DEPENDS', metadata)
-        self.provides         = self.depvar('PROVIDES', metadata)
         self.rdepends         = self.depvar('RDEPENDS', metadata)
-        self.rprovides        = self.depvar('RPROVIDES', metadata)
         self.rrecommends      = self.depvar('RRECOMMENDS', metadata)
         self.rprovides_pkg    = self.pkgvar('RPROVIDES', self.packages, metadata)
         self.rdepends_pkg     = self.pkgvar('RDEPENDS', self.packages, metadata)
-- 
2.7.4


