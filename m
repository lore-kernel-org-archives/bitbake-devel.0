Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 9886877041
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Feb 2016 05:16:00 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id fl4so43986999pad.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Feb 2016 21:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SOWCFEFmg8zm7gwk967c5gOQvulsrgUP7L5rjgrfYxI=;
	b=mQDvlFAW9SapULRvYpBGsZQ4UiOi1JOvi2cHyq0OPJw+kFIX2E3AM/oX0eU5wEB8DI
	V90TmCkg6RgrbHuke1CSyA3VoskCml21cBY8SgRoRy9npX1G6eWGyUxLNaLNaR+Y3Djp
	cHUBY1Ryy/RZOjzuBMo6+DKM21elenK6kCX7CZBu6wbbPDHczC0uDW9JZCa2uq8xAk1X
	D3yG9VQHbKoBHOmQp3dDPs0c2xExsy0EzDTmbFKxtssDR6jxLgtDCGQ3riUx5wTP4ast
	HlJIydAkpJWYnLrewIk/t8jeaIRTxuQIPHzPIszPTLVtFwvt7HzAMvHF0KvbaZ9u3DR6
	ds+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SOWCFEFmg8zm7gwk967c5gOQvulsrgUP7L5rjgrfYxI=;
	b=ez2mB98cgV8pAQ71dPMQno2oxDOn17B7/0N4tmpQ1AowRqkvTpX6twqPKpn5spSHBo
	TBdo1TbbHUOCQWsTPUSVbSG6TZyuRuMTuyqAIUoOX57XCgXMTE44z2Vt7nz6fgumGX0r
	NLuV0SvUMzk+9S33pJhmaPWuDWNPIMuPa61Ap2sIGdqRCE82PnGVEZ08a3lVPDqayBya
	fAWe96UwEkcWH4j6zB6kNjMNG08nrmjivCxIw1QGYg9cZpp9g0jxk38hO/WshPRQpq51
	5nsvzDvm9BaRarNjnI4pHK5kzW4cOee9kAMSieRv2KvNzQyCOzlpUaK0/+1LPDP/viQC
	AQ5w==
X-Gm-Message-State: AG10YOQIap4zN/alN1uguGTQ0QhnCaAFSJf4ZlcBxkiyAgUC7BrFkPxzVoaP5I4QsfoNRA==
X-Received: by 10.66.121.10 with SMTP id lg10mr15448381pab.59.1455858961818;
	Thu, 18 Feb 2016 21:16:01 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	ml5sm13317073pab.2.2016.02.18.21.16.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 18 Feb 2016 21:16:01 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Feb 2016 21:21:48 -0800
Message-Id: <1074d09d9af22d962880d1ba7791b85eecfeac08.1455859137.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1455859137.git.avery.brian@gmail.com>
References: <cover.1455859137.git.avery.brian@gmail.com>
Subject: [PATCH 1/5] toaster: orm migrations Sort out migrations mess
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
X-List-Received-Date: Fri, 19 Feb 2016 05:16:01 -0000

From: Michael Wood <michael.g.wood@intel.com>

We messed up the migrations by squashing some of the image
customisation model definitions into the initial migration which
has meant some irreversible operations on mysql took place.
This deletes, re-orders and fixes the migrations.

If your schema is up to date you may want to use ./manage migrate
with --fake or --fake-initial to avoid re-applying migrations.

[YOCTO #9116]

Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/orm/migrations/0001_initial.py         | 26 --------------
 .../orm/migrations/0002_auto_20151210_1209.py      | 41 ----------------------
 .../orm/migrations/0002_customimagerecipe.py       | 24 +++++++++++++
 .../orm/migrations/0003_customimagepackage.py      |  2 +-
 lib/toaster/orm/migrations/0004_merge.py           | 15 --------
 ...0002_auto_20151223_1528.py => 0004_provides.py} |  2 +-
 .../orm/migrations/0005_auto_20160118_1055.py      | 19 ----------
 .../0006_customimagerecipe_last_updated.py         | 19 ----------
 8 files changed, 26 insertions(+), 122 deletions(-)
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0002_auto_20151210_1209.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0002_customimagerecipe.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0004_merge.py
 rename bitbake/lib/toaster/orm/migrations/{0002_auto_20151223_1528.py => 0004_provides.py} (94%)
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0005_auto_20160118_1055.py
 delete mode 100644 bitbake/lib/toaster/orm/migrations/0006_customimagerecipe_last_updated.py

diff --git a/lib/toaster/orm/migrations/0001_initial.py b/lib/toaster/orm/migrations/0001_initial.py
index 27fd057..760462f 100644
--- a/lib/toaster/orm/migrations/0001_initial.py
+++ b/lib/toaster/orm/migrations/0001_initial.py
@@ -58,13 +58,6 @@ class Migration(migrations.Migration):
             ],
         ),
         migrations.CreateModel(
-            name='CustomImageRecipe',
-            fields=[
-                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
-                ('name', models.CharField(max_length=100)),
-            ],
-        ),
-        migrations.CreateModel(
             name='HelpText',
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
@@ -436,21 +429,6 @@ class Migration(migrations.Migration):
             field=models.ForeignKey(default=None, to='orm.LayerSource', null=True),
         ),
         migrations.AddField(
-            model_name='customimagerecipe',
-            name='base_recipe',
-            field=models.ForeignKey(to='orm.Recipe'),
-        ),
-        migrations.AddField(
-            model_name='customimagerecipe',
-            name='packages',
-            field=models.ManyToManyField(to='orm.Package'),
-        ),
-        migrations.AddField(
-            model_name='customimagerecipe',
-            name='project',
-            field=models.ForeignKey(to='orm.Project'),
-        ),
-        migrations.AddField(
             model_name='build',
             name='project',
             field=models.ForeignKey(to='orm.Project'),
@@ -520,10 +498,6 @@ class Migration(migrations.Migration):
             unique_together=set([('layer_source', 'up_id'), ('layer_source', 'name')]),
         ),
         migrations.AlterUniqueTogether(
-            name='customimagerecipe',
-            unique_together=set([('name', 'project')]),
-        ),
-        migrations.AlterUniqueTogether(
             name='branch',
             unique_together=set([('layer_source', 'up_id'), ('layer_source', 'name')]),
         ),
diff --git a/lib/toaster/orm/migrations/0002_auto_20151210_1209.py b/lib/toaster/orm/migrations/0002_auto_20151210_1209.py
deleted file mode 100644
index d15ceaa..0000000
--- a/lib/toaster/orm/migrations/0002_auto_20151210_1209.py
+++ /dev/null
@@ -1,41 +0,0 @@
-# -*- coding: utf-8 -*-
-from __future__ import unicode_literals
-
-from django.db import migrations, models
-
-
-class Migration(migrations.Migration):
-
-    dependencies = [
-        ('orm', '0001_initial'),
-    ]
-
-    operations = [
-        migrations.AddField(
-            model_name='customimagerecipe',
-            name='recipe_ptr',
-            field=models.OneToOneField(parent_link=True, auto_created=True, default=None, serialize=False, to='orm.Recipe'),
-            preserve_default=False,
-        ),
-        migrations.AlterField(
-            model_name='customimagerecipe',
-            name='base_recipe',
-            field=models.ForeignKey(related_name='based_on_recipe', to='orm.Recipe'),
-        ),
-        migrations.AlterUniqueTogether(
-            name='customimagerecipe',
-            unique_together=set([]),
-        ),
-        migrations.RemoveField(
-            model_name='customimagerecipe',
-            name='id',
-        ),
-        migrations.RemoveField(
-            model_name='customimagerecipe',
-            name='name',
-        ),
-        migrations.RemoveField(
-            model_name='customimagerecipe',
-            name='packages',
-        ),
-    ]
diff --git a/lib/toaster/orm/migrations/0002_customimagerecipe.py b/lib/toaster/orm/migrations/0002_customimagerecipe.py
new file mode 100644
index 0000000..9cec82e
--- /dev/null
+++ b/lib/toaster/orm/migrations/0002_customimagerecipe.py
@@ -0,0 +1,24 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0001_initial'),
+    ]
+
+    operations = [
+        migrations.CreateModel(
+            name='CustomImageRecipe',
+            fields=[
+                ('recipe_ptr', models.OneToOneField(parent_link=True, auto_created=True, primary_key=True, serialize=False, to='orm.Recipe')),
+                ('last_updated', models.DateTimeField(default=None, null=True)),
+                ('base_recipe', models.ForeignKey(related_name='based_on_recipe', to='orm.Recipe')),
+                ('project', models.ForeignKey(to='orm.Project')),
+            ],
+            bases=('orm.recipe',),
+        ),
+    ]
diff --git a/lib/toaster/orm/migrations/0003_customimagepackage.py b/lib/toaster/orm/migrations/0003_customimagepackage.py
index d2ea820..b027f66 100644
--- a/lib/toaster/orm/migrations/0003_customimagepackage.py
+++ b/lib/toaster/orm/migrations/0003_customimagepackage.py
@@ -7,7 +7,7 @@ from django.db import migrations, models
 class Migration(migrations.Migration):
 
     dependencies = [
-        ('orm', '0002_auto_20151210_1209'),
+        ('orm', '0002_customimagerecipe'),
     ]
 
     operations = [
diff --git a/lib/toaster/orm/migrations/0004_merge.py b/lib/toaster/orm/migrations/0004_merge.py
deleted file mode 100644
index 5b9d122..0000000
--- a/lib/toaster/orm/migrations/0004_merge.py
+++ /dev/null
@@ -1,15 +0,0 @@
-# -*- coding: utf-8 -*-
-from __future__ import unicode_literals
-
-from django.db import migrations, models
-
-
-class Migration(migrations.Migration):
-
-    dependencies = [
-        ('orm', '0002_auto_20151223_1528'),
-        ('orm', '0003_customimagepackage'),
-    ]
-
-    operations = [
-    ]
diff --git a/lib/toaster/orm/migrations/0002_auto_20151223_1528.py b/lib/toaster/orm/migrations/0004_provides.py
similarity index 94%
rename from lib/toaster/orm/migrations/0002_auto_20151223_1528.py
rename to lib/toaster/orm/migrations/0004_provides.py
index 194c897..dfde2d1 100644
--- a/lib/toaster/orm/migrations/0002_auto_20151223_1528.py
+++ b/lib/toaster/orm/migrations/0004_provides.py
@@ -7,7 +7,7 @@ from django.db import migrations, models
 class Migration(migrations.Migration):
 
     dependencies = [
-        ('orm', '0001_initial'),
+        ('orm', '0003_customimagepackage'),
     ]
 
     operations = [
diff --git a/lib/toaster/orm/migrations/0005_auto_20160118_1055.py b/lib/toaster/orm/migrations/0005_auto_20160118_1055.py
deleted file mode 100644
index 1120596..0000000
--- a/lib/toaster/orm/migrations/0005_auto_20160118_1055.py
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- coding: utf-8 -*-
-from __future__ import unicode_literals
-
-from django.db import migrations, models
-
-
-class Migration(migrations.Migration):
-
-    dependencies = [
-        ('orm', '0004_merge'),
-    ]
-
-    operations = [
-        migrations.AlterField(
-            model_name='customimagerecipe',
-            name='recipe_ptr',
-            field=models.OneToOneField(parent_link=True, auto_created=True, primary_key=True, serialize=False, to='orm.Recipe'),
-        ),
-    ]
diff --git a/lib/toaster/orm/migrations/0006_customimagerecipe_last_updated.py b/lib/toaster/orm/migrations/0006_customimagerecipe_last_updated.py
deleted file mode 100644
index b7a301b..0000000
--- a/lib/toaster/orm/migrations/0006_customimagerecipe_last_updated.py
+++ /dev/null
@@ -1,19 +0,0 @@
-# -*- coding: utf-8 -*-
-from __future__ import unicode_literals
-
-from django.db import migrations, models
-
-
-class Migration(migrations.Migration):
-
-    dependencies = [
-        ('orm', '0005_auto_20160118_1055'),
-    ]
-
-    operations = [
-        migrations.AddField(
-            model_name='customimagerecipe',
-            name='last_updated',
-            field=models.DateTimeField(default=None, null=True),
-        ),
-    ]
-- 
1.9.1


