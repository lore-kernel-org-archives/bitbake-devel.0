Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f182.google.com (mail-we0-f182.google.com
	[74.125.82.182])
	by mail.openembedded.org (Postfix) with ESMTP id 307367061F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:02 +0000 (UTC)
Received: by mail-we0-f182.google.com with SMTP id k48so3295918wev.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=MsLDXdgAlWMciA8rgMLtZhcxzhliPAWKz/xc2XK81b4=;
	b=Mz2VGZkwxJLF3hWIlXbjkc5ll8ThA7NkxO3fqGYQL0BWWqYx8DRgMvhNcMqNMVXvsT
	cTd2DY9SXd+AI1Hutf4KeiwIkA76R2JP3jikBtv0SYYNuedouyUHtOIsvQTjn7Zo4ncl
	saGSX7D1EgjYbIC/DXvDf5GywN04bM9ltiIjkElHQxugC3QOJWVoxdHTH5+7TVFao0YK
	NWi7a1+4Ad1KCDwnDvVfZ1kbBx79Q69mKf1RpkI5cS6CIxhmI7RZO7hT63KyW1+TxzcA
	7b0WDLPzfUapjy7Dt/+4lrgUVKNeadiP9fUiUI1OhAYMSIg5PwVZr20oLVEYnQ2tLXRt
	3onw==
X-Gm-Message-State: ALoCoQlLpeYUmz7N41PZ6Qk8fe00JOAdP+27Kee01YcSGsMfCT0v/w3RwlFJQJXbFpsY43qIgcVn
X-Received: by 10.180.36.18 with SMTP id m18mr7120463wij.74.1405685703137;
	Fri, 18 Jul 2014 05:15:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id x3sm6126179wia.11.2014.07.18.05.15.01
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D64F95603F8; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:14:59 +0100
Message-Id: <42862f265752b9420388ec0853ef43c35439b2f8.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
References: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 5/8] toaster: properly set layers when running a build
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch enables the localhost build controller to
properly set the layers before the build runs.

It creates the checkout directories under BuildEnvironment
sourcedir directory, and runs the build in the buildir
directory.

Build launch errors are tracked in the newly added BRError table.
These are different from build errors, in the sense that the
build can't start due to these errors.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py             | 108 +++++++++++++++++---
 .../bldcontrol/management/commands/runbuilds.py    |  23 +++--
 .../migrations/0005_auto__add_brerror.py           | 112 +++++++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |   8 +-
 4 files changed, 226 insertions(+), 25 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/migrations/0005_auto__add_brerror.py

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index c3beba9..1e58c67 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -126,6 +126,8 @@ class BuildEnvironmentController(object):
     def setLayers(self,ls):
         """ Sets the layer variables in the config file, after validating local layer paths.
             The layer paths must be in a list of BRLayer object
+
+            a word of attention: by convention, the first layer for any build will be poky!
         """
         raise Exception("Must override setLayers")
 
@@ -165,25 +167,31 @@ class BuildEnvironmentController(object):
 class ShellCmdException(Exception):
     pass
 
+
+class BuildSetupException(Exception):
+    pass
+
 class LocalhostBEController(BuildEnvironmentController):
     """ Implementation of the BuildEnvironmentController for the localhost;
         this controller manages the default build directory,
         the server setup and system start and stop for the localhost-type build environment
 
     """
-    from os.path import dirname as DN
 
     def __init__(self, be):
         super(LocalhostBEController, self).__init__(be)
-        from os.path import dirname as DN
         self.dburl = settings.getDATABASE_URL()
+        self.pokydirname = None
+
+    def _shellcmd(self, command, cwd = None):
+        if cwd is None:
+            cwd = self.be.sourcedir
 
-    def _shellcmd(self, command):
-        p = subprocess.Popen(command, cwd=self.be.sourcedir, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        p = subprocess.Popen(command, cwd = cwd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
         (out,err) = p.communicate()
         if p.returncode:
             if len(err) == 0:
-                err = "command: %s" % command
+                err = "command: %s \n%s" % (command, out)
             else:
                 err = "command: %s \n%s" % (command, err)
             raise ShellCmdException(err)
@@ -191,22 +199,20 @@ class LocalhostBEController(BuildEnvironmentController):
             return out
 
     def _createdirpath(self, path):
+        from os.path import dirname as DN
         if not os.path.exists(DN(path)):
             self._createdirpath(DN(path))
         if not os.path.exists(path):
             os.mkdir(path, 0755)
 
     def _startBE(self):
-        assert self.be.sourcedir and os.path.exists(self.be.sourcedir)
+        assert self.pokydirname and os.path.exists(self.pokydirname)
         self._createdirpath(self.be.builddir)
-        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.be.sourcedir, self.be.builddir))
+        self._shellcmd("bash -c \"source %s/oe-init-build-env %s\"" % (self.pokydirname, self.be.builddir))
 
     def startBBServer(self):
-        assert self.be.sourcedir and os.path.exists(self.be.sourcedir)
-
-        self._startBE()
-
-        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.be.sourcedir, self.be.builddir, self.dburl))
+        assert self.pokydirname and os.path.exists(self.pokydirname)
+        print self._shellcmd("bash -c \"source %s/oe-init-build-env %s && DATABASE_URL=%s source toaster start noweb && sleep 1\"" % (self.pokydirname, self.be.builddir, self.dburl))
         # FIXME unfortunate sleep 1 - we need to make sure that bbserver is started and the toaster ui is connected
         # but since they start async without any return, we just wait a bit
         print "Started server"
@@ -225,10 +231,82 @@ class LocalhostBEController(BuildEnvironmentController):
         print "Stopped server"
 
     def setLayers(self, layers):
+        """ a word of attention: by convention, the first layer for any build will be poky! """
+
         assert self.be.sourcedir is not None
-        layerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
-        if not os.path.exists(layerconf):
-            raise Exception("BE is not consistent: bblayers.conf file missing at ", layerconf)
+        # set layers in the layersource
+
+        # 1. get a list of repos, and map dirpaths for each layer
+        gitrepos = {}
+        for layer in layers:
+            if not layer.giturl in gitrepos:
+                gitrepos[layer.giturl] = []
+            gitrepos[layer.giturl].append( (layer.name, layer.dirpath, layer.commit))
+        for giturl in gitrepos.keys():
+            commitid = gitrepos[giturl][0][2]
+            for e in gitrepos[giturl]:
+                if commitid != e[2]:
+                    raise BuildSetupException("More than one commit per git url, unsupported configuration")
+
+        def _getgitdirectoryname(url):
+            import re
+            components = re.split(r'[\.\/]', url)
+            return components[-2] if components[-1] == "git" else components[-1]
+
+        layerlist = []
+
+        # 2. checkout the repositories
+        for giturl in gitrepos.keys():
+            localdirname = os.path.join(self.be.sourcedir, _getgitdirectoryname(giturl))
+            print "DEBUG: giturl checking out in current directory", localdirname
+
+            # make sure our directory is a git repository
+            if os.path.exists(localdirname):
+                if not giturl in self._shellcmd("git remote -v", localdirname):
+                    raise BuildSetupException("Existing git repository at %s, but with different remotes (not '%s'). Aborting." % (localdirname, giturl))
+            else:
+                self._shellcmd("git clone \"%s\" \"%s\"" % (giturl, localdirname))
+            # checkout the needed commit
+            commit = gitrepos[giturl][0][2]
+            self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
+            print "DEBUG: checked out commit ", commit, "to", localdirname
+
+            # if this is the first checkout, take the localdirname as poky dir
+            if self.pokydirname is None:
+                print "DEBUG: selected poky dir name", localdirname
+                self.pokydirname = localdirname
+
+            # verify our repositories
+            for name, dirpath, commit in gitrepos[giturl]:
+                localdirpath = os.path.join(localdirname, dirpath)
+                if not os.path.exists(localdirpath):
+                    raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
+
+                layerlist.append(localdirpath)
+
+        print "DEBUG: current layer list ", layerlist
+
+        # 3. configure the build environment, so we have a conf/bblayers.conf
+        assert self.pokydirname is not None
+        self._startBE()
+
+        # 4. update the bblayers.conf
+        bblayerconf = os.path.join(self.be.builddir, "conf/bblayers.conf")
+        if not os.path.exists(bblayerconf):
+            raise BuildSetupException("BE is not consistent: bblayers.conf file missing at %s" % bblayerconf)
+
+        conflines = open(bblayerconf, "r").readlines()
+
+        bblayerconffile = open(bblayerconf, "w")
+        for i in xrange(len(conflines)):
+            if conflines[i].startswith("# line added by toaster"):
+                i += 2
+            else:
+                bblayerconffile.write(conflines[i])
+
+        bblayerconffile.write("\n# line added by toaster build control\nBBLAYERS = \"" + " ".join(layerlist) + "\"")
+        bblayerconffile.close()
+
         return True
 
     def release(self):
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index dd8f84b..fa8c1a9 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -1,8 +1,8 @@
 from django.core.management.base import NoArgsCommand, CommandError
 from django.db import transaction
 from orm.models import Build
-from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException
-from bldcontrol.models import BuildRequest, BuildEnvironment
+from bldcontrol.bbcontroller import getBuildEnvironmentController, ShellCmdException, BuildSetupException
+from bldcontrol.models import BuildRequest, BuildEnvironment, BRError
 import os
 
 class Command(NoArgsCommand):
@@ -25,6 +25,7 @@ class Command(NoArgsCommand):
         return br
 
     def schedule(self):
+        import traceback
         try:
             br = None
             try:
@@ -63,15 +64,19 @@ class Command(NoArgsCommand):
 
             # cleanup to be performed by toaster when the deed is done
 
-        except ShellCmdException as e:
-            import traceback
-            print " EE Error executing shell command\n", e
-            traceback.format_exc(e)
 
         except Exception as e:
-            import traceback
-            traceback.print_exc()
-            raise e
+            print " EE Error executing shell command\n", e
+            traceback.print_exc(e)
+            BRError.objects.create(req = br,
+                errtype = str(type(e)),
+                errmsg = str(e),
+                traceback = traceback.format_exc(e))
+            br.state = BuildRequest.REQ_FAILED
+            br.save()
+            bec.be.lock = BuildEnvironment.LOCK_FREE
+            bec.be.save()
+
 
     def cleanup(self):
         from django.utils import timezone
diff --git a/lib/toaster/bldcontrol/migrations/0005_auto__add_brerror.py b/lib/toaster/bldcontrol/migrations/0005_auto__add_brerror.py
new file mode 100644
index 0000000..98aeb41
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0005_auto__add_brerror.py
@@ -0,0 +1,112 @@
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
+        # Adding model 'BRError'
+        db.create_table(u'bldcontrol_brerror', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('req', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['bldcontrol.BuildRequest'])),
+            ('errtype', self.gf('django.db.models.fields.CharField')(max_length=100)),
+            ('errmsg', self.gf('django.db.models.fields.TextField')()),
+            ('traceback', self.gf('django.db.models.fields.TextField')()),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BRError'])
+
+
+    def backwards(self, orm):
+        # Deleting model 'BRError'
+        db.delete_table(u'bldcontrol_brerror')
+
+
+    models = {
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
index 1f253ff..8c271ff 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -48,12 +48,14 @@ class BuildRequest(models.Model):
     REQ_QUEUED = 1
     REQ_INPROGRESS = 2
     REQ_COMPLETED = 3
+    REQ_FAILED = 4
 
     REQUEST_STATE = (
         (REQ_CREATED, "created"),
         (REQ_QUEUED, "queued"),
         (REQ_INPROGRESS, "in progress"),
         (REQ_COMPLETED, "completed"),
+        (REQ_FAILED, "failed"),
     )
 
     project     = models.ForeignKey(Project)
@@ -84,4 +86,8 @@ class BRTarget(models.Model):
     target      = models.CharField(max_length=100)
     task        = models.CharField(max_length=100, null=True)
 
-
+class BRError(models.Model):
+    req         = models.ForeignKey(BuildRequest)
+    errtype     = models.CharField(max_length=100)
+    errmsg      = models.TextField()
+    traceback   = models.TextField()
-- 
1.9.1


