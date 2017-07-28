Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9132E780A1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 15:39:21 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6SFdMgI028841
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 28 Jul 2017 08:39:22 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.294.0;
	Fri, 28 Jul 2017 08:39:23 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jul 2017 10:37:21 -0500
Message-ID: <1501256242-37784-5-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
References: <1501256242-37784-1-git-send-email-mark.hatle@windriver.com>
MIME-Version: 1.0
Cc: toaster@yoctoproject.org
Subject: [PATCH 4/5] toaster/orm/management/commands/lsupdates.py: Use new layerindex module
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
X-List-Received-Date: Fri, 28 Jul 2017 15:39:21 -0000
Content-Type: text/plain

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/toaster/orm/management/commands/lsupdates.py | 215 +++++++++--------------
 1 file changed, 87 insertions(+), 128 deletions(-)

diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 0b0d4ff..055ad78 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -28,13 +28,16 @@ from orm.models import Distro
 import os
 import sys
 
-import json
 import logging
 import threading
 import time
 logger = logging.getLogger("toaster")
 
-DEFAULT_LAYERINDEX_SERVER = "http://layers.openembedded.org/layerindex/api/"
+DEFAULT_LAYERINDEX_SERVER = "http://layers.openembedded.org/layerindex/api/;type=restapi"
+
+# load Bitbake components
+path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
+sys.path.insert(0, path)
 
 
 class Spinner(threading.Thread):
@@ -83,43 +86,6 @@ class Command(BaseCommand):
         self.apiurl = DEFAULT_LAYERINDEX_SERVER
 
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
-        def _get_json_response(apiurl=DEFAULT_LAYERINDEX_SERVER):
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
@@ -128,110 +94,115 @@ class Command(BaseCommand):
         if len(whitelist_branch_names) == 0:
             raise Exception("Failed to make list of branches to fetch")
 
+        self.apiurl += ";branch=%s" % "OR".join(whitelist_branch_names)
+
+        http_progress = Spinner()
+
         logger.info("Fetching metadata releases for %s",
                     " ".join(whitelist_branch_names))
 
-        branches_info = _get_json_response(apilinks['branches'] +
-                                           "?filter=name:%s"
-                                           % "OR".join(whitelist_branch_names))
+
+        import layers.layerindex
+
+        layerindex = layers.layerindex.LayerIndex(None)
+
+        http_progress.start()
+        layerindex.load_layerindex(self.apiurl)
+        http_progress.stop()
+
+        # We know we're only processing one entry, so we reference it here
+        # (this is cheating...)
+        lindex = layerindex.lindex[0]
 
         # Map the layer index branches to toaster releases
         li_branch_id_to_toaster_release = {}
 
-        total = len(branches_info)
-        for i, branch in enumerate(branches_info):
-            li_branch_id_to_toaster_release[branch['id']] = \
-                    Release.objects.get(name=branch['name'])
+        logger.info("Processing branches")
+
+        total = len(lindex['branches'])
+        for i, branchId in enumerate(lindex['branches']):
+            li_branch_id_to_toaster_release[branchId] = \
+                    Release.objects.get(name=lindex['branches'][branchId].get_name())
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
+        total = len(lindex['layerItems'])
+        for i, liId in enumerate(lindex['layerItems']):
             try:
-                l, created = Layer.objects.get_or_create(name=li['name'])
-                l.up_date = li['updated']
-                l.summary = li['summary']
-                l.description = li['description']
+                l, created = Layer.objects.get_or_create(name=lindex['layerItems'][liId].get_name())
+                l.up_date = lindex['layerItems'][liId].get_updated()
+                l.summary = lindex['layerItems'][liId].get_summary()
+                l.description = lindex['layerItems'][liId].get_description()
 
                 if created:
-                    l.vcs_url = li['vcs_url']
-                    l.vcs_web_url = li['vcs_web_url']
-                    l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
-                    l.vcs_web_file_base_url = li['vcs_web_file_base_url']
+                    l.vcs_url = lindex['layerItems'][liId].get_vcs_url()
+                    l.vcs_web_url = lindex['layerItems'][liId].get_vcs_web_url()
+                    l.vcs_web_tree_base_url = lindex['layerItems'][liId].get_vcs_web_tree_base_url()
+                    l.vcs_web_file_base_url = lindex['layerItems'][liId].get_vcs_web_file_base_url()
                 l.save()
             except Layer.MultipleObjectsReturned:
                 logger.info("Skipped %s as we found multiple layers and "
                             "don't know which to update" %
                             li['name'])
 
-            li_layer_id_to_toaster_layer_id[li['id']] = l.pk
+            li_layer_id_to_toaster_layer_id[liId] = l.pk
 
             self.mini_progress("layers", i, total)
 
         # update layer_versions
-        logger.info("Fetching layer versions")
-        layerbranches_info = _get_json_response(
-            apilinks['layerBranches'] + "?filter=branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing layer branches")
 
         # Map Layer index layer_branch object id to
         # layer_version toaster object id
         li_layer_branch_id_to_toaster_lv_id = {}
 
-        total = len(layerbranches_info)
-        for i, lbi in enumerate(layerbranches_info):
+        total = len(lindex['layerBranches'])
+        for i, lbiId in enumerate(lindex['layerBranches']):
             # release as defined by toaster map to layerindex branch
-            release = li_branch_id_to_toaster_release[lbi['branch']]
+            release = li_branch_id_to_toaster_release[lindex['layerBranches'][lbiId].get_branch_id()]
 
             try:
                 lv, created = Layer_Version.objects.get_or_create(
                     layer=Layer.objects.get(
-                        pk=li_layer_id_to_toaster_layer_id[lbi['layer']]),
+                        pk=li_layer_id_to_toaster_layer_id[lindex['layerBranches'][lbiId].get_layer_id()]),
                     release=release
                 )
             except KeyError:
                 logger.warning(
                     "No such layerindex layer referenced by layerbranch %d" %
-                    lbi['layer'])
+                    lindex['layerBranches'][lbiId].get_layer_id())
                 continue
 
             if created:
-                lv.release = li_branch_id_to_toaster_release[lbi['branch']]
-                lv.up_date = lbi['updated']
-                lv.commit = lbi['actual_branch']
-                lv.dirpath = lbi['vcs_subdir']
+                lv.release = li_branch_id_to_toaster_release[lindex['layerBranches'][lbiId].get_branch_id()]
+                lv.up_date = lindex['layerBranches'][lbiId].get_updated()
+                lv.commit = lindex['layerBranches'][lbiId].get_actual_branch()
+                lv.dirpath = lindex['layerBranches'][lbiId].get_vcs_subdir()
                 lv.save()
 
-            li_layer_branch_id_to_toaster_lv_id[lbi['id']] =\
+            li_layer_branch_id_to_toaster_lv_id[lindex['layerBranches'][lbiId].get_id()] =\
                 lv.pk
             self.mini_progress("layer versions", i, total)
 
-        logger.info("Fetching layer version dependencies")
-        # update layer dependencies
-        layerdependencies_info = _get_json_response(
-            apilinks['layerDependencies'] +
-            "?filter=layerbranch__branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing layer dependencies")
 
         dependlist = {}
-        for ldi in layerdependencies_info:
+        for ldiId in lindex['layerDependencies']:
             try:
                 lv = Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[ldi['layerbranch']])
+                    pk=li_layer_branch_id_to_toaster_lv_id[lindex['layerDependencies'][ldiId].get_layerbranch_id()])
             except Layer_Version.DoesNotExist as e:
                 continue
 
             if lv not in dependlist:
                 dependlist[lv] = []
             try:
-                layer_id = li_layer_id_to_toaster_layer_id[ldi['dependency']]
+                layer_id = li_layer_id_to_toaster_layer_id[lindex['layerDependencies'][ldiId].get_dependency_id()]
 
                 dependlist[lv].append(
                     Layer_Version.objects.get(layer__pk=layer_id,
@@ -240,7 +211,7 @@ class Command(BaseCommand):
             except Layer_Version.DoesNotExist:
                 logger.warning("Cannot find layer version (ls:%s),"
                                "up_id:%s lv:%s" %
-                               (self, ldi['dependency'], lv))
+                               (self, lindex['layerDependencies'][ldiId].get_dependency_id(), lv))
 
         total = len(dependlist)
         for i, lv in enumerate(dependlist):
@@ -251,73 +222,61 @@ class Command(BaseCommand):
             self.mini_progress("Layer version dependencies", i, total)
 
         # update Distros
-        logger.info("Fetching distro information")
-        distros_info = _get_json_response(
-            apilinks['distros'] + "?filter=layerbranch__branch__name:%s" %
-            "OR".join(whitelist_branch_names))
+        logger.info("Processing distro information")
 
-        total = len(distros_info)
-        for i, di in enumerate(distros_info):
+        total = len(lindex['distros'])
+        for i, diId in enumerate(lindex['distros']):
             distro, created = Distro.objects.get_or_create(
-                name=di['name'],
+                name=lindex['distros'][diId].get_name(),
                 layer_version=Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[di['layerbranch']]))
-            distro.up_date = di['updated']
-            distro.name = di['name']
-            distro.description = di['description']
+                    pk=li_layer_branch_id_to_toaster_lv_id[lindex['distros'][diId].get_layerbranch_id()]))
+            distro.up_date = lindex['distros'][diId].get_updated()
+            distro.name = lindex['distros'][diId].get_name()
+            distro.description = lindex['distros'][diId].get_description()
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
+        total = len(lindex['machines'])
+        for i, miId in enumerate(lindex['machines']):
             mo, created = Machine.objects.get_or_create(
-                name=mi['name'],
+                name=lindex['machines'][miId].get_name(),
                 layer_version=Layer_Version.objects.get(
-                    pk=li_layer_branch_id_to_toaster_lv_id[mi['layerbranch']]))
-            mo.up_date = mi['updated']
-            mo.name = mi['name']
-            mo.description = mi['description']
+                    pk=li_layer_branch_id_to_toaster_lv_id[lindex['machines'][miId].get_layerbranch_id()]))
+            mo.up_date = lindex['machines'][miId].get_updated()
+            mo.name = lindex['machines'][miId].get_name()
+            mo.description = lindex['machines'][miId].get_description()
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
+        total = len(lindex['recipes'])
+        for i, riId in enumerate(lindex['recipes']):
             try:
-                lv_id = li_layer_branch_id_to_toaster_lv_id[ri['layerbranch']]
+                lv_id = li_layer_branch_id_to_toaster_lv_id[lindex['recipes'][riId].get_layerbranch_id()]
                 lv = Layer_Version.objects.get(pk=lv_id)
 
                 ro, created = Recipe.objects.get_or_create(
                     layer_version=lv,
-                    name=ri['pn']
+                    name=lindex['recipes'][riId].get_pn()
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
+                ro.up_date = lindex['recipes'][riId].get_updated()
+                ro.name = lindex['recipes'][riId].get_pn()
+                ro.version = lindex['recipes'][riId].get_pv()
+                ro.summary = lindex['recipes'][riId].get_summary()
+                ro.description = lindex['recipes'][riId].get_description()
+                ro.section = lindex['recipes'][riId].get_section()
+                ro.license = lindex['recipes'][riId].get_license()
+                ro.homepage = lindex['recipes'][riId].get_homepage()
+                ro.bugtracker = lindex['recipes'][riId].get_bugtracker()
+                ro.file_path = lindex['recipes'][riId].get_filepath() + "/" + lindex['recipes'][riId].get_filename()
+                ro.is_image = 'image' in lindex['recipes'][riId].get_inherits().split()
                 ro.save()
             except Exception as e:
                 logger.warning("Failed saving recipe %s", e)
-- 
1.8.3.1


