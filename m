Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 1FBCD7063F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:05 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id ho1so748885wib.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=61LGV3z0aE6DNoKjMnuMxrwybWIJ49krEfuw2W/Ls8o=;
	b=Fkpvrc38siTwuaQFuAqcnwwzqkFfwrV4SP06j2cKOviblauValZ57WCzuMU+I0Det9
	VCOItKG5SjGwCuwIifgEoajoPZWLR62Ai8Y23S8nu+QAS1aBm/hfJDScHwKf7TiisOmk
	lHZwkIFGrKh6fA/AX6es0drHpl4tqcupBdVMPzjcwTRUUOZR+LY0x75GrM7CuI2Ew03N
	ld0OOd2FrE2DD2GXNUY7lPZm920Ft2zs0fYUdsvPbxsmKavwJ2LBUk/mYi+jhIHtHLsj
	pRZz9hjhhAIwOtGknCsnbtTDnLfRg09PvNeMPJ3kOdoj/Q6rqshUhSVR7f5z5NaS5l4g
	NhSw==
X-Gm-Message-State: ALoCoQk+juVpTeWxaG2kopaHfEs15JnIvJqW8k0Oiet/2034yqxkD79JyduhG/vB4aO+If/mCYBD
X-Received: by 10.194.236.132 with SMTP id uu4mr6150630wjc.54.1405685703960;
	Fri, 18 Jul 2014 05:15:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id cz4sm6068334wib.23.2014.07.18.05.15.02
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CBE5D560262; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:14:55 +0100
Message-Id: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/8] toaster: add fields for sourcedir and builddir paths
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:06 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add explicit absolute paths for a directory where
the layer sources will be checked out (sourcedir) and
where the build activities will take place.

Adding minimal checking when starting the application in
order to make sure that BuildEnvironment (BE) settings are
usable.

Modify the localhost bbcontroller to use the BE settings
instead of trying to self-configure on checked out sources.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        |   1 +
 lib/toaster/bldcontrol/bbcontroller.py             |  51 +++++-----
 .../management/commands/checksettings.py           |  38 ++++++++
 ...onment_sourcedir__add_field_buildenvironment.py | 106 +++++++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |   2 +
 5 files changed, 172 insertions(+), 26 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/management/commands/checksettings.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0002_auto__add_field_buildenvironment_sourcedir__add_field_buildenvironment.py

diff --git a/bin/toaster b/bin/toaster
index 90cd982..1f90362 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -64,6 +64,7 @@ function webserverStartAll()
             python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
         fi
         python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+	python $BBBASEDIR/lib/toaster/manage.py checksettings  || retval=1
 
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index d2b2a23..c3beba9 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -170,27 +170,16 @@ class LocalhostBEController(BuildEnvironmentController):
         this controller manages the default build directory,
         the server setup and system start and stop for the localhost-type build environment
 
-        The address field is used as working directory; if not set, the build/ directory
-        is created
     """
+    from os.path import dirname as DN
 
     def __init__(self, be):
         super(LocalhostBEController, self).__init__(be)
         from os.path import dirname as DN
-        self.cwd = DN(DN(DN(DN(DN(os.path.realpath(__file__))))))
-        if self.be.address is None or len(self.be.address) == 0:
-            self.be.address = "build"
-            self.be.save()
-        self.bwd = self.be.address
         self.dburl = settings.getDATABASE_URL()
 
-        # transform relative paths to absolute ones
-        if not self.bwd.startswith("/"):
-            self.bwd = os.path.join(self.cwd, self.bwd)
-        self._createBE()
-
     def _shellcmd(self, command):
-        p = subprocess.Popen(command, cwd=self.cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        p = subprocess.Popen(command, cwd=self.be.sourcedir, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         (out,err) = p.communicate()
         if p.returncode:
             if len(err) == 0:
@@ -201,39 +190,49 @@ class LocalhostBEController(BuildEnvironmentController):
         else:
             return out
 
-    def _createBE(self):
-        assert self.cwd and os.path.exists(self.cwd)
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.cwd, self.bwd))
+    def _createdirpath(self, path):
+        if not os.path.exists(DN(path)):
+            self._createdirpath(DN(path))
+        if not os.path.exists(path):
+            os.mkdir(path, 0755)
+
+    def _startBE(self):
+        assert self.be.sourcedir and os.path.exists(self.be.sourcedir)
+        self._createdirpath(self.be.builddir)
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.be.sourcedir, self.be.builddir))
 
     def startBBServer(self):
-        assert self.cwd and os.path.exists(self.cwd)
-        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.cwd, self.bwd, self.dburl))
+        assert self.be.sourcedir and os.path.exists(self.be.sourcedir)
+
+        self._startBE()
+
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.be.sourcedir, self.be.builddir, self.dburl))
         # FIXME unfortunate sleep 1 - we need to make sure that bbserver is started and the toaster ui is connected
         # but since they start async without any return, we just wait a bit
         print "Started server"
-        assert self.cwd and os.path.exists(self.bwd)
+        assert self.be.sourcedir and os.path.exists(self.be.builddir)
         self.be.bbaddress = "localhost"
         self.be.bbport = "8200"
         self.be.bbstate = BuildEnvironment.SERVER_STARTED
         self.be.save()
 
     def stopBBServer(self):
-        assert self.cwd
+        assert self.be.sourcedir
         print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && %s source toaster stop\"" %
-            (self.cwd, self.bwd, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
+            (self.be.sourcedir, self.be.builddir, (lambda: "" if self.be.bbtoken is None else "BBTOKEN=%s" % self.be.bbtoken)()))
         self.be.bbstate = BuildEnvironment.SERVER_STOPPED
         self.be.save()
         print "Stopped server"
 
     def setLayers(self, layers):
-        assert self.cwd is not None
-        layerconf = os.path.join(self.bwd, "conf/bblayers.conf")
+        assert self.be.sourcedir is not None
+        layerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
         if not os.path.exists(layerconf):
             raise Exception("BE is not consistent: bblayers.conf file missing at ", layerconf)
         return True
 
     def release(self):
-        assert self.cwd and os.path.exists(self.bwd)
+        assert self.be.sourcedir and os.path.exists(self.be.builddir)
         import shutil
-        shutil.rmtree(os.path.join(self.cwd, "build"))
-        assert not os.path.exists(self.bwd)
+        shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
+        assert not os.path.exists(self.be.builddir)
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
new file mode 100644
index 0000000..da1c3b7
--- /dev/null
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -0,0 +1,38 @@
+from django.core.management.base import NoArgsCommand, CommandError
+from django.db import transaction
+from orm.models import Build
+from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
+from bldcontrol.models import BuildRequest, BuildEnvironment
+import os
+
+class Command(NoArgsCommand):
+    args = ""
+    help = "Verifies thid %dthe configured settings are valid and usable, or prompts the user to fix the settings."
+
+    def handle(self, **options):
+        # we make sure we have builddir and sourcedir for all defined build envionments
+        for be in BuildEnvironment.objects.all():
+            def _verify_be():
+                is_changed = False
+                print("Verifying the Build Environment type %s id %d." % (be.get_betype_display(), be.pk))
+                if len(be.sourcedir) == 0:
+                    be.sourcedir = raw_input(" -- sourcedir may not be empty:")
+                    is_changed = True
+                if not be.sourcedir.startswith("/"):
+                    be.sourcedir = raw_input(" -- sourcedir must be an absolute path:")
+                    is_changed = True
+                if len(be.builddir) == 0:
+                    be.builddir = raw_input(" -- builddir may not be empty:")
+                    is_changed = True
+                if not be.builddir.startswith("/"):
+                    be.builddir = raw_input(" -- builddir must be an absolute path:")
+                    is_changed = True
+                return is_changed
+
+            while (_verify_be()):
+                pass
+        
+
+            
+            
+
diff --git a/lib/toaster/bldcontrol/migrations/0002_auto__add_field_buildenvironment_sourcedir__add_field_buildenvironment.py b/lib/toaster/bldcontrol/migrations/0002_auto__add_field_buildenvironment_sourcedir__add_field_buildenvironment.py
new file mode 100644
index 0000000..f522a50
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0002_auto__add_field_buildenvironment_sourcedir__add_field_buildenvironment.py
@@ -0,0 +1,106 @@
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
+        # Adding field 'BuildEnvironment.sourcedir'
+        db.add_column(u'bldcontrol_buildenvironment', 'sourcedir',
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=512, blank=True),
+                      keep_default=False)
+
+        # Adding field 'BuildEnvironment.builddir'
+        db.add_column(u'bldcontrol_buildenvironment', 'builddir',
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=512, blank=True),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Deleting field 'BuildEnvironment.sourcedir'
+        db.delete_column(u'bldcontrol_buildenvironment', 'sourcedir')
+
+        # Deleting field 'BuildEnvironment.builddir'
+        db.delete_column(u'bldcontrol_buildenvironment', 'builddir')
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
+            'builddir': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'lock': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
+            'sourcedir': ('django.db.models.fields.CharField', [], {'max_length': '512', 'blank': 'True'}),
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
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
+            'created': ('django.db.models.fields.DateTimeField', [], {'auto_now_add': 'True', 'blank': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
+            'short_description': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
+            'updated': ('django.db.models.fields.DateTimeField', [], {'auto_now': 'True', 'blank': 'True'}),
+            'user_id': ('django.db.models.fields.IntegerField', [], {'null': 'True'})
+        }
+    }
+
+    complete_apps = ['bldcontrol']
\ No newline at end of file
diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 158874f..8285257 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -33,6 +33,8 @@ class BuildEnvironment(models.Model):
     bbport      = models.IntegerField(default = -1)
     bbtoken     = models.CharField(max_length = 126, blank = True)
     bbstate     = models.IntegerField(choices = SERVER_STATE, default = SERVER_STOPPED)
+    sourcedir   = models.CharField(max_length = 512, blank = True)
+    builddir    = models.CharField(max_length = 512, blank = True)
     lock        = models.IntegerField(choices = LOCK_STATE, default = LOCK_FREE)
     created     = models.DateTimeField(auto_now_add = True)
     updated     = models.DateTimeField(auto_now = True)
-- 
1.9.1


