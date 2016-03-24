Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id AFDF86FF97
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 12:12:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 24 Mar 2016 05:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,385,1455004800"; d="scan'208";a="917905780"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.9.87])
	by orsmga001.jf.intel.com with ESMTP; 24 Mar 2016 05:12:49 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Mar 2016 12:12:11 +0000
Message-Id: <1458821531-10484-3-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1458821531-10484-1-git-send-email-elliot.smith@intel.com>
References: <1458821531-10484-1-git-send-email-elliot.smith@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 3/3] toaster: get all dependents for pkg for removal
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
X-List-Received-Date: Thu, 24 Mar 2016 12:12:49 -0000

From: Dave Lerner <dave.lerner@windriver.com>

For customised image package removal change behavior.
From:
    Only display the immediate dependents of the requested package
    to remove, not the full dependent list, that is dependents of
    dependents ...
    Do not remove the displayed dependents, just notify the user
    of the list.
To:
    Display the complete dependent tree, traversing all reverse
    dependencies starting from the package to be removed and then it's
    dependents.
    Change the modal dialog to note that all of these dependents will
    be removed automatically.

[YOCTO #9121]

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/views.py | 91 ++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 15760b3..cc7ad17 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -2538,6 +2538,60 @@ if True:
 
         return response
 
+    def _traverse_dependents(next_package_id, rev_deps, all_current_packages, tree_level=0):
+        """
+        Recurse through reverse dependency tree for next_package_id.
+        Limit the reverse dependency search to packages not already scanned,
+        that is, not already in rev_deps.
+        Limit the scan to a depth (tree_level) not exceeding the count of
+        all packages in the custom image, and if that depth is exceeded
+        return False, pop out of the recursion, and write a warning
+        to the log, but this is unlikely, suggesting a dependency loop
+        not caught by bitbake.
+        On return, the input/output arg rev_deps is appended with queryset
+        dictionary elements, annotated for use in the customimage template.
+        The list has unsorted, but unique elements.
+        """
+        max_dependency_tree_depth = all_current_packages.count()
+        if tree_level >= max_dependency_tree_depth:
+            logger.warning(
+                "The number of reverse dependencies "
+                "for this package exceeds " + max_dependency_tree_depth +
+                " and the remaining reverse dependencies will not be removed")
+            return True
+
+        package = CustomImagePackage.objects.get(id=next_package_id)
+        dependents = \
+            package.package_dependencies_target.annotate(
+                name=F('package__name'),
+                pk=F('package__pk'),
+                size=F('package__size'),
+            ).values("name", "pk", "size").exclude(
+                ~Q(pk__in=all_current_packages)
+            )
+
+        for pkg in dependents:
+            if pkg in rev_deps:
+                # already seen, skip dependent search
+                continue
+
+            rev_deps.append(pkg)
+            if (_traverse_dependents(
+                pkg["pk"], rev_deps, all_current_packages, tree_level+1)):
+                return True
+
+        return False
+
+    def _get_all_dependents(package_id, all_current_packages):
+        """
+        Returns sorted list of recursive reverse dependencies for package_id,
+        as a list of dictionary items, by recursing through dependency
+        relationships.
+        """
+        rev_deps = []
+        _traverse_dependents(package_id, rev_deps, all_current_packages)
+        rev_deps = sorted(rev_deps, key=lambda x: x["name"])
+        return rev_deps
 
     @xhr_response
     def xhr_customrecipe_packages(request, recipe_id, package_id):
@@ -2606,15 +2660,9 @@ if True:
                 )
 
                 # Reverse dependencies which are needed by packages that are
-                # in the image
-                reverse_deps = package.package_dependencies_target.annotate(
-                    name=F('package__name'),
-                    pk=F('package__pk'),
-                    size=F('package__size'),
-                ).values("name", "pk", "size").exclude(
-                    ~Q(pk__in=all_current_packages)
-                )
-
+                # in the image. Recursive search providing all dependents,
+                # not just immediate dependents.
+                reverse_deps = _get_all_dependents(package_id, all_current_packages)
                 total_size_deps = 0
                 total_size_reverse_deps = 0
 
@@ -2658,6 +2706,11 @@ if True:
 
             else:
                 recipe.appends_set.add(package)
+                # Make sure that package is not in the excludes set
+                try:
+                    recipe.excludes_set.remove(package)
+                except:
+                    pass
                 # Add the dependencies we think will be added to the recipe
                 # as a result of appending this package.
                 # TODO this should recurse down the entire deps tree
@@ -2668,11 +2721,12 @@ if True:
 
                         recipe.includes_set.add(cust_package)
                         try:
-                            # when adding the pre-requisite package make sure it's not in the
-                            #   excluded list from a prior removal.
+                            # When adding the pre-requisite package, make
+                            # sure it's not in the excluded list from a
+                            # prior removal.
                             recipe.excludes_set.remove(cust_package)
                         except Package.DoesNotExist:
-                            #   Don't care if the package had never been excluded
+                            # Don't care if the package had never been excluded
                             pass
                     except:
                         logger.warning("Could not add package's suggested"
@@ -2688,6 +2742,19 @@ if True:
                     recipe.excludes_set.add(package)
                 else:
                     recipe.appends_set.remove(package)
+                all_current_packages = recipe.get_all_packages()
+                reverse_deps_dictlist = _get_all_dependents(package.pk, all_current_packages)
+                ids = [entry['pk'] for entry in reverse_deps_dictlist]
+                reverse_deps = CustomImagePackage.objects.filter(id__in=ids)
+                for r in reverse_deps:
+                    try:
+                        if r.id in included_packages:
+                            recipe.excludes_set.add(r)
+                        else:
+                            recipe.appends_set.remove(r)
+                    except:
+                        pass
+
                 return {"error": "ok"}
             except CustomImageRecipe.DoesNotExist:
                 return {"error": "Tried to remove package that wasn't present"}
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


