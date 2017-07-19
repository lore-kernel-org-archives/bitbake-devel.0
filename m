Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0A7D5781F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:43 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410402"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:01 +0200
Message-Id: <f0c4e01c7e36cfd767b540ad490547af4c34e794.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 02/12] tinfoil: add a parse_recipes() function
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:43 -0000

Python style recommends underscore based naming rather than camelCase,
and thus the former has been used for most of tinfoil's functions. Add
an underscored version of parseRecipes() for consistency and change the
one place we call it to use the new version.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 2 +-
 lib/bb/tinfoil.py  | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 04e6bec..d184011 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -90,7 +90,7 @@ def main():
 
         if getattr(args, 'parserecipes', False):
             tinfoil.config_data.disableTracking()
-            tinfoil.parseRecipes()
+            tinfoil.parse_recipes()
             tinfoil.config_data.enableTracking()
 
         return args.func(args)
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index b45acea..e027930 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -289,7 +289,13 @@ class Tinfoil:
 
     def parseRecipes(self):
         """
-        Force a parse of all recipes. Normally you should specify
+        Legacy function - use parse_recipes() instead.
+        """
+        self.parse_recipes()
+
+    def parse_recipes(self):
+        """
+        Load information on all recipes. Normally you should specify
         config_only=False when calling prepare() instead of using this
         function; this function is designed for situations where you need
         to initialise Tinfoil and use it with config_only=True first and
-- 
2.9.4


