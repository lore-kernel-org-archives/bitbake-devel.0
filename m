Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 55E6674D0C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 15:48:55 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w6PFmu5H019816
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2018 08:48:56 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.399.0;
	Wed, 25 Jul 2018 08:48:56 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2018 11:48:54 -0400
Message-ID: <20180725154854.141556-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180725154854.141556-1-mark.hatle@windriver.com>
References: <20180725154854.141556-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 5/5 v3] toaster/orm/management/commands/lsupdates.py: Use new layerindexlib module
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
X-List-Received-Date: Wed, 25 Jul 2018 15:48:55 -0000
Content-Type: text/plain

Change lsupdates.py to use the new layerindexlib module to load the data from
the public layer index.  It still does all of the manual parsing.  This
is intended to be a stop gap until the toaster can use the module itself to
manage the data.

Everything else is functionally equivalent to the prior version.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/toaster/orm/management/commands/lsupdates.py | 228 ++++++++++-------------
 1 file changed, 97 insertions(+), 131 deletions(-)

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index efc6b3a..66114ff 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -29,7 +29,6 @@ from orm.models import ToasterSetting
 import os
 import sys
 
-import json
 import logging
 import threading
 import time
@@ -37,6 +36,18 @@ logger = logging.getLogger("toaster")
 
 DEFAULT_LAYERINDEX_SERVER = "http://layers.openembedded.org/layerindex/api/"
 
+# Add path to bitbake modules for layerindexlib
+# lib/toaster/orm/management/commands/lsupdates.py (abspath)
+# lib/toaster/orm/management/commands (dirname)
+# lib/toaster/orm/management (dirname)
+# lib/toaster/orm (dirname)
+# lib/toaster/ (dirname)
+# lib/ (dirname)
+path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))))
+sys.path.insert(0, path)
+
+import layerindexlib
+
 
 class Spinner(threading.Thread):
     """ A simple progress spinner to indicate download/parsing is happening"""
@@ -86,45 +97,6 @@ class Command(BaseCommand):
             self.apiurl = ToasterSetting.objects.get(name = 'CUSTOM_LAYERINDEX_SERVER').value
 
         assert self.apiurl is not None
-        try:
-            from urllib.request import urlopen, URLError
-            from urllib.parse import urlparse
-        except ImportError:
-            from urllib2 import urlopen, URLError
-            from urlparse import urlparse
-
-        proxy_settings = os.environ.get("http_proxy", None)
-
-        def _get_json_response(apiurl=None):
-            if None == apiurl:
-                apiurl=self.apiurl
-            http_progress = Spinner()
-            http_progress.start()
-
-            _parsedurl = urlparse(apiurl)
-            path = _parsedurl.path
-
-            # logger.debug("Fetching %s", apiurl)
-            try:
-                res = urlopen(apiurl)
-            except URLError as e:
-                raise Exception("Failed to read %s: %s" % (path, e.reason))
-
-            parsed = json.loads(res.read().decode('utf-8'))
-
-            http_progress.stop()
-            return parsed
-
-        # verify we can get the basic api
-        try:
-            apilinks = _get_json_response()
-        except Exception as e:
-            import traceback
-            if proxy_settings is not None:
-                logger.info("EE: Using proxy %s" % proxy_settings)
-            logger.warning("EE: could not connect to %s, skipping update:"
-                           "%s\n%s" % (self.apiurl, e, traceback.format_exc()))
-            return
 
         # update branches; only those that we already have names listed in the
         # Releases table
@@ -133,112 +105,118 @@ class Command(BaseCommand):
         if len(whitelist_branch_names) == 0:
             raise Exception("Failed to make list of branches to fetch")
 
-        logger.info("Fetching metadata releases for %s",
+        logger.info("Fetching metadata for %s",
                     " ".join(whitelist_branch_names))
 
-        branches_info = _get_json_response(apilinks['branches'] +
-                                           "?filter=name:%s"
-                                           % "OR".join(whitelist_branch_names))
+        # We require a non-empty bb.data, but we can fake it with a dictionary
+        layerindex = layerindexlib.LayerIndex({"DUMMY" : "VALUE"})
+
+        http_progress = Spinner()
+        http_progress.start()
+
+        if whitelist_branch_names:
+            url_branches = ";branch=%s" % ','.join(whitelist_branch_names)
+        else:
+            url_branches = ""
+        layerindex.load_layerindex("%s%s" % (self.apiurl, url_branches))
+
+        http_progress.stop()
+
+        # We know we're only processing one entry, so we reference it here
+        # (this is cheating...)
+        index = layerindex.indexes[0]
 
         # Map the layer index branches to toaster releases
         li_branch_id_to_toaster_release = {}
 
-        total = len(branches_info)
-        for i, branch in enumerate(branches_info):
-            li_branch_id_to_toaster_release[branch['id']] = \
-                    Release.objects.get(name=branch['name'])
+        logger.info("Processing releases")
+
+        total = len(index.branches)
+        for i, id in enumerate(index.branches):
+            li_branch_id_to_toaster_release[id] = \
+                    Release.objects.get(name=index.branches[id].name)
             self.mini_progress("Releases", i, total)
 
         # keep a track of the layerindex (li) id mappings so that
         # layer_versions can be created for these layers later on
         li_layer_id_to_toaster_layer_id = {}
 
-        logger.info("Fetching layers")
-
-        layers_info = _get_json_response(apilinks['layerItems'])
+        logger.info("Processing layers")
 
-        total = len(layers_info)
-        for i, li in enumerate(layers_info):
+        total = len(index.layerItems)
+        for i, id in enumerate(index.layerItems):
             try:
-                l, created = Layer.objects.get_or_create(name=li['name'])
-                l.up_date = li['updated']
-                l.summary = li['summary']
-                l.description = li['description']
+                l, created = Layer.objects.get_or_create(name=index.layerItems[id].name)
+                l.up_date = index.layerItems[id].updated
+                l.summary = index.layerItems[id].summary
+                l.description = index.layerItems[id].description
 
                 if created:
                     # predefined layers in the fixtures (for example poky.xml)
                     # always preempt the Layer Index for these values
-                    l.vcs_url = li['vcs_url']
-                    l.vcs_web_url = li['vcs_web_url']
-                    l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
-                    l.vcs_web_file_base_url = li['vcs_web_file_base_url']
+                    l.vcs_url = index.layerItems[id].vcs_url
+                    l.vcs_web_url = index.layerItems[id].vcs_web_url
+                    l.vcs_web_tree_base_url = index.layerItems[id].vcs_web_tree_base_url
+                    l.vcs_web_file_base_url = index.layerItems[id].vcs_web_file_base_url
                 l.save()
             except Layer.MultipleObjectsReturned:
                 logger.info("Skipped %s as we found multiple layers and "
                             "don't know which to update" %
-                            li['name'])
+                            index.layerItems[id].name)
 
-            li_layer_id_to_toaster_layer_id[li['id']] = l.pk
+            li_layer_id_to_toaster_layer_id[id] = l.pk
 
             self.mini_progress("layers", i, total)
 
         # update layer_versions
-        logger.info("Fetching layer versions")
-        layerbranches_info = _get_json_response(
-            apilinks['layerBranches'] + "?filter=branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing layer versions")
 
         # Map Layer index layer_branch object id to
         # layer_version toaster object id
         li_layer_branch_id_to_toaster_lv_id = {}
 
-        total = len(layerbranches_info)
-        for i, lbi in enumerate(layerbranches_info):
+        total = len(index.layerBranches)
+        for i, id in enumerate(index.layerBranches):
             # release as defined by toaster map to layerindex branch
-            release = li_branch_id_to_toaster_release[lbi['branch']]
+            release = li_branch_id_to_toaster_release[index.layerBranches[id].branch_id]
 
             try:
                 lv, created = Layer_Version.objects.get_or_create(
                     layer=Layer.objects.get(
-                        pk=li_layer_id_to_toaster_layer_id[lbi['layer']]),
+                        pk=li_layer_id_to_toaster_layer_id[index.layerBranches[id].layer_id]),
                     release=release
                 )
             except KeyError:
                 logger.warning(
                     "No such layerindex layer referenced by layerbranch %d" %
-                    lbi['layer'])
+                    index.layerBranches[id].layer_id)
                 continue
 
             if created:
-                lv.release = li_branch_id_to_toaster_release[lbi['branch']]
-                lv.up_date = lbi['updated']
-                lv.commit = lbi['actual_branch']
-                lv.dirpath = lbi['vcs_subdir']
+                lv.release = li_branch_id_to_toaster_release[index.layerBranches[id].branch_id]
+                lv.up_date = index.layerBranches[id].updated
+                lv.commit = index.layerBranches[id].actual_branch
+                lv.dirpath = index.layerBranches[id].vcs_subdir
                 lv.save()
 
-            li_layer_branch_id_to_toaster_lv_id[lbi['id']] =\
+            li_layer_branch_id_to_toaster_lv_id[index.layerBranches[id].id] =\
                 lv.pk
             self.mini_progress("layer versions", i, total)
 
-        logger.info("Fetching layer version dependencies")
-        # update layer dependencies
-        layerdependencies_info = _get_json_response(
-            apilinks['layerDependencies'] +
-            "?filter=layerbranch__branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing layer version dependencies")
 
         dependlist = {}
-        for ldi in layerdependencies_info:
+        for id in index.layerDependencies:
             try:
                 lv = Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[ldi['layerbranch']])
+                    pk=li_layer_branch_id_to_toaster_lv_id[index.layerDependencies[id].layerbranch_id])
             except Layer_Version.DoesNotExist as e:
                 continue
 
             if lv not in dependlist:
                 dependlist[lv] = []
             try:
-                layer_id = li_layer_id_to_toaster_layer_id[ldi['dependency']]
+                layer_id = li_layer_id_to_toaster_layer_id[index.layerDependencies[id].dependency_id]
 
                 dependlist[lv].append(
                     Layer_Version.objects.get(layer__pk=layer_id,
@@ -247,7 +225,7 @@ class Command(BaseCommand):
             except Layer_Version.DoesNotExist:
                 logger.warning("Cannot find layer version (ls:%s),"
                                "up_id:%s lv:%s" %
-                               (self, ldi['dependency'], lv))
+                               (self, index.layerDependencies[id].dependency_id, lv))
 
         total = len(dependlist)
         for i, lv in enumerate(dependlist):
@@ -258,73 +236,61 @@ class Command(BaseCommand):
             self.mini_progress("Layer version dependencies", i, total)
 
         # update Distros
-        logger.info("Fetching distro information")
-        distros_info = _get_json_response(
-            apilinks['distros'] + "?filter=layerbranch__branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing distro information")
 
-        total = len(distros_info)
-        for i, di in enumerate(distros_info):
+        total = len(index.distros)
+        for i, id in enumerate(index.distros):
             distro, created = Distro.objects.get_or_create(
-                name=di['name'],
+                name=index.distros[id].name,
                 layer_version=Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[di['layerbranch']]))
-            distro.up_date = di['updated']
-            distro.name = di['name']
-            distro.description = di['description']
+                    pk=li_layer_branch_id_to_toaster_lv_id[index.distros[id].layerbranch_id]))
+            distro.up_date = index.distros[id].updated
+            distro.name = index.distros[id].name
+            distro.description = index.distros[id].description
             distro.save()
             self.mini_progress("distros", i, total)
 
         # update machines
-        logger.info("Fetching machine information")
-        machines_info = _get_json_response(
-            apilinks['machines'] + "?filter=layerbranch__branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing machine information")
 
-        total = len(machines_info)
-        for i, mi in enumerate(machines_info):
+        total = len(index.machines)
+        for i, id in enumerate(index.machines):
             mo, created = Machine.objects.get_or_create(
-                name=mi['name'],
+                name=index.machines[id].name,
                 layer_version=Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[mi['layerbranch']]))
-            mo.up_date = mi['updated']
-            mo.name = mi['name']
-            mo.description = mi['description']
+                    pk=li_layer_branch_id_to_toaster_lv_id[index.machines[id].layerbranch_id]))
+            mo.up_date = index.machines[id].updated
+            mo.name = index.machines[id].name
+            mo.description = index.machines[id].description
             mo.save()
             self.mini_progress("machines", i, total)
 
         # update recipes; paginate by layer version / layer branch
-        logger.info("Fetching recipe information")
-        recipes_info = _get_json_response(
-            apilinks['recipes'] + "?filter=layerbranch__branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing recipe information")
 
-        total = len(recipes_info)
-        for i, ri in enumerate(recipes_info):
+        total = len(index.recipes)
+        for i, id in enumerate(index.recipes):
             try:
-                lv_id = li_layer_branch_id_to_toaster_lv_id[ri['layerbranch']]
+                lv_id = li_layer_branch_id_to_toaster_lv_id[index.recipes[id].layerbranch_id]
                 lv = Layer_Version.objects.get(pk=lv_id)
 
                 ro, created = Recipe.objects.get_or_create(
                     layer_version=lv,
-                    name=ri['pn']
+                    name=index.recipes[id].pn
                 )
 
                 ro.layer_version = lv
-                ro.up_date = ri['updated']
-                ro.name = ri['pn']
-                ro.version = ri['pv']
-                ro.summary = ri['summary']
-                ro.description = ri['description']
-                ro.section = ri['section']
-                ro.license = ri['license']
-                ro.homepage = ri['homepage']
-                ro.bugtracker = ri['bugtracker']
-                ro.file_path = ri['filepath'] + "/" + ri['filename']
-                if 'inherits' in ri:
-                    ro.is_image = 'image' in ri['inherits'].split()
-                else:  # workaround for old style layer index
-                    ro.is_image = "-image-" in ri['pn']
+                ro.up_date = index.recipes[id].updated
+                ro.name = index.recipes[id].pn
+                ro.version = index.recipes[id].pv
+                ro.summary = index.recipes[id].summary
+                ro.description = index.recipes[id].description
+                ro.section = index.recipes[id].section
+                ro.license = index.recipes[id].license
+                ro.homepage = index.recipes[id].homepage
+                ro.bugtracker = index.recipes[id].bugtracker
+                ro.file_path = index.recipes[id].fullpath
+                ro.is_image = 'image' in index.recipes[id].inherits.split()
                 ro.save()
             except Exception as e:
                 logger.warning("Failed saving recipe %s", e)
-- 
1.8.3.1


