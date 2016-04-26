Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 346EC601A4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Apr 2016 16:18:19 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 26 Apr 2016 09:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,537,1455004800"; d="scan'208";a="963133140"
Received: from mkamins1-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.29.92])
	by orsmga002.jf.intel.com with ESMTP; 26 Apr 2016 09:18:16 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Apr 2016 17:18:06 +0100
Message-Id: <1461687487-31757-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 1/2] toaster: orm Add get_base_recipe_file to CustomImageRecipe
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
X-List-Received-Date: Tue, 26 Apr 2016 16:18:21 -0000

From: Michael Wood <michael.g.wood@intel.com>

This function returns the base recipe file path only if it currently
exists. This allows us to know whether we can proceed at this point with
generating a custom image recipe. It also enables us to call this
function from the templates to enable visual indication of this state.

Some whitespace fixes also added in generate_recipe_file_contents

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/orm/models.py | 60 ++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 0b83b99..6716ddf 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -1585,6 +1585,21 @@ class CustomImageRecipe(Recipe):
                                                   Q(recipe_includes=self)) &
                                                  ~Q(recipe_excludes=self))
 
+    def get_base_recipe_file(self):
+        """Get the base recipe file path if it exists on the file system"""
+        path_schema_one = "%s/%s" % (self.base_recipe.layer_version.dirpath,
+                                     self.base_recipe.file_path)
+
+        path_schema_two = self.base_recipe.file_path
+
+        if os.path.exists(path_schema_one):
+            return path_schema_one
+
+        # The path may now be the full path if the recipe has been built
+        if os.path.exists(path_schema_two):
+            return path_schema_two
+
+        return None
 
     def generate_recipe_file_contents(self):
         """Generate the contents for the recipe file."""
@@ -1599,17 +1614,16 @@ class CustomImageRecipe(Recipe):
             # We add all the known packages to be built by this recipe apart
             # from locale packages which are are controlled with IMAGE_LINGUAS.
             for pkg in self.get_all_packages().exclude(
-                name__icontains="locale"):
+                    name__icontains="locale"):
                 packages_conf += pkg.name+' '
 
         packages_conf += "\""
-        try:
-            base_recipe = open("%s/%s" %
-                               (self.base_recipe.layer_version.dirpath,
-                                self.base_recipe.file_path), 'r').read()
-        except IOError:
-            # The path may now be the full path if the recipe has been built
-            base_recipe = open(self.base_recipe.file_path, 'r').read()
+
+        base_recipe_path = self.get_base_recipe_file()
+        if base_recipe_path:
+            base_recipe = open(base_recipe_path, 'r').read()
+        else:
+            raise IOError("Based on recipe file not found")
 
         # Add a special case for when the recipe we have based a custom image
         # recipe on requires another recipe.
@@ -1618,8 +1632,8 @@ class CustomImageRecipe(Recipe):
         # "require recipes-core/images/core-image-minimal.bb"
 
         req_search = re.search(r'(require\s+)(.+\.bb\s*$)',
-                                   base_recipe,
-                                   re.MULTILINE)
+                               base_recipe,
+                               re.MULTILINE)
         if req_search:
             require_filename = req_search.group(2).strip()
 
@@ -1629,19 +1643,19 @@ class CustomImageRecipe(Recipe):
 
             new_require_line = "require %s" % corrected_location
 
-            base_recipe = \
-                    base_recipe.replace(req_search.group(0), new_require_line)
-
-
-        info = {"date" : timezone.now().strftime("%Y-%m-%d %H:%M:%S"),
-                "base_recipe" : base_recipe,
-                "recipe_name" : self.name,
-                "base_recipe_name" : self.base_recipe.name,
-                "license" : self.license,
-                "summary" : self.summary,
-                "description" : self.description,
-                "packages_conf" : packages_conf.strip(),
-               }
+            base_recipe = base_recipe.replace(req_search.group(0),
+                                              new_require_line)
+
+        info = {
+            "date": timezone.now().strftime("%Y-%m-%d %H:%M:%S"),
+            "base_recipe": base_recipe,
+            "recipe_name": self.name,
+            "base_recipe_name": self.base_recipe.name,
+            "license": self.license,
+            "summary": self.summary,
+            "description": self.description,
+            "packages_conf": packages_conf.strip()
+        }
 
         recipe_contents = ("# Original recipe %(base_recipe_name)s \n"
                            "%(base_recipe)s\n\n"
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


