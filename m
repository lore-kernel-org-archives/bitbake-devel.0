Return-Path: <elliot.smith@intel.com>
Received: from gainsboro.cherry.relay.mailchannels.net
	(gainsboro.cherry.relay.mailchannels.net [23.83.223.65])
	by mail.openembedded.org (Postfix) with ESMTP id F0E4F6FFFE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jul 2016 13:44:32 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C39CA21854;
	Thu, 21 Jul 2016 13:44:28 +0000 (UTC)
Received: from uscentral428.accountservergroup.com
	(ip-10-107-69-155.us-west-2.compute.internal [10.107.69.155])
	by relay.mailchannels.net (Postfix) with ESMTPA id 4AD6C219B0;
	Thu, 21 Jul 2016 13:44:28 +0000 (UTC)
X-Sender-Id: wwwh|x-authuser|elliot@townx.org
Received: from uscentral428.accountservergroup.com ([TEMPUNAVAIL].
	[10.135.9.54]) (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.1); Thu, 21 Jul 2016 13:44:28 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: wwwh|x-authuser|elliot@townx.org
X-MailChannels-Auth-Id: wwwh
X-MC-Loop-Signature: 1469108702562:2712886907
X-MC-Ingress-Time: 1469108702562
Received: from [176.249.240.35] (port=56888 helo=localhost.localdomain)
	by uscentral428.accountservergroup.com with esmtpa (Exim 4.87)
	(envelope-from <elliot.smith@intel.com>)
	id 1bQEH0-0002ZY-2q; Thu, 21 Jul 2016 09:44:22 -0400
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2016 14:43:24 +0100
Message-Id: <1469108612-12433-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
References: <1469108612-12433-1-git-send-email-elliot.smith@intel.com>
X-AuthUser: elliot@townx.org
Subject: [PATCH][v2 02/10] toaster: bldcollector admin Remove LayerSourceAdmin
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
X-List-Received-Date: Thu, 21 Jul 2016 13:44:36 -0000

From: Michael Wood <michael.g.wood@intel.com>

Remove the LayerSource admin from django admin interface. LayerSources
are not going to be manageable from the admin interface.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/toaster/bldcollector/admin.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/bitbake/lib/toaster/bldcollector/admin.py b/bitbake/lib/toaster/bldcollector/admin.py
index c1f85d7..7b69ecd 100644
--- a/bitbake/lib/toaster/bldcollector/admin.py
+++ b/bitbake/lib/toaster/bldcollector/admin.py
@@ -1,15 +1,12 @@
 from django.contrib import admin
 from django.contrib.admin.filters import RelatedFieldListFilter
-from orm.models import BitbakeVersion, Release, LayerSource, ToasterSetting
+from orm.models import BitbakeVersion, Release, ToasterSetting
 from django.forms.widgets import Textarea
 from django import forms
 import django.db.models as models
 
 from django.contrib.admin import widgets, helpers
 
-class LayerSourceAdmin(admin.ModelAdmin):
-    pass
-
 class BitbakeVersionAdmin(admin.ModelAdmin):
 
     # we override the formfield for db URLField because of broken URL validation
@@ -27,7 +24,6 @@ class ReleaseAdmin(admin.ModelAdmin):
 class ToasterSettingAdmin(admin.ModelAdmin):
     pass
 
-admin.site.register(LayerSource, LayerSourceAdmin)
 admin.site.register(BitbakeVersion, BitbakeVersionAdmin)
 admin.site.register(Release, ReleaseAdmin)
 admin.site.register(ToasterSetting, ToasterSettingAdmin)
-- 
2.7.4


