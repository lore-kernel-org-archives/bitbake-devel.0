Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id 2B0D4731F7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:39:36 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AEBEB20A24;
	Thu, 21 Jul 2016 13:39:36 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-10-199.us-west-2.compute.internal [10.229.10.199])
	by relay.mailchannels.net (Postfix) with ESMTPA id 13463206AF;
	Thu, 21 Jul 2016 13:39:36 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.107.128.240])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:39:36 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108376433:4036462896
X-MC-Ingress-Time: 1469108376432
Received: from [176.249.240.35] (port=56876 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQECM-00012R-NH; Thu, 21 Jul 2016 09:39:35 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:39:10 +0100
Message-Id: <1469108352-12098-8-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
References: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 08/10] toaster: orm Remove the layerindex specific up_branch fields
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
X-List-Received-Date: Thu, 21 Jul 2016 13:39:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

We don't need to keep track of layerindex data in our database. And
using branch==release is very confusing in the schema. Instead use the
existing Release definition to keep track of which release a
layer_version is for.

Remove the Branch model and all references to it.

Create a migration path to convert from up_branches to their
corresponding releases.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py               |  6 +--
 .../bldcontrol/management/commands/loadconf.py     |  2 +-
 .../toaster/orm/management/commands/lsupdates.py   | 23 +++++---
 .../0012_use_release_instead_of_up_branch.py       | 62 ++++++++++++++++++++++
 bitbake/lib/toaster/orm/models.py                  | 32 +++--------
 .../fixtures/toastergui-unittest-data.xml          | 21 +++++---
 bitbake/lib/toaster/toastergui/tests.py            |  2 +-
 bitbake/lib/toaster/toastergui/views.py            |  8 +--
 8 files changed, 108 insertions(+), 48 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 91189f6..8cd9371 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -393,7 +393,7 @@ class ORMWrapper(object):
             layer_copy, c = Layer_Version.objects.get_or_create(
                 build=build_obj,
                 layer=layer_obj.layer,
-                up_branch=layer_obj.up_branch,
+                release=layer_obj.release,
                 branch=layer_version_information['branch'],
                 commit=layer_version_information['commit'],
                 local_path=layer_version_information['local_path'],
@@ -625,8 +625,8 @@ class ORMWrapper(object):
                         Recipe,
                         name=built_recipe.name,
                         layer_version__build=None,
-                        layer_version__up_branch=
-                        built_recipe.layer_version.up_branch,
+                        layer_version__release=
+                        built_recipe.layer_version.release,
                         file_path=built_recipe.file_path,
                         version=built_recipe.version
                     )
diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
index 1f57fc1..59324ac 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -1,5 +1,5 @@
 from django.core.management.base import BaseCommand, CommandError
-from orm.models import LayerSource, ToasterSetting, Branch, Layer, Layer_Version
+from orm.models import LayerSource, ToasterSetting, Layer, Layer_Version
 from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer
 from django.db import IntegrityError
 import os
diff --git a/bitbake/lib/toaster/orm/management/commands/lsupdates.py b/bitbake/lib/toaster/orm/management/commands/lsupdates.py
index 138b686..be63a85 100644
--- a/bitbake/lib/toaster/orm/management/commands/lsupdates.py
+++ b/bitbake/lib/toaster/orm/management/commands/lsupdates.py
@@ -102,14 +102,24 @@ class Command(NoArgsCommand):
         logger.info("Fetching metadata releases for %s",
                     " ".join(whitelist_branch_names))
 
-        # keep a track of the id mappings so that layer_versions can be created
-        # for these layers later on
+        branches_info = _get_json_response(apilinks['branches'] +
+                                           "?filter=name:%s"
+                                           % "OR".join(whitelist_branch_names))
+
+        # Map the layer index branches to toaster releases
+        li_branch_id_to_toaster_release = {}
+
+        total = len(branches_info)
+        for i, branch in enumerate(branches_info):
+            li_branch_id_to_toaster_release[branch['id']] = \
+                    Release.objects.get(name=branch['name'])
+            self.mini_progress("Releases", i, total)
+
+        # keep a track of the layerindex (li) id mappings so that
+        # layer_versions can be created for these layers later on
         li_layer_id_to_toaster_layer_id = {}
 
-        # We may need this? TODO
-        #branches_info = _get_json_response(apilinks['branches'] +
-        #                                   "?filter=name:%s"
-        #                                   % "OR".join(whitelist_branch_names))
+        logger.info("Fetching layers")
 
         layers_info = _get_json_response(apilinks['layerItems'])
 
@@ -179,6 +189,7 @@ class Command(NoArgsCommand):
                     lbi['layer'])
                 continue
 
+            lv.release = li_branch_id_to_toaster_release[lbi['branch']]
             lv.up_date = lbi['updated']
             lv.commit = lbi['actual_branch']
             lv.dirpath = lbi['vcs_subdir']
diff --git a/bitbake/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py b/bitbake/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py
new file mode 100644
index 0000000..0e6bb83
--- /dev/null
+++ b/bitbake/lib/toaster/orm/migrations/0012_use_release_instead_of_up_branch.py
@@ -0,0 +1,62 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+from django.db.models import Q
+
+
+def branch_to_release(apps, schema_editor):
+    Layer_Version = apps.get_model('orm', 'Layer_Version')
+    Release = apps.get_model('orm', 'Release')
+
+    print("Converting all layer version up_branches to releases")
+    # Find all the layer versions which have an upbranch and convert them to
+    # the release that they're for.
+    for layer_version in Layer_Version.objects.filter(
+            Q(release=None) & ~Q(up_branch=None)):
+        try:
+            # HEAD and local are equivalent
+            if "HEAD" in layer_version.up_branch.name:
+                release = Release.objects.get(name="local")
+                layer_version.commit = "HEAD"
+                layer_version.branch = "HEAD"
+            else:
+                release = Release.objects.get(
+                    name=layer_version.up_branch.name)
+
+            layer_version.release = release
+            layer_version.save()
+        except Exception as e:
+            print("Couldn't work out an appropriate release for %s "
+                  "the up_branch was %s "
+                  "user the django admin interface to correct it" %
+                  (layer_version.layer.name, layer_version.up_branch.name))
+            print(e)
+
+            continue
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0011_delete_layersource'),
+    ]
+
+    operations = [
+        migrations.AddField(
+            model_name='layer_version',
+            name='release',
+            field=models.ForeignKey(to='orm.Release', default=None, null=True),
+        ),
+        migrations.RunPython(branch_to_release,
+                             reverse_code=migrations.RunPython.noop),
+
+        migrations.RemoveField(
+            model_name='layer_version',
+            name='up_branch',
+        ),
+
+        migrations.DeleteModel(
+            name='Branch',
+        ),
+    ]
diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 34ea28c..72b9dfe 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -144,7 +144,7 @@ class ProjectManager(models.Manager):
         for rdl in release.releasedefaultlayer_set.all():
             lv = Layer_Version.objects.filter(
                 layer__name=rdl.layer_name,
-                up_branch__name=release.branch_name).first()
+                release=release).first()
 
             if lv:
                 ProjectLayer.objects.create(project=prj,
@@ -280,7 +280,7 @@ class Project(models.Model):
         # guard on release, as it can be null
         if self.release:
             queryset = Layer_Version.objects.filter(
-                (Q(up_branch__name=self.release.branch_name) &
+                (Q(release=self.release) &
                  Q(build=None) &
                  Q(project=None)) |
                  Q(project=self))
@@ -1257,22 +1257,6 @@ class ReleaseDefaultLayer(models.Model):
     layer_name = models.CharField(max_length=100, default="")
 
 
-# Branch class is synced with layerindex.Branch, branches can only come
-# from remote layer indexes
-class Branch(models.Model):
-    # id of branch in the layerindex
-    up_date = models.DateTimeField(null=True, default=None)
-
-    name = models.CharField(max_length=50)
-    short_description = models.CharField(max_length=50, blank=True)
-
-    class Meta:
-        verbose_name_plural = "Branches"
-
-    def __unicode__(self):
-        return self.name
-
-
 class LayerSource(object):
     """ Where the layer metadata came from """
     TYPE_LOCAL = 0
@@ -1321,7 +1305,7 @@ class Layer_Version(models.Model):
     """
     search_allowed_fields = ["layer__name", "layer__summary",
                              "layer__description", "layer__vcs_url",
-                             "dirpath", "up_branch__name", "commit", "branch"]
+                             "dirpath", "release__name", "commit", "branch"]
 
     build = models.ForeignKey(Build, related_name='layer_version_build',
                               default=None, null=True)
@@ -1333,8 +1317,8 @@ class Layer_Version(models.Model):
 
     up_date = models.DateTimeField(null=True, default=timezone.now)
 
-    # layerindex specific field
-    up_branch = models.ForeignKey(Branch, null=True, default=None)
+    # To which metadata release does this layer version belong to
+    release = models.ForeignKey(Release, null=True, default=None)
 
     branch = models.CharField(max_length=80)
     commit = models.CharField(max_length=100)
@@ -1368,7 +1352,7 @@ class Layer_Version(models.Model):
                     extra_path = self.dirpath
             else:
                 extra_path = path
-            branchname = self.up_branch.name
+            branchname = self.release.name
             url = base_url.replace('%branch%', branchname)
 
             # If there's a % in the path (e.g. a wildcard bbappend) we need to encode it
@@ -1404,8 +1388,8 @@ class Layer_Version(models.Model):
     def get_vcs_reference(self):
         if self.branch is not None and len(self.branch) > 0:
             return self.branch
-        if self.up_branch is not None:
-            return self.up_branch.name
+        if self.release is not None:
+            return self.release.name
         if self.commit is not None and len(self.commit) > 0:
             return self.commit
         return 'N/A'
diff --git a/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml b/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
index 80c1e19..4517ed1 100644
--- a/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
+++ b/bitbake/lib/toaster/toastergui/fixtures/toastergui-unittest-data.xml
@@ -1,5 +1,16 @@
 <?xml version="1.0" encoding="utf-8"?>
 <django-objects version="1.0">
+   <object pk="1" model="orm.bitbakeversion">
+      <field type="CharField" name="name">v2.3</field>
+      <field type="GitURLField" name="giturl">git://git.openembedded.org/bitbake</field>
+      <field type="CharField" name="dirpath">b</field>
+      <field type="CharField" name="branch">a</field>
+  </object>
+  <object pk="1" model="orm.release">
+     <field type="CharField" name="name">master</field>
+     <field type="CharField" name="description">master project</field>
+     <field to="orm.bitbake_version" name="bitbake_version">1</field>
+  </object>
   <object pk="1" model="orm.project">
     <field type="CharField" name="name">a test project</field>
     <field type="CharField" name="short_description"></field>
@@ -332,10 +343,6 @@
     <field type="CharField" name="branch_name">master</field>
     <field type="TextField" name="helptext"><None></None></field>
   </object>
-  <object pk="1" model="orm.branch">
-    <field type="CharField" name="name">master</field>
-    <field type="CharField" name="short_description"></field>
-  </object>
   <object pk="1" model="orm.layer">
     <field type="DateTimeField" name="up_date"><None></None></field>
     <field type="CharField" name="name">a layer</field>
@@ -351,7 +358,7 @@
     <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
     <field to="orm.layer" name="layer" rel="ManyToOneRel">1</field>
     <field type="DateTimeField" name="up_date"><None></None></field>
-    <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
+    <field to="orm.release" name="release" rel="ManyToOneRel">1</field>
     <field type="CharField" name="branch">master</field>
     <field type="CharField" name="commit">abcdef123</field>
     <field type="CharField" name="dirpath">/tmp/</field>
@@ -363,7 +370,7 @@
     <field to="orm.build" name="build" rel="ManyToOneRel"><None></None></field>
     <field to="orm.layer" name="layer" rel="ManyToOneRel">2</field>
     <field type="DateTimeField" name="up_date"><None></None></field>
-    <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
+    <field to="orm.release" name="release" rel="ManyToOneRel">1</field>
     <field type="CharField" name="branch">testing-branch</field>
     <field type="CharField" name="commit">9876fedcba</field>
     <field type="CharField" name="dirpath"><None></None></field>
@@ -375,7 +382,7 @@
     <field to="orm.build" name="build" rel="ManyToOneRel">1</field>
     <field to="orm.layer" name="layer" rel="ManyToOneRel">2</field>
     <field type="DateTimeField" name="up_date"><None></None></field>
-    <field to="orm.branch" name="up_branch" rel="ManyToOneRel">1</field>
+    <field to="orm.release" name="release" rel="ManyToOneRel">1</field>
     <field type="CharField" name="branch">testing-branch</field>
     <field type="CharField" name="commit">9876fedcba</field>
     <field type="CharField" name="dirpath"><None></None></field>
diff --git a/bitbake/lib/toaster/toastergui/tests.py b/bitbake/lib/toaster/toastergui/tests.py
index 03b73a9..61ac477 100644
--- a/bitbake/lib/toaster/toastergui/tests.py
+++ b/bitbake/lib/toaster/toastergui/tests.py
@@ -31,7 +31,7 @@ from orm.models import Project, Release, BitbakeVersion, Package, LogMessage
 from orm.models import LayerSource, Layer, Build
 from orm.models import Layer_Version, Recipe, Machine, ProjectLayer, Target
 from orm.models import CustomImageRecipe, ProjectVariable
-from orm.models import Branch, CustomImagePackage
+from orm.models import CustomImagePackage
 
 import toastermain
 import inspect
diff --git a/bitbake/lib/toaster/toastergui/views.py b/bitbake/lib/toaster/toastergui/views.py
index d19815f..a40ceef 100755
--- a/bitbake/lib/toaster/toastergui/views.py
+++ b/bitbake/lib/toaster/toastergui/views.py
@@ -161,7 +161,7 @@ def _lv_to_dict(prj, x = None):
     return {"id": x.pk,
             "name": x.layer.name,
             "tooltip": "%s | %s" % (x.layer.vcs_url,x.get_vcs_reference()),
-            "detail": "(%s" % x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.get_vcs_reference()+")"),
+            "detail": "(%s" % x.layer.vcs_url + (")" if x.release == None else " | "+x.get_vcs_reference()+")"),
             "giturl": x.layer.vcs_url,
             "layerdetailurl" : reverse('layerdetails', args=(prj.id,x.pk)),
             "revision" : x.get_vcs_reference(),
@@ -1288,7 +1288,7 @@ if True:
     from django.contrib.auth import authenticate, login
     from django.contrib.auth.decorators import login_required
 
-    from orm.models import Branch, LayerSource, ToasterSetting, Release, Machine, LayerVersionDependency
+    from orm.models import LayerSource, ToasterSetting, Release, Machine, LayerVersionDependency
     from bldcontrol.models import BuildRequest
 
     import traceback
@@ -1667,9 +1667,6 @@ if True:
           post_data[key] = val.strip()
 
 
-        # We need to know what release the current project is so that we
-        # can set the imported layer's up_branch_id
-
         try:
             layer, layer_created = Layer.objects.get_or_create(name=post_data['name'])
         except MultipleObjectsReturned:
@@ -1759,7 +1756,6 @@ if True:
 
         return HttpResponse(jsonfilter(json_response), content_type = "application/json")
 
-
     @xhr_response
     def xhr_customrecipe(request):
         """
-- 
2.7.4


