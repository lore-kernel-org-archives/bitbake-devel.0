Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C9BDB773C4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb3B6007479; Wed, 1 Jun 2016 13:37:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oNjQxrInPS_L; Wed,  1 Jun 2016 13:37:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxUK007459
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000oe-EW; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:36 +0100
Message-Id: <1464784607-2985-17-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 17/28] toaster: replace map with list comprehensions
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

map returns map object in python 3. Replaced calls of
map to equivalent list comprehensions in the code which
requires lists.

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/orm/models.py        |  2 +-
 lib/toaster/toastergui/tables.py |  3 +--
 lib/toaster/toastergui/views.py  | 45 ++++++++++++++++------------------------
 3 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index ee01a46..dd64664 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1183,7 +1183,7 @@ class LayerIndexLayerSource(LayerSource):
 
         # update branches; only those that we already have names listed in the
         # Releases table
-        whitelist_branch_names = map(lambda x: x.branch_name, Release.objects.all())
+        whitelist_branch_names = [rel.branch_name for rel in Release.objects.all()]
         if len(whitelist_branch_names) == 0:
             raise Exception("Failed to make list of branches to fetch")
 
diff --git a/lib/toaster/toastergui/tables.py b/lib/toaster/toastergui/tables.py
index d21bed1..caa2fba 100644
--- a/lib/toaster/toastergui/tables.py
+++ b/lib/toaster/toastergui/tables.py
@@ -333,8 +333,7 @@ class RecipesTable(ToasterTable):
         context = super(RecipesTable, self).get_context_data(**kwargs)
 
         context['project'] = project
-
-        context['projectlayers'] = map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=context['project']))
+        context['projectlayers'] = [player.layercommit.id for player in ProjectLayer.objects.filter(project=context['project'])]
 
         return context
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index b256db7..8e920f0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -967,18 +967,19 @@ def dirinfo(request, build_id, target_id, file_path=None):
     return render(request, template, context)
 
 def _find_task_dep(task_object):
-    return map(lambda x: x.depends_on, Task_Dependency.objects.filter(task=task_object).filter(depends_on__order__gt = 0).exclude(depends_on__outcome = Task.OUTCOME_NA).select_related("depends_on"))
-
+    tdeps = Task_Dependency.objects.filter(task=task_object).filter(depends_on__order__gt=0)
+    tdeps = tdeps.exclude(depends_on__outcome=Task.OUTCOME_NA).select_related("depends_on")
+    return [x.depends_on for x in tdeps]
 
 def _find_task_revdep(task_object):
-    tp = []
-    tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on=task_object).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
-    return tp
+    tdeps = Task_Dependency.objects.filter(depends_on=task_object).filter(task__order__gt=0)
+    tdeps = tdeps.exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build")
+    return [tdep.task for tdep in tdeps]
 
 def _find_task_revdep_list(tasklist):
-    tp = []
-    tp = map(lambda t: t.task, Task_Dependency.objects.filter(depends_on__in=tasklist).filter(task__order__gt=0).exclude(task__outcome = Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build"))
-    return tp
+    tdeps = Task_Dependency.objects.filter(depends_on__in=tasklist).filter(task__order__gt=0)
+    tdeps = tdeps.exclude(task__outcome=Task.OUTCOME_NA).select_related("task", "task__recipe", "task__build")
+    return [tdep.task for tdep in tdeps]
 
 def _find_task_provider(task_object):
     task_revdeps = _find_task_revdep(task_object)
@@ -1979,7 +1980,8 @@ if True:
 
             except (IntegrityError, BadParameterException) as e:
                 # fill in page with previously submitted values
-                map(lambda x: context.__setitem__(x, request.POST.get(x, "-- missing")), mandatory_fields)
+                for field in mandatory_fields:
+                    context.__setitem__(field, request.POST.get(field, "-- missing"))
                 if isinstance(e, IntegrityError) and "username" in str(e):
                     context['alert'] = "Your chosen username is already used"
                 else:
@@ -2073,21 +2075,11 @@ if True:
             "prj" : {"name": prj.name, },
             "buildrequests" : prj.build_set.filter(outcome=Build.IN_PROGRESS),
             "builds" : Build.get_recent(prj),
-            "layers" :  map(lambda x: {
-                        "id": x.layercommit.pk,
-                        "orderid": x.pk,
-                        "name" : x.layercommit.layer.name,
-                        "vcs_url": x.layercommit.layer.vcs_url,
-                        "vcs_reference" : x.layercommit.get_vcs_reference(),
-                        "url": x.layercommit.layer.layer_index_url,
-                        "layerdetailurl": x.layercommit.get_detailspage_url(prj.pk),
-                # This branch name is actually the release
-                        "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
-                    prj.projectlayer_set.all().order_by("id")),
-            "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
-            "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
+            "layers" : layers,
+            "targets" : [{"target" : x.target, "task" : x.task, "pk": x.pk} for x in prj.projecttarget_set.all()],
+            "variables": [(x.name, x.value) for x in prj.projectvariable_set.all()],
             "freqtargets": freqtargets[:5],
-            "releases": map(lambda x: {"id": x.pk, "name": x.name, "description":x.description}, Release.objects.all()),
+            "releases": [{"id": x.pk, "name": x.name, "description":x.description} for x in Release.objects.all()],
             "project_html": 1,
             "recipesTypeAheadUrl": reverse('xhr_recipestypeahead', args=(prj.pk,)),
             "projectBuildsUrl": reverse('projectbuilds', args=(prj.pk,)),
@@ -2178,8 +2170,7 @@ if True:
                     retval.append(project)
 
             return response({"error":"ok",
-                             "rows" : map( _lv_to_dict(prj),
-                                          map(lambda x: x.layercommit, retval ))
+                             "rows": [_lv_to_dict(prj) for y in [x.layercommit for x in retval]]
                             })
 
         except Exception as e:
@@ -2225,7 +2216,7 @@ if True:
 
             return_data = {
                 "error": "ok",
-                'configvars'   : map(lambda x: (x.name, x.value, x.pk), configvars_query),
+                'configvars': [(x.name, x.value, x.pk) for x in configvars_query]
                }
             try:
                 return_data['distro'] = ProjectVariable.objects.get(project = prj, name = "DISTRO").value,
@@ -2848,7 +2839,7 @@ if True:
                 "vcs_url": dep.layer.vcs_url,
                 "vcs_reference": dep.get_vcs_reference()} \
                 for dep in layer_version.get_alldeps(project.id)]},
-            'projectlayers': map(lambda prjlayer: prjlayer.layercommit.id, ProjectLayer.objects.filter(project=project))
+            'projectlayers': [player.layercommit.id for player in ProjectLayer.objects.filter(project=project)]
         }
 
         return context
-- 
2.5.0


