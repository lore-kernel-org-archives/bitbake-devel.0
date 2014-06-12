Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 4CD4765E0F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 13:51:58 +0000 (UTC)
Received: by mail-wg0-f47.google.com with SMTP id k14so1266477wgh.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jun 2014 06:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=yYoOVOFf272CC0AWQe0wuA9E39G3/aqBwV3tM5JZe6g=;
	b=iSO/TAySIezi1KDz/yhwckvGgLQRfguRgxwCBfoCHMaEP5D8YlJcKppYi0Fi/UirNU
	LU127nb4ObIUVXrCvl4U5JMZFqJl6gi+5c8PRW6cKqchqFUhYC7aubWW59JRmEnYnhBM
	V1rMkuXdgXcMNifDf0OH+qxrCDrDXLghybYoYJj6IXp+kxGtNjIyrtRRS4IT4Rn8v0LK
	t89An0LPEToSDbvI0Gr4pY/9h/UJfpXKYKaT8Ws/c+19T/ybXaO4qxdPCOExabA9JITO
	xNmRBuhZsVHzDYcsV80r0BF64OFN8gUCYrfajO6BLL7KOgi4UrIhMh4/L/wVbqHkcbTn
	Ezkw==
X-Gm-Message-State: ALoCoQmEVCC+abaP5suEO+pFc6leqZAepOVUk4kyBcgkOsERPl3NGlwUsxH4nVJqEEn+fFzV2sTI
X-Received: by 10.180.20.141 with SMTP id n13mr6923000wie.6.1402581119471;
	Thu, 12 Jun 2014 06:51:59 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fg5sm33532992wib.17.2014.06.12.06.51.58 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Jun 2014 06:51:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A562D560CE5; Thu, 12 Jun 2014 14:52:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Thu, 12 Jun 2014 14:51:58 +0100
Message-Id: <d4bfe9059f765f11244b97e324c0131f32f8e400.1402580802.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
References: <08556b79b7b2af08aaeedf8733b1b8996f387c4e.1402580802.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1402580802.git.alexandru.damian@intel.com>
References: <cover.1402580802.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/6] toaster: create models for bldcontrol and enable it
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
X-List-Received-Date: Thu, 12 Jun 2014 13:52:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We create the model classes that store information
about triggering builds, and the available build
environments.

We add a fixture with a default build environment
for build control, using a "build/" directory under
the poky checkout directory.

We enable the bldcontrol in toaster starting script
and in the toaster settings as to allow the actual database
to be kept in sync with the source code.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                       |   2 +-
 lib/toaster/bldcontrol/fixtures/initial_data.json |   1 +
 lib/toaster/bldcontrol/migrations/0001_initial.py | 154 ++++++++++++++++++++++
 lib/toaster/bldcontrol/migrations/__init__.py     |   0
 lib/toaster/bldcontrol/models.py                  |  80 ++++++++++-
 lib/toaster/toastermain/settings.py               |   1 +
 6 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/fixtures/initial_data.json
 create mode 100644 lib/toaster/bldcontrol/migrations/0001_initial.py
 create mode 100644 lib/toaster/bldcontrol/migrations/__init__.py

diff --git a/bin/toaster b/bin/toaster
index f469e4f..80bda6d 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -63,7 +63,7 @@ function webserverStartAll()
             retval=0
             python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
         fi
-        # python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
 
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
diff --git a/lib/toaster/bldcontrol/fixtures/initial_data.json b/lib/toaster/bldcontrol/fixtures/initial_data.json
new file mode 100644
index 0000000..21883ab
--- /dev/null
+++ b/lib/toaster/bldcontrol/fixtures/initial_data.json
@@ -0,0 +1 @@
+[{"pk": 1, "model": "bldcontrol.buildenvironment", "fields": {"updated": "2014-05-20T12:17:30Z", "created": "2014-05-20T12:17:30Z", "lock": 0, "bbstate": 0, "bbaddress": "", "betype": 0, "bbtoken": "", "address": "localhost", "bbport": -1}}]
diff --git a/lib/toaster/bldcontrol/migrations/0001_initial.py b/lib/toaster/bldcontrol/migrations/0001_initial.py
new file mode 100644
index 0000000..9f13d14
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0001_initial.py
@@ -0,0 +1,154 @@
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
+        # Adding model 'BuildEnvironment'
+        db.create_table(u'bldcontrol_buildenvironment', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('address', self.gf('django.db.models.fields.CharField')(max_length=254)),
+            ('betype', self.gf('django.db.models.fields.IntegerField')()),
+            ('bbaddress', self.gf('django.db.models.fields.CharField')(max_length=254, blank=True)),
+            ('bbport', self.gf('django.db.models.fields.IntegerField')(default=-1)),
+            ('bbtoken', self.gf('django.db.models.fields.CharField')(max_length=126, blank=True)),
+            ('bbstate', self.gf('django.db.models.fields.IntegerField')(default=0)),
+            ('lock', self.gf('django.db.models.fields.IntegerField')(default=0)),
+            ('created', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
+            ('updated', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BuildEnvironment'])
+
+        # Adding model 'BuildRequest'
+        db.create_table(u'bldcontrol_buildrequest', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('project', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Project'])),
+            ('build', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Build'], null=True)),
+            ('state', self.gf('django.db.models.fields.IntegerField')(default=0)),
+            ('created', self.gf('django.db.models.fields.DateTimeField')(auto_now_add=True, blank=True)),
+            ('updated', self.gf('django.db.models.fields.DateTimeField')(auto_now=True, blank=True)),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BuildRequest'])
+
+        # Adding model 'BRLayer'
+        db.create_table(u'bldcontrol_brlayer', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('req', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['bldcontrol.BuildRequest'])),
+            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
+            ('giturl', self.gf('django.db.models.fields.CharField')(max_length=254)),
+            ('commit', self.gf('django.db.models.fields.CharField')(max_length=254)),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BRLayer'])
+
+        # Adding model 'BRVariable'
+        db.create_table(u'bldcontrol_brvariable', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('req', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['bldcontrol.BuildRequest'])),
+            ('name', self.gf('django.db.models.fields.CharField')(max_length=100)),
+            ('value', self.gf('django.db.models.fields.TextField')(blank=True)),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BRVariable'])
+
+        # Adding model 'BRTarget'
+        db.create_table(u'bldcontrol_brtarget', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('req', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['bldcontrol.BuildRequest'])),
+            ('target', self.gf('django.db.models.fields.CharField')(max_length=100)),
+            ('task', self.gf('django.db.models.fields.CharField')(max_length=100, null=True)),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BRTarget'])
+
+
+    def backwards(self, orm):
+        # Deleting model 'BuildEnvironment'
+        db.delete_table(u'bldcontrol_buildenvironment')
+
+        # Deleting model 'BuildRequest'
+        db.delete_table(u'bldcontrol_buildrequest')
+
+        # Deleting model 'BRLayer'
+        db.delete_table(u'bldcontrol_brlayer')
+
+        # Deleting model 'BRVariable'
+        db.delete_table(u'bldcontrol_brvariable')
+
+        # Deleting model 'BRTarget'
+        db.delete_table(u'bldcontrol_brtarget')
+
+
+    models = {
+        u'bldcontrol.brlayer': {
+            'Meta': {'object_name': 'BRLayer'},
+            'commit': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            'giturl': ('django.db.models.fields.CharField', [], {'max_length': '254'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
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
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'lock': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
+        },
+        u'bldcontrol.buildrequest': {
+            'Meta': {'object_name': 'BuildRequest'},
+            'build': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Build']", 'null': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'project': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Project']"}),
+            'state': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
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
+        u'orm.project': {
+            'Meta': {'object_name': 'Project'},
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'})
+        }
+    }
+
+    complete_apps = ['bldcontrol']
\ No newline at end of file
diff --git a/lib/toaster/bldcontrol/migrations/__init__.py b/lib/toaster/bldcontrol/migrations/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 71a8362..11f487c 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -1,3 +1,81 @@
 from django.db import models
+from django.core.validators import MaxValueValidator, MinValueValidator
+from orm.models import Project, ProjectLayer, ProjectVariable, ProjectTarget, Build
+
+# a BuildEnvironment is the equivalent of the "build/" directory on the localhost
+class BuildEnvironment(models.Model):
+    SERVER_STOPPED = 0
+    SERVER_STARTED = 1
+    SERVER_STATE = (
+        (SERVER_STOPPED, "stopped"),
+        (SERVER_STARTED, "started"),
+    )
+
+    TYPE_LOCAL = 0
+    TYPE_SSH   = 1
+    TYPE = (
+        (TYPE_LOCAL, "local"),
+        (TYPE_SSH, "ssh"),
+    )
+
+    LOCK_FREE = 0
+    LOCK_LOCK = 1
+    LOCK_STATE = (
+        (LOCK_FREE, "free"),
+        (LOCK_LOCK, "lock"),
+    )
+
+    address     = models.CharField(max_length = 254)
+    betype      = models.IntegerField(choices = TYPE)
+    bbaddress   = models.CharField(max_length = 254, blank = True)
+    bbport      = models.IntegerField(default = -1)
+    bbtoken     = models.CharField(max_length = 126, blank = True)
+    bbstate     = models.IntegerField(choices = SERVER_STATE, default = SERVER_STOPPED)
+    lock        = models.IntegerField(choices = LOCK_STATE, default = LOCK_FREE)
+    created     = models.DateTimeField(auto_now_add = True)
+    updated     = models.DateTimeField(auto_now = True)
+
+
+# a BuildRequest is a request that the scheduler will build using a BuildEnvironment
+# the build request queue is the table itself, ordered by state
+
+class BuildRequest(models.Model):
+    REQ_CREATED = 0
+    REQ_QUEUED = 1
+    REQ_INPROGRESS = 2
+    REQ_COMPLETED = 3
+
+    REQUEST_STATE = (
+        (REQ_CREATED, "created"),
+        (REQ_QUEUED, "queued"),
+        (REQ_INPROGRESS, "in progress"),
+        (REQ_COMPLETED, "completed"),
+    )
+
+    project     = models.ForeignKey(Project)
+    build       = models.ForeignKey(Build, null = True)     # TODO: toasterui should set this when Build is created
+    state       = models.IntegerField(choices = REQUEST_STATE, default = REQ_CREATED)
+    created     = models.DateTimeField(auto_now_add = True)
+    updated     = models.DateTimeField(auto_now = True)
+
+
+# These tables specify the settings for running an actual build.
+# They MUST be kept in sync with the tables in orm.models.Project*
+
+class BRLayer(models.Model):
+    req         = models.ForeignKey(BuildRequest)
+    name        = models.CharField(max_length = 100)
+    giturl      = models.CharField(max_length = 254)
+    commit      = models.CharField(max_length = 254)
+
+class BRVariable(models.Model):
+    req         = models.ForeignKey(BuildRequest)
+    name        = models.CharField(max_length=100)
+    value       = models.TextField(blank = True)
+
+class BRTarget(models.Model):
+    req         = models.ForeignKey(BuildRequest)
+    target      = models.CharField(max_length=100)
+    task        = models.CharField(max_length=100, null=True)
+
 
-# Create your models here.
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index adaa56c..2c52b68 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -221,6 +221,7 @@ INSTALLED_APPS = (
     'toastergui',
     'bldviewer',
     'south',
+    'bldcontrol',
 )
 
 # A sample logging configuration. The only tangible logging
-- 
1.9.1


