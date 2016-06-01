Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ECBB5773CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48Q007485; Wed, 1 Jun 2016 13:37:07 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id khdbWm6-k_G5; Wed,  1 Jun 2016 13:37:07 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Caxqw007463
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000p0-Gb; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:40 +0100
Message-Id: <1464784607-2985-21-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 21/28] toaster: fix migrations
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Created two new migrations due to the models changes made
in python3 patchset.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../migrations/0004_auto_20160509_0946.py          | 34 +++++++++
 .../orm/migrations/0007_auto_20160509_0946.py      | 89 ++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0004_auto_20160509_0946.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0007_auto_20160509_0946.py

diff --git a/bitbake/lib/toaster/bldcontrol/migrations/0004_auto_20160509_0946.py b/bitbake/lib/toaster/bldcontrol/migrations/0004_auto_20160509_0946.py
new file mode 100644
index 0000000..4a70e2d
--- /dev/null
+++ b/bitbake/lib/toaster/bldcontrol/migrations/0004_auto_20160509_0946.py
@@ -0,0 +1,34 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('bldcontrol', '0003_add_cancelling_state'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='buildenvironment',
+            name='bbstate',
+            field=models.IntegerField(choices=[(0, 'stopped'), (1, 'started')], default=0),
+        ),
+        migrations.AlterField(
+            model_name='buildenvironment',
+            name='betype',
+            field=models.IntegerField(choices=[(0, 'local')]),
+        ),
+        migrations.AlterField(
+            model_name='buildenvironment',
+            name='lock',
+            field=models.IntegerField(choices=[(0, 'free'), (1, 'lock'), (2, 'running')], default=0),
+        ),
+        migrations.AlterField(
+            model_name='buildrequest',
+            name='state',
+            field=models.IntegerField(choices=[(0, 'created'), (1, 'queued'), (2, 'in progress'), (3, 'completed'), (4, 'failed'), (5, 'deleted'), (6, 'cancelling'), (7, 'archive')], default=0),
+        ),
+    ]
diff --git a/bitbake/lib/toaster/orm/migrations/0007_auto_20160509_0946.py b/bitbake/lib/toaster/orm/migrations/0007_auto_20160509_0946.py
new file mode 100644
index 0000000..d866105
--- /dev/null
+++ b/bitbake/lib/toaster/orm/migrations/0007_auto_20160509_0946.py
@@ -0,0 +1,89 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('orm', '0006_add_cancelled_state'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='build',
+            name='outcome',
+            field=models.IntegerField(choices=[(0, 'Succeeded'), (1, 'Failed'), (2, 'In Progress'), (3, 'Cancelled')], default=2),
+        ),
+        migrations.AlterField(
+            model_name='helptext',
+            name='area',
+            field=models.IntegerField(choices=[(0, 'variable')]),
+        ),
+        migrations.AlterField(
+            model_name='layer',
+            name='summary',
+            field=models.TextField(null=True, help_text='One-line description of the layer', default=None),
+        ),
+        migrations.AlterField(
+            model_name='layer_version',
+            name='local_path',
+            field=models.FilePathField(max_length=1024, default='/'),
+        ),
+        migrations.AlterField(
+            model_name='layersource',
+            name='sourcetype',
+            field=models.IntegerField(choices=[(0, 'local'), (1, 'layerindex'), (2, 'imported')]),
+        ),
+        migrations.AlterField(
+            model_name='logmessage',
+            name='level',
+            field=models.IntegerField(choices=[(0, 'info'), (1, 'warn'), (2, 'error'), (3, 'critical'), (-1, 'toaster exception')], default=0),
+        ),
+        migrations.AlterField(
+            model_name='package',
+            name='installed_name',
+            field=models.CharField(max_length=100, default=''),
+        ),
+        migrations.AlterField(
+            model_name='package_dependency',
+            name='dep_type',
+            field=models.IntegerField(choices=[(0, 'depends'), (1, 'depends'), (3, 'recommends'), (2, 'recommends'), (4, 'suggests'), (5, 'provides'), (6, 'replaces'), (7, 'conflicts')]),
+        ),
+        migrations.AlterField(
+            model_name='recipe_dependency',
+            name='dep_type',
+            field=models.IntegerField(choices=[(0, 'depends'), (1, 'rdepends')]),
+        ),
+        migrations.AlterField(
+            model_name='release',
+            name='branch_name',
+            field=models.CharField(max_length=50, default=''),
+        ),
+        migrations.AlterField(
+            model_name='releasedefaultlayer',
+            name='layer_name',
+            field=models.CharField(max_length=100, default=''),
+        ),
+        migrations.AlterField(
+            model_name='target_file',
+            name='inodetype',
+            field=models.IntegerField(choices=[(1, 'regular'), (2, 'directory'), (3, 'symlink'), (4, 'socket'), (5, 'fifo'), (6, 'character'), (7, 'block')]),
+        ),
+        migrations.AlterField(
+            model_name='task',
+            name='outcome',
+            field=models.IntegerField(choices=[(-1, 'Not Available'), (0, 'Succeeded'), (1, 'Covered'), (2, 'Cached'), (3, 'Prebuilt'), (4, 'Failed'), (5, 'Empty')], default=-1),
+        ),
+        migrations.AlterField(
+            model_name='task',
+            name='script_type',
+            field=models.IntegerField(choices=[(0, 'N/A'), (2, 'Python'), (3, 'Shell')], default=0),
+        ),
+        migrations.AlterField(
+            model_name='task',
+            name='sstate_result',
+            field=models.IntegerField(choices=[(0, 'Not Applicable'), (1, 'File not in cache'), (2, 'Failed'), (3, 'Succeeded')], default=0),
+        ),
+    ]
-- 
2.5.0


