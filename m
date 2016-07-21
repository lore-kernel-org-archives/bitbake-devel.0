Return-Path: <elliot.smith@intel.com>
Received: from bird.oak.relay.mailchannels.net
	(bird.oak.relay.mailchannels.net [23.83.215.17])
	by mail.openembedded.org (Postfix) with ESMTP id AEF6A731D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:39:36 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 58C78101430;
	Thu, 21 Jul 2016 13:39:37 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-220-3-24.us-west-2.compute.internal [10.220.3.24])
	by relay.mailchannels.net (Postfix) with ESMTPA id D831410006C;
	Thu, 21 Jul 2016 13:39:36 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com
	(uscentral428.accountservergroup.com [10.107.128.240])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:39:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108377135:2261038630
X-MC-Ingress-Time: 1469108377135
Received: from [176.249.240.35] (port=56876 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQECN-00012R-L4; Thu, 21 Jul 2016 09:39:35 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:39:11 +0100
Message-Id: <1469108352-12098-9-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
References: <1469108352-12098-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH 09/10] toaster: admin Add Layer_Version to the admin-able models
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
X-List-Received-Date: Thu, 21 Jul 2016 13:39:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

If the migration didn't get the release conversion right for say, a
local or imported layer it would be handy to be able to edit this
in the django admin page.

Also useful for developers to be able to tweak layers on the fly.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/bldcollector/admin.py | 18 +++++++++++-------
 bitbake/lib/toaster/orm/models.py         | 11 +++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/toaster/bldcollector/admin.py b/bitbake/lib/toaster/bldcollector/admin.py
index 7b69ecd..1f2e07f 100644
--- a/bitbake/lib/toaster/bldcollector/admin.py
+++ b/bitbake/lib/toaster/bldcollector/admin.py
@@ -1,29 +1,33 @@
 from django.contrib import admin
-from django.contrib.admin.filters import RelatedFieldListFilter
-from orm.models import BitbakeVersion, Release, ToasterSetting
-from django.forms.widgets import Textarea
+from orm.models import BitbakeVersion, Release, ToasterSetting, Layer_Version
 from django import forms
 import django.db.models as models
 
-from django.contrib.admin import widgets, helpers
 
 class BitbakeVersionAdmin(admin.ModelAdmin):
 
-    # we override the formfield for db URLField because of broken URL validation
+    # we override the formfield for db URLField
+    # because of broken URL validation
 
     def formfield_for_dbfield(self, db_field, **kwargs):
         if isinstance(db_field, models.fields.URLField):
             return forms.fields.CharField()
-        return super(BitbakeVersionAdmin, self).formfield_for_dbfield(db_field, **kwargs)
-
+        return super(BitbakeVersionAdmin, self).formfield_for_dbfield(
+            db_field, **kwargs)
 
 
 class ReleaseAdmin(admin.ModelAdmin):
     pass
 
+
 class ToasterSettingAdmin(admin.ModelAdmin):
     pass
 
+
+class LayerVersionsAdmin(admin.ModelAdmin):
+    pass
+
+admin.site.register(Layer_Version, LayerVersionsAdmin)
 admin.site.register(BitbakeVersion, BitbakeVersionAdmin)
 admin.site.register(Release, ReleaseAdmin)
 admin.site.register(ToasterSetting, ToasterSettingAdmin)
diff --git a/bitbake/lib/toaster/orm/models.py b/bitbake/lib/toaster/orm/models.py
index 72b9dfe..caacc2a 100644
--- a/bitbake/lib/toaster/orm/models.py
+++ b/bitbake/lib/toaster/orm/models.py
@@ -1252,6 +1252,9 @@ class Release(models.Model):
     def __unicode__(self):
         return "%s (%s)" % (self.name, self.branch_name)
 
+    def __str__(self):
+        return self.name
+
 class ReleaseDefaultLayer(models.Model):
     release = models.ForeignKey(Release)
     layer_name = models.CharField(max_length=100, default="")
@@ -1419,6 +1422,14 @@ class Layer_Version(models.Model):
     def __unicode__(self):
         return ("id %d belongs to layer: %s" % (self.pk, self.layer.name))
 
+    def __str__(self):
+        if self.release:
+            release = self.release.name
+        else:
+            release = "No release set"
+
+        return "%d %s (%s)" % (self.pk, self.layer.name, release)
+
 
 class LayerVersionDependency(models.Model):
 
-- 
2.7.4


