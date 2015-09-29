Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9C6B576903
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:09 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so198605917pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=XxKgtDjwvAtHfOwotcv3B5gQCJYIGbM+IDLXOWn9hGI=;
	b=vfh4BOCcLP0Em1y5Sjtnc78fmDF15WYlU1GYwya/PBy615/6JNgzjxkzI+WuynZVxW
	z/2Y9a7EVTdH+3AW4+Xj/SeYC0K9axo5LasA+Nsyw3KEWyFx9tMS8Hm5F9+5/KeoiFKm
	K5oloK/ZoHrj4fBvDOAOZZT9vdBoF/5WYT4XLYCJY3+Q+BmBmiHdwxNbXSVbA030CsAF
	+dcOiNtEmw9h49lz2ZO3bOW+H60UVq6c0q86VvSGfRO2kxwYoJwaDtnCbOw1PZo3H1MY
	1P93WPm6IFP0JvrNzTAe+VNwXHpHZ+1kC35Ht9/as/RsrX8ENVzgjsOv2rf4qfWizg2s
	zIeQ==
X-Received: by 10.66.220.2 with SMTP id ps2mr30320332pac.128.1443501849487;
	Mon, 28 Sep 2015 21:44:09 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:08 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:27 -0700
Message-Id: <1b457415737fa46e029c7d797631da6aa2e4041e.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 17/22] toaster: Create a relationship between build information and toaster layers
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:09 -0000

From: Michael Wood <michael.g.wood@intel.com>

Previously this layer relationship was done by trying to match path
information that came back to the buildinfohelper with trying to query for
data in toaster's layers table. This rarely matched due to the lose coupling.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py                       |  30 +++-
 .../0009_auto__add_field_brlayer_layer_version.py  | 180 +++++++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |   3 +-
 lib/toaster/orm/models.py                          |   2 +-
 4 files changed, 211 insertions(+), 4 deletions(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0009_auto__add_field_brlayer_layer_version.py

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 5098448..d0efaa9 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -94,8 +94,8 @@ class ORMWrapper(object):
 
         created = False
         if not key in vars(self)[dictname].keys():
-            vars(self)[dictname][key] = clazz.objects.create(**kwargs)
-            created = True
+            vars(self)[dictname][key], created = \
+                clazz.objects.get_or_create(**kwargs)
 
         return (vars(self)[dictname][key], created)
 
@@ -271,6 +271,17 @@ class ORMWrapper(object):
         return recipe_object
 
     def get_update_layer_version_object(self, build_obj, layer_obj, layer_version_information):
+        if isinstance(layer_obj, Layer_Version):
+            # We already found our layer version for this build so just
+            # update it with the new build information
+            logger.debug("We found our layer from toaster")
+            layer_obj.build = build_obj
+            layer_obj.local_path = layer_version_information['local_path']
+            layer_obj.commit = layer_version_information['commit']
+            layer_obj.save()
+            self.layer_version_objects.append(layer_obj)
+            return layer_obj
+
         assert isinstance(build_obj, Build)
         assert isinstance(layer_obj, Layer)
         assert 'branch' in layer_version_information
@@ -320,8 +331,15 @@ class ORMWrapper(object):
                     localdirname = os.path.join(bc.be.sourcedir, localdirname)
                 #logger.debug(1, "Localdirname %s lcal_path %s" % (localdirname, layer_information['local_path']))
                 if localdirname.startswith(layer_information['local_path']):
+                  # If the build request came from toaster this field
+                  # should contain the information from the layer_version
+                  # That created this build request.
+                    if brl.layer_version:
+                        return brl.layer_version
+
                     # we matched the BRLayer, but we need the layer_version that generated this BR; reverse of the Project.schedule_build()
                     #logger.debug(1, "Matched %s to BRlayer %s" % (pformat(layer_information["local_path"]), localdirname))
+
                     for pl in buildrequest.project.projectlayer_set.filter(layercommit__layer__name = brl.name):
                         if pl.layercommit.layer.vcs_url == brl.giturl :
                             layer = pl.layercommit.layer
@@ -674,6 +692,7 @@ class BuildInfoHelper(object):
     def __init__(self, server, has_build_history = False):
         self.internal_state = {}
         self.internal_state['taskdata'] = {}
+        self.internal_state['targets'] = []
         self.task_order = 0
         self.autocommit_step = 1
         self.server = server
@@ -752,8 +771,15 @@ class BuildInfoHelper(object):
                 if not localdirname.startswith("/"):
                     localdirname = os.path.join(bc.be.sourcedir, localdirname)
                 if path.startswith(localdirname):
+                    # If the build request came from toaster this field
+                    # should contain the information from the layer_version
+                    # That created this build request.
+                    if brl.layer_version:
+                        return brl.layer_version
+
                     #logger.warn("-- managed: matched path %s with layer %s " % (path, localdirname))
                     # we matched the BRLayer, but we need the layer_version that generated this br
+
                     for lvo in self.orm_wrapper.layer_version_objects:
                         if brl.name == lvo.layer.name:
                             return lvo
diff --git a/lib/toaster/bldcontrol/migrations/0009_auto__add_field_brlayer_layer_version.py b/lib/toaster/bldcontrol/migrations/0009_auto__add_field_brlayer_layer_version.py
new file mode 100644
index 0000000..9b50bc1
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0009_auto__add_field_brlayer_layer_version.py
@@ -0,0 +1,180 @@
+# -*- coding: utf-8 -*-
+from south.utils import datetime_utils as datetime
+from south.db import db
+from south.v2 import SchemaMigration
+from django.db import models
+
+
+class Migration(SchemaMigration):
+
+    def forwards(self, orm):
+        # Adding field 'BRLayer.layer_version'
+        db.add_column(u'bldcontrol_brlayer', 'layer_version',
+                      self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer_Version'], null=True),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Deleting field 'BRLayer.layer_version'
+        db.delete_column(u'bldcontrol_brlayer', 'layer_version_id')
+
+
+    models = {
+        u'bldcontrol.brbitbake': {
+            'Meta': {'object_name': 'BRBitbake'},
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']", 'unique': 'True'})
+        },
+        u'bldcontrol.brerror': {
+            'Meta': {'object_name': 'BRError'},
+            'errmsg': ('django.db.models.fields.TextField', [], {}),
+            'errtype': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"}),
+            'traceback': ('django.db.models.fields.TextField', [], {})
+        },
+        u'bldcontrol.brlayer': {
+            'Meta': {'object_name': 'BRLayer'},
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer_Version']", 'null': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"})
+        },
+        u'bldcontrol.brtarget': {
+            'Meta': {'object_name': 'BRTarget'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'task': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True'})
+        },
+        u'bldcontrol.brvariable': {
+            'Meta': {'object_name': 'BRVariable'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'req': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildRequest']"}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
+        },
+        u'bldcontrol.buildenvironment': {
+            'Meta': {'object_name': 'BuildEnvironment'},
+            'address': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'bbaddress': ('django.db.models.fields.CharField', [], {'max_length': '254', 'blank': 'True'}),
+            'bbport': ('django.db.models.fields.IntegerField', [], {'default': '-1'}),
+            'bbstate': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'bbtoken': ('django.db.models.fields.CharField', [], {'max_length': '126', 'blank': 'True'}),
+            'betype': ('django.db.models.fields.IntegerField', [], {}),
+            'builddir': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'lock': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'sourcedir': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
+        },
+        u'bldcontrol.buildrequest': {
+            'Meta': {'object_name': 'BuildRequest'},
+            'build': ('django.db.models.fields.related.OneToOneField', [], {'to': u"orm['orm.Build']", 'unique': 'True', 'null': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            'environment': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['bldcontrol.BuildEnvironment']", 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'state': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
+        },
+        u'orm.bitbakeversion': {
+            'Meta': {'object_name': 'BitbakeVersion'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '32'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'giturl': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        },
+        u'orm.branch': {
+            'Meta': {'unique_together': "(('layer_source', 'name'), ('layer_source', 'up_id'))", 'object_name': 'Branch'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'True', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.build': {
+            'Meta': {'object_name': 'Build'},
+            'bitbake_version': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'build_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'completed_on': ('django.db.models.fields.DateTimeField', [], {}),
+            'cooker_log_path': ('django.db.models.fields.CharField', [], {'max_length': '500'}),
+            'distro': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'distro_version': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'machine': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '2'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'started_on': ('django.db.models.fields.DateTimeField', [], {})
+        },
+        u'orm.layer': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'), ('layer_source', 'name'))", 'object_name': 'Layer'},
+            'description': ('django.db.models.fields.TextField', [], {'default': 'None', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_index_url': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'summary': ('django.db.models.fields.TextField', [], {'default': 'None', 'null': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'}),
+            'vcs_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_file_base_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_tree_base_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'})
+        },
+        u'orm.layer_version': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'),)", 'object_name': 'Layer_Version'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '80'}),
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'related_name': "'layer_version_build'", 'null': 'True', 'to': u"orm['orm.Build']"}),
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'layer_version_layer'", 'to': u"orm['orm.Layer']"}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'local_path': ('django.db.models.fields.FilePathField', [], {'default': "'/'", 'max_length': '1024'}),
+            'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Project']", 'null': 'True'}),
+            'up_branch': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Branch']", 'null': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.layersource': {
+            'Meta': {'unique_together': "(('sourcetype', 'apiurl'),)", 'object_name': 'LayerSource'},
+            'apiurl': ('django.db.models.fields.CharField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '63'}),
+            'sourcetype': ('django.db.models.fields.IntegerField', [], {})
+        },
+        u'orm.project': {
+            'Meta': {'object_name': 'Project'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']", 'null': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'is_default': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']", 'null': 'True'}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
+            'user_id': ('django.db.models.fields.IntegerField', [], {'null': 'True'})
+        },
+        u'orm.release': {
+            'Meta': {'object_name': 'Release'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
+            'branch_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50'}),
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'helptext': ('django.db.models.fields.TextField', [], {'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        }
+    }
+
+    complete_apps = ['bldcontrol']
\ No newline at end of file
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index b61de58..f2493a8 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -1,6 +1,6 @@
 from django.db import models
 from django.core.validators import MaxValueValidator, MinValueValidator
-from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build
+from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build, Layer_Version
 
 # a BuildEnvironment is the equivalent of the "build/" directory on the localhost
 class BuildEnvironment(models.Model):
@@ -137,6 +137,7 @@ class BRLayer(models.Model):
     giturl      = models.CharField(max_length = 254)
     commit      = models.CharField(max_length = 254)
     dirpath     = models.CharField(max_length = 254)
+    layer_version = models.ForeignKey(Layer_Version, null=True)
 
 class BRBitbake(models.Model):
     req         = models.ForeignKey(BuildRequest, unique = True)    # only one bitbake for a request
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4025702..8d7388e 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -260,7 +260,7 @@ class Project(models.Model):
             for l in self.projectlayer_set.all().order_by("pk"):
                 commit = l.layercommit.get_vcs_reference()
                 print("ii Building layer ", l.layercommit.layer.name, " at vcs point ", commit)
-                BRLayer.objects.create(req = br, name = l.layercommit.layer.name, giturl = l.layercommit.layer.vcs_url, commit = commit, dirpath = l.layercommit.dirpath)
+                BRLayer.objects.create(req = br, name = l.layercommit.layer.name, giturl = l.layercommit.layer.vcs_url, commit = commit, dirpath = l.layercommit.dirpath, layer_version=l.layercommit)
 
             br.state = BuildRequest.REQ_QUEUED
             now = timezone.now()
-- 
1.9.1


