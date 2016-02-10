Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id E71DE6018C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 11:51:57 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 10 Feb 2016 03:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,425,1449561600"; d="scan'208";a="912249674"
Received: from granquex-mobl3.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.12.23])
	by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2016 03:51:57 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Feb 2016 11:51:44 +0000
Message-Id: <1455105104-27188-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: models Remove manual transaction control from lsupdates
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
X-List-Received-Date: Wed, 10 Feb 2016 11:51:58 -0000

From: Michael Wood <michael.g.wood@intel.com>

Revert "toaster: models.py do not use transactions".
This reverts commit e248a503ba84658dea086e65e9cde8b845b9c0ed
(Bitbake rev: 48d0d510816346073f135bb86fb7904fdb50bb27)

Manually managing the database transactions caused more
problems than it temporarily solved so we return control back to
Django's orm.

[YOCTO #8796]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/orm/models.py | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index ac2aa9e..01afeed 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -1032,8 +1032,7 @@ class LayerIndexLayerSource(LayerSource):
 
         # update layers
         layers_info = _get_json_response(apilinks['layerItems'])
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(False)
+
         for li in layers_info:
             # Special case for the openembedded-core layer
             if li['name'] == oe_core_layer:
@@ -1065,17 +1064,12 @@ class LayerIndexLayerSource(LayerSource):
             l.description = li['description']
             l.save()
 
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(True)
-
         # update layerbranches/layer_versions
         logger.debug("Fetching layer information")
         layerbranches_info = _get_json_response(apilinks['layerBranches']
                 + "?filter=branch:%s" % "OR".join(map(lambda x: str(x.up_id), [i for i in Branch.objects.filter(layer_source = self) if i.up_id is not None] ))
             )
 
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(False)
         for lbi in layerbranches_info:
             lv, created = Layer_Version.objects.get_or_create(layer_source = self,
                     up_id = lbi['id'],
@@ -1088,14 +1082,10 @@ class LayerIndexLayerSource(LayerSource):
             lv.commit = lbi['actual_branch']
             lv.dirpath = lbi['vcs_subdir']
             lv.save()
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(True)
 
         # update layer dependencies
         layerdependencies_info = _get_json_response(apilinks['layerDependencies'])
         dependlist = {}
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(False)
         for ldi in layerdependencies_info:
             try:
                 lv = Layer_Version.objects.get(layer_source = self, up_id = ldi['layerbranch'])
@@ -1113,8 +1103,6 @@ class LayerIndexLayerSource(LayerSource):
             LayerVersionDependency.objects.filter(layer_version = lv).delete()
             for lvd in dependlist[lv]:
                 LayerVersionDependency.objects.get_or_create(layer_version = lv, depends_on = lvd)
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(True)
 
 
         # update machines
@@ -1123,8 +1111,6 @@ class LayerIndexLayerSource(LayerSource):
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
 
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(False)
         for mi in machines_info:
             mo, created = Machine.objects.get_or_create(layer_source = self, up_id = mi['id'], layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']))
             mo.up_date = mi['updated']
@@ -1132,16 +1118,11 @@ class LayerIndexLayerSource(LayerSource):
             mo.description = mi['description']
             mo.save()
 
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(True)
-
         # update recipes; paginate by layer version / layer branch
         logger.debug("Fetching target information")
         recipes_info = _get_json_response(apilinks['recipes']
                 + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
             )
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(False)
         for ri in recipes_info:
             try:
                 ro, created = Recipe.objects.get_or_create(layer_source = self, up_id = ri['id'], layer_version = Layer_Version.objects.get(layer_source = self, up_id = ri['layerbranch']))
@@ -1163,8 +1144,6 @@ class LayerIndexLayerSource(LayerSource):
             except IntegrityError as e:
                 logger.debug("Failed saving recipe, ignoring: %s (%s:%s)" % (e, ro.layer_version, ri['filepath']+"/"+ri['filename']))
                 ro.delete()
-        if not connection.features.autocommits_when_autocommit_is_off:
-            transaction.set_autocommit(True)
 
 class BitbakeVersion(models.Model):
 
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


