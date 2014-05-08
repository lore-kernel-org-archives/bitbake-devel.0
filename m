Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f175.google.com (unknown [74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id 692FA60173
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 13:32:06 +0000 (UTC)
Received: by mail-we0-f175.google.com with SMTP id t61so2548615wes.34
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 May 2014 06:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=JW9us8lA45csigFIAGBSntjoPtnarpZPKlbdUCwKaaU=;
	b=K1K7gzjsrEoUS/ObYcI2+mF4EnqMIQ6E5QpFrFLjVANjkn05vsVZ6uTSqu2yAliPmy
	pWe/neOKEHkoK3firLf9SvHJri7yuPJ0Fj/EefdAQzYEpGcRK2wqo6Idqmz2mXmIF12g
	bBqhH2ur9uNi2Hu/ghGSh9aAr5rRNPrYay3SFY9NiWLVtRUumoephSxT1H4qkJdntoJf
	Ft3/KtxHSOad+XZoRppT8+6hG7IVdugtjMTTp7+qH0XkeJbTtA87WQvHWcP4uaQ55ikn
	m9Z9BzuXm20SdphsTrvc0Ri+hLTDXSzdDOCQWuZ90pgbN93qW/KQzKoT4c77ll5N/d8D
	wtTw==
X-Gm-Message-State: ALoCoQn+5KWfcEbWVBCeuGCCU97/dyE1xQ10+Fg88uLeHp2U+QZmF7MHbDHe1SNxemE/SNtqaeQX
X-Received: by 10.180.206.205 with SMTP id lq13mr12943896wic.11.1399555481240; 
	Thu, 08 May 2014 06:24:41 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id dn1sm4898948wid.6.2014.05.08.06.24.37
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 May 2014 06:24:37 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id F1E3F56082F; Thu,  8 May 2014 21:24:36 +0800 (HKT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 May 2014 14:24:34 +0100
Message-Id: <48f8cb830499e272bd5a354c00a7b32f020c54be.1399555312.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
References: <7fc64b40c28e09f8fe549d8d2972d5066bc1d125.1399555312.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1399555312.git.alexandru.damian@intel.com>
References: <cover.1399555312.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/5] toaster: fix migration code for MySQL
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
X-List-Received-Date: Thu, 08 May 2014 13:32:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a patch that fixes the 0004, 0005 migrations of the toaster
model to get them to properly work with MySQL.

These migrations had a conflict around Build.timespent field.
The sqlite3 constraits were not enough to detect the conflict, and
the migrations worked as expected.

MySQL objected to adding the field twice, so I did regenerate
the migrations with the correct model listing. The net effect
is the same, so the migrations work the same, but now we
can use these two migration on the MySQL and other more advanced
SQL engines.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 .../0004_auto__add_field_package_installed_name.py |  1 +
 ...e__add_target_file__add_field_variablehistor.py | 56 +++++++---------------
 2 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/lib/toaster/orm/migrations/0004_auto__add_field_package_installed_name.py b/lib/toaster/orm/migrations/0004_auto__add_field_package_installed_name.py
index ca114de..fc5ff53 100644
--- a/lib/toaster/orm/migrations/0004_auto__add_field_package_installed_name.py
+++ b/lib/toaster/orm/migrations/0004_auto__add_field_package_installed_name.py
@@ -34,6 +34,7 @@ class Migration(SchemaMigration):
             'machine': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
             'outcome': ('django.db.models.fields.IntegerField', [], {'default': '2'}),
             'started_on': ('django.db.models.fields.DateTimeField', [], {}),
+            'timespent': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
             'warnings_no': ('django.db.models.fields.IntegerField', [], {'default': '0'})
         },
         u'orm.layer': {
diff --git a/lib/toaster/orm/migrations/0005_auto__add_target_image_file__add_target_file__add_field_variablehistor.py b/lib/toaster/orm/migrations/0005_auto__add_target_image_file__add_target_file__add_field_variablehistor.py
index a55451c..fd1d153 100644
--- a/lib/toaster/orm/migrations/0005_auto__add_target_image_file__add_target_file__add_field_variablehistor.py
+++ b/lib/toaster/orm/migrations/0005_auto__add_target_image_file__add_target_file__add_field_variablehistor.py
@@ -8,15 +8,6 @@ from django.db import models
 class Migration(SchemaMigration):
 
     def forwards(self, orm):
-        # Adding model 'Target_Image_File'
-        db.create_table(u'orm_target_image_file', (
-            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
-            ('target', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Target'])),
-            ('file_name', self.gf('django.db.models.fields.FilePathField')(max_length=100)),
-            ('file_size', self.gf('django.db.models.fields.IntegerField')()),
-        ))
-        db.send_create_signal(u'orm', ['Target_Image_File'])
-
         # Adding model 'Target_File'
         db.create_table(u'orm_target_file', (
             (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
@@ -32,6 +23,15 @@ class Migration(SchemaMigration):
         ))
         db.send_create_signal(u'orm', ['Target_File'])
 
+        # Adding model 'Target_Image_File'
+        db.create_table(u'orm_target_image_file', (
+            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
+            ('target', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Target'])),
+            ('file_name', self.gf('django.db.models.fields.FilePathField')(max_length=100)),
+            ('file_size', self.gf('django.db.models.fields.IntegerField')()),
+        ))
+        db.send_create_signal(u'orm', ['Target_Image_File'])
+
         # Adding field 'VariableHistory.value'
         db.add_column(u'orm_variablehistory', 'value',
                       self.gf('django.db.models.fields.TextField')(default='', blank=True),
@@ -49,11 +49,6 @@ class Migration(SchemaMigration):
         # Deleting field 'Build.image_fstypes'
         db.delete_column(u'orm_build', 'image_fstypes')
 
-        # Adding field 'Build.timespent'
-        db.add_column(u'orm_build', 'timespent',
-                      self.gf('django.db.models.fields.IntegerField')(default=0),
-                      keep_default=False)
-
         # Adding field 'LogMessage.task'
         db.add_column(u'orm_logmessage', 'task',
                       self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Task'], null=True, blank=True),
@@ -70,12 +65,12 @@ class Migration(SchemaMigration):
         # Removing unique constraint on 'Task', fields ['build', 'recipe', 'task_name']
         db.delete_unique(u'orm_task', ['build_id', 'recipe_id', 'task_name'])
 
-        # Deleting model 'Target_Image_File'
-        db.delete_table(u'orm_target_image_file')
-
         # Deleting model 'Target_File'
         db.delete_table(u'orm_target_file')
 
+        # Deleting model 'Target_Image_File'
+        db.delete_table(u'orm_target_image_file')
+
         # Deleting field 'VariableHistory.value'
         db.delete_column(u'orm_variablehistory', 'value')
 
@@ -84,36 +79,21 @@ class Migration(SchemaMigration):
                       self.gf('django.db.models.fields.TextField')(default='', blank=True),
                       keep_default=False)
 
-
-        # User chose to not deal with backwards NULL issues for 'Target.file_name'
-        raise RuntimeError("Cannot reverse this migration. 'Target.file_name' and its values cannot be restored.")
-        
-        # The following code is provided here to aid in writing a correct migration        # Adding field 'Target.file_name'
+        # Adding field 'Target.file_name'
         db.add_column(u'orm_target', 'file_name',
-                      self.gf('django.db.models.fields.CharField')(max_length=100),
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=100),
                       keep_default=False)
 
-
-        # User chose to not deal with backwards NULL issues for 'Target.file_size'
-        raise RuntimeError("Cannot reverse this migration. 'Target.file_size' and its values cannot be restored.")
-        
-        # The following code is provided here to aid in writing a correct migration        # Adding field 'Target.file_size'
+        # Adding field 'Target.file_size'
         db.add_column(u'orm_target', 'file_size',
-                      self.gf('django.db.models.fields.IntegerField')(),
+                      self.gf('django.db.models.fields.IntegerField')(default=0),
                       keep_default=False)
 
-
-        # User chose to not deal with backwards NULL issues for 'Build.image_fstypes'
-        raise RuntimeError("Cannot reverse this migration. 'Build.image_fstypes' and its values cannot be restored.")
-        
-        # The following code is provided here to aid in writing a correct migration        # Adding field 'Build.image_fstypes'
+        # Adding field 'Build.image_fstypes'
         db.add_column(u'orm_build', 'image_fstypes',
-                      self.gf('django.db.models.fields.CharField')(max_length=100),
+                      self.gf('django.db.models.fields.CharField')(default='', max_length=100),
                       keep_default=False)
 
-        # Deleting field 'Build.timespent'
-        db.delete_column(u'orm_build', 'timespent')
-
         # Deleting field 'LogMessage.task'
         db.delete_column(u'orm_logmessage', 'task_id')
 
-- 
1.9.1


