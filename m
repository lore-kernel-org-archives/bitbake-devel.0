Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 7AAB17061F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:15:04 +0000 (UTC)
Received: by mail-wi0-f176.google.com with SMTP id bs8so754358wib.15
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IiA8DZl+Ec3cc3EHteUVZYektgyOcl/SyYl3LlmT9ps=;
	b=RktAIq0ElwyVJa10SnpA85HOp9w2fnjyCddMt6ouaPsNmNaTuV4XHwYbVrN/4s0uig
	ryAGJ14lNYKvpnim6SxTsz3dsL7buSo1tZj9bfhzkqSmT2WCd54MzLmkoijQvw0y3tRk
	szM8gedZJ7yqmFUOn5fEbogdyM9OcofjDegDLHVvhjTuRBNP/KCh3pfgDEe72QZ6Op6m
	Yc2+SdA8wNtia/WLeJ91dvdbOuMNlMmLUB80nKBErFlA5vqLtgYFvDieEzk+f9tQdwWS
	9OeaYwx22pCYuF600JqaCxoZ4ohIUAkbclnLeGjyUyYaCeilNB0UGmXJSIwYN9Y5j8pq
	nqIg==
X-Gm-Message-State: ALoCoQnbKCRq+2ZmNOVQfvtEtyqcpuyIFJHhvinvs0jB0Gy8n1v0PEXec2SNUAsNYGtktUT7WV6N
X-Received: by 10.180.20.105 with SMTP id m9mr4720961wie.6.1405685704334;
	Fri, 18 Jul 2014 05:15:04 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fs17sm13838895wjc.6.2014.07.18.05.15.01 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:15:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D09915602D5; Fri, 18 Jul 2014 13:15:02 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:14:57 +0100
Message-Id: <6a0406d1c5cc0a63334888d945835e96c1555ec3.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
References: <a487f31bcfa47e1a48cb4bc122017ccb5e8b8f1a.1405685308.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1405685308.git.alexandru.damian@intel.com>
References: <cover.1405685308.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/8] toaster: move bldcontrol initial_data fixture to code
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:05 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We move the initial_data fixture to a code migration,
in order to make sure that we don't overwrite modified data.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        |   2 +-
 lib/toaster/bldcontrol/fixtures/initial_data.json  |   1 -
 .../management/commands/checksettings.py           |   8 +-
 .../bldcontrol/migrations/0004_loadinitialdata.py  | 104 +++++++++++++++++++++
 4 files changed, 109 insertions(+), 6 deletions(-)
 delete mode 100644 lib/toaster/bldcontrol/fixtures/initial_data.json
 create mode 100644 lib/toaster/bldcontrol/migrations/0004_loadinitialdata.py

diff --git a/bin/toaster b/bin/toaster
index 1f90362..78fbfa5 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -65,7 +65,7 @@ function webserverStartAll()
         fi
         python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
 	python $BBBASEDIR/lib/toaster/manage.py checksettings  || retval=1
-
+	echo "Starting webserver"
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
diff --git a/lib/toaster/bldcontrol/fixtures/initial_data.json b/lib/toaster/bldcontrol/fixtures/initial_data.json
deleted file mode 100644
index b2f12b3..0000000
--- a/lib/toaster/bldcontrol/fixtures/initial_data.json
+++ /dev/null
@@ -1 +0,0 @@
-[{"pk": 1, "model": "bldcontrol.buildenvironment", "fields": {"updated": "2014-05-20T12:17:30Z", "created": "2014-05-20T12:17:30Z", "lock": 0, "bbstate": 0, "bbaddress": "", "betype": 0, "bbtoken": "", "address": "", "bbport": -1}}]
diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index da1c3b7..a91dd15 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -27,12 +27,12 @@ class Command(NoArgsCommand):
                 if not be.builddir.startswith("/"):
                     be.builddir = raw_input(" -- builddir must be an absolute path:")
                     is_changed = True
+                if is_changed:
+                    print "saved"
+                    be.save()
                 return is_changed
 
             while (_verify_be()):
                 pass
-        
-
-            
-            
 
+            return 0
diff --git a/lib/toaster/bldcontrol/migrations/0004_loadinitialdata.py b/lib/toaster/bldcontrol/migrations/0004_loadinitialdata.py
new file mode 100644
index 0000000..d908578
--- /dev/null
+++ b/lib/toaster/bldcontrol/migrations/0004_loadinitialdata.py
@@ -0,0 +1,104 @@
+# -*- coding: utf-8 -*-
+from south.utils import datetime_utils as datetime
+from south.db import db
+from south.v2 import DataMigration
+from django.db import models
+
+class Migration(DataMigration):
+
+    def forwards(self, orm):
+        "Write your forwards methods here."
+        # Note: Don't use "from appname.models import ModelName".
+        # Use orm.ModelName to refer to models in this application,
+        # and orm['appname.ModelName'] for models in other applications.
+        try:
+            orm.BuildEnvironment.objects.get(pk = 1)
+        except:
+            from django.utils import timezone
+            orm.BuildEnvironment.objects.create(pk = 1,
+                created = timezone.now(),
+                updated = timezone.now(),
+                betype = 0)
+
+    def backwards(self, orm):
+        "Write your backwards methods here."
+
+    models = {
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
+    symmetrical = True
-- 
1.9.1


