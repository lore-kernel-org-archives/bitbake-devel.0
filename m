Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0CED47823A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:49 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410424"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:07 +0200
Message-Id: <f408e0fc4474ad7089a7d464119dc1c7e6e89e7f.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 08/12] tinfoil: enable access to additional cached items
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:49 -0000

Add access to fn_provides, packages, packages_dynamic and rproviders on
the recipecache object. This requires an additional corresponding
command plumbing to be added.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 32 ++++++++++++++++++++++++++++++++
 lib/bb/tinfoil.py |  8 ++++++++
 2 files changed, 40 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 01a2c61..4c00a34 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -307,6 +307,38 @@ class CommandsSync:
         return command.cooker.recipecaches[mc].pkg_pepvpr
     getRecipeVersions.readonly = True
 
+    def getRecipeProvides(self, command, params):
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.recipecaches[mc].fn_provides
+    getRecipeProvides.readonly = True
+
+    def getRecipePackages(self, command, params):
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.recipecaches[mc].packages
+    getRecipePackages.readonly = True
+
+    def getRecipePackagesDynamic(self, command, params):
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.recipecaches[mc].packages_dynamic
+    getRecipePackagesDynamic.readonly = True
+
+    def getRProviders(self, command, params):
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.recipecaches[mc].rproviders
+    getRProviders.readonly = True
+
     def getRuntimeDepends(self, command, params):
         ret = []
         try:
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 580ce8d..feaeb56 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -173,6 +173,14 @@ class TinfoilCookerAdapter:
                 attrvalue = self.tinfoil.run_command('getBbFilePriority') or {}
             elif name == 'pkg_dp':
                 attrvalue = self.tinfoil.run_command('getDefaultPreference') or {}
+            elif name == 'fn_provides':
+                attrvalue = self.tinfoil.run_command('getRecipeProvides') or {}
+            elif name == 'packages':
+                attrvalue = self.tinfoil.run_command('getRecipePackages') or {}
+            elif name == 'packages_dynamic':
+                attrvalue = self.tinfoil.run_command('getRecipePackagesDynamic') or {}
+            elif name == 'rproviders':
+                attrvalue = self.tinfoil.run_command('getRProviders') or {}
             else:
                 raise AttributeError("%s instance has no attribute '%s'" % (self.__class__.__name__, name))
 
-- 
2.9.4


