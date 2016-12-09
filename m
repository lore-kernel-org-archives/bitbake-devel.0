Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 305A66013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Dec 2016 16:53:08 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id a197so32365835wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 09 Dec 2016 08:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7BAHIO7CGNeafNLRM6bEGHDvGHiq1WzV0UStrQ/XRrg=;
	b=Nfihq/35zed2ioQPH07WJ9FXst2gklfoa8GITDJX8VP1SN87qQ5UK0p1VjlcLSXo71
	3/zaiMz6u7E8n+vaqpwDg6l36I5iPL/nAae/HN5GwHMDK0mpDdlMiokWoPSt/OK+d26t
	z2LKhU7mXeqOVnlJ/iHUOpJyiJ93nhtWjTTaFqFlTeVo6sCltVfmTuCVsfzfIcYs5l7a
	oB3XMNO4zzuTO5i+zRDZmBIIc8X+6mVJg5tZU1VRCVTcR7/C0bZU57oMitr9zy9pYQzJ
	bSOcDCQZYG1n4JhKN+sDMUARY3VGRITv8GS89PQSbOAAf3PBD5hR3g+CKY9l+hk46QLL
	JBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7BAHIO7CGNeafNLRM6bEGHDvGHiq1WzV0UStrQ/XRrg=;
	b=Ce8kcHDLAa1GNqHxB5av6RpOfJstCP55cFZUodZxquGSaARLxbRrcBHnByqjkQn6qS
	hHzzk4qh0n/68ppBLUn0LGeC7iOzTrw17vOXO4BGO2QceLMQqhJgHRPtGSNPk/CEsS78
	KLhVSwqxSmJhel3hqOQ/3LbqgDDbqfNGej1ire7lnAmbOETjPui2koR6WwmlsmcTNmQJ
	ROkr8rqb3pk7M5dDvQRXVyrxCXpquejvFo3F8wsBVjkZHWmkVWwe+nPZ6YWUXPsKnlAU
	TyVP+p9n0Snc36GVxd1w08WFeuQgTiDBAF18UJ+TyvBsTGQfEWIp0mT+AfB4XEEq/wmv
	UrBA==
X-Gm-Message-State: AKaTC00zjU9D0HgpLYj9+b+TJRQAmecZ2uXWtzgLjQRstNcvD+ZXfvq2Xe8k1pDl6+pvk75Z
X-Received: by 10.28.55.203 with SMTP id e194mr7425663wma.6.1481302390000;
	Fri, 09 Dec 2016 08:53:10 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	ke6sm43170601wjb.21.2016.12.09.08.53.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 09 Dec 2016 08:53:09 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Dec 2016 16:52:48 +0000
Message-Id: <1481302375-7985-8-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
References: <1481302375-7985-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 07/14] toaster: typeaheads widgets Fix flake8 issues and remove redundant code
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
X-List-Received-Date: Fri, 09 Dec 2016 16:53:10 -0000

Fix flake8 issues and remove redundant __init__ function definitions
from typeaheads (likely a copy and paste error).

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/typeaheads.py | 80 ++++++++++++++++++------------------
 lib/toaster/toastergui/widgets.py    |  8 ++--
 2 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/lib/toaster/toastergui/typeaheads.py b/lib/toaster/toastergui/typeaheads.py
index 4ded9ac..2c6c145 100644
--- a/lib/toaster/toastergui/typeaheads.py
+++ b/lib/toaster/toastergui/typeaheads.py
@@ -23,8 +23,6 @@ from django.core.urlresolvers import reverse
 class LayersTypeAhead(ToasterTypeAhead):
     """ Typeahead for layers available and not added in the current project's
     configuration """
-    def __init__(self):
-      super(LayersTypeAhead, self).__init__()
 
     def apply_search(self, search_term, prj, request):
         layers = prj.get_all_compatible_layer_versions()
@@ -33,13 +31,15 @@ class LayersTypeAhead(ToasterTypeAhead):
         # Unlike the other typeaheads we also don't want to show suggestions
         # for layers already in the project unless required such as when adding
         # layerdeps to a new layer.
-        if ("include_added" in request.GET and
-                request.GET['include_added'] != "true"):
+        if "include_added" in request.GET and \
+           request.GET['include_added'] != "true":
             layers = layers.exclude(
                 pk__in=prj.get_project_layer_versions(pk=True))
 
         primary_results = layers.filter(layer__name__istartswith=search_term)
-        secondary_results = layers.filter(layer__name__icontains=search_term).exclude(pk__in=primary_results)
+        secondary_results = layers.filter(
+            layer__name__icontains=search_term).exclude(
+                pk__in=primary_results)
 
         results = []
 
@@ -49,97 +49,99 @@ class LayersTypeAhead(ToasterTypeAhead):
             detail = "[ %s | %s ]" % (layer_version.layer.vcs_url,
                                       vcs_reference)
             needed_fields = {
-                'id' : layer_version.pk,
-                'name' : layer_version.layer.name,
-                'layerdetailurl' : layer_version.get_detailspage_url(prj.pk),
-                'vcs_url' : layer_version.layer.vcs_url,
-                'vcs_reference' : vcs_reference,
-                'detail' : detail,
-                'local_source_dir' : layer_version.layer.local_source_dir,
+                'id': layer_version.pk,
+                'name': layer_version.layer.name,
+                'layerdetailurl': layer_version.get_detailspage_url(prj.pk),
+                'vcs_url': layer_version.layer.vcs_url,
+                'vcs_reference': vcs_reference,
+                'detail': detail,
+                'local_source_dir': layer_version.layer.local_source_dir,
             }
 
             results.append(needed_fields)
 
         return results
 
+
 class MachinesTypeAhead(ToasterTypeAhead):
     """ Typeahead for all the machines available in the current project's
     configuration """
-    def __init__(self):
-        super(MachinesTypeAhead, self).__init__()
 
     def apply_search(self, search_term, prj, request):
         machines = prj.get_available_machines()
         machines = machines.order_by("name")
 
         primary_results = machines.filter(name__istartswith=search_term)
-        secondary_results = machines.filter(name__icontains=search_term).exclude(pk__in=primary_results)
-        tertiary_results = machines.filter(layer_version__layer__name__icontains=search_term).exclude(pk__in=primary_results).exclude(pk__in=secondary_results)
+        secondary_results = machines.filter(
+            name__icontains=search_term).exclude(pk__in=primary_results)
+        tertiary_results = machines.filter(
+            layer_version__layer__name__icontains=search_term).exclude(
+                pk__in=primary_results).exclude(pk__in=secondary_results)
 
         results = []
 
-        for machine in list(primary_results) + list(secondary_results) + list(tertiary_results):
+        for machine in list(primary_results) + list(secondary_results) + \
+                list(tertiary_results):
 
             detail = "[ %s ]" % (machine.layer_version.layer.name)
             needed_fields = {
-                'id' : machine.pk,
-                'name' : machine.name,
-                'detail' : detail,
+                'id': machine.pk,
+                'name': machine.name,
+                'detail': detail,
             }
 
             results.append(needed_fields)
-
         return results
 
+
 class RecipesTypeAhead(ToasterTypeAhead):
     """ Typeahead for all the recipes available in the current project's
     configuration """
-    def __init__(self):
-        super(RecipesTypeAhead, self).__init__()
-
     def apply_search(self, search_term, prj, request):
         recipes = prj.get_available_recipes()
         recipes = recipes.order_by("name")
 
-
         primary_results = recipes.filter(name__istartswith=search_term)
-        secondary_results = recipes.filter(name__icontains=search_term).exclude(pk__in=primary_results)
-        tertiary_results = recipes.filter(layer_version__layer__name__icontains=search_term).exclude(pk__in=primary_results).exclude(pk__in=secondary_results)
+        secondary_results = recipes.filter(
+            name__icontains=search_term).exclude(pk__in=primary_results)
+        tertiary_results = recipes.filter(
+            layer_version__layer__name__icontains=search_term).exclude(
+                pk__in=primary_results).exclude(pk__in=secondary_results)
 
         results = []
 
-        for recipe in list(primary_results) + list(secondary_results) + list(tertiary_results):
+        for recipe in list(primary_results) + list(secondary_results) + \
+                list(tertiary_results):
 
             detail = "[ %s ]" % (recipe.layer_version.layer.name)
             needed_fields = {
-                'id' : recipe.pk,
-                'name' : recipe.name,
-                'detail' : detail,
+                'id': recipe.pk,
+                'name': recipe.name,
+                'detail': detail,
             }
 
             results.append(needed_fields)
 
         return results
 
+
 class ProjectsTypeAhead(ToasterTypeAhead):
     """ Typeahead for all the projects, except for command line builds """
-    def __init__(self):
-        super(ProjectsTypeAhead, self).__init__()
-
     def apply_search(self, search_term, prj, request):
         projects = Project.objects.exclude(is_default=True).order_by("name")
 
         primary_results = projects.filter(name__istartswith=search_term)
-        secondary_results = projects.filter(name__icontains=search_term).exclude(pk__in=primary_results)
+        secondary_results = projects.filter(
+            name__icontains=search_term).exclude(pk__in=primary_results)
 
         results = []
 
         for project in list(primary_results) + list(secondary_results):
             needed_fields = {
-                'id' : project.pk,
-                'name' : project.name,
-                'detail' : "",
-                'projectPageUrl' : reverse('project', args=(project.pk,))
+                'id': project.pk,
+                'name': project.name,
+                'detail': "",
+                'projectPageUrl': reverse('project', args=(project.pk,))
             }
 
             results.append(needed_fields)
diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 026903d..6b7b981 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -42,6 +42,8 @@ import json
 import collections
 import re
 
+from toastergui.tablefilter import TableFilterMap
+
 try:
     from urllib import unquote_plus
 except ImportError:
@@ -50,8 +52,6 @@ except ImportError:
 import logging
 logger = logging.getLogger("toaster")
 
-from toastergui.tablefilter import TableFilterMap
-
 
 class NoFieldOrDataName(Exception):
     pass
@@ -259,9 +259,9 @@ class ToasterTable(TemplateView):
                     queries = query
 
             if search_queries:
-               search_queries &= queries
+                search_queries &= queries
             else:
-               search_queries = queries
+                search_queries = queries
 
         self.queryset = self.queryset.filter(search_queries)
 
-- 
2.7.4


