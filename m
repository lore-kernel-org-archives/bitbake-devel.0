Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AD75478271
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 04:11:14 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v7L4BGpg021354
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Aug 2017 21:11:16 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 20 Aug 2017 21:11:15 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Aug 2017 21:02:54 -0700
Message-ID: <3d469f0f6831ca94b0ad6e7d00bb941fcff10feb.1503287968.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1503287968.git.David.Reyna@windriver.com>
References: <cover.1503287968.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 1/1] toaster: support custom Layer Index URL and fixture override
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
X-List-Received-Date: Mon, 21 Aug 2017 04:11:14 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster needs to allow the custom fixture file to specific an
alternate Layer Index URL for users that host their own Layer
Index Server via the 'CUSTOM_LAYERINDEX_SERVER' in
'custom.xml'.

Toaster also needs to allow the ability to completely override
the default fixture files, otherwise that content can leak into
the custom environment (by default the custom fixture is an
overlay that cannot remove existing values from the default
fixture) via the 'CUSTOM_XML_ONLY' value in 'setting.xml'.

[YOCTO #11938]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 lib/toaster/orm/management/commands/lsupdates.py            | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/management/commands/checksettings.py b/lib/toaster/bldcontrol/management/commands/checksettings.py
index d11166e..582114a 100644
--- a/lib/toaster/bldcontrol/management/commands/checksettings.py
+++ b/lib/toaster/bldcontrol/management/commands/checksettings.py
@@ -75,7 +75,10 @@ class Command(BaseCommand):
                         call_command("loaddata", "settings")
                         template_conf = os.environ.get("TEMPLATECONF", "")
 
-                        if "poky" in template_conf:
+                        if ToasterSetting.objects.filter(name='CUSTOM_XML_ONLY').count() > 0:
+                            # only use the custom settings
+                            pass
+                        elif "poky" in template_conf:
                             print("Loading poky configuration")
                             call_command("loaddata", "poky")
                         else:
diff --git a/lib/toaster/orm/management/commands/lsupdates.py b/lib/toaster/orm/management/commands/lsupdates.py
index 0b0d4ff..fac5733 100644
--- a/lib/toaster/orm/management/commands/lsupdates.py
+++ b/lib/toaster/orm/management/commands/lsupdates.py
@@ -81,6 +81,8 @@ class Command(BaseCommand):
         os.system('setterm -cursor off')
 
         self.apiurl = DEFAULT_LAYERINDEX_SERVER
+        if ToasterSetting.objects.filter(name='CUSTOM_LAYERINDEX_SERVER').count() == 1:
+            self.apiurl = ToasterSetting.objects.get(name = 'CUSTOM_LAYERINDEX_SERVER').value
 
         assert self.apiurl is not None
         try:
@@ -92,7 +94,9 @@ class Command(BaseCommand):
 
         proxy_settings = os.environ.get("http_proxy", None)
 
-        def _get_json_response(apiurl=DEFAULT_LAYERINDEX_SERVER):
+        def _get_json_response(apiurl=None):
+            if None == apiurl:
+                apiurl=self.apiurl
             http_progress = Spinner()
             http_progress.start()
 
-- 
1.9.1


