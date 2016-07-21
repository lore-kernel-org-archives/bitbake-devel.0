Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id 2E746731D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:44:29 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8981412123B;
	Thu, 21 Jul 2016 13:44:29 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-2-62.us-west-2.compute.internal [10.229.2.62])
	by relay.mailchannels.net (Postfix) with ESMTPA id D0BFC1212F6;
	Thu, 21 Jul 2016 13:44:28 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.135.9.54])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:44:29 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108669158:1723879947
X-MC-Ingress-Time: 1469108669158
Received: from [176.249.240.35] (port=56888 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQEH5-0002ZY-K2; Thu, 21 Jul 2016 09:44:27 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:43:29 +0100
Message-Id: <1469108612-12433-7-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
References: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH][v2 07/10] toaster: lsupdates Add progress information and clean up logging
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
X-List-Received-Date: Thu, 21 Jul 2016 13:44:29 -0000

From: Michael Wood <michael.g.wood@intel.com>

Adds basic progress % information and provides better description of
what is happening.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../toaster/orm/management/commands/lsupdates.py   | 81 ++++++++++++++++------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/toaster/orm/management/commands/lsupdates.py b/bitbake/lib/toaster/orm/management/commands/lsupdates.py
index 89ee53e..138b686 100644
--- a/bitbake/lib/toaster/orm/management/commands/lsupdates.py
+++ b/bitbake/lib/toaster/orm/management/commands/lsupdates.py
@@ -25,6 +25,8 @@ from orm.models import LayerSource, Layer, Release, Layer_Version
 from orm.models import LayerVersionDependency, Machine, Recipe
 
 import os
+import sys
+
 import json
 import logging
 logger = logging.getLogger("toaster")
@@ -36,6 +38,18 @@ class Command(NoArgsCommand):
     args = ""
     help = "Updates locally cached information from a layerindex server"
 
+    def mini_progress(self, what, i, total):
+        i = i + 1
+        pec = (float(i)/float(total))*100
+
+        sys.stdout.write("\rUpdating %s %d%%" %
+                         (what,
+                          pec))
+        sys.stdout.flush()
+        if int(pec) is 100:
+            sys.stdout.write("\n")
+            sys.stdout.flush()
+
     def update(self):
         """
             Fetches layer, recipe and machine information from a layerindex
@@ -85,7 +99,8 @@ class Command(NoArgsCommand):
         if len(whitelist_branch_names) == 0:
             raise Exception("Failed to make list of branches to fetch")
 
-        logger.debug("Fetching branches")
+        logger.info("Fetching metadata releases for %s",
+                    " ".join(whitelist_branch_names))
 
         # keep a track of the id mappings so that layer_versions can be created
         # for these layers later on
@@ -96,10 +111,10 @@ class Command(NoArgsCommand):
         #                                   "?filter=name:%s"
         #                                   % "OR".join(whitelist_branch_names))
 
-        # update layers
         layers_info = _get_json_response(apilinks['layerItems'])
 
-        for li in layers_info:
+        total = len(layers_info)
+        for i, li in enumerate(layers_info):
             # Special case for the openembedded-core layer
             if li['name'] == oe_core_layer:
                 try:
@@ -113,25 +128,34 @@ class Command(NoArgsCommand):
                     oe_core_l.description = li['description']
                     oe_core_l.save()
                     li_layer_id_to_toaster_layer_id[li['id']] = oe_core_l.pk
+                    self.mini_progress("layers", i, total)
                     continue
 
                 except Layer.DoesNotExist:
                     pass
 
-            l, created = Layer.objects.get_or_create(name=li['name'])
-            l.up_date = li['updated']
-            l.vcs_url = li['vcs_url']
-            l.vcs_web_url = li['vcs_web_url']
-            l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
-            l.vcs_web_file_base_url = li['vcs_web_file_base_url']
-            l.summary = li['summary']
-            l.description = li['description']
-            l.save()
+            try:
+                l, created = Layer.objects.get_or_create(name=li['name'],
+                                                         vcs_url=li['vcs_url'])
+                l.up_date = li['updated']
+                l.vcs_url = li['vcs_url']
+                l.vcs_web_url = li['vcs_web_url']
+                l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
+                l.vcs_web_file_base_url = li['vcs_web_file_base_url']
+                l.summary = li['summary']
+                l.description = li['description']
+                l.save()
+            except Layer.MultipleObjectsReturned:
+                logger.info("Skipped %s as we found multiple layers and "
+                            "don't know which to update" %
+                            li['name'])
 
             li_layer_id_to_toaster_layer_id[li['id']] = l.pk
 
-        # update layerbranches/layer_versions
-        logger.debug("Fetching layer information")
+            self.mini_progress("layers", i, total)
+
+        # update layer_versions
+        logger.info("Fetching layer versions")
         layerbranches_info = _get_json_response(
             apilinks['layerBranches'] + "?filter=branch__name:%s" %
             "OR".join(whitelist_branch_names))
@@ -140,7 +164,8 @@ class Command(NoArgsCommand):
         # layer_version toaster object id
         li_layer_branch_id_to_toaster_lv_id = {}
 
-        for lbi in layerbranches_info:
+        total = len(layerbranches_info)
+        for i, lbi in enumerate(layerbranches_info):
 
             try:
                 lv, created = Layer_Version.objects.get_or_create(
@@ -149,8 +174,9 @@ class Command(NoArgsCommand):
                         pk=li_layer_id_to_toaster_layer_id[lbi['layer']])
                 )
             except KeyError:
-                print("No such layerindex layer referenced by layerbranch %d" %
-                      lbi['layer'])
+                logger.warning(
+                    "No such layerindex layer referenced by layerbranch %d" %
+                    lbi['layer'])
                 continue
 
             lv.up_date = lbi['updated']
@@ -160,7 +186,9 @@ class Command(NoArgsCommand):
 
             li_layer_branch_id_to_toaster_lv_id[lbi['id']] =\
                 lv.pk
+            self.mini_progress("layer versions", i, total)
 
+        logger.info("Fetching layer version dependencies")
         # update layer dependencies
         layerdependencies_info = _get_json_response(
             apilinks['layerDependencies'] +
@@ -190,19 +218,22 @@ class Command(NoArgsCommand):
                                "up_id:%s lv:%s" %
                                (self, ldi['dependency'], lv))
 
-        for lv in dependlist:
+        total = len(dependlist)
+        for i, lv in enumerate(dependlist):
             LayerVersionDependency.objects.filter(layer_version=lv).delete()
             for lvd in dependlist[lv]:
                 LayerVersionDependency.objects.get_or_create(layer_version=lv,
                                                              depends_on=lvd)
+            self.mini_progress("Layer version dependencies", i, total)
 
         # update machines
-        logger.debug("Fetching machine information")
+        logger.info("Fetching machine information")
         machines_info = _get_json_response(
             apilinks['machines'] + "?filter=layerbranch__branch__name:%s" %
             "OR".join(whitelist_branch_names))
 
-        for mi in machines_info:
+        total = len(machines_info)
+        for i, mi in enumerate(machines_info):
             mo, created = Machine.objects.get_or_create(
                 name=mi['name'],
                 layer_version=Layer_Version.objects.get(
@@ -211,14 +242,16 @@ class Command(NoArgsCommand):
             mo.name = mi['name']
             mo.description = mi['description']
             mo.save()
+            self.mini_progress("machines", i, total)
 
         # update recipes; paginate by layer version / layer branch
-        logger.debug("Fetching target information")
+        logger.info("Fetching recipe information")
         recipes_info = _get_json_response(
             apilinks['recipes'] + "?filter=layerbranch__branch__name:%s" %
             "OR".join(whitelist_branch_names))
 
-        for ri in recipes_info:
+        total = len(recipes_info)
+        for i, ri in enumerate(recipes_info):
             try:
                 lv_id = li_layer_branch_id_to_toaster_lv_id[ri['layerbranch']]
                 lv = Layer_Version.objects.get(pk=lv_id)
@@ -245,7 +278,9 @@ class Command(NoArgsCommand):
                     ro.is_image = "-image-" in ri['pn']
                 ro.save()
             except Exception as e:
-                logger.debug("Failed saving recipe %s", e)
+                logger.warning("Failed saving recipe %s", e)
+
+            self.mini_progress("recipes", i, total)
 
     def handle_noargs(self, **options):
             self.update()
-- 
2.7.4


