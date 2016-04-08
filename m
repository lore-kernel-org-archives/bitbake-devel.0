Return-Path: <elliot.smith@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B80C576988
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Apr 2016 08:39:49 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 08 Apr 2016 01:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,449,1455004800"; d="scan'208";a="780670152"
Received: from kjmurthy-mobl6.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.12.14])
	by orsmga003.jf.intel.com with ESMTP; 08 Apr 2016 01:39:31 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Apr 2016 09:39:28 +0100
Message-Id: <1460104768-32379-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH] toaster: fixes for customimage package not found
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
X-List-Received-Date: Fri, 08 Apr 2016 08:39:49 -0000

From: Dave Lerner <dave.lerner@windriver.com>

For a custom image, if a search for a package results in no packages
found, then additional information should be presented to the user.
This is different than a 'no results' found for a search in other
contexts, for example, a search for a package in a non-customised build.
For a custom image, a package search failure can happen because the
package was not added to the custom image. This commit presents more
information to the user, suggesting why the package was not found in the
custom image.
The generic table view handling js changes to handle a new div
element no-results-special-... such that, if present, that template
section is shown rather than the default no-results-... section.

[YOCTO #9154]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/toastergui/static/js/customrecipe.js   |  9 +++++++++
 bitbake/lib/toaster/toastergui/static/js/table.js  | 11 +++++++++--
 .../toaster/toastergui/templates/customrecipe.html | 22 ++++++++++++----------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/static/js/customrecipe.js b/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
index a31c268..1c0ef9e 100644
--- a/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
+++ b/bitbake/lib/toaster/toastergui/static/js/customrecipe.js
@@ -265,6 +265,15 @@ function customRecipePageInit(ctx) {
     });
   }
 
+  $("#no-results-show-all-packages").click(function(){
+    $(".no-results-search-input").val("");
+  });
+
+  $("#no-results-remove-search-btn").click(function(){
+      $(".no-results-search-input").val("");
+      $(this).hide();
+  });
+
   /* Trigger a build of your custom image */
   $(".build-custom-image").click(function(){
     libtoaster.startABuild(null, ctx.recipe.name,
diff --git a/bitbake/lib/toaster/toastergui/static/js/table.js b/bitbake/lib/toaster/toastergui/static/js/table.js
index a7e4fba..2ae7695 100644
--- a/bitbake/lib/toaster/toastergui/static/js/table.js
+++ b/bitbake/lib/toaster/toastergui/static/js/table.js
@@ -75,8 +75,15 @@ function tableInit(ctx){
 
     if (tableData.total === 0){
       tableContainer.hide();
-      $("#new-search-input-"+ctx.tableName).val(tableParams.search);
-      $("#no-results-"+ctx.tableName).show();
+      if ($("#no-results-special-"+ctx.tableName).length > 0) {
+        /* use this page's special no-results form instead of the default */
+        $("#no-results-search-input-"+ctx.tableName).val(tableParams.search);
+        $("#no-results-special-"+ctx.tableName).show();
+        $("#results-found-"+ctx.tableName).hide();
+      } else {
+        $("#new-search-input-"+ctx.tableName).val(tableParams.search);
+        $("#no-results-"+ctx.tableName).show();
+      }
       table.trigger("table-done", [tableData.total, tableParams]);
 
       return;
diff --git a/bitbake/lib/toaster/toastergui/templates/customrecipe.html b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
index 4b58992..ea3c9c7 100644
--- a/bitbake/lib/toaster/toastergui/templates/customrecipe.html
+++ b/bitbake/lib/toaster/toastergui/templates/customrecipe.html
@@ -103,25 +103,26 @@
         Download recipe file
       </a>
     </div>
-    <div id="no-package-results" class="air" style="display:none;">
+    <div id="no-results-special-{{table_name}}" class="air" style="display:none;">
       <div class="alert">
         <h3>No packages found</h3>
-        <p>You might consider <a href="all-software-recipes.html">searching the list of recipes</a> instead. If you find a recipe that matches the name of the package you want:</p>
+        <p>You might consider <a href={% url 'projectsoftwarerecipes' project.id %}>searching the list of recipes</a> instead. If you find a recipe that matches the name of the package you want:</p>
         <ol>
           <li>Add the layer providing the recipe to your project</li>
           <li>Build the recipe</li>
           <li>Once the build completes, come back to this page and search for the package</li>
         </ol>
         <form class="input-append no-results">
-          <input type="text" class="input-xlarge" value="search query">
-            <a href="#" class="add-on btn">
-              <i class="icon-remove"></i>
-            </a>
-            <button class="btn">Search</button>
-            <button class="btn btn-link" id="show-all">Show all packages</button>
-          </form>
-        </div>
+          <input type="text" class="input-xlarge no-results-search-input" id="no-results-search-input-{{table_name}}" name="search" placeholder="Search {{title|lower}}" />
+          <a href="#" class="add-on btn" id="no-results-remove-search-btn" tabindex="-1">
+            <i class="icon-remove"></i>
+          </a>
+          <button class="btn search-submit-{{table_name}}">Search</button>
+          <button class="btn btn-link" id="no-results-show-all-packages">Show all packages</button>
+        </form>
+      </div>
       </div>
+      <div id="results-found-{{table_name}}">
       <div id="packages-table">
         {% if recipe.get_all_packages.count == 0 and last_build == None %}
         <h2> Add | Remove packages </h2>
@@ -136,6 +137,7 @@
         {% include "toastertable.html" %}
         {% endif %}
       </div>
+      </div>
     </div>
     <div class="span4 well">
       <h2 style="margin-bottom:20px;">About {{recipe.name}}</h2>
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


