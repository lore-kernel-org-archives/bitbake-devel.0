Return-Path: <elliot.smith@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id DB30A731EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Jan 2016 11:17:28 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 08 Jan 2016 03:17:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,538,1444719600"; d="scan'208";a="722947320"
Received: from deryaeke-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.25.84])
	by orsmga003.jf.intel.com with ESMTP; 08 Jan 2016 03:17:28 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jan 2016 11:17:18 +0000
Message-Id: <3bac0574ce178ede45c323357f69e6b4eb0115f1.1452251694.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
References: <d4ae58e68ced0a70b88430fca9aad786b113953b.1452251694.git.elliot.smith@intel.com>
In-Reply-To: <cover.1452251694.git.elliot.smith@intel.com>
References: <cover.1452251694.git.elliot.smith@intel.com>
Subject: [PATCH 4/8] toaster: add Provider model
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
X-List-Received-Date: Fri, 08 Jan 2016 11:17:29 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Added new model Provider and a foreign key 'via' to link
Recipe_Dependency to it.

[YOCTO #6169]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../orm/migrations/0002_auto_20151223_1528.py      | 27 ++++++++++++++++++++++
 lib/toaster/orm/models.py                          |  5 ++++
 2 files changed, 32 insertions(+)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0002_auto_20151223_1528.py

diff --git a/lib/toaster/orm/migrations/0002_auto_20151223_1528.py b/lib/toaster/orm/migrations/0002_auto_20151223_1528.py
new file mode 100644
index 0000000..194c897
--- /dev/null
+++ b/lib/toaster/orm/migrations/0002_auto_20151223_1528.py
@@ -0,0 +1,27 @@
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
+            name='Provides',
+            fields=[
+                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
+                ('name', models.CharField(max_length=100)),
+                ('recipe', models.ForeignKey(to='orm.Recipe')),
+            ],
+        ),
+        migrations.AddField(
+            model_name='recipe_dependency',
+            name='via',
+            field=models.ForeignKey(null=True, default=None, to='orm.Provides'),
+        ),
+    ]
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 6e87c54..e4ab0bb 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -733,6 +733,10 @@ class Recipe_DependencyManager(models.Manager):
     def get_queryset(self):
         return super(Recipe_DependencyManager, self).get_queryset().exclude(recipe_id = F('depends_on__id'))
 
+class Provides(models.Model):
+    name = models.CharField(max_length=100)
+    recipe = models.ForeignKey(Recipe)
+
 class Recipe_Dependency(models.Model):
     TYPE_DEPENDS = 0
     TYPE_RDEPENDS = 1
@@ -743,6 +747,7 @@ class Recipe_Dependency(models.Model):
     )
     recipe = models.ForeignKey(Recipe, related_name='r_dependencies_recipe')
     depends_on = models.ForeignKey(Recipe, related_name='r_dependencies_depends')
+    via = models.ForeignKey(Provides, null=True, default=None)
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
     objects = Recipe_DependencyManager()
 
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


