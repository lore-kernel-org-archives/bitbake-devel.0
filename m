Return-Path: <elliot.smith@intel.com>
Received: from gainsboro.cherry.relay.mailchannels.net
	(gainsboro.cherry.relay.mailchannels.net [23.83.223.65])
	by mail.openembedded.org (Postfix) with ESMTP id C9E49731B9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:43:01 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 82210E00B4;
	Mon, 22 Aug 2016 15:42:57 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-107-69-155.us-west-2.compute.internal [10.107.69.155])
	by relay.mailchannels.net (Postfix) with ESMTPA id E81A1E1AF0;
	Mon, 22 Aug 2016 15:42:51 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com ([TEMPUNAVAIL].
	[10.45.13.172]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:54 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880572565:711990329
X-MC-Ingress-Time: 1471880572565
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN7-0002ZA-9w; Mon, 22 Aug 2016 11:42:45 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:33 +0100
Message-Id: <1471880556-9232-6-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 6/9] toaster: Move Custom image recipe rest api to api file
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
X-List-Received-Date: Mon, 22 Aug 2016 15:43:04 -0000

From: Michael Wood <michael.g.wood@intel.com>

We now have a dedicated file for the rest API so move and rework for
class based views. Also clean up all flake8 identified warnings.

Remove unused imports from toastergui views.

The original work for this API was done by Elliot Smith, Ed Bartosh,
Michael Wood and Dave Lerner

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/toastergui/api.py   | 469 +++++++++++++++++++++++++++++++-
 bitbake/lib/toaster/toastergui/urls.py  |  18 +-
 bitbake/lib/toaster/toastergui/views.py | 447 +-----------------------------
 3 files changed, 482 insertions(+), 452 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/api.py b/bitbake/lib/toaster/toastergui/api.py
index 09fb02b..be18090 100644
--- a/bitbake/lib/toaster/toastergui/api.py
+++ b/bitbake/lib/toaster/toastergui/api.py
@@ -16,21 +16,29 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+# Please run flake8 on this file before sending patches
 
-# Temporary home for the UI's misc API
 import re
+import logging
 
 from orm.models import Project, ProjectTarget, Build, Layer_Version
 from orm.models import LayerVersionDependency, LayerSource, ProjectLayer
+from orm.models import Recipe, CustomImageRecipe, CustomImagePackage
+from orm.models import Layer, Target, Package, Package_Dependency
 from bldcontrol.models import BuildRequest
 from bldcontrol import bbcontroller
+
 from django.http import HttpResponse, JsonResponse
 from django.views.generic import View
 from django.core.urlresolvers import reverse
-from django.core import serializers
 from django.utils import timezone
-from django.template.defaultfilters import date
+from django.db.models import Q, F
+from django.db import Error
 from toastergui.templatetags.projecttags import json, sectohms, get_tasks
+from toastergui.templatetags.projecttags import filtered_filesizeformat
+
+logger = logging.getLogger("toaster")
+
 
 def error_response(error):
     return JsonResponse({"error": error})
@@ -216,6 +224,7 @@ class XhrLayer(View):
             "redirect": reverse('project', args=(kwargs['pid'],))
         })
 
+
 class MostRecentBuildsView(View):
     def _was_yesterday_or_earlier(self, completed_on):
         now = timezone.now()
@@ -230,13 +239,11 @@ class MostRecentBuildsView(View):
         """
         Returns a list of builds in JSON format.
         """
-        mrb_type = 'all'
         project = None
 
         project_id = request.GET.get('project_id', None)
         if project_id:
             try:
-                mrb_type = 'project'
                 project = Project.objects.get(pk=project_id)
             except:
                 # if project lookup fails, assume no project
@@ -245,9 +252,6 @@ class MostRecentBuildsView(View):
         recent_build_objs = Build.get_recent(project)
         recent_builds = []
 
-        # for timezone conversion
-        tz = timezone.get_current_timezone()
-
         for build_obj in recent_build_objs:
             dashboard_url = reverse('builddashboard', args=(build_obj.pk,))
             buildtime_url = reverse('buildtime', args=(build_obj.pk,))
@@ -266,7 +270,8 @@ class MostRecentBuildsView(View):
             build['buildrequest_id'] = buildrequest_id
 
             build['recipes_parsed_percentage'] = \
-                int((build_obj.recipes_parsed / build_obj.recipes_to_parse) * 100)
+                int((build_obj.recipes_parsed /
+                     build_obj.recipes_to_parse) * 100)
 
             tasks_complete_percentage = 0
             if build_obj.outcome in (Build.SUCCEEDED, Build.FAILED):
@@ -300,7 +305,8 @@ class MostRecentBuildsView(View):
             completed_on_template = '%H:%M'
             if self._was_yesterday_or_earlier(completed_on):
                 completed_on_template = '%d/%m/%Y ' + completed_on_template
-            build['completed_on'] = completed_on.strftime(completed_on_template)
+            build['completed_on'] = completed_on.strftime(
+                completed_on_template)
 
             targets = []
             target_objs = build_obj.get_sorted_target_list()
@@ -323,3 +329,446 @@ class MostRecentBuildsView(View):
             recent_builds.append(build)
 
         return JsonResponse(recent_builds, safe=False)
+
+
+class XhrCustomRecipe(View):
+    """ Create a custom image recipe """
+
+    def post(self, request, *args, **kwargs):
+        """
+        Custom image recipe REST API
+
+        Entry point: /xhr_customrecipe/
+        Method: POST
+
+        Args:
+            name: name of custom recipe to create
+            project: target project id of orm.models.Project
+            base: base recipe id of orm.models.Recipe
+
+        Returns:
+            {"error": "ok",
+             "url": <url of the created recipe>}
+            or
+            {"error": <error message>}
+        """
+        # check if request has all required parameters
+        for param in ('name', 'project', 'base'):
+            if param not in request.POST:
+                return error_response("Missing parameter '%s'" % param)
+
+        # get project and baserecipe objects
+        params = {}
+        for name, model in [("project", Project),
+                            ("base", Recipe)]:
+            value = request.POST[name]
+            try:
+                params[name] = model.objects.get(id=value)
+            except model.DoesNotExist:
+                return error_response("Invalid %s id %s" % (name, value))
+
+        # create custom recipe
+        try:
+
+            # Only allowed chars in name are a-z, 0-9 and -
+            if re.search(r'[^a-z|0-9|-]', request.POST["name"]):
+                return error_response("invalid-name")
+
+            custom_images = CustomImageRecipe.objects.all()
+
+            # Are there any recipes with this name already in our project?
+            existing_image_recipes_in_project = custom_images.filter(
+                name=request.POST["name"], project=params["project"])
+
+            if existing_image_recipes_in_project.count() > 0:
+                return error_response("image-already-exists")
+
+            # Are there any recipes with this name which aren't custom
+            # image recipes?
+            custom_image_ids = custom_images.values_list('id', flat=True)
+            existing_non_image_recipes = Recipe.objects.filter(
+                Q(name=request.POST["name"]) & ~Q(pk__in=custom_image_ids)
+            )
+
+            if existing_non_image_recipes.count() > 0:
+                return error_response("recipe-already-exists")
+
+            # create layer 'Custom layer' and verion if needed
+            layer = Layer.objects.get_or_create(
+                name=CustomImageRecipe.LAYER_NAME,
+                summary="Layer for custom recipes",
+                vcs_url="file:///toaster_created_layer")[0]
+
+            # Check if we have a layer version already
+            # We don't use get_or_create here because the dirpath will change
+            # and is a required field
+            lver = Layer_Version.objects.filter(Q(project=params['project']) &
+                                                Q(layer=layer) &
+                                                Q(build=None)).last()
+            if lver is None:
+                lver, created = Layer_Version.objects.get_or_create(
+                    project=params['project'],
+                    layer=layer,
+                    dirpath="toaster_created_layer")
+
+            # Add a dependency on our layer to the base recipe's layer
+            LayerVersionDependency.objects.get_or_create(
+                layer_version=lver,
+                depends_on=params["base"].layer_version)
+
+            # Add it to our current project if needed
+            ProjectLayer.objects.get_or_create(project=params['project'],
+                                               layercommit=lver,
+                                               optional=False)
+
+            # Create the actual recipe
+            recipe, created = CustomImageRecipe.objects.get_or_create(
+                name=request.POST["name"],
+                base_recipe=params["base"],
+                project=params["project"],
+                layer_version=lver,
+                is_image=True)
+
+            # If we created the object then setup these fields. They may get
+            # overwritten later on and cause the get_or_create to create a
+            # duplicate if they've changed.
+            if created:
+                recipe.file_path = request.POST["name"]
+                recipe.license = "MIT"
+                recipe.version = "0.1"
+                recipe.save()
+
+        except Error as err:
+            return error_response("Can't create custom recipe: %s" % err)
+
+        # Find the package list from the last build of this recipe/target
+        target = Target.objects.filter(Q(build__outcome=Build.SUCCEEDED) &
+                                       Q(build__project=params['project']) &
+                                       (Q(target=params['base'].name) |
+                                        Q(target=recipe.name))).last()
+        if target:
+            # Copy in every package
+            # We don't want these packages to be linked to anything because
+            # that underlying data may change e.g. delete a build
+            for tpackage in target.target_installed_package_set.all():
+                try:
+                    built_package = tpackage.package
+                    # The package had no recipe information so is a ghost
+                    # package skip it
+                    if built_package.recipe is None:
+                        continue
+
+                    config_package = CustomImagePackage.objects.get(
+                        name=built_package.name)
+
+                    recipe.includes_set.add(config_package)
+                except Exception as e:
+                    logger.warning("Error adding package %s %s" %
+                                   (tpackage.package.name, e))
+                    pass
+
+        return JsonResponse(
+            {"error": "ok",
+             "packages": recipe.get_all_packages().count(),
+             "url": reverse('customrecipe', args=(params['project'].pk,
+                                                  recipe.id))})
+
+
+class XhrCustomRecipeId(View):
+    """
+    Set of ReST API processors working with recipe id.
+
+    Entry point: /xhr_customrecipe/<recipe_id>
+
+    Methods:
+        GET - Get details of custom image recipe
+        DELETE - Delete custom image recipe
+
+    Returns:
+        GET:
+        {"error": "ok",
+        "info": dictionary of field name -> value pairs
+        of the CustomImageRecipe model}
+        DELETE:
+        {"error": "ok"}
+          or
+        {"error": <error message>}
+    """
+    @staticmethod
+    def _get_ci_recipe(recipe_id):
+        """ Get Custom Image recipe or return an error response"""
+        try:
+            custom_recipe = \
+                    CustomImageRecipe.objects.get(pk=recipe_id)
+            return custom_recipe, None
+
+        except CustomImageRecipe.DoesNotExist:
+            return None, error_response("Custom recipe with id=%s "
+                                        "not found" % recipe_id)
+
+    def get(self, request, *args, **kwargs):
+        custom_recipe, error = self._get_ci_recipe(kwargs['recipe_id'])
+        if error:
+            return error
+
+        if request.method == 'GET':
+            info = {"id": custom_recipe.id,
+                    "name": custom_recipe.name,
+                    "base_recipe_id": custom_recipe.base_recipe.id,
+                    "project_id": custom_recipe.project.id}
+
+            return JsonResponse({"error": "ok", "info": info})
+
+    def delete(self, request, *args, **kwargs):
+        custom_recipe, error = self._get_ci_recipe(kwargs['recipe_id'])
+        if error:
+            return error
+
+        custom_recipe.delete()
+        return JsonResponse({"error": "ok"})
+
+
+class XhrCustomRecipePackages(View):
+    """
+    ReST API to add/remove packages to/from custom recipe.
+
+    Entry point: /xhr_customrecipe/<recipe_id>/packages/<package_id>
+    Methods:
+         PUT - Add package to the recipe
+         DELETE - Delete package from the recipe
+         GET - Get package information
+
+     Returns:
+         {"error": "ok"}
+          or
+          {"error": <error message>}
+    """
+    @staticmethod
+    def _get_package(package_id):
+        try:
+            package = CustomImagePackage.objects.get(pk=package_id)
+            return package, None
+        except Package.DoesNotExist:
+            return None, error_response("Package with id=%s "
+                                        "not found" % package_id)
+
+    def _traverse_dependents(self, next_package_id,
+                             rev_deps, all_current_packages, tree_level=0):
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
+            if (self._traverse_dependents(pkg["pk"], rev_deps,
+                                          all_current_packages,
+                                          tree_level+1)):
+                return True
+
+        return False
+
+    def _get_all_dependents(self, package_id, all_current_packages):
+        """
+        Returns sorted list of recursive reverse dependencies for package_id,
+        as a list of dictionary items, by recursing through dependency
+        relationships.
+        """
+        rev_deps = []
+        self._traverse_dependents(package_id, rev_deps, all_current_packages)
+        rev_deps = sorted(rev_deps, key=lambda x: x["name"])
+        return rev_deps
+
+    def get(self, request, *args, **kwargs):
+        recipe, error = XhrCustomRecipeId._get_ci_recipe(
+            kwargs['recipe_id'])
+        if error:
+            return error
+
+        # If no package_id then list all the current packages
+        if not kwargs['package_id']:
+            total_size = 0
+            packages = recipe.get_all_packages().values("id",
+                                                        "name",
+                                                        "version",
+                                                        "size")
+            for package in packages:
+                package['size_formatted'] = \
+                    filtered_filesizeformat(package['size'])
+                total_size += package['size']
+
+            return JsonResponse({"error": "ok",
+                                 "packages": list(packages),
+                                 "total": len(packages),
+                                 "total_size": total_size,
+                                 "total_size_formatted":
+                                 filtered_filesizeformat(total_size)})
+        else:
+            package, error = XhrCustomRecipePackages._get_package(
+                kwargs['package_id'])
+            if error:
+                return error
+
+            all_current_packages = recipe.get_all_packages()
+
+            # Dependencies for package which aren't satisfied by the
+            # current packages in the custom image recipe
+            deps = package.package_dependencies_source.for_target_or_none(
+                recipe.name)['packages'].annotate(
+                name=F('depends_on__name'),
+                pk=F('depends_on__pk'),
+                size=F('depends_on__size'),
+                ).values("name", "pk", "size").filter(
+                # There are two depends types we don't know why
+                (Q(dep_type=Package_Dependency.TYPE_TRDEPENDS) |
+                 Q(dep_type=Package_Dependency.TYPE_RDEPENDS)) &
+                ~Q(pk__in=all_current_packages)
+                )
+
+            # Reverse dependencies which are needed by packages that are
+            # in the image. Recursive search providing all dependents,
+            # not just immediate dependents.
+            reverse_deps = self._get_all_dependents(kwargs['package_id'],
+                                                    all_current_packages)
+            total_size_deps = 0
+            total_size_reverse_deps = 0
+
+            for dep in deps:
+                dep['size_formatted'] = \
+                    filtered_filesizeformat(dep['size'])
+                total_size_deps += dep['size']
+
+            for dep in reverse_deps:
+                dep['size_formatted'] = \
+                    filtered_filesizeformat(dep['size'])
+                total_size_reverse_deps += dep['size']
+
+            return JsonResponse(
+                {"error": "ok",
+                 "id": package.pk,
+                 "name": package.name,
+                 "version": package.version,
+                 "unsatisfied_dependencies": list(deps),
+                 "unsatisfied_dependencies_size": total_size_deps,
+                 "unsatisfied_dependencies_size_formatted":
+                 filtered_filesizeformat(total_size_deps),
+                 "reverse_dependencies": list(reverse_deps),
+                 "reverse_dependencies_size": total_size_reverse_deps,
+                 "reverse_dependencies_size_formatted":
+                 filtered_filesizeformat(total_size_reverse_deps)})
+
+    def put(self, request, *args, **kwargs):
+        recipe, error = XhrCustomRecipeId._get_ci_recipe(kwargs['recipe_id'])
+        package, error = self._get_package(kwargs['package_id'])
+        if error:
+            return error
+
+        included_packages = recipe.includes_set.values_list('pk',
+                                                            flat=True)
+
+        # If we're adding back a package which used to be included in this
+        # image all we need to do is remove it from the excludes
+        if package.pk in included_packages:
+            try:
+                recipe.excludes_set.remove(package)
+                return {"error": "ok"}
+            except Package.DoesNotExist:
+                return error_response("Package %s not found in excludes"
+                                      " but was in included list" %
+                                      package.name)
+
+        else:
+            recipe.appends_set.add(package)
+            # Make sure that package is not in the excludes set
+            try:
+                recipe.excludes_set.remove(package)
+            except:
+                pass
+            # Add the dependencies we think will be added to the recipe
+            # as a result of appending this package.
+            # TODO this should recurse down the entire deps tree
+            for dep in package.package_dependencies_source.all_depends():
+                try:
+                    cust_package = CustomImagePackage.objects.get(
+                        name=dep.depends_on.name)
+
+                    recipe.includes_set.add(cust_package)
+                    try:
+                        # When adding the pre-requisite package, make
+                        # sure it's not in the excluded list from a
+                        # prior removal.
+                        recipe.excludes_set.remove(cust_package)
+                    except package.DoesNotExist:
+                        # Don't care if the package had never been excluded
+                        pass
+                except:
+                    logger.warning("Could not add package's suggested"
+                                   "dependencies to the list")
+        return JsonResponse({"error": "ok"})
+
+    def delete(self, request, *args, **kwargs):
+        recipe, error = XhrCustomRecipeId._get_ci_recipe(kwargs['recipe_id'])
+        package, error = self._get_package(kwargs['package_id'])
+        if error:
+            return error
+
+        try:
+            included_packages = recipe.includes_set.values_list('pk',
+                                                                flat=True)
+            # If we're deleting a package which is included we need to
+            # Add it to the excludes list.
+            if package.pk in included_packages:
+                recipe.excludes_set.add(package)
+            else:
+                recipe.appends_set.remove(package)
+                all_current_packages = recipe.get_all_packages()
+
+                reverse_deps_dictlist = self._get_all_dependents(
+                    package.pk,
+                    all_current_packages)
+
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
+            return JsonResponse({"error": "ok"})
+        except CustomImageRecipe.DoesNotExist:
+            return error_response("Tried to remove package that wasn't"
+                                  " present")
diff --git a/bitbake/lib/toaster/toastergui/urls.py b/bitbake/lib/toaster/toastergui/urls.py
index 9892d2a..9509cd5 100644
--- a/bitbake/lib/toaster/toastergui/urls.py
+++ b/bitbake/lib/toaster/toastergui/urls.py
@@ -199,19 +199,25 @@ urlpatterns = patterns('toastergui.views',
         url(r'^js-unit-tests/$', 'jsunittests', name='js-unit-tests'),
 
         # image customisation functionality
-        url(r'^xhr_customrecipe/(?P<recipe_id>\d+)/packages/(?P<package_id>\d+|)$',
-            'xhr_customrecipe_packages', name='xhr_customrecipe_packages'),
+        url(r'^xhr_customrecipe/(?P<recipe_id>\d+)'
+            '/packages/(?P<package_id>\d+|)$',
+            api.XhrCustomRecipePackages.as_view(),
+            name='xhr_customrecipe_packages'),
 
         url(r'^xhr_customrecipe/(?P<recipe_id>\d+)/packages/$',
-            'xhr_customrecipe_packages', name='xhr_customrecipe_packages'),
+            api.XhrCustomRecipePackages.as_view(),
+            name='xhr_customrecipe_packages'),
 
-        url(r'^xhr_customrecipe/(?P<recipe_id>\d+)$', 'xhr_customrecipe_id',
+        url(r'^xhr_customrecipe/(?P<recipe_id>\d+)$',
+            api.XhrCustomRecipeId.as_view(),
             name='xhr_customrecipe_id'),
-        url(r'^xhr_customrecipe/', 'xhr_customrecipe',
+
+        url(r'^xhr_customrecipe/',
+            api.XhrCustomRecipe.as_view(),
             name='xhr_customrecipe'),
 
         url(r'^xhr_buildrequest/project/(?P<pid>\d+)$',
-           api.XhrBuildRequest.as_view(),
+            api.XhrBuildRequest.as_view(),
             name='xhr_buildrequest'),
 
         url(r'^mostrecentbuilds$', api.MostRecentBuildsView.as_view(),
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index 940ea25..365a1e8 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -19,43 +19,37 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-# pylint: disable=method-hidden
-# Gives E:848, 4: An attribute defined in json.encoder line 162 hides this method (method-hidden)
-# which is an invalid warning
 
-import operator,re
+import re
 
-from django.db.models import F, Q, Sum, Count, Max
-from django.db import IntegrityError, Error
+from django.db.models import F, Q, Sum
+from django.db import IntegrityError
 from django.shortcuts import render, redirect, get_object_or_404
-from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable
-from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, Target_File, Target_Image_File, CustomImagePackage
-from orm.models import TargetKernelFile, TargetSDKFile
+from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe
+from orm.models import LogMessage, Variable, Package_Dependency, Package
+from orm.models import Task_Dependency, Package_File
+from orm.models import Target_Installed_Package, Target_File
+from orm.models import TargetKernelFile, TargetSDKFile, Target_Image_File
 from orm.models import BitbakeVersion, CustomImageRecipe
-from bldcontrol import bbcontroller
-from django.views.decorators.cache import cache_control
+
 from django.core.urlresolvers import reverse, resolve
 from django.core.exceptions import MultipleObjectsReturned, ObjectDoesNotExist
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
-from django.http import HttpResponseBadRequest, HttpResponseNotFound
+from django.http import HttpResponseNotFound
 from django.utils import timezone
-from django.utils.html import escape
 from datetime import timedelta, datetime
-from django.utils import formats
 from toastergui.templatetags.projecttags import json as jsonfilter
 from decimal import Decimal
 import json
 import os
 from os.path import dirname
-from functools import wraps
-import itertools
 import mimetypes
 
 import logging
 
 logger = logging.getLogger("toaster")
 
+
 class MimeTypeFinder(object):
     # setting this to False enables additional non-standard mimetypes
     # to be included in the guess
@@ -1498,18 +1492,6 @@ if True:
 
         return context
 
-    def xhr_response(fun):
-        """
-        Decorator for REST methods.
-        calls jsonfilter on the returned dictionary and returns result
-        as HttpResponse object of content_type application/json
-        """
-        @wraps(fun)
-        def wrapper(*args, **kwds):
-            return HttpResponse(jsonfilter(fun(*args, **kwds)),
-                                content_type="application/json")
-        return wrapper
-
     def jsunittests(request):
         """ Provides a page for the js unit tests """
         bbv = BitbakeVersion.objects.filter(branch="master").first()
@@ -1767,187 +1749,6 @@ if True:
 
         return HttpResponse(jsonfilter(json_response), content_type = "application/json")
 
-    @xhr_response
-    def xhr_customrecipe(request):
-        """
-        Custom image recipe REST API
-
-        Entry point: /xhr_customrecipe/
-        Method: POST
-
-        Args:
-            name: name of custom recipe to create
-            project: target project id of orm.models.Project
-            base: base recipe id of orm.models.Recipe
-
-        Returns:
-            {"error": "ok",
-             "url": <url of the created recipe>}
-            or
-            {"error": <error message>}
-        """
-        # check if request has all required parameters
-        for param in ('name', 'project', 'base'):
-            if param not in request.POST:
-                return {"error": "Missing parameter '%s'" % param}
-
-        # get project and baserecipe objects
-        params = {}
-        for name, model in [("project", Project),
-                            ("base", Recipe)]:
-            value = request.POST[name]
-            try:
-                params[name] = model.objects.get(id=value)
-            except model.DoesNotExist:
-                return {"error": "Invalid %s id %s" % (name, value)}
-
-        # create custom recipe
-        try:
-
-            # Only allowed chars in name are a-z, 0-9 and -
-            if re.search(r'[^a-z|0-9|-]', request.POST["name"]):
-                return {"error": "invalid-name"}
-
-            custom_images = CustomImageRecipe.objects.all()
-
-            # Are there any recipes with this name already in our project?
-            existing_image_recipes_in_project = custom_images.filter(
-                name=request.POST["name"], project=params["project"])
-
-            if existing_image_recipes_in_project.count() > 0:
-                return {"error": "image-already-exists"}
-
-            # Are there any recipes with this name which aren't custom
-            # image recipes?
-            custom_image_ids = custom_images.values_list('id', flat=True)
-            existing_non_image_recipes = Recipe.objects.filter(
-                Q(name=request.POST["name"]) & ~Q(pk__in=custom_image_ids)
-            )
-
-            if existing_non_image_recipes.count() > 0:
-                return {"error": "recipe-already-exists"}
-
-            # create layer 'Custom layer' and verion if needed
-            layer = Layer.objects.get_or_create(
-                name=CustomImageRecipe.LAYER_NAME,
-                summary="Layer for custom recipes",
-                vcs_url="file:///toaster_created_layer")[0]
-
-            # Check if we have a layer version already
-            # We don't use get_or_create here because the dirpath will change
-            # and is a required field
-            lver = Layer_Version.objects.filter(Q(project=params['project']) &
-                                                Q(layer=layer) &
-                                                Q(build=None)).last()
-            if lver == None:
-                lver, created = Layer_Version.objects.get_or_create(
-                    project=params['project'],
-                    layer=layer,
-                    dirpath="toaster_created_layer")
-
-            # Add a dependency on our layer to the base recipe's layer
-            LayerVersionDependency.objects.get_or_create(
-                layer_version=lver,
-                depends_on=params["base"].layer_version)
-
-            # Add it to our current project if needed
-            ProjectLayer.objects.get_or_create(project=params['project'],
-                                               layercommit=lver,
-                                               optional=False)
-
-            # Create the actual recipe
-            recipe, created = CustomImageRecipe.objects.get_or_create(
-                name=request.POST["name"],
-                base_recipe=params["base"],
-                project=params["project"],
-                layer_version=lver,
-                is_image=True)
-
-            # If we created the object then setup these fields. They may get
-            # overwritten later on and cause the get_or_create to create a
-            # duplicate if they've changed.
-            if created:
-                recipe.file_path = request.POST["name"]
-                recipe.license = "MIT"
-                recipe.version = "0.1"
-                recipe.save()
-
-        except Error as err:
-            return {"error": "Can't create custom recipe: %s" % err}
-
-        # Find the package list from the last build of this recipe/target
-        target = Target.objects.filter(Q(build__outcome=Build.SUCCEEDED) &
-                                       Q(build__project=params['project']) &
-                                       (Q(target=params['base'].name) |
-                                        Q(target=recipe.name))).last()
-        if target:
-            # Copy in every package
-            # We don't want these packages to be linked to anything because
-            # that underlying data may change e.g. delete a build
-            for tpackage in target.target_installed_package_set.all():
-                try:
-                    built_package = tpackage.package
-                    # The package had no recipe information so is a ghost
-                    # package skip it
-                    if built_package.recipe == None:
-                        continue;
-
-                    config_package = CustomImagePackage.objects.get(
-                        name=built_package.name)
-
-                    recipe.includes_set.add(config_package)
-                except Exception as e:
-                    logger.warning("Error adding package %s %s" %
-                                   (tpackage.package.name, e))
-                    pass
-
-        return {"error": "ok",
-                "packages" : recipe.get_all_packages().count(),
-                "url": reverse('customrecipe', args=(params['project'].pk,
-                                                     recipe.id))}
-
-    @xhr_response
-    def xhr_customrecipe_id(request, recipe_id):
-        """
-        Set of ReST API processors working with recipe id.
-
-        Entry point: /xhr_customrecipe/<recipe_id>
-
-        Methods:
-            GET - Get details of custom image recipe
-            DELETE - Delete custom image recipe
-
-        Returns:
-            GET:
-            {"error": "ok",
-             "info": dictionary of field name -> value pairs
-                     of the CustomImageRecipe model}
-            DELETE:
-            {"error": "ok"}
-            or
-            {"error": <error message>}
-        """
-        try:
-            custom_recipe = CustomImageRecipe.objects.get(id=recipe_id)
-        except CustomImageRecipe.DoesNotExist:
-            return {"error": "Custom recipe with id=%s "
-                             "not found" % recipe_id}
-
-        if request.method == 'GET':
-            info = {"id" : custom_recipe.id,
-                    "name" : custom_recipe.name,
-                    "base_recipe_id": custom_recipe.base_recipe.id,
-                    "project_id": custom_recipe.project.id,
-                   }
-
-            return {"error": "ok", "info": info}
-
-        elif request.method == 'DELETE':
-            custom_recipe.delete()
-            return {"error": "ok"}
-        else:
-            return {"error": "Method %s is not supported" % request.method}
-
     def customrecipe_download(request, pid, recipe_id):
         recipe = get_object_or_404(CustomImageRecipe, pk=recipe_id)
 
@@ -1960,232 +1761,6 @@ if True:
 
         return response
 
-    def _traverse_dependents(next_package_id, rev_deps, all_current_packages, tree_level=0):
-        """
-        Recurse through reverse dependency tree for next_package_id.
-        Limit the reverse dependency search to packages not already scanned,
-        that is, not already in rev_deps.
-        Limit the scan to a depth (tree_level) not exceeding the count of
-        all packages in the custom image, and if that depth is exceeded
-        return False, pop out of the recursion, and write a warning
-        to the log, but this is unlikely, suggesting a dependency loop
-        not caught by bitbake.
-        On return, the input/output arg rev_deps is appended with queryset
-        dictionary elements, annotated for use in the customimage template.
-        The list has unsorted, but unique elements.
-        """
-        max_dependency_tree_depth = all_current_packages.count()
-        if tree_level >= max_dependency_tree_depth:
-            logger.warning(
-                "The number of reverse dependencies "
-                "for this package exceeds " + max_dependency_tree_depth +
-                " and the remaining reverse dependencies will not be removed")
-            return True
-
-        package = CustomImagePackage.objects.get(id=next_package_id)
-        dependents = \
-            package.package_dependencies_target.annotate(
-                name=F('package__name'),
-                pk=F('package__pk'),
-                size=F('package__size'),
-            ).values("name", "pk", "size").exclude(
-                ~Q(pk__in=all_current_packages)
-            )
-
-        for pkg in dependents:
-            if pkg in rev_deps:
-                # already seen, skip dependent search
-                continue
-
-            rev_deps.append(pkg)
-            if (_traverse_dependents(
-                pkg["pk"], rev_deps, all_current_packages, tree_level+1)):
-                return True
-
-        return False
-
-    def _get_all_dependents(package_id, all_current_packages):
-        """
-        Returns sorted list of recursive reverse dependencies for package_id,
-        as a list of dictionary items, by recursing through dependency
-        relationships.
-        """
-        rev_deps = []
-        _traverse_dependents(package_id, rev_deps, all_current_packages)
-        rev_deps = sorted(rev_deps, key=lambda x: x["name"])
-        return rev_deps
-
-    @xhr_response
-    def xhr_customrecipe_packages(request, recipe_id, package_id):
-        """
-        ReST API to add/remove packages to/from custom recipe.
-
-        Entry point: /xhr_customrecipe/<recipe_id>/packages/<package_id>
-
-        Methods:
-            PUT - Add package to the recipe
-            DELETE - Delete package from the recipe
-            GET - Get package information
-
-        Returns:
-            {"error": "ok"}
-            or
-            {"error": <error message>}
-        """
-        try:
-            recipe = CustomImageRecipe.objects.get(id=recipe_id)
-        except CustomImageRecipe.DoesNotExist:
-            return {"error": "Custom recipe with id=%s "
-                             "not found" % recipe_id}
-
-        if package_id:
-            try:
-                package = CustomImagePackage.objects.get(id=package_id)
-            except Package.DoesNotExist:
-                return {"error": "Package with id=%s "
-                        "not found" % package_id}
-
-        if request.method == 'GET':
-            # If no package_id then list the current packages
-            if not package_id:
-                total_size = 0
-                packages = recipe.get_all_packages().values("id",
-                                                            "name",
-                                                            "version",
-                                                            "size")
-                for package in packages:
-                    package['size_formatted'] = \
-                            filtered_filesizeformat(package['size'])
-                    total_size += package['size']
-
-                return {"error": "ok",
-                        "packages" : list(packages),
-                        "total" : len(packages),
-                        "total_size" : total_size,
-                        "total_size_formatted" :
-                        filtered_filesizeformat(total_size)
-                       }
-            else:
-                all_current_packages = recipe.get_all_packages()
-
-                # Dependencies for package which aren't satisfied by the
-                # current packages in the custom image recipe
-                deps =\
-                    package.package_dependencies_source.for_target_or_none(
-                        recipe.name)['packages'].annotate(
-                    name=F('depends_on__name'),
-                    pk=F('depends_on__pk'),
-                    size=F('depends_on__size'),
-                ).values("name", "pk", "size").filter(
-                    # There are two depends types we don't know why
-                    (Q(dep_type=Package_Dependency.TYPE_TRDEPENDS) |
-                    Q(dep_type=Package_Dependency.TYPE_RDEPENDS)) &
-                    ~Q(pk__in=all_current_packages)
-                )
-
-                # Reverse dependencies which are needed by packages that are
-                # in the image. Recursive search providing all dependents,
-                # not just immediate dependents.
-                reverse_deps = _get_all_dependents(package_id, all_current_packages)
-                total_size_deps = 0
-                total_size_reverse_deps = 0
-
-                for dep in deps:
-                    dep['size_formatted'] = \
-                            filtered_filesizeformat(dep['size'])
-                    total_size_deps += dep['size']
-
-                for dep in reverse_deps:
-                    dep['size_formatted'] = \
-                            filtered_filesizeformat(dep['size'])
-                    total_size_reverse_deps += dep['size']
-
-
-                return {"error": "ok",
-                        "id": package.pk,
-                        "name": package.name,
-                        "version": package.version,
-                        "unsatisfied_dependencies": list(deps),
-                        "unsatisfied_dependencies_size": total_size_deps,
-                        "unsatisfied_dependencies_size_formatted":
-                        filtered_filesizeformat(total_size_deps),
-                        "reverse_dependencies": list(reverse_deps),
-                        "reverse_dependencies_size": total_size_reverse_deps,
-                        "reverse_dependencies_size_formatted":
-                        filtered_filesizeformat(total_size_reverse_deps)}
-
-        included_packages = recipe.includes_set.values_list('pk', flat=True)
-
-        if request.method == 'PUT':
-            # If we're adding back a package which used to be included in this
-            # image all we need to do is remove it from the excludes
-            if package.pk in included_packages:
-                try:
-                   recipe.excludes_set.remove(package)
-                   return {"error": "ok"}
-                except Package.DoesNotExist:
-                   return {"error":
-                           "Package %s not found in excludes but was in "
-                           "included list" % package.name}
-
-            else:
-                recipe.appends_set.add(package)
-                # Make sure that package is not in the excludes set
-                try:
-                    recipe.excludes_set.remove(package)
-                except:
-                    pass
-                # Add the dependencies we think will be added to the recipe
-                # as a result of appending this package.
-                # TODO this should recurse down the entire deps tree
-                for dep in package.package_dependencies_source.all_depends():
-                    try:
-                        cust_package = CustomImagePackage.objects.get(
-                                           name=dep.depends_on.name)
-
-                        recipe.includes_set.add(cust_package)
-                        try:
-                            # When adding the pre-requisite package, make
-                            # sure it's not in the excluded list from a
-                            # prior removal.
-                            recipe.excludes_set.remove(cust_package)
-                        except Package.DoesNotExist:
-                            # Don't care if the package had never been excluded
-                            pass
-                    except:
-                        logger.warning("Could not add package's suggested"
-                                       "dependencies to the list")
-
-            return {"error": "ok"}
-
-        elif request.method == 'DELETE':
-            try:
-                # If we're deleting a package which is included we need to
-                # Add it to the excludes list.
-                if package.pk in included_packages:
-                    recipe.excludes_set.add(package)
-                else:
-                    recipe.appends_set.remove(package)
-                all_current_packages = recipe.get_all_packages()
-                reverse_deps_dictlist = _get_all_dependents(package.pk, all_current_packages)
-                ids = [entry['pk'] for entry in reverse_deps_dictlist]
-                reverse_deps = CustomImagePackage.objects.filter(id__in=ids)
-                for r in reverse_deps:
-                    try:
-                        if r.id in included_packages:
-                            recipe.excludes_set.add(r)
-                        else:
-                            recipe.appends_set.remove(r)
-                    except:
-                        pass
-
-                return {"error": "ok"}
-            except CustomImageRecipe.DoesNotExist:
-                return {"error": "Tried to remove package that wasn't present"}
-
-        else:
-            return {"error": "Method %s is not supported" % request.method}
-
     def importlayer(request, pid):
         template = "importlayer.html"
         context = {
-- 
2.7.4


