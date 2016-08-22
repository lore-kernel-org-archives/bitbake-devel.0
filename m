Return-Path: <elliot.smith@intel.com>
Received: from bongo.birch.relay.mailchannels.net
	(bongo.birch.relay.mailchannels.net [23.83.209.21])
	by mail.openembedded.org (Postfix) with ESMTP id 904E177081
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 22 Aug 2016 15:42:53 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8925EA11EF;
	Mon, 22 Aug 2016 15:42:52 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-107-69-155.us-west-2.compute.internal [10.107.69.155])
	by relay.mailchannels.net (Postfix) with ESMTPA id CF132A2747;
	Mon, 22 Aug 2016 15:42:51 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com ([TEMPUNAVAIL].
	[10.92.147.53]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.6); Mon, 22 Aug 2016 15:42:52 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1471880572161:895782940
X-MC-Ingress-Time: 1471880572160
Received: from [176.249.240.35] (port=48672 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bbrN9-0002ZA-Kf; Mon, 22 Aug 2016 11:42:47 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Aug 2016 16:42:35 +0100
Message-Id: <1471880556-9232-8-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
References: <1471880556-9232-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 8/9] toaster: Allow git information to be null for BRLayer
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
X-List-Received-Date: Mon, 22 Aug 2016 15:42:54 -0000

From: Michael Wood <michael.g.wood@intel.com>

We no longer only deal with layers that have their source in a gir
repository, we also allow for local directories too so update the
BRLayer model to reflect this.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 .../migrations/0007_brlayers_optional_gitinfo.py   | 29 ++++++++++++++++++++++
 bitbake/lib/toaster/bldcontrol/models.py           | 11 ++++----
 2 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0007_brlayers_optional_gitinfo.py

diff --git a/bitbake/lib/toaster/bldcontrol/migrations/0007_brlayers_optional_gitinfo.py b/bitbake/lib/toaster/bldcontrol/migrations/0007_brlayers_optional_gitinfo.py
new file mode 100644
index 0000000..4be42a4
--- /dev/null
+++ b/bitbake/lib/toaster/bldcontrol/migrations/0007_brlayers_optional_gitinfo.py
@@ -0,0 +1,29 @@
+# -*- coding: utf-8 -*-
+from __future__ import unicode_literals
+
+from django.db import migrations, models
+
+
+class Migration(migrations.Migration):
+
+    dependencies = [
+        ('bldcontrol', '0006_brlayer_local_source_dir'),
+    ]
+
+    operations = [
+        migrations.AlterField(
+            model_name='brlayer',
+            name='commit',
+            field=models.CharField(max_length=254, null=True),
+        ),
+        migrations.AlterField(
+            model_name='brlayer',
+            name='dirpath',
+            field=models.CharField(max_length=254, null=True),
+        ),
+        migrations.AlterField(
+            model_name='brlayer',
+            name='giturl',
+            field=models.CharField(max_length=254, null=True),
+        ),
+    ]
diff --git a/bitbake/lib/toaster/bldcontrol/models.py b/bitbake/lib/toaster/bldcontrol/models.py
index 83b6969..409614b 100644
--- a/bitbake/lib/toaster/bldcontrol/models.py
+++ b/bitbake/lib/toaster/bldcontrol/models.py
@@ -126,13 +126,14 @@ class BuildRequest(models.Model):
 # These tables specify the settings for running an actual build.
 # They MUST be kept in sync with the tables in orm.models.Project*
 
+
 class BRLayer(models.Model):
-    req         = models.ForeignKey(BuildRequest)
-    name        = models.CharField(max_length = 100)
-    giturl      = models.CharField(max_length = 254)
+    req = models.ForeignKey(BuildRequest)
+    name = models.CharField(max_length=100)
+    giturl = models.CharField(max_length=254, null=True)
     local_source_dir = models.CharField(max_length=254, null=True)
-    commit      = models.CharField(max_length = 254)
-    dirpath     = models.CharField(max_length = 254)
+    commit = models.CharField(max_length=254, null=True)
+    dirpath = models.CharField(max_length=254, null=True)
     layer_version = models.ForeignKey(Layer_Version, null=True)
 
 class BRBitbake(models.Model):
-- 
2.7.4


