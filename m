Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 81D6778577
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Nov 2017 09:03:14 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id vAU93GQQ028357
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Nov 2017 01:03:16 -0800 (PST)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Thu, 30 Nov 2017 01:03:15 -0800
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 30 Nov 2017 00:55:28 -0800
Message-ID: <14ddb955e9d0bad3a779d256536d650af1148eab.1512030424.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1512030424.git.David.Reyna@windriver.com>
References: <cover.1512030424.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH V2 6/6] toaster: add 'nobuild' option to Toaster
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
X-List-Received-Date: Thu, 30 Nov 2017 09:03:14 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Add a 'nobuild' option for starting Toaster without the project
and hosted builds support. This allows a Toaster host to provide
local build statistics without opening the host to external users
building projects.

[YOCTO #12315]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster                                   | 19 ++++++---
 lib/toaster/toastergui/templates/base.html    |  4 ++
 lib/toaster/toastergui/templates/landing.html |  2 +
 lib/toaster/toastergui/views.py               | 57 ++++++++++++++++-----------
 lib/toaster/toastergui/widgets.py             |  4 ++
 5 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 762451d..4036f0a 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -18,9 +18,10 @@
 # along with this program. If not, see http://www.gnu.org/licenses/.
 
 HELP="
-Usage: source toaster start|stop [webport=<address:port>] [noweb]
+Usage: source toaster start|stop [webport=<address:port>] [noweb] [nobuild]
     Optional arguments:
-        [noweb] Setup the environment for building with toaster but don't start the development server
+        [nobuild] Setup the environment for capturing builds with toaster but disable managed builds
+        [noweb] Setup the environment for capturing builds with toaster but don't start the web server
         [webport] Set the development server (default: localhost:8000)
 "
 
@@ -183,6 +184,7 @@ unset OE_ROOT
 
 
 WEBSERVER=1
+export TOASTER_BUILDSERVER=1
 ADDR_PORT="localhost:8000"
 unset CMD
 for param in $*; do
@@ -190,6 +192,9 @@ for param in $*; do
     noweb )
             WEBSERVER=0
     ;;
+    nobuild )
+            TOASTER_BUILDSERVER=0
+    ;;
     start )
             CMD=$param
     ;;
@@ -286,9 +291,13 @@ case $CMD in
             return 4
         fi
         export BITBAKE_UI='toasterui'
-        $MANAGE runbuilds \
-           </dev/null >>${BUILDDIR}/toaster_runbuilds.log 2>&1 \
-           & echo $! >${BUILDDIR}/.runbuilds.pid
+        if [ $TOASTER_BUILDSERVER -eq 1 ] ; then
+            $MANAGE runbuilds \
+               </dev/null >>${BUILDDIR}/toaster_runbuilds.log 2>&1 \
+               & echo $! >${BUILDDIR}/.runbuilds.pid
+        else
+            echo "Toaster build server not started."
+        fi
 
         # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toastergui/templates/base.html
index edbd110..4f72064 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -110,6 +110,7 @@
                 All builds
               </a>
               </li>
+              {% if project_enable %}
               <li id="navbar-all-projects"
               {% if request.resolver_match.url_name == 'all-projects'  %}
               class="active"
@@ -119,6 +120,7 @@
                 All projects
               </a>
               </li>
+              {% endif %}
             {% endif %}
               <li id="navbar-docs">
               <a target="_blank" href="http://www.yoctoproject.org/docs/latest/toaster-manual/toaster-manual.html">
@@ -127,7 +129,9 @@
               </a>
               </li>
             </ul>
+            {% if project_enable %}
             <a class="btn btn-default navbar-btn navbar-right" id="new-project-button" href="{% url 'newproject' %}">New project</a>
+            {% endif %}
           </div>
       </div>
     </nav>
diff --git a/lib/toaster/toastergui/templates/landing.html b/lib/toaster/toastergui/templates/landing.html
index cf7516d..70c7359 100644
--- a/lib/toaster/toastergui/templates/landing.html
+++ b/lib/toaster/toastergui/templates/landing.html
@@ -21,11 +21,13 @@
 		          </p>
 
 		          {% if lvs_nos %}
+                    {% if project_enable %}
 		            <p class="top-air">
 		              <a class="btn btn-primary btn-lg" href="{% url 'newproject' %}">
 			              Create your first Toaster project to run manage builds
 		              </a>
 		            </p>
+                    {% endif %}
 		          {% else %}
                 <div class="alert alert-info lead top-air">
                   Toaster has no layer information. Without layer information, you cannot run builds. To generate layer information you can:
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 209b07d..34ed2b2 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -49,6 +49,8 @@ import logging
 
 logger = logging.getLogger("toaster")
 
+# Project creation and managed build enable
+project_enable = ('1' == os.environ.get('TOASTER_BUILDSERVER'))
 
 class MimeTypeFinder(object):
     # setting this to False enables additional non-standard mimetypes
@@ -65,6 +67,12 @@ class MimeTypeFinder(object):
             guessed_type = 'application/octet-stream'
         return guessed_type
 
+# single point to add global values into the context before rendering
+def toaster_render(request, page, context):
+    context['project_enable'] = project_enable
+    return render(request, page, context)
+
+
 # all new sessions should come through the landing page;
 # determine in which mode we are running in, and redirect appropriately
 def landing(request):
@@ -86,7 +94,7 @@ def landing(request):
 
     context = {'lvs_nos' : Layer_Version.objects.all().count()}
 
-    return render(request, 'landing.html', context)
+    return toaster_render(request, 'landing.html', context)
 
 def objtojson(obj):
     from django.db.models.query import QuerySet
@@ -519,7 +527,7 @@ def builddashboard( request, build_id ):
             'packagecount'    : packageCount,
             'logmessages'     : logmessages,
     }
-    return render( request, template, context )
+    return toaster_render( request, template, context )
 
 
 
@@ -591,7 +599,7 @@ def task( request, build_id, task_id ):
             build__completed_on__lt=task_object.build.completed_on).exclude(
             order__isnull=True).exclude(outcome=Task.OUTCOME_NA).order_by('-build__completed_on')
 
-    return render( request, template, context )
+    return toaster_render( request, template, context )
 
 def recipe(request, build_id, recipe_id, active_tab="1"):
     template = "recipe.html"
@@ -618,7 +626,7 @@ def recipe(request, build_id, recipe_id, active_tab="1"):
             'package_count' : package_count,
             'tab_states' : tab_states,
     }
-    return render(request, template, context)
+    return toaster_render(request, template, context)
 
 def recipe_packages(request, build_id, recipe_id):
     template = "recipe_packages.html"
@@ -663,7 +671,7 @@ def recipe_packages(request, build_id, recipe_id):
                 },
            ]
        }
-    response = render(request, template, context)
+    response = toaster_render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
 
@@ -785,7 +793,7 @@ def dirinfo(request, build_id, target_id, file_path=None):
                 'dir_list': dir_list,
                 'file_path': file_path,
               }
-    return render(request, template, context)
+    return toaster_render(request, template, context)
 
 def _find_task_dep(task_object):
     tdeps = Task_Dependency.objects.filter(task=task_object).filter(depends_on__order__gt=0)
@@ -837,7 +845,7 @@ def configuration(request, build_id):
                     'build': build,
                     'project': build.project,
                     'targets': Target.objects.filter(build=build_id)})
-    return render(request, template, context)
+    return toaster_render(request, template, context)
 
 
 def configvars(request, build_id):
@@ -926,7 +934,7 @@ def configvars(request, build_id):
                 ],
             }
 
-    response = render(request, template, context)
+    response = toaster_render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
 
@@ -939,7 +947,7 @@ def bfile(request, build_id, package_id):
         'project': build.project,
         'objects' : files
     }
-    return render(request, template, context)
+    return toaster_render(request, template, context)
 
 
 # A set of dependency types valid for both included and built package views
@@ -1092,7 +1100,7 @@ def package_built_detail(request, build_id, package_id):
     if paths.all().count() < 2:
         context['disable_sort'] = True;
 
-    response = render(request, template, context)
+    response = toaster_render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
 
@@ -1111,7 +1119,7 @@ def package_built_dependencies(request, build_id, package_id):
             'other_deps' :   dependencies['other_deps'],
             'dependency_count' : _get_package_dependency_count(package, -1,  False)
     }
-    return render(request, template, context)
+    return toaster_render(request, template, context)
 
 
 def package_included_detail(request, build_id, target_id, package_id):
@@ -1157,7 +1165,7 @@ def package_included_detail(request, build_id, target_id, package_id):
     }
     if paths.all().count() < 2:
         context['disable_sort'] = True
-    response = render(request, template, context)
+    response = toaster_render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
 
@@ -1181,7 +1189,7 @@ def package_included_dependencies(request, build_id, target_id, package_id):
             'reverse_count' : _get_package_reverse_dep_count(package, target_id),
             'dependency_count' : _get_package_dependency_count(package, target_id, True)
     }
-    return render(request, template, context)
+    return toaster_render(request, template, context)
 
 def package_included_reverse_dependencies(request, build_id, target_id, package_id):
     template = "package_included_reverse_dependencies.html"
@@ -1232,7 +1240,7 @@ def package_included_reverse_dependencies(request, build_id, target_id, package_
     }
     if objects.all().count() < 2:
         context['disable_sort'] = True
-    response = render(request, template, context)
+    response = toaster_render(request, template, context)
     _set_parameters_values(pagesize, orderby, request)
     return response
 
@@ -1365,6 +1373,9 @@ if True:
 
     # new project
     def newproject(request):
+        if not project_enable:
+            return redirect( landing )
+
         template = "newproject.html"
         context = {
             'email': request.user.email if request.user.is_authenticated() else '',
@@ -1379,7 +1390,7 @@ if True:
 
         if request.method == "GET":
             # render new project page
-            return render(request, template, context)
+            return toaster_render(request, template, context)
         elif request.method == "POST":
             mandatory_fields = ['projectname', 'ptype']
             try:
@@ -1419,7 +1430,7 @@ if True:
                     context['alert'] = "Your chosen username is already used"
                 else:
                     context['alert'] = str(e)
-                return render(request, template, context)
+                return toaster_render(request, template, context)
 
         raise Exception("Invalid HTTP method for this page")
 
@@ -1427,7 +1438,7 @@ if True:
     def project(request, pid):
         project = Project.objects.get(pk=pid)
         context = {"project": project}
-        return render(request, "project.html", context)
+        return toaster_render(request, "project.html", context)
 
     def jsunittests(request):
         """ Provides a page for the js unit tests """
@@ -1453,7 +1464,7 @@ if True:
                                               name="MACHINE",
                                               value="qemux86")
         context = {'project': new_project}
-        return render(request, "js-unit-tests.html", context)
+        return toaster_render(request, "js-unit-tests.html", context)
 
     from django.views.decorators.csrf import csrf_exempt
     @csrf_exempt
@@ -1588,7 +1599,7 @@ if True:
         context = {
             'project': Project.objects.get(id=pid),
         }
-        return render(request, template, context)
+        return toaster_render(request, template, context)
 
     def layerdetails(request, pid, layerid):
         project = Project.objects.get(pk=pid)
@@ -1617,7 +1628,7 @@ if True:
             'projectlayers': list(project_layers)
         }
 
-        return render(request, 'layerdetails.html', context)
+        return toaster_render(request, 'layerdetails.html', context)
 
 
     def get_project_configvars_context():
@@ -1707,7 +1718,7 @@ if True:
         except (ProjectVariable.DoesNotExist, BuildEnvironment.DoesNotExist):
             pass
 
-        return render(request, "projectconf.html", context)
+        return toaster_render(request, "projectconf.html", context)
 
     def _file_names_for_artifact(build, artifact_type, artifact_id):
         """
@@ -1774,7 +1785,7 @@ if True:
 
                 return response
             else:
-                return render(request, "unavailable_artifact.html")
+                return toaster_render(request, "unavailable_artifact.html")
         except (ObjectDoesNotExist, IOError):
-            return render(request, "unavailable_artifact.html")
+            return toaster_render(request, "unavailable_artifact.html")
 
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 67c1ff9..a1792d9 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -41,6 +41,7 @@ import types
 import json
 import collections
 import re
+import os
 
 from toastergui.tablefilter import TableFilterMap
 
@@ -86,6 +87,9 @@ class ToasterTable(TemplateView):
         context['table_name'] = type(self).__name__.lower()
         context['empty_state'] = self.empty_state
 
+        # global variables
+        context['project_enable'] = ('1' == os.environ.get('TOASTER_BUILDSERVER'))
+
         return context
 
     def get(self, request, *args, **kwargs):
-- 
1.9.1


