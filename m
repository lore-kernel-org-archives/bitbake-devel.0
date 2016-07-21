Return-Path: <elliot.smith@intel.com>
Received: from gainsboro.cherry.relay.mailchannels.net
	(gainsboro.cherry.relay.mailchannels.net [23.83.223.65])
	by mail.openembedded.org (Postfix) with ESMTP id 74FFD731C6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:39:38 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 0267B10081E;
	Thu, 21 Jul 2016 13:39:32 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-229-10-199.us-west-2.compute.internal [10.229.10.199])
	by relay.mailchannels.net (Postfix) with ESMTPA id 387E6100BC7;
	Thu, 21 Jul 2016 13:39:31 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.92.147.53])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:39:31 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108371653:2361538465
X-MC-Ingress-Time: 1469108371653
Received: from [176.249.240.35] (port=56876 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQECH-00012R-QE; Thu, 21 Jul 2016 09:39:30 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:39:05 +0100
Message-Id: <1469108352-12098-3-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
References: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 03/10] toaster: models Remove LayerSource models and replace with enum
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
X-List-Received-Date: Thu, 21 Jul 2016 13:39:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

We had a lot of complexity around different layer sources to allow for
multiple sources and different priorities for these source. This was
implemented using rigged abstract classes which represented the
different layer sources when in fact just an enum/flag on the
layer_version object is sufficient for our needs.

Remove the LayerSourcePriority object as this is not needed. We no longer
have a problem of multiple layers coming from multiple sources so this
is not needed. Two migrations are added to first remove the child models
which represented layersources. Then a second migration is needed to
remove the LayerSource model it's self as Django can't understand the
non-standard base class dependency. Triggering this issue:
https://docs.djangoproject.com/en/1.8/topics/migrations/#dependencies

Clean up a number of flake8 warnings in classes which were modified.

[YOCTO #9853]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 .../0010_delete_layer_source_references.py         | 118 +++++
 .../orm/migrations/0011_delete_layersource.py      |  17 +
 bitbake/lib/toaster/orm/models.py                  | 481 +++++----------------
 3 files changed, 238 insertions(+), 378 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0010_delete_layer_source_references.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0011_delete_layersource.py

diff --git a/bitbake/lib/toaster/orm/migrations/0010_delete_layer_source_references.py b/bitbake/lib/toaster/orm/migrations/0010_delete_layer_source_references.py
new file mode 100644
index 0000000..f67388e
--- /dev/null
+++ b/bitbake/lib/toaster/orm/migrations/0010_delete_layer_source_references.py
@@ -0,0 +1,118 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+import django.utils.timezone
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0009_target_package_manifest_path'),
+    ]
+
+    operations = [
+        migrations.AlterUniqueTogether(
+            name='releaselayersourcepriority',
+            unique_together=set([]),
+        ),
+        migrations.RemoveField(
+            model_name='releaselayersourcepriority',
+            name='layer_source',
+        ),
+        migrations.RemoveField(
+            model_name='releaselayersourcepriority',
+            name='release',
+        ),
+        migrations.DeleteModel(
+            name='ImportedLayerSource',
+        ),
+        migrations.DeleteModel(
+            name='LayerIndexLayerSource',
+        ),
+        migrations.DeleteModel(
+            name='LocalLayerSource',
+        ),
+        migrations.RemoveField(
+            model_name='recipe',
+            name='layer_source',
+        ),
+        migrations.RemoveField(
+            model_name='recipe',
+            name='up_id',
+        ),
+        migrations.AlterField(
+            model_name='layer',
+            name='up_date',
+            field=models.DateTimeField(default=django.utils.timezone.now, null=True),
+        ),
+        migrations.AlterField(
+            model_name='layer_version',
+            name='layer_source',
+            field=models.IntegerField(default=0, choices=[(0, 'local'), (1, 'layerindex'), (2, 'imported'), (3, 'build')]),
+        ),
+        migrations.AlterField(
+            model_name='layer_version',
+            name='up_date',
+            field=models.DateTimeField(default=django.utils.timezone.now, null=True),
+        ),
+        migrations.AlterUniqueTogether(
+            name='branch',
+            unique_together=set([]),
+        ),
+        migrations.AlterUniqueTogether(
+            name='layer',
+            unique_together=set([]),
+        ),
+        migrations.AlterUniqueTogether(
+            name='layer_version',
+            unique_together=set([]),
+        ),
+        migrations.AlterUniqueTogether(
+            name='layerversiondependency',
+            unique_together=set([]),
+        ),
+        migrations.AlterUniqueTogether(
+            name='machine',
+            unique_together=set([]),
+        ),
+        migrations.DeleteModel(
+            name='ReleaseLayerSourcePriority',
+        ),
+        migrations.RemoveField(
+            model_name='branch',
+            name='layer_source',
+        ),
+        migrations.RemoveField(
+            model_name='branch',
+            name='up_id',
+        ),
+        migrations.RemoveField(
+            model_name='layer',
+            name='layer_source',
+        ),
+        migrations.RemoveField(
+            model_name='layer',
+            name='up_id',
+        ),
+        migrations.RemoveField(
+            model_name='layer_version',
+            name='up_id',
+        ),
+        migrations.RemoveField(
+            model_name='layerversiondependency',
+            name='layer_source',
+        ),
+        migrations.RemoveField(
+            model_name='layerversiondependency',
+            name='up_id',
+        ),
+        migrations.RemoveField(
+            model_name='machine',
+            name='layer_source',
+        ),
+        migrations.RemoveField(
+            model_name='machine',
+            name='up_id',
+        ),
+    ]
diff --git a/bitbake/lib/toaster/orm/migrations/0011_delete_layersource.py b/bitbake/lib/toaster/orm/migrations/0011_delete_layersource.py
new file mode 100644
index 0000000..7550696
--- /dev/null
+++ b/bitbake/lib/toaster/orm/migrations/0011_delete_layersource.py
@@ -0,0 +1,17 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0010_delete_layer_source_references'),
+    ]
+
+    operations = [
+        migrations.DeleteModel(
+            name='LayerSource',
+        ),
+    ]
diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 048399f..1daec9c 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -22,7 +22,7 @@
 from __future__ import unicode_literals
 
 from django.db import models, IntegrityError
-from django.db.models import F, Q, Avg, Max, Sum, Count
+from django.db.models import F, Q, Sum, Count
 from django.utils import timezone
 from django.utils.encoding import force_bytes
 
@@ -117,39 +117,48 @@ class ToasterSetting(models.Model):
     def __unicode__(self):
         return "Setting %s = %s" % (self.name, self.value)
 
+
 class ProjectManager(models.Manager):
     def create_project(self, name, release):
         if release is not None:
-            prj = self.model(name = name, bitbake_version = release.bitbake_version, release = release)
+            prj = self.model(name=name,
+                             bitbake_version=release.bitbake_version,
+                             release=release)
         else:
-            prj = self.model(name = name, bitbake_version = None, release = None)
+            prj = self.model(name=name,
+                             bitbake_version=None,
+                             release=None)
 
         prj.save()
 
-        for defaultconf in ToasterSetting.objects.filter(name__startswith="DEFCONF_"):
+        for defaultconf in ToasterSetting.objects.filter(
+                name__startswith="DEFCONF_"):
             name = defaultconf.name[8:]
-            ProjectVariable.objects.create( project = prj,
-                name = name,
-                value = defaultconf.value)
+            ProjectVariable.objects.create(project=prj,
+                                           name=name,
+                                           value=defaultconf.value)
 
         if release is None:
             return prj
 
         for rdl in release.releasedefaultlayer_set.all():
-            try:
-                lv = Layer_Version.objects.filter(layer__name = rdl.layer_name, up_branch__name = release.branch_name)[0].get_equivalents_wpriority(prj)[0]
-                ProjectLayer.objects.create( project = prj,
-                        layercommit = lv,
-                        optional = False )
-            except IndexError:
-                # we may have no valid layer version objects, and that's ok
-                pass
+            lv = Layer_Version.objects.filter(
+                layer__name=rdl.layer_name,
+                up_branch__name=release.branch_name).first()
+
+            if lv:
+                ProjectLayer.objects.create(project=prj,
+                                            layercommit=lv,
+                                            optional=False)
+            else:
+                logger.warning("Default project layer %s not found" %
+                               rdl.layer_name)
 
         return prj
 
     # return single object with is_default = True
     def get_or_create_default_project(self):
-        projects = super(ProjectManager, self).filter(is_default = True)
+        projects = super(ProjectManager, self).filter(is_default=True)
 
         if len(projects) > 1:
             raise Exception('Inconsistent project data: multiple ' +
@@ -157,7 +166,8 @@ class ProjectManager(models.Manager):
         elif len(projects) < 1:
             options = {
                 'name': 'Command line builds',
-                'short_description': 'Project for builds started outside Toaster',
+                'short_description':
+                'Project for builds started outside Toaster',
                 'is_default': True
             }
             project = Project.objects.create(**options)
@@ -1126,21 +1136,27 @@ class Target_Installed_Package(models.Model):
     target = models.ForeignKey(Target)
     package = models.ForeignKey(Package, related_name='buildtargetlist_package')
 
+
 class Package_File(models.Model):
     package = models.ForeignKey(Package, related_name='buildfilelist_package')
     path = models.FilePathField(max_length=255, blank=True)
     size = models.IntegerField()
 
+
 class Recipe(models.Model):
-    search_allowed_fields = ['name', 'version', 'file_path', 'section', 'summary', 'description', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__local_path', 'layer_version__layer_source__name']
+    search_allowed_fields = ['name', 'version', 'file_path', 'section',
+                             'summary', 'description', 'license',
+                             'layer_version__layer__name',
+                             'layer_version__branch', 'layer_version__commit',
+                             'layer_version__local_path',
+                             'layer_version__layer_source']
 
-    layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this recipe
-    up_id = models.IntegerField(null = True, default = None)                    # id of entry in the source
-    up_date = models.DateTimeField(null = True, default = None)
+    up_date = models.DateTimeField(null=True, default=None)
 
-    name = models.CharField(max_length=100, blank=True)                 # pn
-    version = models.CharField(max_length=100, blank=True)              # pv
-    layer_version = models.ForeignKey('Layer_Version', related_name='recipe_layer_version')
+    name = models.CharField(max_length=100, blank=True)
+    version = models.CharField(max_length=100, blank=True)
+    layer_version = models.ForeignKey('Layer_Version',
+                                      related_name='recipe_layer_version')
     summary = models.TextField(blank=True)
     description = models.TextField(blank=True)
     section = models.CharField(max_length=100, blank=True)
@@ -1151,13 +1167,6 @@ class Recipe(models.Model):
     pathflags = models.CharField(max_length=200, blank=True)
     is_image = models.BooleanField(default=False)
 
-    def get_layersource_view_url(self):
-        if self.layer_source is None:
-            return ""
-
-        url = self.layer_source.get_object_view(self.layer_version.up_branch, "recipes", self.name)
-        return url
-
     def __unicode__(self):
         return "Recipe " + self.name + ":" + self.version
 
@@ -1203,8 +1212,6 @@ class Recipe_Dependency(models.Model):
 
 class Machine(models.Model):
     search_allowed_fields = ["name", "description", "layer_version__layer__name"]
-    layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this machine
-    up_id = models.IntegerField(null = True, default = None)                      # id of entry in the source
     up_date = models.DateTimeField(null = True, default = None)
 
     layer_version = models.ForeignKey('Layer_Version')
@@ -1219,293 +1226,9 @@ class Machine(models.Model):
     def __unicode__(self):
         return "Machine " + self.name + "(" + self.description + ")"
 
-    class Meta:
-        unique_together = ("layer_source", "up_id")
-
-
-from django.db.models.base import ModelBase
 
-class InheritanceMetaclass(ModelBase):
-    def __call__(cls, *args, **kwargs):
-        obj = super(InheritanceMetaclass, cls).__call__(*args, **kwargs)
-        return obj.get_object()
 
 
-class LayerSource(models.Model):
-    __metaclass__ = InheritanceMetaclass
-
-    class Meta:
-        unique_together = (('sourcetype', 'apiurl'), )
-
-    TYPE_LOCAL = 0
-    TYPE_LAYERINDEX = 1
-    TYPE_IMPORTED = 2
-    SOURCE_TYPE = (
-        (TYPE_LOCAL, "local"),
-        (TYPE_LAYERINDEX, "layerindex"),
-        (TYPE_IMPORTED, "imported"),
-      )
-
-    name = models.CharField(max_length=63, unique = True)
-    sourcetype = models.IntegerField(choices=SOURCE_TYPE)
-    apiurl = models.CharField(max_length=255, null=True, default=None)
-
-    def __init__(self, *args, **kwargs):
-        super(LayerSource, self).__init__(*args, **kwargs)
-        if self.sourcetype == LayerSource.TYPE_LOCAL:
-            self.__class__ = LocalLayerSource
-        elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
-            self.__class__ = LayerIndexLayerSource
-        elif self.sourcetype == LayerSource.TYPE_IMPORTED:
-            self.__class__ = ImportedLayerSource
-        elif self.sourcetype == None:
-            raise Exception("Unknown LayerSource-derived class. If you added a new layer source type, fill out all code stubs.")
-
-
-    def update(self):
-        """
-            Updates the local database information from the upstream layer source
-        """
-        raise Exception("Abstract, update() must be implemented by all LayerSource-derived classes (object is %s)" % str(vars(self)))
-
-    def save(self, *args, **kwargs):
-        return super(LayerSource, self).save(*args, **kwargs)
-
-    def get_object(self):
-        # preset an un-initilized object
-        if None == self.name:
-            self.name=""
-        if None == self.apiurl:
-            self.apiurl=""
-        if None == self.sourcetype:
-            self.sourcetype=LayerSource.TYPE_LOCAL
-
-        if self.sourcetype == LayerSource.TYPE_LOCAL:
-            self.__class__ = LocalLayerSource
-        elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
-            self.__class__ = LayerIndexLayerSource
-        elif self.sourcetype == LayerSource.TYPE_IMPORTED:
-            self.__class__ = ImportedLayerSource
-        else:
-            raise Exception("Unknown LayerSource type. If you added a new layer source type, fill out all code stubs.")
-        return self
-
-    def __unicode__(self):
-        return "%s (%s)" % (self.name, self.sourcetype)
-
-
-class LocalLayerSource(LayerSource):
-    class Meta(LayerSource._meta.__class__):
-        proxy = True
-
-    def __init__(self, *args, **kwargs):
-        super(LocalLayerSource, self).__init__(args, kwargs)
-        self.sourcetype = LayerSource.TYPE_LOCAL
-
-    def update(self):
-        """
-            Fetches layer, recipe and machine information from local repository
-        """
-        pass
-
-class ImportedLayerSource(LayerSource):
-    class Meta(LayerSource._meta.__class__):
-        proxy = True
-
-    def __init__(self, *args, **kwargs):
-        super(ImportedLayerSource, self).__init__(args, kwargs)
-        self.sourcetype = LayerSource.TYPE_IMPORTED
-
-    def update(self):
-        """
-            Fetches layer, recipe and machine information from local repository
-        """
-        pass
-
-
-class LayerIndexLayerSource(LayerSource):
-    class Meta(LayerSource._meta.__class__):
-        proxy = True
-
-    def __init__(self, *args, **kwargs):
-        super(LayerIndexLayerSource, self).__init__(args, kwargs)
-        self.sourcetype = LayerSource.TYPE_LAYERINDEX
-
-    def get_object_view(self, branch, objectype, upid):
-        return self.apiurl + "../branch/" + branch.name + "/" + objectype + "/?q=" + str(upid)
-
-    def update(self):
-        """
-            Fetches layer, recipe and machine information from remote repository
-        """
-        assert self.apiurl is not None
-        from django.db import transaction, connection
-
-        import json
-        import os
-
-        try:
-            from urllib.request import urlopen, URLError
-            from urllib.parse import urlparse
-        except ImportError:
-            from urllib2 import urlopen, URLError
-            from urlparse import urlparse
-
-        proxy_settings = os.environ.get("http_proxy", None)
-        oe_core_layer = 'openembedded-core'
-
-        def _get_json_response(apiurl = self.apiurl):
-            _parsedurl = urlparse(apiurl)
-            path = _parsedurl.path
-
-            try:
-                res = urlopen(apiurl)
-            except URLError as e:
-                raise Exception("Failed to read %s: %s" % (path, e.reason))
-
-            return json.loads(res.read().decode('utf-8'))
-
-        # verify we can get the basic api
-        try:
-            apilinks = _get_json_response()
-        except Exception as e:
-            import traceback
-            if proxy_settings is not None:
-                logger.info("EE: Using proxy %s" % proxy_settings)
-            logger.warning("EE: could not connect to %s, skipping update: %s\n%s" % (self.apiurl, e, traceback.format_exc()))
-            return
-
-        # update branches; only those that we already have names listed in the
-        # Releases table
-        whitelist_branch_names = [rel.branch_name for rel in Release.objects.all()]
-        if len(whitelist_branch_names) == 0:
-            raise Exception("Failed to make list of branches to fetch")
-
-        logger.debug("Fetching branches")
-        branches_info = _get_json_response(apilinks['branches']
-            + "?filter=name:%s" % "OR".join(whitelist_branch_names))
-        for bi in branches_info:
-            b, created = Branch.objects.get_or_create(layer_source = self, name = bi['name'])
-            b.up_id = bi['id']
-            b.up_date = bi['updated']
-            b.name = bi['name']
-            b.short_description = bi['short_description']
-            b.save()
-
-        # update layers
-        layers_info = _get_json_response(apilinks['layerItems'])
-
-        for li in layers_info:
-            # Special case for the openembedded-core layer
-            if li['name'] == oe_core_layer:
-                try:
-                    # If we have an existing openembedded-core for example
-                    # from the toasterconf.json augment the info using the
-                    # layerindex rather than duplicate it
-                    oe_core_l =  Layer.objects.get(name=oe_core_layer)
-                    # Take ownership of the layer as now coming from the
-                    # layerindex
-                    oe_core_l.layer_source = self
-                    oe_core_l.up_id = li['id']
-                    oe_core_l.summary = li['summary']
-                    oe_core_l.description = li['description']
-                    oe_core_l.save()
-                    continue
-
-                except Layer.DoesNotExist:
-                    pass
-
-            l, created = Layer.objects.get_or_create(layer_source = self, name = li['name'])
-            l.up_id = li['id']
-            l.up_date = li['updated']
-            l.vcs_url = li['vcs_url']
-            l.vcs_web_url = li['vcs_web_url']
-            l.vcs_web_tree_base_url = li['vcs_web_tree_base_url']
-            l.vcs_web_file_base_url = li['vcs_web_file_base_url']
-            l.summary = li['summary']
-            l.description = li['description']
-            l.save()
-
-        # update layerbranches/layer_versions
-        logger.debug("Fetching layer information")
-        layerbranches_info = _get_json_response(apilinks['layerBranches']
-                + "?filter=branch:%s" % "OR".join(map(lambda x: str(x.up_id), [i for i in Branch.objects.filter(layer_source = self) if i.up_id is not None] ))
-            )
-
-        for lbi in layerbranches_info:
-            lv, created = Layer_Version.objects.get_or_create(layer_source = self,
-                    up_id = lbi['id'],
-                    layer=Layer.objects.get(layer_source = self, up_id = lbi['layer'])
-                )
-
-            lv.up_date = lbi['updated']
-            lv.up_branch = Branch.objects.get(layer_source = self, up_id = lbi['branch'])
-            lv.branch = lbi['actual_branch']
-            lv.commit = lbi['actual_branch']
-            lv.dirpath = lbi['vcs_subdir']
-            lv.save()
-
-        # update layer dependencies
-        layerdependencies_info = _get_json_response(apilinks['layerDependencies'])
-        dependlist = {}
-        for ldi in layerdependencies_info:
-            try:
-                lv = Layer_Version.objects.get(layer_source = self, up_id = ldi['layerbranch'])
-            except Layer_Version.DoesNotExist as e:
-                continue
-
-            if lv not in dependlist:
-                dependlist[lv] = []
-            try:
-                dependlist[lv].append(Layer_Version.objects.get(layer_source = self, layer__up_id = ldi['dependency'], up_branch = lv.up_branch))
-            except Layer_Version.DoesNotExist:
-                logger.warning("Cannot find layer version (ls:%s), up_id:%s lv:%s" % (self, ldi['dependency'], lv))
-
-        for lv in dependlist:
-            LayerVersionDependency.objects.filter(layer_version = lv).delete()
-            for lvd in dependlist[lv]:
-                LayerVersionDependency.objects.get_or_create(layer_version = lv, depends_on = lvd)
-
-
-        # update machines
-        logger.debug("Fetching machine information")
-        machines_info = _get_json_response(apilinks['machines']
-                + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
-            )
-
-        for mi in machines_info:
-            mo, created = Machine.objects.get_or_create(layer_source = self, up_id = mi['id'], layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']))
-            mo.up_date = mi['updated']
-            mo.name = mi['name']
-            mo.description = mi['description']
-            mo.save()
-
-        # update recipes; paginate by layer version / layer branch
-        logger.debug("Fetching target information")
-        recipes_info = _get_json_response(apilinks['recipes']
-                + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
-            )
-        for ri in recipes_info:
-            try:
-                ro, created = Recipe.objects.get_or_create(layer_source = self, up_id = ri['id'], layer_version = Layer_Version.objects.get(layer_source = self, up_id = ri['layerbranch']))
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
-                else: # workaround for old style layer index
-                    ro.is_image = "-image-" in ri['pn']
-                ro.save()
-            except IntegrityError as e:
-                logger.debug("Failed saving recipe, ignoring: %s (%s:%s)" % (e, ro.layer_version, ri['filepath']+"/"+ri['filename']))
-                ro.delete()
 
 class BitbakeVersion(models.Model):
 
@@ -1529,87 +1252,98 @@ class Release(models.Model):
     def __unicode__(self):
         return "%s (%s)" % (self.name, self.branch_name)
 
-class ReleaseLayerSourcePriority(models.Model):
-    """ Each release selects layers from the set up layer sources, ordered by priority """
-    release = models.ForeignKey("Release")
-    layer_source = models.ForeignKey("LayerSource")
-    priority = models.IntegerField(default = 0)
-
-    def __unicode__(self):
-        return "%s-%s:%d" % (self.release.name, self.layer_source.name, self.priority)
-    class Meta:
-        unique_together = (('release', 'layer_source'),)
-
-
 class ReleaseDefaultLayer(models.Model):
     release = models.ForeignKey(Release)
     layer_name = models.CharField(max_length=100, default="")
 
 
-# Branch class is synced with layerindex.Branch, branches can only come from remote layer indexes
+# Branch class is synced with layerindex.Branch, branches can only come
+# from remote layer indexes
 class Branch(models.Model):
-    layer_source = models.ForeignKey('LayerSource', null = True, default = True)
-    up_id = models.IntegerField(null = True, default = None)                    # id of branch in the source
-    up_date = models.DateTimeField(null = True, default = None)
+    # id of branch in the layerindex
+    up_date = models.DateTimeField(null=True, default=None)
 
     name = models.CharField(max_length=50)
     short_description = models.CharField(max_length=50, blank=True)
 
     class Meta:
         verbose_name_plural = "Branches"
-        unique_together = (('layer_source', 'name'),('layer_source', 'up_id'))
 
     def __unicode__(self):
         return self.name
 
 
-# Layer class synced with layerindex.LayerItem
+class LayerSource(object):
+    """ Where the layer metadata came from """
+    TYPE_LOCAL = 0
+    TYPE_LAYERINDEX = 1
+    TYPE_IMPORTED = 2
+    TYPE_BUILD = 3
+
+    SOURCE_TYPE = (
+        (TYPE_LOCAL, "local"),
+        (TYPE_LAYERINDEX, "layerindex"),
+        (TYPE_IMPORTED, "imported"),
+        (TYPE_BUILD, "build"),
+    )
+
+
 class Layer(models.Model):
-    layer_source = models.ForeignKey(LayerSource, null = True, default = None)  # from where did we got this layer
-    up_id = models.IntegerField(null = True, default = None)                    # id of layer in the remote source
-    up_date = models.DateTimeField(null = True, default = None)
+
+    up_date = models.DateTimeField(null=True, default=timezone.now)
 
     name = models.CharField(max_length=100)
     layer_index_url = models.URLField()
-    vcs_url = GitURLField(default = None, null = True)
-    vcs_web_url = models.URLField(null = True, default = None)
-    vcs_web_tree_base_url = models.URLField(null = True, default = None)
-    vcs_web_file_base_url = models.URLField(null = True, default = None)
+    vcs_url = GitURLField(default=None, null=True)
+    vcs_web_url = models.URLField(null=True, default=None)
+    vcs_web_tree_base_url = models.URLField(null=True, default=None)
+    vcs_web_file_base_url = models.URLField(null=True, default=None)
 
-    summary = models.TextField(help_text='One-line description of the layer', null = True, default = None)
-    description = models.TextField(null = True, default = None)
+    summary = models.TextField(help_text='One-line description of the layer',
+                               null=True, default=None)
+    description = models.TextField(null=True, default=None)
 
     def __unicode__(self):
-        return "%s / %s " % (self.name, self.layer_source)
-
-    class Meta:
-        unique_together = (("layer_source", "up_id"), ("layer_source", "name"))
+        return "%s / %s " % (self.name, self.summary)
 
 
-# LayerCommit class is synced with layerindex.LayerBranch
 class Layer_Version(models.Model):
     """
     A Layer_Version either belongs to a single project or no project
     """
-    search_allowed_fields = ["layer__name", "layer__summary", "layer__description", "layer__vcs_url", "dirpath", "up_branch__name", "commit", "branch"]
-    build = models.ForeignKey(Build, related_name='layer_version_build', default = None, null = True)
+    search_allowed_fields = ["layer__name", "layer__summary",
+                             "layer__description", "layer__vcs_url",
+                             "dirpath", "up_branch__name", "commit", "branch"]
+
+    build = models.ForeignKey(Build, related_name='layer_version_build',
+                              default=None, null=True)
+
     layer = models.ForeignKey(Layer, related_name='layer_version_layer')
 
-    layer_source = models.ForeignKey(LayerSource, null = True, default = None)                   # from where did we get this Layer Version
-    up_id = models.IntegerField(null = True, default = None)        # id of layerbranch in the remote source
-    up_date = models.DateTimeField(null = True, default = None)
-    up_branch = models.ForeignKey(Branch, null = True, default = None)
+    layer_source = models.IntegerField(choices=LayerSource.SOURCE_TYPE,
+                                       default=0)
+
+    up_date = models.DateTimeField(null=True, default=timezone.now)
 
-    branch = models.CharField(max_length=80)            # LayerBranch.actual_branch
-    commit = models.CharField(max_length=100)           # LayerBranch.vcs_last_rev
-    dirpath = models.CharField(max_length=255, null = True, default = None)          # LayerBranch.vcs_subdir
-    priority = models.IntegerField(default = 0)         # if -1, this is a default layer
+    # layerindex specific field
+    up_branch = models.ForeignKey(Branch, null=True, default=None)
 
-    local_path = models.FilePathField(max_length=1024, default = "/")  # where this layer was checked-out
+    branch = models.CharField(max_length=80)
+    commit = models.CharField(max_length=100)
+    # If the layer is in a subdir
+    dirpath = models.CharField(max_length=255, null=True, default=None)
 
-    project = models.ForeignKey('Project', null = True, default = None)   # Set if this layer is project-specific; always set for imported layers, and project-set branches
+    # if -1, this is a default layer
+    priority = models.IntegerField(default=0)
 
-    # code lifted, with adaptations, from the layerindex-web application https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
+    # where this layer exists on the filesystem
+    local_path = models.FilePathField(max_length=1024, default="/")
+
+    # Set if this layer is restricted to a particular project
+    project = models.ForeignKey('Project', null=True, default=None)
+
+    # code lifted, with adaptations, from the layerindex-web application
+    # https://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
     def _handle_url_path(self, base_url, path):
         import re, posixpath
         if base_url:
@@ -1651,18 +1385,14 @@ class Layer_Version(models.Model):
     def get_vcs_file_link_url(self, file_path=""):
         if self.layer.vcs_web_file_base_url is None:
             return None
-        return self._handle_url_path(self.layer.vcs_web_file_base_url, file_path)
+        return self._handle_url_path(self.layer.vcs_web_file_base_url,
+                                     file_path)
 
     def get_vcs_dirpath_link_url(self):
         if self.layer.vcs_web_tree_base_url is None:
             return None
         return self._handle_url_path(self.layer.vcs_web_tree_base_url, '')
 
-    def get_equivalents_wpriority(self, project):
-        layer_versions = project.get_all_compatible_layer_versions()
-        filtered = layer_versions.filter(layer__name = self.layer.name)
-        return filtered.order_by("-layer_source__releaselayersourcepriority__priority")
-
     def get_vcs_reference(self):
         if self.branch is not None and len(self.branch) > 0:
             return self.branch
@@ -1695,20 +1425,15 @@ class Layer_Version(models.Model):
         return sorted(result, key=lambda x: x.layer.name)
 
     def __unicode__(self):
-        return "%d %s (VCS %s, Project %s)" % (self.pk, str(self.layer), self.get_vcs_reference(), self.build.project if self.build is not None else "No project")
+        return ("id %d belongs to layer: %s" % (self.pk, self.layer.name))
 
-    class Meta:
-        unique_together = ("layer_source", "up_id")
 
 class LayerVersionDependency(models.Model):
-    layer_source = models.ForeignKey(LayerSource, null = True, default = None)  # from where did we got this layer
-    up_id = models.IntegerField(null = True, default = None)                    # id of layerbranch in the remote source
-
-    layer_version = models.ForeignKey(Layer_Version, related_name="dependencies")
-    depends_on = models.ForeignKey(Layer_Version, related_name="dependees")
 
-    class Meta:
-        unique_together = ("layer_source", "up_id")
+    layer_version = models.ForeignKey(Layer_Version,
+                                      related_name="dependencies")
+    depends_on = models.ForeignKey(Layer_Version,
+                                   related_name="dependees")
 
 class ProjectLayer(models.Model):
     project = models.ForeignKey(Project)
-- 
2.7.4


