Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id B02396FE3B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 17:23:51 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id f8so6986794wiw.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 10:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=7wE3pEtIYjIxMTSACWKMaToTASM8v7oQBprscJg3ILI=;
	b=JJ/8P0QUK5ctJiQQGTei5GXDhONED+/wIrYNwPIaoInOdTfb6jUgkoFuxpRY92sTuS
	+1i8pnrxZluQh4bEbEkXXX85Di+KWuQP/xqiGqoanOkj5XU1LAzAC3YLqWtswa/vQ34U
	HgmXZA8HomHc27dGZ0E+dc5chKMaO1tdnIQyaiXycj7qOsPF8R1STzKrphhZzO3bowbu
	phJvdExcYC0luaP9LRf5OXhJpWaYfoC60T/yC+a9H3r6xQJR8Z5RnXoVh3zEZOxRK4g8
	iKIasfMJXOUQdiMu1S5aWoGBPuTqVTbggHfKB3RBUmeCV5yiV38pvyMtD484Z+GY25lC
	cJIw==
X-Gm-Message-State: ALoCoQmS9gbq3B5KSHzifnnTruB2oVHSj6BcfvtzApOc1NTqukkSXi4U62O3MdUsryymd/DMj0a9
X-Received: by 10.194.205.196 with SMTP id li4mr37722640wjc.46.1409160231670; 
	Wed, 27 Aug 2014 10:23:51 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gr3sm25882230wib.12.2014.08.27.10.23.48 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 27 Aug 2014 10:23:50 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A6ABF5611B1; Wed, 27 Aug 2014 18:23:45 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Wed, 27 Aug 2014 18:23:40 +0100
Message-Id: <ea0895d832aabc2f83306f43dc6d45f5dce9ba2a.1409159626.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
References: <21a46e29c3a9df56db7ad81106a23e7284584afe.1409159626.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409159626.git.alexandru.damian@intel.com>
References: <cover.1409159626.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 08/11] toaster: update the bldcontrol to the new orm models
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
X-List-Received-Date: Wed, 27 Aug 2014 17:23:52 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We update the build controller application to make proper
use of the bitbake specification in project settings.

Added heuristic to detect when the meta* layers and bitbake
are checked out from Yocto Project poky, and use a single
git checkout.

Building without a proper oe-init-build-env is not yet supported.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py             |  35 ++++--
 .../bldcontrol/management/commands/runbuilds.py    |   2 +-
 .../migrations/0006_auto__add_brbitbake.py         | 128 +++++++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |   5 +
 4 files changed, 158 insertions(+), 12 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/migrations/0006_auto__add_brbitbake.py

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 1e58c67..bf9cdf9 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -25,7 +25,7 @@ import sys
 import re
 from django.db import transaction
 from django.db.models import Q
-from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget
+from bldcontrol.models import BuildEnvironment, BRLayer, BRVariable, BRTarget, BRBitbake
 import subprocess
 
 from toastermain import settings
@@ -123,8 +123,10 @@ class BuildEnvironmentController(object):
             self.connection must be none.
         """
 
-    def setLayers(self,ls):
-        """ Sets the layer variables in the config file, after validating local layer paths.
+    def setLayers(self, bbs, ls):
+        """ Checks-out bitbake executor and layers from git repositories.
+            Sets the layer variables in the config file, after validating local layer paths.
+            The bitbakes must be a 1-length list of BRBitbake
             The layer paths must be in a list of BRLayer object
 
             a word of attention: by convention, the first layer for any build will be poky!
@@ -230,15 +232,22 @@ class LocalhostBEController(BuildEnvironmentController):
         self.be.save()
         print "Stopped server"
 
-    def setLayers(self, layers):
+    def setLayers(self, bitbakes, layers):
         """ a word of attention: by convention, the first layer for any build will be poky! """
 
         assert self.be.sourcedir is not None
+        assert len(bitbakes) == 1
         # set layers in the layersource
 
         # 1. get a list of repos, and map dirpaths for each layer
         gitrepos = {}
+        gitrepos[bitbakes[0].giturl] = []
+        gitrepos[bitbakes[0].giturl].append( ("bitbake", bitbakes[0].dirpath, bitbakes[0].commit) )
+        
         for layer in layers:
+            # we don't process local URLs
+            if layer.giturl.startswith("file://"):
+                continue
             if not layer.giturl in gitrepos:
                 gitrepos[layer.giturl] = []
             gitrepos[layer.giturl].append( (layer.name, layer.dirpath, layer.commit))
@@ -250,7 +259,7 @@ class LocalhostBEController(BuildEnvironmentController):
 
         def _getgitdirectoryname(url):
             import re
-            components = re.split(r'[\.\/]', url)
+            components = re.split(r'[:\.\/]', url)
             return components[-2] if components[-1] == "git" else components[-1]
 
         layerlist = []
@@ -258,7 +267,7 @@ class LocalhostBEController(BuildEnvironmentController):
         # 2. checkout the repositories
         for giturl in gitrepos.keys():
             localdirname = os.path.join(self.be.sourcedir, _getgitdirectoryname(giturl))
-            print "DEBUG: giturl checking out in current directory", localdirname
+            print "DEBUG: giturl ", giturl ,"checking out in current directory", localdirname
 
             # make sure our directory is a git repository
             if os.path.exists(localdirname):
@@ -268,11 +277,14 @@ class LocalhostBEController(BuildEnvironmentController):
                 self._shellcmd("git clone \"%s\" \"%s\"" % (giturl, localdirname))
             # checkout the needed commit
             commit = gitrepos[giturl][0][2]
-            self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
-            print "DEBUG: checked out commit ", commit, "to", localdirname
 
-            # if this is the first checkout, take the localdirname as poky dir
-            if self.pokydirname is None:
+            # branch magic name "HEAD" will inhibit checkout
+            if commit != "HEAD":
+                print "DEBUG: checking out commit ", commit, "to", localdirname
+                self._shellcmd("git fetch --all && git checkout \"%s\"" % commit , localdirname)
+
+            # take the localdirname as poky dir if we can find the oe-init-build-env
+            if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
                 print "DEBUG: selected poky dir name", localdirname
                 self.pokydirname = localdirname
 
@@ -282,7 +294,8 @@ class LocalhostBEController(BuildEnvironmentController):
                 if not os.path.exists(localdirpath):
                     raise BuildSetupException("Cannot find layer git path '%s' in checked out repository '%s:%s'. Aborting." % (localdirpath, giturl, commit))
 
-                layerlist.append(localdirpath)
+                if name != "bitbake":
+                    layerlist.append(localdirpath)
 
         print "DEBUG: current layer list ", layerlist
 
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index fa8c1a9..8efe8e6 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -43,7 +43,7 @@ class Command(NoArgsCommand):
 
             # set up the buid environment with the needed layers
             print "Build %s, Environment %s" % (br, bec.be)
-            bec.setLayers(br.brlayer_set.all())
+            bec.setLayers(br.brbitbake_set.all(), br.brlayer_set.all())
 
             # get the bb server running
             bbctrl = bec.getBBController()
diff --git a/lib/toaster/bldcontrol/migrations/0006_auto__add_brbitbake.py b/lib/toaster/bldcontrol/migrations/0006_auto__add_brbitbake.py
new file mode 100644
index 0000000..74388f8
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0006_auto__add_brbitbake.py
@@ -0,0 +1,128 @@
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
+        # Adding model 'BRBitbake'
+        db.create_table(u'bldcontrol_brbitbake', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('req', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['bldcontrol.BuildRequest'], unique=True)),
+            ('giturl', self.gf('django.db.models.fields.CharField')(max_length=254)),
+            ('commit', self.gf('django.db.models.fields.CharField')(max_length=254)),
+            ('dirpath', self.gf('django.db.models.fields.CharField')(max_length=254)),
+        ))
+        db.send_create_signal(u'bldcontrol', ['BRBitbake'])
+
+
+    def backwards(self, orm):
+        # Deleting model 'BRBitbake'
+        db.delete_table(u'bldcontrol_brbitbake')
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
+        u'orm.bitbakeversion': {
+            'Meta': {'object_name': 'BitbakeVersion'},
+            'branch': ('django.db.models.fields.CharField', [], {'max_length': '32'}),
+            'dirpath': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'giturl': ('django.db.models.fields.URLField', [], {'max_length': '200'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
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
+            'bitbake_version': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.BitbakeVersion']"}),
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
index 8c271ff..4c54a59 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -75,6 +75,11 @@ class BRLayer(models.Model):
     commit      = models.CharField(max_length = 254)
     dirpath     = models.CharField(max_length = 254)
 
+class BRBitbake(models.Model):
+    req         = models.ForeignKey(BuildRequest, unique = True)    # only one bitbake for a request
+    giturl      = models.CharField(max_length =254)
+    commit      = models.CharField(max_length = 254)
+    dirpath     = models.CharField(max_length = 254)
 
 class BRVariable(models.Model):
     req         = models.ForeignKey(BuildRequest)
-- 
1.9.1


