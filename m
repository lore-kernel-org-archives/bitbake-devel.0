Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id E899E7F03A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Jul 2019 03:02:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x6C32PK8003268
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Jul 2019 20:02:25 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Thu, 11 Jul 2019 20:02:24 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 12 Jul 2019 11:26:15 +0800
Message-ID: <af05f775953106ed9ce7dd27e83b7da1970b0b1b.1562901936.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1562901936.git.liezhi.yang@windriver.com>
References: <cover.1562901936.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] cache: Set packages for skipped recipes
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
X-List-Received-Date: Fri, 12 Jul 2019 03:02:25 -0000
Content-Type: text/plain

The provides and rprovides had been set for skipped recipes, packages are
similar to them (all of them provide something), so also set it. This makes it
easier to figure out the RDEPENDS issues, for example, lmsensors
(lmsensors_3.5.0.bb) RRECOMMENDS lmsensors-config-fancontrol
(lmsensors-config_1.0.bb), but lmsensors-config is skipped for some reasons,
then if we run:

$ bitbake lmsensors
ERROR: Nothing RPROVIDES 'lmsensors-config-fancontrol' (but /path/to/lmsensors_3.5.0.bb RDEPENDS on or otherwise requires it)
NOTE: Runtime target 'lmsensors-config-fancontrol' is unbuildable, removing...
Missing or unbuildable dependency chain was: ['lmsensors-config-fancontrol']
ERROR: Required build target 'lmsensors' has no buildable providers.
Missing or unbuildable dependency chain was: ['lmsensors', 'lmsensors-config-fancontrol']

We had no way to know who rprovides lmsensors-config-fancontrol, we can figure
it out by bitbake/contrib/dump_cache.py after this patch.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cache.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 62d43ee..bec8ef7 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -85,19 +85,19 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         self.provides  = self.depvar('PROVIDES', metadata)
         self.rprovides = self.depvar('RPROVIDES', metadata)
+        self.pn = self.getvar('PN', metadata) or bb.parse.vars_from_file(filename,metadata)[0]
+        self.packages = self.listvar('PACKAGES', metadata)
+        if not self.packages:
+            self.packages.append(self.pn)
+        self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
+
         self.skipreason = self.getvar('__SKIPPED', metadata)
         if self.skipreason:
-            self.pn = self.getvar('PN', metadata) or bb.parse.vars_from_file(filename,metadata)[0]
             self.skipped = True
             return
 
         self.tasks = metadata.getVar('__BBTASKS', False)
 
-        self.pn = self.getvar('PN', metadata)
-        self.packages = self.listvar('PACKAGES', metadata)
-        if not self.packages:
-            self.packages.append(self.pn)
-
         self.basetaskhashes = self.taskvar('BB_BASEHASH', self.tasks, metadata)
         self.hashfilename = self.getvar('BB_HASHFILENAME', metadata)
 
@@ -113,7 +113,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.stampclean = self.getvar('STAMPCLEAN', metadata)
         self.stamp_extrainfo = self.flaglist('stamp-extra-info', self.tasks, metadata)
         self.file_checksums = self.flaglist('file-checksums', self.tasks, metadata, True)
-        self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
         self.depends          = self.depvar('DEPENDS', metadata)
         self.rdepends         = self.depvar('RDEPENDS', metadata)
         self.rrecommends      = self.depvar('RRECOMMENDS', metadata)
-- 
2.7.4


