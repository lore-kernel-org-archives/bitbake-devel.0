Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 45A8F6B7CA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:27:37 +0000 (UTC)
Received: by mail-pa0-f54.google.com with SMTP id fb1so2866926pad.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3eRRxqZuRRdHLKo70hN2g56COrCtjMV8zVQT/T8n0/o=;
	b=Nxw5OlsAOXSLWpbncds2ondK9yZHvQQm5f8sqTIDh9Ynv1rRKqkeUdaXdg1h7kwVJw
	GDeX/bQ6A40r9rpJXSIPehkrK6ljDmsTV/fJTyzLWpa/UC9KJ6e+HmYIgITEG0Y/MkeF
	arf44fTn8q8pCJusHNfco3k9Berfvdn1tNvi58W/KpjUKeVgnX1G9RiiF9bT1ArbhqBc
	oh3JuJ1M6k55RwyWBZuEuLoF1GeESUxCKPU9V7MXQRNWPgO8xkrlY7dkWsyGevLrHdcF
	/UpCslYZxPtdP3f7lCn0Cx5cc2eoFNLWRPA57TV2JjYQYRtvSbOpSBFJFb3CJkg9vPqt
	X5ZA==
X-Gm-Message-State: ALoCoQk73dqM/Pa4hZN8uahsVNL/nv9WYJUjDHOoTdJ6JLgGElkEPN1H3LVv5XrRli5rD8tqqnSq
X-Received: by 10.66.124.130 with SMTP id mi2mr58324283pab.104.1416500856902; 
	Thu, 20 Nov 2014 08:27:36 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	qd10sm2446808pbc.86.2014.11.20.08.27.33 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:27:35 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 7AE03564116; Thu, 20 Nov 2014 16:27:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:19 +0000
Message-Id: <4357200aed522ad56cfd84917f877645b83b6a70.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
References: <d4a47bc84f762666a847f1152cc2e75c9ef36092.1416500715.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1416500715.git.alexandru.damian@intel.com>
References: <cover.1416500715.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 03/11] toastergui: layer name correlation
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
X-List-Received-Date: Thu, 20 Nov 2014 16:27:38 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch modifies how layers are identified and matched.

Layers were primarely organized by the source of layer information,
and Releases were separated by both layer git branches and originating
source of layer information. This setup prevented mixing layers from
different sources for a certain release, which didn't match the way
people use Yocto Project / bitbake.

This patch brings name-based indentification, where layers with the
same name are assumed to be equivalent, in the sense of being able
to substitute one another. To facilitate this identification to
humans, layers are differentiated by GIT URI instead of layer sources,
which was a rather arbitrary abstraction.

Additional changes include modification to models in order accomodate
for the new data structure, and to config file loading to match
the new toasterconf.json layout.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        |   2 +-
 .../management/commands/checksettings.py           |  47 ++-
 .../bldcontrol/management/commands/loadconf.py     |  29 +-
 ...faultlayer__add_releaselayersourcepriority__.py | 396 +++++++++++++++++++++
 lib/toaster/orm/models.py                          | 115 ++++--
 lib/toaster/orm/tests.py                           |  11 +-
 lib/toaster/toastergui/static/js/projectapp.js     |   2 +
 lib/toaster/toastergui/templates/layers.html       |   6 +-
 lib/toaster/toastergui/templates/project.html      |   4 +-
 lib/toaster/toastergui/views.py                    |  84 +++--
 10 files changed, 599 insertions(+), 97 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0017_auto__del_toastersettingdefaultlayer__add_releaselayersourcepriority__.py

diff --git a/bin/toaster b/bin/toaster
index 75f31d0..7511012 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -126,7 +126,6 @@ function notify_chldexit() {
 }
 
 
-
 # Verify prerequisites
 
 if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (5,6)" | python 2>/dev/null | grep True >/dev/null; then
@@ -139,6 +138,7 @@ if ! echo "import south; print [0,8,4] ==  map(int,south.__version__.split(\".\"
     return 2
 fi
 
+
 # read command line parameters
 
 BBBASEDIR=`dirname ${BASH_SOURCE}`/..
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index 56e4e1b..cd604eb 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -34,6 +34,22 @@ class Command(NoArgsCommand):
                 return ret
         return None
 
+    def _recursive_list_directories(self, startdirectory, level = 0):
+        if level < 0:
+            return []
+        dirs = []
+        try:
+            for i in os.listdir(startdirectory):
+                j = os.path.join(startdirectory, i)
+                if os.path.isdir(j):
+                    dirs.append(j)
+        except OSError:
+            pass
+        for j in dirs:
+                dirs = dirs + self._recursive_list_directories(j, level - 1)
+        return dirs
+
+
     def _get_suggested_sourcedir(self, be):
         if be.betype != BuildEnvironment.TYPE_LOCAL:
             return ""
@@ -67,7 +83,6 @@ class Command(NoArgsCommand):
                 print("Verifying the Build Environment type %s id %d." % (be.get_betype_display(), be.pk))
                 if len(be.sourcedir) == 0:
                     suggesteddir = self._get_suggested_sourcedir(be)
-                    homesourcedir = suggesteddir
                     be.sourcedir = raw_input(" -- Layer sources checkout directory may not be empty [guessed \"%s\"]:" % suggesteddir)
                     if len(be.sourcedir) == 0 and len(suggesteddir) > 0:
                         be.sourcedir = suggesteddir
@@ -94,17 +109,25 @@ class Command(NoArgsCommand):
                     be.save()
 
                 if is_changed and be.betype == BuildEnvironment.TYPE_LOCAL:
-                    baselayerdir = DN(DN(self._find_first_path_for_file(homesourcedir, "toasterconf.json", 3)))
-                    if baselayerdir:
-                        i = raw_input(" -- Do you want to import basic layer configuration from \"%s\" ? (y/N):" % baselayerdir)
-                        if len(i) and i.upper()[0] == 'Y':
-                            from loadconf import Command as LoadConfigCommand
-                            LoadConfigCommand()._import_layer_config(os.path.join(baselayerdir, "meta/conf/toasterconf.json"))
-                            # we run lsupdates after config update
-                            print "Updating information from the layer source, please wait."
-                            from django.core.management import call_command
-                            call_command("lsupdates")
-                        pass
+                    for dirname in self._recursive_list_directories(be.sourcedir,2):
+                        if os.path.exists(os.path.join(dirname, ".templateconf")):
+                            import subprocess
+                            conffilepath, error = subprocess.Popen('bash -c ". '+os.path.join(dirname, ".templateconf")+'; echo \"\$TEMPLATECONF\""', shell=True, stdout=subprocess.PIPE).communicate()
+                            conffilepath = os.path.join(conffilepath.strip(), "toasterconf.json")
+                            candidatefilepath = os.path.join(dirname, conffilepath)
+                            if os.path.exists(candidatefilepath):
+                                i = raw_input(" -- Do you want to import basic layer configuration from \"%s\" ? (y/N):" % candidatefilepath)
+                                if len(i) and i.upper()[0] == 'Y':
+                                    from loadconf import Command as LoadConfigCommand
+
+                                    LoadConfigCommand()._import_layer_config(candidatefilepath)
+                                    # we run lsupdates after config update
+                                    print "Layer configuration imported. Updating information from the layer source, please wait."
+                                    from django.core.management import call_command
+                                    call_command("lsupdates")
+
+                                    # we don't look for any other config files
+                                    return is_changed
 
                 return is_changed
 
diff --git a/lib/toaster/bldcontrol/management/commands/loadconf.py b/lib/toaster/bldcontrol/management/commands/loadconf.py
index c9af487..6e1f97a 100644
--- a/lib/toaster/bldcontrol/management/commands/loadconf.py
+++ b/lib/toaster/bldcontrol/management/commands/loadconf.py
@@ -1,6 +1,6 @@
 from django.core.management.base import BaseCommand, CommandError
 from orm.models import LayerSource, ToasterSetting, Branch, Layer, Layer_Version
-from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer
+from orm.models import BitbakeVersion, Release, ReleaseDefaultLayer, ReleaseLayerSourcePriority
 import os
 
 from checksettings import DN
@@ -71,17 +71,23 @@ class Command(BaseCommand):
             assert 'name' in lsi
             assert 'branches' in lsi
 
-            if lsi['sourcetype'] == LayerSource.TYPE_LAYERINDEX or lsi['apiurl'].startswith("/"):
+            def _get_id_for_sourcetype(s):
+                for i in LayerSource.SOURCE_TYPE:
+                    if s == i[1]:
+                        return i[0]
+                raise Exception("Could not find definition for sourcetype " + s)
+
+            if _get_id_for_sourcetype(lsi['sourcetype']) == LayerSource.TYPE_LAYERINDEX or lsi['apiurl'].startswith("/"):
                 apiurl = lsi['apiurl']
             else:
                 apiurl = self._reduce_canon_path(os.path.join(DN(filepath), lsi['apiurl']))
 
             try:
-                ls = LayerSource.objects.get(sourcetype = lsi['sourcetype'], apiurl = apiurl)
+                ls = LayerSource.objects.get(sourcetype = _get_id_for_sourcetype(lsi['sourcetype']), apiurl = apiurl)
             except LayerSource.DoesNotExist:
                 ls = LayerSource.objects.create(
                     name = lsi['name'],
-                    sourcetype = lsi['sourcetype'],
+                    sourcetype = _get_id_for_sourcetype(lsi['sourcetype']),
                     apiurl = apiurl
                 )
 
@@ -121,17 +127,20 @@ class Command(BaseCommand):
             bvo = BitbakeVersion.objects.get(name = ri['bitbake'])
             assert bvo is not None
 
-            ro, created = Release.objects.get_or_create(name = ri['name'], bitbake_version = bvo, branch = Branch.objects.get( layer_source__name = ri['layersource'], name=ri['branch']))
+            ro, created = Release.objects.get_or_create(name = ri['name'], bitbake_version = bvo, branch_name = ri['branch'])
             ro.description = ri['description']
             ro.helptext = ri['helptext']
             ro.save()
 
+            # save layer source priority for release
+            for ls_name in ri['layersourcepriority'].keys():
+                rlspo, created = ReleaseLayerSourcePriority.objects.get_or_create(release = ro, layer_source = LayerSource.objects.get(name=ls_name))
+                rlspo.priority = ri['layersourcepriority'][ls_name]
+                rlspo.save()
+
             for dli in ri['defaultlayers']:
-                layer, created = Layer.objects.get_or_create(
-                        layer_source = LayerSource.objects.get(name = ri['layersource']),
-                        name = dli
-                    )
-                ReleaseDefaultLayer.objects.get_or_create( release = ro, layer = layer)
+                # find layers with the same name
+                ReleaseDefaultLayer.objects.get_or_create( release = ro, layer_name = dli)
 
         # set default release
         if ToasterSetting.objects.filter(name = "DEFAULT_RELEASE").count() > 0:
diff --git a/lib/toaster/orm/migrations/0017_auto__del_toastersettingdefaultlayer__add_releaselayersourcepriority__.py b/lib/toaster/orm/migrations/0017_auto__del_toastersettingdefaultlayer__add_releaselayersourcepriority__.py
new file mode 100644
index 0000000..6685b55
--- /dev/null
+++ b/lib/toaster/orm/migrations/0017_auto__del_toastersettingdefaultlayer__add_releaselayersourcepriority__.py
@@ -0,0 +1,396 @@
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
+        # Deleting model 'ToasterSettingDefaultLayer'
+        db.delete_table(u'orm_toastersettingdefaultlayer')
+
+        # Adding model 'ReleaseLayerSourcePriority'
+        db.create_table(u'orm_releaselayersourcepriority', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('release', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Release'])),
+            ('layer_source', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.LayerSource'])),
+            ('priority', self.gf('django.db.models.fields.IntegerField')(default=0)),
+        ))
+        db.send_create_signal(u'orm', ['ReleaseLayerSourcePriority'])
+
+        # Adding unique constraint on 'ReleaseLayerSourcePriority', fields ['release', 'layer_source']
+        db.create_unique(u'orm_releaselayersourcepriority', ['release_id', 'layer_source_id'])
+
+        # Deleting field 'Release.branch'
+        db.delete_column(u'orm_release', 'branch_id')
+
+        # Adding field 'Release.branch_name'
+        db.add_column(u'orm_release', 'branch_name',
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=50),
+                      keep_default=False)
+
+        # Adding unique constraint on 'LayerSource', fields ['name']
+        db.create_unique(u'orm_layersource', ['name'])
+
+        # Deleting field 'ReleaseDefaultLayer.layer'
+        db.delete_column(u'orm_releasedefaultlayer', 'layer_id')
+
+        # Adding field 'ReleaseDefaultLayer.layer_name'
+        db.add_column(u'orm_releasedefaultlayer', 'layer_name',
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=100),
+                      keep_default=False)
+
+
+    def backwards(self, orm):
+        # Removing unique constraint on 'LayerSource', fields ['name']
+        db.delete_unique(u'orm_layersource', ['name'])
+
+        # Removing unique constraint on 'ReleaseLayerSourcePriority', fields ['release', 'layer_source']
+        db.delete_unique(u'orm_releaselayersourcepriority', ['release_id', 'layer_source_id'])
+
+        # Adding model 'ToasterSettingDefaultLayer'
+        db.create_table(u'orm_toastersettingdefaultlayer', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('layer_version', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer_Version'])),
+        ))
+        db.send_create_signal(u'orm', ['ToasterSettingDefaultLayer'])
+
+        # Deleting model 'ReleaseLayerSourcePriority'
+        db.delete_table(u'orm_releaselayersourcepriority')
+
+
+        # User chose to not deal with backwards NULL issues for 'Release.branch'
+        raise RuntimeError("Cannot reverse this migration. 'Release.branch' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'Release.branch'
+        db.add_column(u'orm_release', 'branch',
+                      self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Branch']),
+                      keep_default=False)
+
+        # Deleting field 'Release.branch_name'
+        db.delete_column(u'orm_release', 'branch_name')
+
+
+        # User chose to not deal with backwards NULL issues for 'ReleaseDefaultLayer.layer'
+        raise RuntimeError("Cannot reverse this migration. 'ReleaseDefaultLayer.layer' and its values cannot be restored.")
+        
+        # The following code is provided here to aid in writing a correct migration        # Adding field 'ReleaseDefaultLayer.layer'
+        db.add_column(u'orm_releasedefaultlayer', 'layer',
+                      self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Layer']),
+                      keep_default=False)
+
+        # Deleting field 'ReleaseDefaultLayer.layer_name'
+        db.delete_column(u'orm_releasedefaultlayer', 'layer_name')
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
+            'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
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
+            'summary': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
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
+            'Meta': {'unique_together': "(('project', 'layercommit'),)", 'object_name': 'ProjectLayer'},
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
+            'Meta': {'unique_together': "(('layer_version', 'file_path'),)", 'object_name': 'Recipe'},
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
+            'summary': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
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
+            'branch_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50'}),
+            'description': ('django.db.models.fields.CharField', [], {'max_length': '255'}),
+            'helptext': ('django.db.models.fields.TextField', [], {'null': 'True'}),
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '32'})
+        },
+        u'orm.releasedefaultlayer': {
+            'Meta': {'object_name': 'ReleaseDefaultLayer'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_name': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '100'}),
+            'release': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.Release']"})
+        },
+        u'orm.releaselayersourcepriority': {
+            'Meta': {'unique_together': "(('release', 'layer_source'),)", 'object_name': 'ReleaseLayerSourcePriority'},
+            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
+            'layer_source': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['orm.LayerSource']"}),
+            'priority': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
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
index d99a4c2..c90e047 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -21,7 +21,6 @@
 
 from django.db import models
 from django.db.models import F
-from django.utils.encoding import python_2_unicode_compatible
 from django.utils import timezone
 
 
@@ -54,9 +53,6 @@ class ToasterSetting(models.Model):
     def __unicode__(self):
         return "Setting %s" % self.name
 
-class ToasterSettingDefaultLayer(models.Model):
-    layer_version = models.ForeignKey('Layer_Version')
-
 class ProjectManager(models.Manager):
     def create_project(self, name, release):
         prj = self.model(name = name, bitbake_version = release.bitbake_version, release = release)
@@ -68,10 +64,10 @@ class ProjectManager(models.Manager):
                 name = name,
                 value = defaultconf.value)
 
-        for layer in map(lambda x: x.layer, ReleaseDefaultLayer.objects.filter(release = release)):
-            for branches in Branch.objects.filter(name = release.branch):
-                for lv in Layer_Version.objects.filter(layer = layer, up_branch = branches ):
-                    ProjectLayer.objects.create( project = prj,
+
+        for rdl in release.releasedefaultlayer_set.all():
+            lv = Layer_Version.objects.filter(layer__name = rdl.layer_name, up_branch__name = release.branch_name)[0].get_equivalents_wpriority(prj)[0]
+            ProjectLayer.objects.create( project = prj,
                         layercommit = lv,
                         optional = False )
 
@@ -84,6 +80,7 @@ class ProjectManager(models.Manager):
         raise Exception("Invalid call to Project.objects.get_or_create. Use Project.objects.create_project() to create a project")
 
 class Project(models.Model):
+    search_allowed_fields = ['name', 'short_description', 'release__name', 'release__branch_name']
     name = models.CharField(max_length=100)
     short_description = models.CharField(max_length=50, blank=True)
     bitbake_version = models.ForeignKey('BitbakeVersion')
@@ -97,6 +94,8 @@ class Project(models.Model):
     user_id     = models.IntegerField(null = True)
     objects     = ProjectManager()
 
+    def __unicode__(self):
+        return "%s (%s, %s)" % (self.name, self.release, self.bitbake_version)
 
     def schedule_build(self):
         from bldcontrol.models import BuildRequest, BRTarget, BRLayer, BRVariable, BRBitbake
@@ -184,7 +183,6 @@ class ProjectTarget(models.Model):
     target = models.CharField(max_length=100)
     task = models.CharField(max_length=100, null=True)
 
-@python_2_unicode_compatible
 class Target(models.Model):
     search_allowed_fields = ['target', 'file_name']
     build = models.ForeignKey(Build)
@@ -196,7 +194,7 @@ class Target(models.Model):
     def package_count(self):
         return Target_Installed_Package.objects.filter(target_id__exact=self.id).count()
 
-    def __str__(self):
+    def __unicode__(self):
         return self.target
 
 class Target_Image_File(models.Model):
@@ -391,10 +389,10 @@ class Package_Dependency(models.Model):
         (TYPE_RREPLACES, "replaces"),
         (TYPE_RCONFLICTS, "conflicts"),
     )
-    ''' Indexed by dep_type, in view order, key for short name and help
+    """ Indexed by dep_type, in view order, key for short name and help
         description which when viewed will be printf'd with the
         package name.
-    '''
+    """
     DEPENDS_DICT = {
         TYPE_RDEPENDS :     ("depends", "%s is required to run %s"),
         TYPE_TRDEPENDS :    ("depends", "%s is required to run %s"),
@@ -509,33 +507,47 @@ class LayerSource(models.Model):
 
     TYPE_LOCAL = 0
     TYPE_LAYERINDEX = 1
+    TYPE_IMPORTED = 2
     SOURCE_TYPE = (
         (TYPE_LOCAL, "local"),
         (TYPE_LAYERINDEX, "layerindex"),
+        (TYPE_IMPORTED, "imported"),
       )
 
-    name = models.CharField(max_length=63)
+    name = models.CharField(max_length=63, unique = True)
     sourcetype = models.IntegerField(choices=SOURCE_TYPE)
     apiurl = models.CharField(max_length=255, null=True, default=None)
 
+    def update(self):
+        """
+            Updates the local database information from the upstream layer source
+        """
+        raise Exception("Abstract, update() must be implemented by all LayerSource-derived classes (object is %s)" % str(vars(self)))
+
     def save(self, *args, **kwargs):
         if isinstance(self, LocalLayerSource):
             self.sourcetype = LayerSource.TYPE_LOCAL
         elif isinstance(self, LayerIndexLayerSource):
             self.sourcetype = LayerSource.TYPE_LAYERINDEX
+        elif isinstance(self, ImportedLayerSource):
+            self.sourcetype = LayerSource.TYPE_IMPORTED
         elif self.sourcetype == None:
-            raise Exception("Invalid LayerSource type")
+            raise Exception("Unknown LayerSource-derived class. If you added a new layer source type, fill out all code stubs.")
         return super(LayerSource, self).save(*args, **kwargs)
 
     def get_object(self):
-        if self.sourcetype is not None:
-            if self.sourcetype == LayerSource.TYPE_LOCAL:
-                self.__class__ = LocalLayerSource
-            if self.sourcetype == LayerSource.TYPE_LAYERINDEX:
-                self.__class__ = LayerIndexLayerSource
+        if self.sourcetype == LayerSource.TYPE_LOCAL:
+            self.__class__ = LocalLayerSource
+        elif self.sourcetype == LayerSource.TYPE_LAYERINDEX:
+            self.__class__ = LayerIndexLayerSource
+        elif self.sourcetype == LayerSource.TYPE_IMPORTED:
+            self.__class__ = ImportedLayerSource
+        else:
+            raise Exception("Unknown LayerSource type. If you added a new layer source type, fill out all code stubs.")
         return self
 
-        return "LS " + self.sourcetype + " " + self.name
+    def __unicode__(self):
+        return "%s (%s)" % (self.name, self.sourcetype)
 
 
 class LocalLayerSource(LayerSource):
@@ -547,11 +559,26 @@ class LocalLayerSource(LayerSource):
         self.sourcetype = LayerSource.TYPE_LOCAL
 
     def update(self):
-        '''
+        """
+            Fetches layer, recipe and machine information from local repository
+        """
+        pass
+
+class ImportedLayerSource(LayerSource):
+    class Meta(LayerSource._meta.__class__):
+        proxy = True
+
+    def __init__(self, *args, **kwargs):
+        super(ImportedLayerSource, self).__init__(args, kwargs)
+        self.sourcetype = LayerSource.TYPE_IMPORTED
+
+    def update(self):
+        """
             Fetches layer, recipe and machine information from local repository
-        '''
+        """
         pass
 
+
 class LayerIndexLayerSource(LayerSource):
     class Meta(LayerSource._meta.__class__):
         proxy = True
@@ -566,9 +593,9 @@ class LayerIndexLayerSource(LayerSource):
         return self.apiurl + "../branch/" + branch.name + "/" + objectype + "/?q=" + str(upid)
 
     def update(self):
-        '''
+        """
             Fetches layer, recipe and machine information from remote repository
-        '''
+        """
         assert self.apiurl is not None
         from django.db import IntegrityError
 
@@ -601,7 +628,7 @@ class LayerIndexLayerSource(LayerSource):
             return
 
         # update branches; only those that we already have names listed in the Releases table
-        whitelist_branch_names = map(lambda x: x.branch.name, Release.objects.all())
+        whitelist_branch_names = map(lambda x: x.branch_name, Release.objects.all())
 
         branches_info = _get_json_response(apilinks['branches']
             + "?filter=name:%s" % "OR".join(whitelist_branch_names))
@@ -713,16 +740,31 @@ class BitbakeVersion(models.Model):
 
 
 class Release(models.Model):
+    """ A release is a project template, used to pre-populate Project settings with a configuration set """
     name = models.CharField(max_length=32, unique = True)
     description = models.CharField(max_length=255)
     bitbake_version = models.ForeignKey(BitbakeVersion)
-    branch = models.ForeignKey('Branch')
+    branch_name = models.CharField(max_length=50, default = "")
     helptext = models.TextField(null=True)
 
+    def __unicode__(self):
+        return "%s (%s)" % (self.name, self.branch_name)
+
+class ReleaseLayerSourcePriority(models.Model):
+    """ Each release selects layers from the set up layer sources, ordered by priority """
+    release = models.ForeignKey("Release")
+    layer_source = models.ForeignKey("LayerSource")
+    priority = models.IntegerField(default = 0)
+
+    def __unicode__(self):
+        return "%s-%s:%d" % (self.release.name, self.layer_source.name, self.priority)
+    class Meta:
+        unique_together = (('release', 'layer_source'),)
+
 
 class ReleaseDefaultLayer(models.Model):
     release = models.ForeignKey(Release)
-    layer = models.ForeignKey('Layer')
+    layer_name = models.CharField(max_length=100, default="")
 
 
 # Branch class is synced with layerindex.Branch, branches can only come from remote layer indexes
@@ -760,7 +802,7 @@ class Layer(models.Model):
     description = models.TextField(null = True, default = None)
 
     def __unicode__(self):
-        return "L " + self.name
+        return "%s / %s " % (self.name, self.layer_source)
 
     class Meta:
         unique_together = (("layer_source", "up_id"), ("layer_source", "name"))
@@ -831,9 +873,21 @@ class Layer_Version(models.Model):
             return None
         return self._handle_url_path(self.layer.vcs_web_tree_base_url, '')
 
+    def get_equivalents_wpriority(self, project):
+        """ Returns an ordered layerversion list that satisfies a LayerVersionDependency using the layer name and the current Project Releases' LayerSource priority """
+        def _get_ls_priority(ls):
+            try:
+                return ls.releaselayersourcepriority_set.get(release=project.release).priority
+            except ReleaseLayerSourcePriority.DoesNotExist:
+                raise
+        return sorted(
+                Layer_Version.objects.filter( layer__name = self.layer.name, up_branch__name = self.up_branch.name ),
+                key = lambda x: _get_ls_priority(x.layer_source),
+                reverse = False)
+
 
     def __unicode__(self):
-        return "LV " + str(self.layer) + " " + self.commit
+        return  str(self.layer) + " (" + self.commit +")"
 
     class Meta:
         unique_together = ("layer_source", "up_id")
@@ -853,6 +907,9 @@ class ProjectLayer(models.Model):
     layercommit = models.ForeignKey(Layer_Version, null=True)
     optional = models.BooleanField(default = True)
 
+    def __unicode__(self):
+        return "%s, %s" % (self.project.name, self.layercommit)
+
     class Meta:
         unique_together = (("project", "layercommit"),)
 
diff --git a/lib/toaster/orm/tests.py b/lib/toaster/orm/tests.py
index f2f561b..b965d8e 100644
--- a/lib/toaster/orm/tests.py
+++ b/lib/toaster/orm/tests.py
@@ -1,16 +1,19 @@
 from django.test import TestCase
-from orm.models import LocalLayerSource, LayerIndexLayerSource, LayerSource
+from orm.models import LocalLayerSource, LayerIndexLayerSource, ImportedLayerSource, LayerSource
 from orm.models import Branch
 
 class LayerSourceVerifyInheritanceSaveLoad(TestCase):
     def test_object_creation(self):
         lls = LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
-        lils = LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "")
+        lils = LayerSource.objects.create(name = "a2", sourcetype = LayerSource.TYPE_LAYERINDEX, apiurl = "")
+        imls = LayerSource.objects.create(name = "a3", sourcetype = LayerSource.TYPE_IMPORTED, apiurl = "")
 
-        print LayerSource.objects.all()
+        import pprint
+        pprint.pprint([(x.__class__,vars(x)) for x in LayerSource.objects.all()])
 
         self.assertTrue(True in map(lambda x: isinstance(x, LocalLayerSource), LayerSource.objects.all()))
         self.assertTrue(True in map(lambda x: isinstance(x, LayerIndexLayerSource), LayerSource.objects.all()))
+        self.assertTrue(True in map(lambda x: isinstance(x, ImportedLayerSource), LayerSource.objects.all()))
 
     def test_duplicate_error(self):
         def duplicate():
@@ -18,7 +21,7 @@ class LayerSourceVerifyInheritanceSaveLoad(TestCase):
             LayerSource.objects.create(name = "a1", sourcetype = LayerSource.TYPE_LOCAL, apiurl = "")
 
         self.assertRaises(Exception, duplicate)
-            
+
 
 
 class LILSUpdateTestCase(TestCase):
diff --git a/lib/toaster/toastergui/static/js/projectapp.js b/lib/toaster/toastergui/static/js/projectapp.js
index 9f9a064..e9b07c7 100644
--- a/lib/toaster/toastergui/static/js/projectapp.js
+++ b/lib/toaster/toastergui/static/js/projectapp.js
@@ -173,6 +173,8 @@ projectApp.controller('prjCtrl', function($scope, $modal, $http, $interval, $loc
             if (_data.error != "ok") {
                 alert("Failed XHR request (" + _status + "): " + _data.error);
                 console.error("Failed XHR request: ", _data, _status, _headers, _config);
+                // stop refreshing hte page
+                $interval.cancel($scope.pollHandle);
                 deffered.reject(_data.error);
             }
             else {
diff --git a/lib/toaster/toastergui/templates/layers.html b/lib/toaster/toastergui/templates/layers.html
index 8cb079d..2bca84b 100644
--- a/lib/toaster/toastergui/templates/layers.html
+++ b/lib/toaster/toastergui/templates/layers.html
@@ -9,9 +9,9 @@
 {% block projectinfomain %}
                 <div class="page-header">
                     <h1>
-  {% if request.GET.filter and objects.paginator.count >  0 or request.GET.search and objects.paginator.count >  0 %}
-      {{objects.paginator.count}} layer{{objects.paginator.count|pluralize}} found
-  {% elif request.GET.filter and objects.paginator.count ==  0 or request.GET.search and objects.paginator.count == 0 %}
+  {% if request.GET.filter and total_count >  0 or request.GET.search and total_count >  0 %}
+      {{total_count}} layer{{total_count|pluralize}} found
+  {% elif request.GET.filter and total_count ==  0 or request.GET.search and total_count == 0 %}
       No layers found
   {%else%}
       All layers
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 4e8a7e2..e1ef824 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -236,9 +236,9 @@ vim: expandtab tabstop=2
       <p><a href="{% url 'layers' %}">View all layers</a> | <a href="{% url 'importlayer' %}">Import layer</a></p>
       <ul class="unstyled configuration-list">
           <li ng-repeat="l in layers track by l.id" class="animate-repeat">
-            <a href="{[l.layerdetailurl]}" target="_#" class="layer-info" data-toggle="tooltip" tooltip="{[l.branch.layersource]} | {[l.branch.name]}">{[l.name]} </a>
+            <a href="{[l.layerdetailurl]}" target="_#" class="layer-info" data-toggle="tooltip" tooltip="{[l.giturl]} | {[l.branch.name]}">{[l.name]}</a>
             <i class="icon-trash" ng-click="layerDel(l.id)" tooltip="Delete"></i>
-          </li>
+                      </li>
       </ul>
     </div>
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 5e92c24..1b4bb9f 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1881,7 +1881,10 @@ if toastermain.settings.MANAGED:
             "MANAGED" : toastermain.settings.MANAGED
         }
         if 'project_id' in request.session:
-            ret['project'] = Project.objects.get(pk = request.session['project_id'])
+            try:
+                ret['project'] = Project.objects.get(pk = request.session['project_id'])
+            except Project.DoesNotExist:
+                del request.session['project_id']
         return ret
 
     # new project
@@ -1989,6 +1992,7 @@ if toastermain.settings.MANAGED:
                         "id": x.layercommit.pk,
                         "orderid": x.pk,
                         "name" : x.layercommit.layer.name,
+                        "giturl": x.layercommit.layer.vcs_url,
                         "url": x.layercommit.layer.layer_index_url,
                         "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)),
                         "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}},
@@ -2053,6 +2057,9 @@ if toastermain.settings.MANAGED:
         except Exception as e:
             return HttpResponse(jsonfilter({"error":str(e) + "\n" + traceback.format_exc()}), content_type = "application/json")
 
+
+
+
     def xhr_projectedit(request, pid):
         try:
             prj = Project.objects.get(id = pid)
@@ -2078,11 +2085,14 @@ if toastermain.settings.MANAGED:
                 # we need to change the layers
                 for i in prj.projectlayer_set.all():
                     # find and add a similarly-named layer on the new branch
-                    lv = Layer_Version.objects.filter(layer__name = i.layercommit.layer.name, up_branch__release = prj.release)
-                    if lv.count() == 1:
-                        ProjectLayer.objects.get_or_create(project = prj, layercommit = lv[0])
-                    # get rid of the old entry
-                    i.delete()
+                    try:
+                        lv = Layer_Version.objects.filter(layer__name = i.layercommit.layer.name, up_branch__name = prj.release.branch_name)[0].get_equivalents_wpriority(prj)[0]
+                        ProjectLayer.objects.get_or_create(project = prj, layercommit = lv)
+                    except IndexError:
+                        pass
+                    finally:
+                        # get rid of the old entry
+                        i.delete()
 
             if 'machineName' in request.POST:
                 machinevar = prj.projectvariable_set.get(name="MACHINE")
@@ -2092,7 +2102,7 @@ if toastermain.settings.MANAGED:
             # return all project settings
             return HttpResponse(jsonfilter( {
                 "error": "ok",
-                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().order_by("id")),
+                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().order_by("id")),
                 "builds" : _project_recent_build_list(prj),
                 "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
                 "machine": {"name": prj.projectvariable_set.get(name="MACHINE").value},
@@ -2107,45 +2117,46 @@ if toastermain.settings.MANAGED:
     @csrf_exempt
     def xhr_datatypeahead(request):
         try:
+            prj = None
+            if 'project_id' in request.session:
+                prj = Project.objects.get(pk = request.session['project_id'])
+
             # returns layers for current project release that are not in the project set
             if request.GET['type'] == "layers":
-                queryset_all = Layer_Version.objects.all()
-                if 'project_id' in request.session:
-                    prj = Project.objects.get(pk = request.session['project_id'])
-                    queryset_all = queryset_all.filter(up_branch__release = prj.release).exclude(pk__in = map(lambda x: x.layercommit_id, prj.projectlayer_set.all()))
-                queryset_all = queryset_all.filter(layer__name__icontains=request.GET.get('value',''))
+                queryset_all = Layer_Version.objects.filter(layer__name__icontains=request.GET.get('value',''))
+                queryset_all = queryset_all.filter(up_branch__name= prj.release.branch_name).exclude(pk__in = [x.id for x in reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all()))])
+
+                queryset_all = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all[:8]])
+
                 return HttpResponse(jsonfilter( { "error":"ok",
-                    "list" : map( lambda x: {"id": x.pk, "name": x.layer.name, "detail": "(" + x.layer.layer_source.name + (")" if x.up_branch == None else " | "+x.up_branch.name+")")},
-                            queryset_all[:8])
+                    "list" : map( lambda x: {"id": x.pk, "name": "%s" % (x.layer.name, ), "detail": "(" + x.layer.vcs_url + (")" if x.up_branch == None else " | "+x.up_branch.name+")")},
+                            queryset_all)
                     }), content_type = "application/json")
 
+
             # returns layer dependencies for a layer, excluding current project layers
             if request.GET['type'] == "layerdeps":
                 queryset_all = LayerVersionDependency.objects.filter(layer_version_id = request.GET['value'])
-
-                if 'project_id' in request.session:
-                    prj = Project.objects.get(pk = request.session['project_id'])
-                    queryset_all = queryset_all.exclude(depends_on__in = map(lambda x: x.layercommit, prj.projectlayer_set.all()))
-
+                queryset_all = queryset_all.exclude(depends_on__in = reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), prj.projectlayer_set.all())))
                 queryset_all.order_by("-up_id");
 
                 return HttpResponse(jsonfilter( { "error":"ok",
                     "list" : map(
                         lambda x: {"id": x.pk, "name": x.layer.name, "detail": "(" + x.layer.layer_source.name + (")" if x.up_branch == None else " | "+x.up_branch.name+")"),
-                                   "layerdetailurl" : reverse('layerdetails', args=(x.pk,))},
-                        map(lambda x: x.depends_on, queryset_all))
+                                   "giturl": x.layer.vcs_url, "layerdetailurl" : reverse('layerdetails', args=(x.pk,))},
+                        map(lambda x: x.depends_on.get_equivalents_wpriority(prj)[0], queryset_all))
                     }), content_type = "application/json")
 
+
             # returns layer versions that would be deleted on the new release__pk
             if request.GET['type'] == "versionlayers":
                 if not 'project_id' in request.session:
                     raise Exception("This call cannot makes no sense outside a project context")
 
                 retval = []
-                prj = Project.objects.get(pk = request.session['project_id'])
                 for i in prj.projectlayer_set.all():
-                    lv = Layer_Version.objects.filter(layer__name = i.layercommit.layer.name, up_branch__release__pk=request.GET['value'])
-                    if lv.count() != 1:     # there is no layer_version with the new release id, and the same name
+                    lv = Layer_Version.objects.filter(layer__name = i.layercommit.layer.name, up_branch__name = Release.objects.get(pk=request.GET['value']).branch_name)
+                    if lv.count() < 1:     # there is no layer_version with the new release id, and the same name
                         retval.append(i)
 
                 return HttpResponse(jsonfilter( {"error":"ok",
@@ -2153,11 +2164,11 @@ if toastermain.settings.MANAGED:
                         lambda x: {"id": x.layercommit.pk, "name": x.layercommit.layer.name, "detail": "(" + x.layercommit.layer.layer_source.name + (")" if x.layercommit.up_branch == None else " | "+x.layercommit.up_branch.name+")")},
                         retval) }), content_type = "application/json")
 
+
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
                 queryset_all = Recipe.objects.all()
-                if 'project_id' in request.session:
-                    queryset_all = queryset_all.filter(layer_version__layer__in = map(lambda x: x.layercommit.layer, ProjectLayer.objects.filter(project_id=request.session['project_id'])))
+                queryset_all = queryset_all.filter(layer_version__in = reduce(lambda x, y: list(x) + list(y), map(lambda x: x.layercommit.get_equivalents_wpriority(prj), ProjectLayer.objects.filter(project = prj))))
                 return HttpResponse(jsonfilter({ "error":"ok",
                     "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
                         queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
@@ -2208,13 +2219,14 @@ if toastermain.settings.MANAGED:
         queryset_all = Layer_Version.objects.all()
 
         prj = Project.objects.get(pk = request.session['project_id'])
-        queryset_all = queryset_all.filter(up_branch__release = prj.release)
+        queryset_all = queryset_all.filter(up_branch__name = prj.release.branch_name)
 
-        queryset_with_search = _get_queryset(Layer_Version, queryset_all, None, search_term, ordering_string, '-layer__name')
-        queryset = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
+        queryset_all = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
+
+        objects_all= list(set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all[:pagesize]]))
 
         # retrieve the objects that will be displayed in the table; layers a paginator and gets a page range to display
-        layer_info = _build_page_range(Paginator(queryset, request.GET.get('count', 10)),request.GET.get('page', 1))
+        layer_info = _build_page_range(Paginator(objects_all, request.GET.get('count', 10)),request.GET.get('page', 1))
 
 
         context = {
@@ -2222,7 +2234,7 @@ if toastermain.settings.MANAGED:
             'objects' : layer_info,
             'objectname' : "layers",
             'default_orderby' : 'layer__name:+',
-            'total_count': queryset_with_search.count(),
+            'total_count': queryset_all.count(),
 
             'tablecols' : [
                 {   'name': 'Layer',
@@ -2241,7 +2253,7 @@ if toastermain.settings.MANAGED:
                     'filter': {
                         'class': 'layer',
                         'label': 'Show:',
-                        'options': map(lambda x: (x.name + " layers", 'layer_source__pk:' + str(x.id), queryset_with_search.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
+                        'options': map(lambda x: (x.name + " layers", 'layer_source__pk:' + str(x.id), queryset_all.filter(layer_source__pk = x.id).count() ), LayerSource.objects.all()),
                     }
                 },
                 {   'name': 'Git repository URL',
@@ -2269,8 +2281,8 @@ if toastermain.settings.MANAGED:
                         'class': 'add-del-layers',
                         'label': 'Show:',
                         'options': [
-              ('Layers added to this project', "projectlayer__project:" + str(prj.id), queryset_with_search.filter(projectlayer__project = prj.id).count()),
-              ('Layers not added to this project', "projectlayer__project:NOT" + str(prj.id), queryset_with_search.exclude(projectlayer__project = prj.id).count()),
+              ('Layers added to this project', "projectlayer__project:" + str(prj.id), queryset_all.filter(projectlayer__project = prj.id).count()),
+              ('Layers not added to this project', "projectlayer__project:NOT" + str(prj.id), queryset_all.exclude(projectlayer__project = prj.id).count()),
                                    ]
 
                     }
@@ -2300,7 +2312,7 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
 
         prj = Project.objects.get(pk = request.session['project_id'])
-        queryset_all = Recipe.objects.filter(Q(layer_version__up_branch__release = prj.release) | Q(layer_version__build__in = prj.build_set.all()))
+        queryset_all = Recipe.objects.filter(Q(layer_version__up_branch__name= prj.release.name) | Q(layer_version__build__in = prj.build_set.all()))
 
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
 
@@ -2404,7 +2416,7 @@ if toastermain.settings.MANAGED:
 
         queryset_all = Machine.objects.all()
 #        if 'project_id' in request.session:
-#            queryset_all = queryset_all.filter(Q(layer_version__up_branch__release = Project.objects.get(request.session['project_id']).release) | Q(layer_version__build__in = Project.objects.get(request.session['project_id']).build_set.all()))
+#            queryset_all = queryset_all.filter(Q(layer_version__up_branch__name = Project.objects.get(request.session['project_id']).release.branch_name) | Q(layer_version__build__in = Project.objects.get(request.session['project_id']).build_set.all()))
 
         queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
         queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
-- 
1.9.1


