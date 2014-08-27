Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f177.google.com (mail-we0-f177.google.com
	[74.125.82.177])
	by mail.openembedded.org (Postfix) with ESMTP id 226D27117E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:47 +0000 (UTC)
Received: by mail-we0-f177.google.com with SMTP id w62so545384wes.22
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=pS7DvcTJuXmD70aFKqlQhmH5tYXsilY21gRwuN30ov8=;
	b=cA17KtE15miKmCerZjc7V1kNNOjlbkSVfUgb+DBhxMszfpEp4iJ6RcL/LTORDp0nJN
	4rv3VCFWBdiUCZOUkmLLK0f3fuciPnc+5MlWrs360MOeHdJIsKjNmIIJ4euvyZhX9Wf9
	sJUACaTFklGmFbZBni8v4daRt0YW0paGAUVBMnCnQZ36+eZ18t1N+T3GvscdqMmMXIj0
	h/tywUd8A3fl9uV7e8C8pJj4+/40EJ+1v5aIrcKtfGNQHbsLvP9a1O+79Kzhoe32e121
	/IEUmO6JWJq9Xql+rPXqLZqk7aSTafsTaXEx/8ead1Tl+JNF4QpyX99C9uCkigp2Fh3o
	Qx9w==
X-Gm-Message-State: ALoCoQm8LJobKb+JROKj2/daXB8//E0e6zI8ahnx8Q8Lt0s7BTCVJ6BM0keuFyXDzSh0wnF1z+8l
X-Received: by 10.180.21.141 with SMTP id v13mr30687302wie.48.1409160228029;
	Wed, 27 Aug 2014 10:23:48 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	lm18sm25803669wic.22.2014.08.27.10.23.45 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:46 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 4CCB8560FCB; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:35 +0100
Message-Id: <33ffa0f0d54003869c90ecdab380d6c0c3433f74.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/11] toaster: update orm models for layerindex compatibility
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:48 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a ToasterSettings table that will keep
installation-wide settings.

We update the models for the layer-related data storage to
make them compatible with the layerindex application API.

We add a LayerSource class that can update local data from
a LayerIndex-like compatible API.

Adding a command line option to perform information update
from all upstream layer sources.

Fair warning - there is no backward migration from 0013.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/management/__init__.py             |   0
 lib/toaster/orm/management/commands/__init__.py    |   0
 lib/toaster/orm/management/commands/lsupdates.py   |  12 +
 ...erversiondependency__add_unique_layerversion.py | 710 +++++++++++++++++++++
 lib/toaster/orm/models.py                          | 377 +++++++++--
 lib/toaster/orm/tests.py                           |  33 +
 lib/toaster/toastermain/settings.py                |   2 +
 7 files changed, 1096 insertions(+), 38 deletions(-)
 create mode 100644 lib/toaster/orm/management/__init__.py
 create mode 100644 lib/toaster/orm/management/commands/__init__.py
 create mode 100644 lib/toaster/orm/management/commands/lsupdates.py
 create mode 100644 lib/toaster/orm/migrations/0013_auto__add_release__add_layerversiondependency__add_unique_layerversion.py
 create mode 100644 lib/toaster/orm/tests.py

diff --git a/lib/toaster/orm/management/__init__.py b/lib/toaster/orm/management/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/orm/management/commands/__init__.py b/lib/toaster/orm/management/commands/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
new file mode 100644
index 0000000..75e9513
--- /dev/null
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -0,0 +1,12 @@
+from django.core.management.base import NoArgsCommand, CommandError
+from orm.models import LayerSource
+import os
+
+class Command(NoArgsCommand):
+    args    = ""
+    help    = "Updates locally cached information from all LayerSources"
+
+
+    def handle_noargs(self, **options):
+        for ls in LayerSource.objects.all():
+            ls.update()
diff --git a/lib/toaster/orm/migrations/0013_auto__add_release__add_layerversiondependency__add_unique_layerversion.py b/lib/toaster/orm/migrations/0013_auto__add_release__add_layerversiondependency__add_unique_layerversion.py
new file mode 100644
index 0000000..7c954e6
--- /dev/null
+++ b/lib/toaster/orm/migrations/0013_auto__add_release__add_layerversiondependency__add_unique_layerversion.py
@@ -0,0 +1,710 @@
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
+        # Adding model 'Release'
+        db.create_table(u'orm_release', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('name', self.gf('django.db.models.fields.CharField')(unique=True, max_length=32)),
+            ('description', self.gf('django.db.models.fields.CharField')(max_length=255)),
+            ('bitbake_version', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.BitbakeVersion'])),
+            ('branch', self.gf('django.db.models.fields.CharField')(max_length=32)),
+        ))
+        db.send_create_signal(u'orm', ['Release'])
+
+        # Adding model 'LayerVersionDependency'
+        db.create_table(u'orm_layerversiondependency', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('layer_source', self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.LayerSource'], null=True)),
+            ('up_id', self.gf('django.db.models.fields.IntegerField')(default=None, null=True)),
+            ('layer_version', self.gf('django.db.models.fields.related.ForeignKey')(related_name='dependencies', to=orm['orm.Layer_Version'])),
+            ('depends_on', self.gf('django.db.models.fields.related.ForeignKey')(related_name='dependees', to=orm['orm.Layer_Version'])),
+        ))
+        db.send_create_signal(u'orm', ['LayerVersionDependency'])
+
+        # Adding unique constraint on 'LayerVersionDependency', fields ['layer_source', 'up_id']
+        db.create_unique(u'orm_layerversiondependency', ['layer_source_id', 'up_id'])
+
+        # Adding model 'ToasterSetting'
+        db.create_table(u'orm_toastersetting', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('name', self.gf('django.db.models.fields.CharField')(max_length=63)),
+            ('helptext', self.gf('django.db.models.fields.TextField')()),
+            ('value', self.gf('django.db.models.fields.CharField')(max_length=255)),
+        ))
+        db.send_create_signal(u'orm', ['ToasterSetting'])
+
+        # Adding model 'Machine'
+        db.create_table(u'orm_machine', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('layer_source', self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.LayerSource'], null=True)),
+            ('up_id', self.gf('django.db.models.fields.IntegerField')(default=None, null=True)),
+            ('up_date', self.gf('django.db.models.fields.DateTimeField')(default=None, null=True)),
+            ('layer_version', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer_Version'])),
+            ('name', self.gf('django.db.models.fields.CharField')(max_length=255)),
+            ('description', self.gf('django.db.models.fields.CharField')(max_length=255)),
+        ))
+        db.send_create_signal(u'orm', ['Machine'])
+
+        # Adding unique constraint on 'Machine', fields ['layer_source', 'up_id']
+        db.create_unique(u'orm_machine', ['layer_source_id', 'up_id'])
+
+        # Adding model 'ReleaseDefaultLayer'
+        db.create_table(u'orm_releasedefaultlayer', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('release', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Release'])),
+            ('layer', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer'])),
+        ))
+        db.send_create_signal(u'orm', ['ReleaseDefaultLayer'])
+
+        # Adding model 'BitbakeVersion'
+        db.create_table(u'orm_bitbakeversion', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('name', self.gf('django.db.models.fields.CharField')(unique=True, max_length=32)),
+            ('giturl', self.gf('django.db.models.fields.URLField')(max_length=200)),
+            ('branch', self.gf('django.db.models.fields.CharField')(max_length=32)),
+            ('dirpath', self.gf('django.db.models.fields.CharField')(max_length=255)),
+        ))
+        db.send_create_signal(u'orm', ['BitbakeVersion'])
+
+        # Adding model 'Branch'
+        db.create_table(u'orm_branch', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('layer_source', self.gf('django.db.models.fields.related.ForeignKey')(default=True, to=orm['orm.LayerSource'], null=True)),
+            ('up_id', self.gf('django.db.models.fields.IntegerField')(default=None, null=True)),
+            ('up_date', self.gf('django.db.models.fields.DateTimeField')(default=None, null=True)),
+            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
+            ('bitbake_branch', self.gf('django.db.models.fields.CharField')(max_length=50, blank=True)),
+            ('short_description', self.gf('django.db.models.fields.CharField')(max_length=50, blank=True)),
+        ))
+        db.send_create_signal(u'orm', ['Branch'])
+
+        # Adding unique constraint on 'Branch', fields ['layer_source', 'name']
+        db.create_unique(u'orm_branch', ['layer_source_id', 'name'])
+
+        # Adding unique constraint on 'Branch', fields ['layer_source', 'up_id']
+        db.create_unique(u'orm_branch', ['layer_source_id', 'up_id'])
+
+        # Adding model 'ToasterSettingDefaultLayer'
+        db.create_table(u'orm_toastersettingdefaultlayer', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('layer_version', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer_Version'])),
+        ))
+        db.send_create_signal(u'orm', ['ToasterSettingDefaultLayer'])
+
+        # Adding model 'LayerSource'
+        db.create_table(u'orm_layersource', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('name', self.gf('django.db.models.fields.CharField')(max_length=63)),
+            ('sourcetype', self.gf('django.db.models.fields.IntegerField')()),
+            ('apiurl', self.gf('django.db.models.fields.CharField')(default=None, max_length=255, null=True)),
+        ))
+        db.send_create_signal(u'orm', ['LayerSource'])
+
+        # Adding unique constraint on 'LayerSource', fields ['sourcetype', 'apiurl']
+        db.create_unique(u'orm_layersource', ['sourcetype', 'apiurl'])
+
+        # Deleting field 'ProjectLayer.name'
+        db.delete_column(u'orm_projectlayer', 'name')
+
+        # Deleting field 'ProjectLayer.dirpath'
+        db.delete_column(u'orm_projectlayer', 'dirpath')
+
+        # Deleting field 'ProjectLayer.commit'
+        db.delete_column(u'orm_projectlayer', 'commit')
+
+        # Deleting field 'ProjectLayer.giturl'
+        db.delete_column(u'orm_projectlayer', 'giturl')
+
+        # Adding field 'ProjectLayer.layercommit'
+        db.add_column(u'orm_projectlayer', 'layercommit',
+                      self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer_Version'], null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer_Version.layer_source'
+        db.add_column(u'orm_layer_version', 'layer_source',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.LayerSource'], null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer_Version.up_id'
+        db.add_column(u'orm_layer_version', 'up_id',
+                      self.gf('django.db.models.fields.IntegerField')(default=None, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer_Version.up_date'
+        db.add_column(u'orm_layer_version', 'up_date',
+                      self.gf('django.db.models.fields.DateTimeField')(default=None, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer_Version.up_branch'
+        db.add_column(u'orm_layer_version', 'up_branch',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.Branch'], null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer_Version.dirpath'
+        db.add_column(u'orm_layer_version', 'dirpath',
+                      self.gf('django.db.models.fields.CharField')(default=None, max_length=255, null=True),
+                      keep_default=False)
+
+
+        # Changing field 'Layer_Version.build'
+        db.alter_column(u'orm_layer_version', 'build_id', self.gf('django.db.models.fields.related.ForeignKey')(null=True, to=orm['orm.Build']))
+
+        # Changing field 'Layer_Version.branch'
+        db.alter_column(u'orm_layer_version', 'branch', self.gf('django.db.models.fields.CharField')(max_length=80))
+        # Adding unique constraint on 'Layer_Version', fields ['layer_source', 'up_id']
+        db.create_unique(u'orm_layer_version', ['layer_source_id', 'up_id'])
+
+        # Adding field 'Recipe.layer_source'
+        db.add_column(u'orm_recipe', 'layer_source',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.LayerSource'], null=True),
+                      keep_default=False)
+
+        # Adding field 'Recipe.up_id'
+        db.add_column(u'orm_recipe', 'up_id',
+                      self.gf('django.db.models.fields.IntegerField')(default=None, null=True),
+                      keep_default=False)
+
+        # Adding field 'Recipe.up_date'
+        db.add_column(u'orm_recipe', 'up_date',
+                      self.gf('django.db.models.fields.DateTimeField')(default=None, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.layer_source'
+        db.add_column(u'orm_layer', 'layer_source',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=None, to=orm['orm.LayerSource'], null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.up_id'
+        db.add_column(u'orm_layer', 'up_id',
+                      self.gf('django.db.models.fields.IntegerField')(default=None, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.up_date'
+        db.add_column(u'orm_layer', 'up_date',
+                      self.gf('django.db.models.fields.DateTimeField')(default=None, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.vcs_url'
+        db.add_column(u'orm_layer', 'vcs_url',
+                      self.gf('django.db.models.fields.URLField')(default=None, max_length=200, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.vcs_web_file_base_url'
+        db.add_column(u'orm_layer', 'vcs_web_file_base_url',
+                      self.gf('django.db.models.fields.URLField')(default=None, max_length=200, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.summary'
+        db.add_column(u'orm_layer', 'summary',
+                      self.gf('django.db.models.fields.CharField')(default=None, max_length=200, null=True),
+                      keep_default=False)
+
+        # Adding field 'Layer.description'
+        db.add_column(u'orm_layer', 'description',
+                      self.gf('django.db.models.fields.TextField')(default=None, null=True),
+                      keep_default=False)
+
+
+        # Changing field 'Layer.local_path'
+        db.alter_column(u'orm_layer', 'local_path', self.gf('django.db.models.fields.FilePathField')(max_length=255, null=True))
+        # Adding unique constraint on 'Layer', fields ['layer_source', 'up_id']
+        db.create_unique(u'orm_layer', ['layer_source_id', 'up_id'])
+
+        # Adding unique constraint on 'Layer', fields ['layer_source', 'name']
+        db.create_unique(u'orm_layer', ['layer_source_id', 'name'])
+
+        # Deleting field 'Project.branch'
+        db.delete_column(u'orm_project', 'branch')
+
+        # Adding field 'Project.bitbake_version'
+        db.add_column(u'orm_project', 'bitbake_version',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=-1, to=orm['orm.BitbakeVersion']),
+                      keep_default=False)
+
+        # Adding field 'Project.release'
+        db.add_column(u'orm_project', 'release',
+                      self.gf('django.db.models.fields.related.ForeignKey')(default=-1, to=orm['orm.Release']),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Removing unique constraint on 'Layer', fields ['layer_source', 'name']
+        db.delete_unique(u'orm_layer', ['layer_source_id', 'name'])
+
+        # Removing unique constraint on 'Layer', fields ['layer_source', 'up_id']
+        db.delete_unique(u'orm_layer', ['layer_source_id', 'up_id'])
+
+        # Removing unique constraint on 'Layer_Version', fields ['layer_source', 'up_id']
+        db.delete_unique(u'orm_layer_version', ['layer_source_id', 'up_id'])
+
+        # Removing unique constraint on 'LayerSource', fields ['sourcetype', 'apiurl']
+        db.delete_unique(u'orm_layersource', ['sourcetype', 'apiurl'])
+
+        # Removing unique constraint on 'Branch', fields ['layer_source', 'up_id']
+        db.delete_unique(u'orm_branch', ['layer_source_id', 'up_id'])
+
+        # Removing unique constraint on 'Branch', fields ['layer_source', 'name']
+        db.delete_unique(u'orm_branch', ['layer_source_id', 'name'])
+
+        # Removing unique constraint on 'Machine', fields ['layer_source', 'up_id']
+        db.delete_unique(u'orm_machine', ['layer_source_id', 'up_id'])
+
+        # Removing unique constraint on 'LayerVersionDependency', fields ['layer_source', 'up_id']
+        db.delete_unique(u'orm_layerversiondependency', ['layer_source_id', 'up_id'])
+
+        # Deleting model 'Release'
+        db.delete_table(u'orm_release')
+
+        # Deleting model 'LayerVersionDependency'
+        db.delete_table(u'orm_layerversiondependency')
+
+        # Deleting model 'ToasterSetting'
+        db.delete_table(u'orm_toastersetting')
+
+        # Deleting model 'Machine'
+        db.delete_table(u'orm_machine')
+
+        # Deleting model 'ReleaseDefaultLayer'
+        db.delete_table(u'orm_releasedefaultlayer')
+
+        # Deleting model 'BitbakeVersion'
+        db.delete_table(u'orm_bitbakeversion')
+
+        # Deleting model 'Branch'
+        db.delete_table(u'orm_branch')
+
+        # Deleting model 'ToasterSettingDefaultLayer'
+        db.delete_table(u'orm_toastersettingdefaultlayer')
+
+        # Deleting model 'LayerSource'
+        db.delete_table(u'orm_layersource')
+
+
+        # User chose to not deal with backwards NULL issues for 'ProjectLayer.name'
+        raise RuntimeError("Cannot reverse this migration. 'ProjectLayer.name' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'ProjectLayer.name'
+        db.add_column(u'orm_projectlayer', 'name',
+                      self.gf('django.db.models.fields.CharField')(max_length=100),
+                      keep_default=False)
+
+
+        # User chose to not deal with backwards NULL issues for 'ProjectLayer.dirpath'
+        raise RuntimeError("Cannot reverse this migration. 'ProjectLayer.dirpath' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'ProjectLayer.dirpath'
+        db.add_column(u'orm_projectlayer', 'dirpath',
+                      self.gf('django.db.models.fields.CharField')(max_length=254),
+                      keep_default=False)
+
+
+        # User chose to not deal with backwards NULL issues for 'ProjectLayer.commit'
+        raise RuntimeError("Cannot reverse this migration. 'ProjectLayer.commit' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'ProjectLayer.commit'
+        db.add_column(u'orm_projectlayer', 'commit',
+                      self.gf('django.db.models.fields.CharField')(max_length=254),
+                      keep_default=False)
+
+
+        # User chose to not deal with backwards NULL issues for 'ProjectLayer.giturl'
+        raise RuntimeError("Cannot reverse this migration. 'ProjectLayer.giturl' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'ProjectLayer.giturl'
+        db.add_column(u'orm_projectlayer', 'giturl',
+                      self.gf('django.db.models.fields.CharField')(max_length=254),
+                      keep_default=False)
+
+        # Deleting field 'ProjectLayer.layercommit'
+        db.delete_column(u'orm_projectlayer', 'layercommit_id')
+
+        # Deleting field 'Layer_Version.layer_source'
+        db.delete_column(u'orm_layer_version', 'layer_source_id')
+
+        # Deleting field 'Layer_Version.up_id'
+        db.delete_column(u'orm_layer_version', 'up_id')
+
+        # Deleting field 'Layer_Version.up_date'
+        db.delete_column(u'orm_layer_version', 'up_date')
+
+        # Deleting field 'Layer_Version.up_branch'
+        db.delete_column(u'orm_layer_version', 'up_branch_id')
+
+        # Deleting field 'Layer_Version.dirpath'
+        db.delete_column(u'orm_layer_version', 'dirpath')
+
+
+        # User chose to not deal with backwards NULL issues for 'Layer_Version.build'
+        raise RuntimeError("Cannot reverse this migration. 'Layer_Version.build' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration
+        # Changing field 'Layer_Version.build'
+        db.alter_column(u'orm_layer_version', 'build_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Build']))
+
+        # Changing field 'Layer_Version.branch'
+        db.alter_column(u'orm_layer_version', 'branch', self.gf('django.db.models.fields.CharField')(max_length=50))
+        # Deleting field 'Recipe.layer_source'
+        db.delete_column(u'orm_recipe', 'layer_source_id')
+
+        # Deleting field 'Recipe.up_id'
+        db.delete_column(u'orm_recipe', 'up_id')
+
+        # Deleting field 'Recipe.up_date'
+        db.delete_column(u'orm_recipe', 'up_date')
+
+        # Deleting field 'Layer.layer_source'
+        db.delete_column(u'orm_layer', 'layer_source_id')
+
+        # Deleting field 'Layer.up_id'
+        db.delete_column(u'orm_layer', 'up_id')
+
+        # Deleting field 'Layer.up_date'
+        db.delete_column(u'orm_layer', 'up_date')
+
+        # Deleting field 'Layer.vcs_url'
+        db.delete_column(u'orm_layer', 'vcs_url')
+
+        # Deleting field 'Layer.vcs_web_file_base_url'
+        db.delete_column(u'orm_layer', 'vcs_web_file_base_url')
+
+        # Deleting field 'Layer.summary'
+        db.delete_column(u'orm_layer', 'summary')
+
+        # Deleting field 'Layer.description'
+        db.delete_column(u'orm_layer', 'description')
+
+
+        # User chose to not deal with backwards NULL issues for 'Layer.local_path'
+        raise RuntimeError("Cannot reverse this migration. 'Layer.local_path' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration
+        # Changing field 'Layer.local_path'
+        db.alter_column(u'orm_layer', 'local_path', self.gf('django.db.models.fields.FilePathField')(max_length=255))
+
+        # User chose to not deal with backwards NULL issues for 'Project.branch'
+        raise RuntimeError("Cannot reverse this migration. 'Project.branch' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'Project.branch'
+        db.add_column(u'orm_project', 'branch',
+                      self.gf('django.db.models.fields.CharField')(max_length=50),
+                      keep_default=False)
+
+        # Deleting field 'Project.bitbake_version'
+        db.delete_column(u'orm_project', 'bitbake_version_id')
+
+        # Deleting field 'Project.release'
+        db.delete_column(u'orm_project', 'release_id')
+
+
+    models = {
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
+            'bitbake_branch': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
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
+            'errors_no': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'machine': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '2'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']", 'null': 'True'}),
+            'started_on': ('django.db.models.fields.DateTimeField', [], {}),
+            'timespent': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'warnings_no': ('django.db.models.fields.IntegerField', [], {'default': '0'})
+        },
+        u'orm.helptext': {
+            'Meta': {'object_name': 'HelpText'},
+            'area': ('django.db.models.fields.IntegerField', [], {}),
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'helptext_build'", 'to': u"orm['orm.Build']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'key': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'text': ('django.db.models.fields.TextField', [], {})
+        },
+        u'orm.layer': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'), ('layer_source', 'name'))", 'object_name': 'Layer'},
+            'description': ('django.db.models.fields.TextField', [], {'default': 'None', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_index_url': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'local_path': ('django.db.models.fields.FilePathField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'summary': ('django.db.models.fields.CharField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'}),
+            'vcs_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'}),
+            'vcs_web_file_base_url': ('django.db.models.fields.URLField', [], {'default': 'None', 'max_length': '200', 'null': 'True'})
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
+            'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'up_branch': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.Branch']", 'null': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.layersource': {
+            'Meta': {'unique_together': "(('sourcetype', 'apiurl'),)", 'object_name': 'LayerSource'},
+            'apiurl': ('django.db.models.fields.CharField', [], {'default': 'None', 'max_length': '255', 'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '63'}),
+            'sourcetype': ('django.db.models.fields.IntegerField', [], {})
+        },
+        u'orm.layerversiondependency': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'),)", 'object_name': 'LayerVersionDependency'},
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'dependees'", 'to': u"orm['orm.Layer_Version']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'dependencies'", 'to': u"orm['orm.Layer_Version']"}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.logmessage': {
+            'Meta': {'object_name': 'LogMessage'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'level': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'lineno': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'message': ('django.db.models.fields.CharField', [], {'max_length': '240'}),
+            'pathname': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'task': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Task']", 'null': 'True', 'blank': 'True'})
+        },
+        u'orm.machine': {
+            'Meta': {'unique_together': "(('layer_source', 'up_id'),)", 'object_name': 'Machine'},
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer_Version']"}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'})
+        },
+        u'orm.package': {
+            'Meta': {'object_name': 'Package'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'installed_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '100'}),
+            'installed_size': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'license': ('django.db.models.fields.CharField', [], {'max_length': '80', 'blank': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Recipe']", 'null': 'True'}),
+            'revision': ('django.db.models.fields.CharField', [], {'max_length': '32', 'blank': 'True'}),
+            'section': ('django.db.models.fields.CharField', [], {'max_length': '80', 'blank': 'True'}),
+            'size': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'summary': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
+            'version': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'})
+        },
+        u'orm.package_dependency': {
+            'Meta': {'object_name': 'Package_Dependency'},
+            'dep_type': ('django.db.models.fields.IntegerField', [], {}),
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'package_dependencies_target'", 'to': u"orm['orm.Package']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'package': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'package_dependencies_source'", 'to': u"orm['orm.Package']"}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']", 'null': 'True'})
+        },
+        u'orm.package_file': {
+            'Meta': {'object_name': 'Package_File'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'package': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'buildfilelist_package'", 'to': u"orm['orm.Package']"}),
+            'path': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'size': ('django.db.models.fields.IntegerField', [], {})
+        },
+        u'orm.project': {
+            'Meta': {'object_name': 'Project'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']"}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
+            'user_id': ('django.db.models.fields.IntegerField', [], {'null': 'True'})
+        },
+        u'orm.projectlayer': {
+            'Meta': {'object_name': 'ProjectLayer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layercommit': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer_Version']", 'null': 'True'}),
+            'optional': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"})
+        },
+        u'orm.projecttarget': {
+            'Meta': {'object_name': 'ProjectTarget'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'task': ('django.db.models.fields.CharField', [], {'max_length': '100', 'null': 'True'})
+        },
+        u'orm.projectvariable': {
+            'Meta': {'object_name': 'ProjectVariable'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
+        },
+        u'orm.recipe': {
+            'Meta': {'object_name': 'Recipe'},
+            'bugtracker': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'file_path': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            'homepage': ('django.db.models.fields.URLField', [], {'max_length': '200', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'default': 'None', 'to': u"orm['orm.LayerSource']", 'null': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'recipe_layer_version'", 'to': u"orm['orm.Layer_Version']"}),
+            'license': ('django.db.models.fields.CharField', [], {'max_length': '200', 'blank': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'section': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'summary': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'up_date': ('django.db.models.fields.DateTimeField', [], {'default': 'None', 'null': 'True'}),
+            'up_id': ('django.db.models.fields.IntegerField', [], {'default': 'None', 'null': 'True'}),
+            'version': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'})
+        },
+        u'orm.recipe_dependency': {
+            'Meta': {'object_name': 'Recipe_Dependency'},
+            'dep_type': ('django.db.models.fields.IntegerField', [], {}),
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'r_dependencies_depends'", 'to': u"orm['orm.Recipe']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'r_dependencies_recipe'", 'to': u"orm['orm.Recipe']"})
+        },
+        u'orm.release': {
+            'Meta': {'object_name': 'Release'},
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '32'}),
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        },
+        u'orm.releasedefaultlayer': {
+            'Meta': {'object_name': 'ReleaseDefaultLayer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer']"}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']"})
+        },
+        u'orm.target': {
+            'Meta': {'object_name': 'Target'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'image_size': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'is_image': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'license_manifest_path': ('django.db.models.fields.CharField', [], {'max_length': '500', 'null': 'True'}),
+            'target': ('django.db.models.fields.CharField', [], {'max_length': '100'})
+        },
+        u'orm.target_file': {
+            'Meta': {'object_name': 'Target_File'},
+            'directory': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'directory_set'", 'null': 'True', 'to': u"orm['orm.Target_File']"}),
+            'group': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'inodetype': ('django.db.models.fields.IntegerField', [], {}),
+            'owner': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
+            'path': ('django.db.models.fields.FilePathField', [], {'max_length': '100'}),
+            'permission': ('django.db.models.fields.CharField', [], {'max_length': '16'}),
+            'size': ('django.db.models.fields.IntegerField', [], {}),
+            'sym_target': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'symlink_set'", 'null': 'True', 'to': u"orm['orm.Target_File']"}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']"})
+        },
+        u'orm.target_image_file': {
+            'Meta': {'object_name': 'Target_Image_File'},
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '254'}),
+            'file_size': ('django.db.models.fields.IntegerField', [], {}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']"})
+        },
+        u'orm.target_installed_package': {
+            'Meta': {'object_name': 'Target_Installed_Package'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'package': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'buildtargetlist_package'", 'to': u"orm['orm.Package']"}),
+            'target': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Target']"})
+        },
+        u'orm.task': {
+            'Meta': {'ordering': "('order', 'recipe')", 'unique_together': "(('build', 'recipe', 'task_name'),)", 'object_name': 'Task'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'task_build'", 'to': u"orm['orm.Build']"}),
+            'cpu_usage': ('django.db.models.fields.DecimalField', [], {'null': 'True', 'max_digits': '6', 'decimal_places': '2'}),
+            'disk_io': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'elapsed_time': ('django.db.models.fields.DecimalField', [], {'null': 'True', 'max_digits': '6', 'decimal_places': '2'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'line_number': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'logfile': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'message': ('django.db.models.fields.CharField', [], {'max_length': '240'}),
+            'order': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'outcome': ('django.db.models.fields.IntegerField', [], {'default': '-1'}),
+            'path_to_sstate_obj': ('django.db.models.fields.FilePathField', [], {'max_length': '500', 'blank': 'True'}),
+            'recipe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'build_recipe'", 'to': u"orm['orm.Recipe']"}),
+            'script_type': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'source_url': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'}),
+            'sstate_checksum': ('django.db.models.fields.CharField', [], {'max_length': '100', 'blank': 'True'}),
+            'sstate_result': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'task_executed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'task_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'work_directory': ('django.db.models.fields.FilePathField', [], {'max_length': '255', 'blank': 'True'})
+        },
+        u'orm.task_dependency': {
+            'Meta': {'object_name': 'Task_Dependency'},
+            'depends_on': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'task_dependencies_depends'", 'to': u"orm['orm.Task']"}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'task': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'task_dependencies_task'", 'to': u"orm['orm.Task']"})
+        },
+        u'orm.toastersetting': {
+            'Meta': {'object_name': 'ToasterSetting'},
+            'helptext': ('django.db.models.fields.TextField', [], {}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '63'}),
+            'value': ('django.db.models.fields.CharField', [], {'max_length': '255'})
+        },
+        u'orm.toastersettingdefaultlayer': {
+            'Meta': {'object_name': 'ToasterSettingDefaultLayer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Layer_Version']"})
+        },
+        u'orm.variable': {
+            'Meta': {'object_name': 'Variable'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'variable_build'", 'to': u"orm['orm.Build']"}),
+            'changed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
+            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'human_readable_name': ('django.db.models.fields.CharField', [], {'max_length': '200'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'variable_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'variable_value': ('django.db.models.fields.TextField', [], {'blank': 'True'})
+        },
+        u'orm.variablehistory': {
+            'Meta': {'object_name': 'VariableHistory'},
+            'file_name': ('django.db.models.fields.FilePathField', [], {'max_length': '255'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'line_number': ('django.db.models.fields.IntegerField', [], {'null': 'True'}),
+            'operation': ('django.db.models.fields.CharField', [], {'max_length': '64'}),
+            'value': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
+            'variable': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'vhistory'", 'to': u"orm['orm.Variable']"})
+        }
+    }
+
+    complete_apps = ['orm']
\ No newline at end of file
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index f19a437..5a6dcd7 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -22,30 +22,33 @@
 from django.db import models
 from django.db.models import F
 from django.utils.encoding import python_2_unicode_compatible
+from django.utils import timezone
+
+class ToasterSetting(models.Model):
+    name = models.CharField(max_length=63)
+    helptext = models.TextField()
+    value = models.CharField(max_length=255)
+
+class ToasterSettingDefaultLayer(models.Model):
+    layer_version = models.ForeignKey('Layer_Version')
 
 class ProjectManager(models.Manager):
-    def create_project(self, name, branch, short_description):
-        prj = self.model(name = name, branch = branch, short_description = short_description)
+    def create_project(self, name, release):
+        prj = self.model(name = name, bitbake_version = release.bitbake_version, release = release)
         prj.save()
 
-        # create default variables
-        ProjectVariable.objects.create(project = prj, name = "MACHINE", value = "qemux86")
-        ProjectVariable.objects.create(project = prj, name = "DISTRO", value = "poky")
-
-        # create default layers
-        ProjectLayer.objects.create(project = prj,
-            name = "meta",
-            giturl = "git://git.yoctoproject.org/poky",
-            commit = branch,
-            dirpath = "meta",
-            optional = False)
-
-        ProjectLayer.objects.create(project = prj,
-            name = "meta-yocto",
-            giturl = "git://git.yoctoproject.org/poky",
-            commit = branch,
-            dirpath = "meta-yocto",
-            optional = False)
+        for defaultconf in ToasterSetting.objects.filter(name__startswith="DEFCONF_"):
+            name = defaultconf.name[8:]
+            ProjectVariable.objects.create( project = prj,
+                name = name,
+                value = defaultconf.value)
+
+        for layer in map(lambda x: x.layer, ReleaseDefaultLayer.objects.filter(release = release)):
+            for branches in Branch.objects.filter(name = release.branch):
+                for lv in Layer_Version.objects.filter(layer = layer, up_branch = branches ):
+                    ProjectLayer.objects.create( project = prj,
+                        layercommit = lv,
+                        optional = False )
 
         return prj
 
@@ -57,8 +60,9 @@ class ProjectManager(models.Manager):
 
 class Project(models.Model):
     name = models.CharField(max_length=100)
-    branch = models.CharField(max_length=50)
     short_description = models.CharField(max_length=50, blank=True)
+    bitbake_version = models.ForeignKey('BitbakeVersion')
+    release     = models.ForeignKey("Release")
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
     # This is a horrible hack; since Toaster has no "User" model available when
@@ -70,10 +74,16 @@ class Project(models.Model):
 
 
     def schedule_build(self):
-        from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable
+        from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
         br = BuildRequest.objects.create(project = self)
+
+        BRBitbake.objects.create(req = br,
+            giturl = self.bitbake_version.giturl,
+            commit = self.bitbake_version.branch,
+            dirpath = self.bitbake_version.dirpath)
+
         for l in self.projectlayer_set.all():
-            BRLayer.objects.create(req = br, name = l.name, giturl = l.giturl, commit = l.commit, dirpath = l.dirpath)
+            BRLayer.objects.create(req = br, name = l.layercommit.layer.name, giturl = l.layercommit.layer.vcs_url, commit = l.layercommit.commit, dirpath = l.layercommit.dirpath)
         for t in self.projecttarget_set.all():
             BRTarget.objects.create(req = br, target = t.target, task = t.task)
         for v in self.projectvariable_set.all():
@@ -83,7 +93,6 @@ class Project(models.Model):
         br.save()
         return br
 
-
 class Build(models.Model):
     SUCCEEDED = 0
     FAILED = 1
@@ -359,8 +368,13 @@ class Package_File(models.Model):
 
 class Recipe(models.Model):
     search_allowed_fields = ['name', 'version', 'file_path', 'section', 'license', 'layer_version__layer__name', 'layer_version__branch', 'layer_version__commit', 'layer_version__layer__local_path']
-    name = models.CharField(max_length=100, blank=True)
-    version = models.CharField(max_length=100, blank=True)
+
+    layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this recipe
+    up_id = models.IntegerField(null = True, default = None)                    # id of entry in the source
+    up_date = models.DateTimeField(null = True, default = None)
+
+    name = models.CharField(max_length=100, blank=True)                 # pn
+    version = models.CharField(max_length=100, blank=True)              # pv
     layer_version = models.ForeignKey('Layer_Version', related_name='recipe_layer_version')
     summary = models.CharField(max_length=100, blank=True)
     description = models.TextField(blank=True)
@@ -370,6 +384,9 @@ class Recipe(models.Model):
     bugtracker = models.URLField(blank=True)
     file_path = models.FilePathField(max_length=255)
 
+    def __unicode__(self):
+        return "Recipe " + self.name + ":" + self.version
+
 class Recipe_DependencyManager(models.Manager):
     use_for_related_fields = True
 
@@ -389,27 +406,311 @@ class Recipe_Dependency(models.Model):
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
     objects = Recipe_DependencyManager()
 
-class ProjectLayer(models.Model):
-    project = models.ForeignKey(Project)
-    name = models.CharField(max_length = 100)
-    giturl = models.CharField(max_length = 254)
-    commit = models.CharField(max_length = 254)
-    dirpath = models.CharField(max_length = 254)
-    optional = models.BooleanField(default = True)
 
+class Machine(models.Model):
+    layer_source = models.ForeignKey('LayerSource', default = None, null = True)  # from where did we get this machine
+    up_id = models.IntegerField(null = True, default = None)                      # id of entry in the source
+    up_date = models.DateTimeField(null = True, default = None)
+
+    layer_version = models.ForeignKey('Layer_Version')
+    name = models.CharField(max_length=255)
+    description = models.CharField(max_length=255)
+
+    def __unicode__(self):
+        return "Machine " + self.name + "(" + self.description + ")"
+
+    class Meta:
+        unique_together = ("layer_source", "up_id")
+
+
+from django.db.models.base import ModelBase
+
+class InheritanceMetaclass(ModelBase):
+    def __call__(cls, *args, **kwargs):
+        obj = super(InheritanceMetaclass, cls).__call__(*args, **kwargs)
+        return obj.get_object()
+
+
+class LayerSource(models.Model):
+    __metaclass__ = InheritanceMetaclass
+
+    class Meta:
+        unique_together = (('sourcetype', 'apiurl'), )
+
+    TYPE_LOCAL = 0
+    TYPE_LAYERINDEX = 1
+    SOURCE_TYPE = (
+        (TYPE_LOCAL, "local"),
+        (TYPE_LAYERINDEX, "layerindex"),
+      )
+
+    name = models.CharField(max_length=63)
+    sourcetype = models.IntegerField(choices=SOURCE_TYPE)
+    apiurl = models.CharField(max_length=255, null=True, default=None)
+
+    def save(self, *args, **kwargs):
+        if isinstance(self, LocalLayerSource):
+            self.sourcetype = LayerSource.TYPE_LOCAL
+        elif isinstance(self, LayerIndexLayerSource):
+            self.sourcetype = LayerSource.TYPE_LAYERINDEX
+        elif self.sourcetype == None:
+            raise Exception("Invalid LayerSource type")
+        return super(LayerSource, self).save(*args, **kwargs)
+
+    def get_object(self):
+        if self.sourcetype is not None:
+            if self.sourcetype == LayerSource.TYPE_LOCAL:
+                self.__class__ = LocalLayerSource
+            if self.sourcetype == LayerSource.TYPE_LAYERINDEX:
+                self.__class__ = LayerIndexLayerSource
+        return self
+
+        return "LS " + self.sourcetype + " " + self.name
+
+
+class LocalLayerSource(LayerSource):
+    class Meta(LayerSource._meta.__class__):
+        proxy = True
+
+    def __init__(self, *args, **kwargs):
+        super(LocalLayerSource, self).__init__(args, kwargs)
+        self.sourcetype = LayerSource.TYPE_LOCAL
+
+    def update(self):
+        '''
+            Fetches layer, recipe and machine information from local repository
+        '''
+        pass
+
+class LayerIndexLayerSource(LayerSource):
+    class Meta(LayerSource._meta.__class__):
+        proxy = True
+
+    def __init__(self, *args, **kwargs):
+        super(LayerIndexLayerSource, self).__init__(args, kwargs)
+        self.sourcetype = LayerSource.TYPE_LAYERINDEX
+
+    def update(self):
+        '''
+            Fetches layer, recipe and machine information from remote repository
+        '''
+        assert self.apiurl is not None
+
+        def _get_json_response(apiurl = self.apiurl):
+            import httplib, urlparse, json
+            parsedurl = urlparse.urlparse(apiurl)
+            (host, port) = parsedurl.netloc.split(":")
+            if port is None:
+                port = 80
+            else:
+                port = int(port)
+            #print "-- connect to: http://%s:%s%s?%s" % (host, port, parsedurl.path, parsedurl.query)
+            conn = httplib.HTTPConnection(host, port)
+            conn.request("GET", parsedurl.path + "?" + parsedurl.query)
+            r = conn.getresponse()
+            if r.status != 200:
+                raise Exception("Failed to read " + parsedurl.path + ": %d %s" % (r.status, r.reason))
+            return json.loads(r.read())
+
+        # verify we can get the basic api
+        try:
+            apilinks = _get_json_response()
+        except:
+            print "EE: could not connect to %s, skipping update" % self.apiurl
+            return
+
+        # update branches; only those that we already have names listed in the database
+        whitelist_branch_names = self.branchnames.split(",")
+
+        branches_info = _get_json_response(apilinks['branches']
+            + "?filter=name:%s" % "OR".join(whitelist_branch_names))
+        for bi in branches_info:
+            try:
+                b = Branch.objects.get(layer_source = self, name = bi['name'])
+                b.up_id = bi['id']
+                b.up_date = bi['updated']
+                b.name = bi['name']
+                b.bitbake_branch = bi['bitbake_branch']
+                b.short_description = bi['short_description']
+                b.save()
+            except Branch.DoesNotExist:
+                b = Branch.objects.create(
+                    layer_source = self,
+                    up_id = bi['id'],
+                    up_date = bi['updated'],
+                    name = bi['name'],
+                    bitbake_branch = bi['bitbake_branch'],
+                    short_description = bi['short_description']
+                )
+
+        # update layers
+        layers_info = _get_json_response(apilinks['layerItems'])
+        for li in layers_info:
+            try:
+                l = Layer.objects.get(layer_source = self,
+                    up_id = li['id'])
+                l.update(
+                    up_date = li['updated'],
+                    name = li['name'],
+                    vcs_url = li['vcs_url'],
+                    vcs_web_file_base_url = li['vcs_url'],
+                    summary = li['summary'],
+                    description = li['description'])
+            except Layer.DoesNotExist:
+                Layer.objects.create(layer_source = self,
+                    up_id = li['id'],
+                    up_date = li['updated'],
+                    name = li['name'],
+                    vcs_url = li['vcs_url'],
+                    vcs_web_file_base_url = li['vcs_url'],
+                    summary = li['summary'],
+                    description = li['description']
+                )
+
+        # update layerbranches/layer_versions
+        layerbranches_info = _get_json_response(apilinks['layerBranches']
+                + "?filter=branch:%s" % "OR".join(map(lambda x: str(x.up_id), Branch.objects.filter(layer_source = self)))
+            )
+        for lbi in layerbranches_info:
+            Layer_Version.objects.get_or_create(layer_source = self,
+                    up_id = lbi['id'],
+                    up_date = lbi['updated'],
+                    layer = Layer.objects.get(layer_source = self, up_id = lbi['layer']),
+                    up_branch = Branch.objects.get(layer_source = self, up_id = lbi['branch']),
+                    branch = lbi['actual_branch'],
+                    commit = lbi['vcs_last_rev'],
+                    dirpath = lbi['vcs_subdir'])
+
+        # update machines
+        machines_info = _get_json_response(apilinks['machines']
+                + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
+            )
+        for mi in machines_info:
+            Machine.objects.get_or_create(layer_source = self,
+                    up_id = mi['id'],
+                    up_date = mi['updated'],
+                    layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']),
+                    name = mi['name'],
+                    description = mi['description'])
+
+        # update recipes; paginate by layer version / layer branch
+        recipes_info = _get_json_response(apilinks['recipes']
+                + "?filter=layerbranch:%s" % "OR".join(map(lambda x: str(x.up_id), Layer_Version.objects.filter(layer_source = self)))
+            )
+        for ri in recipes_info:
+            Recipe.objects.get_or_create(layer_source = self,
+                    up_id = ri['id'],
+                    up_date = ri['updated'],
+                    layer_version = Layer_Version.objects.get(layer_source = self, up_id = mi['layerbranch']),
+
+                    name = ri['pn'],
+                    version = ri['pv'],
+                    summary = ri['summary'],
+                    description = ri['description'],
+                    section = ri['section'],
+                    license = ri['license'],
+                    homepage = ri['homepage'],
+                    bugtracker = ri['bugtracker'],
+                    file_path = ri['filepath'] + ri['filename']
+                )
+
+        pass
+
+class BitbakeVersion(models.Model):
+    name = models.CharField(max_length=32, unique = True)
+    giturl = models.URLField()
+    branch = models.CharField(max_length=32)
+    dirpath = models.CharField(max_length=255)
+
+
+class Release(models.Model):
+    name = models.CharField(max_length=32, unique = True)
+    description = models.CharField(max_length=255)
+    bitbake_version = models.ForeignKey(BitbakeVersion)
+    branch = models.CharField(max_length=32)
+
+
+class ReleaseDefaultLayer(models.Model):
+    release = models.ForeignKey(Release)
+    layer = models.ForeignKey('Layer')
+
+
+# Branch class is synced with layerindex.Branch, branches can only come from remote layer indexes
+class Branch(models.Model):
+    layer_source = models.ForeignKey('LayerSource', null = True, default = True)
+    up_id = models.IntegerField(null = True, default = None)                    # id of branch in the source
+    up_date = models.DateTimeField(null = True, default = None)
+
+    name = models.CharField(max_length=50)
+    bitbake_branch = models.CharField(max_length=50, blank=True)
+    short_description = models.CharField(max_length=50, blank=True)
+
+    class Meta:
+        verbose_name_plural = "Branches"
+        unique_together = (('layer_source', 'name'),('layer_source', 'up_id'))
+
+    def __unicode__(self):
+        return self.name
+
+
+# Layer class synced with layerindex.LayerItem
 class Layer(models.Model):
+    layer_source = models.ForeignKey(LayerSource, null = True, default = None)  # from where did we got this layer
+    up_id = models.IntegerField(null = True, default = None)                    # id of layer in the remote source
+    up_date = models.DateTimeField(null = True, default = None)
+
     name = models.CharField(max_length=100)
-    local_path = models.FilePathField(max_length=255)
+    local_path = models.FilePathField(max_length=255, null = True, default = None)
     layer_index_url = models.URLField()
+    vcs_url = models.URLField(default = None, null = True)
+    vcs_web_file_base_url = models.URLField(null = True, default = None)
+
+    summary = models.CharField(max_length=200, help_text='One-line description of the layer', null = True, default = None)
+    description = models.TextField(null = True, default = None)
+
+    def __unicode__(self):
+        return "L " + self.name
+
+    class Meta:
+        unique_together = (("layer_source", "up_id"), ("layer_source", "name"))
 
 
+# LayerCommit class is synced with layerindex.LayerBranch
 class Layer_Version(models.Model):
-    build = models.ForeignKey(Build, related_name='layer_version_build')
+    search_allowed_fields = ["layer__name", "layer__summary",]
+    build = models.ForeignKey(Build, related_name='layer_version_build', default = None, null = True)
     layer = models.ForeignKey(Layer, related_name='layer_version_layer')
-    branch = models.CharField(max_length=50)
-    commit = models.CharField(max_length=100)
-    priority = models.IntegerField()
 
+    layer_source = models.ForeignKey(LayerSource, null = True, default = None)                   # from where did we get this Layer Version
+    up_id = models.IntegerField(null = True, default = None)        # id of layerbranch in the remote source
+    up_date = models.DateTimeField(null = True, default = None)
+    up_branch = models.ForeignKey(Branch, null = True, default = None)
+
+    branch = models.CharField(max_length=80)            # LayerBranch.actual_branch
+    commit = models.CharField(max_length=100)           # LayerBranch.vcs_last_rev
+    dirpath = models.CharField(max_length=255, null = True, default = None)          # LayerBranch.vcs_subdir
+    priority = models.IntegerField(default = 0)         # if -1, this is a default layer
+
+    def __unicode__(self):
+        return "LV " + str(self.layer) + " " + self.commit
+
+    class Meta:
+        unique_together = ("layer_source", "up_id")
+
+class LayerVersionDependency(models.Model):
+    layer_source = models.ForeignKey(LayerSource, null = True, default = None)  # from where did we got this layer
+    up_id = models.IntegerField(null = True, default = None)                    # id of layerbranch in the remote source
+
+    layer_version = models.ForeignKey(Layer_Version, related_name="dependencies")
+    depends_on = models.ForeignKey(Layer_Version, related_name="dependees")
+
+    class Meta:
+        unique_together = ("layer_source", "up_id")
+
+class ProjectLayer(models.Model):
+    project = models.ForeignKey(Project)
+    layercommit = models.ForeignKey(Layer_Version, null=True)
+    optional = models.BooleanField(default = True)
 
 class ProjectVariable(models.Model):
     project = models.ForeignKey(Project)
diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
new file mode 100644
index 0000000..f2f561b
--- /dev/null
+++ b/lib/toaster/orm/tests.py
@@ -0,0 +1,33 @@
+from django.test import TestCase
+from orm.models import LocalLayerSource, LayerIndexLayerSource, LayerSource
+from orm.models import Branch
+
+class LayerSourceVerifyInheritanceSaveLoad(TestCase):
+    def test_object_creation(self):
+        lls = LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
+        lils = LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "")
+
+        print LayerSource.objects.all()
+
+        self.assertTrue(True in map(lambda x: isinstance(x, LocalLayerSource), LayerSource.objects.all()))
+        self.assertTrue(True in map(lambda x: isinstance(x, LayerIndexLayerSource), LayerSource.objects.all()))
+
+    def test_duplicate_error(self):
+        def duplicate():
+            LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
+            LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
+
+        self.assertRaises(Exception, duplicate)
+            
+
+
+class LILSUpdateTestCase(TestCase):
+    def test_update(self):
+        lils = LayerSource.objects.create(name = "b1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "http://adamian-desk.local:8080/layerindex/api/")
+        lils.update()
+
+        # run second update
+        # lils.update()
+
+        # print vars(lils)
+        #print map(lambda x: vars(x), Branch.objects.all())
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index a8b3e3a..1dab25a 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -245,6 +245,8 @@ INSTALLED_APPS = (
     'bldcontrol',
 )
 
+SOUTH_TESTS_MIGRATE = False
+
 # if we run in managed mode, we need user support
 if MANAGED:
     INSTALLED_APPS = ('django.contrib.auth',
-- 
1.9.1


