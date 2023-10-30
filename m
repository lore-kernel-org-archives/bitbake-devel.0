Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B0EC4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 22:26:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.172790.1698704789391039261
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 15:26:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=RyPqr0f0;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AEF129C332D
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 18:26:28 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id A4MnrUOaBY6o; Mon, 30 Oct 2023 18:26:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 24FE29C3231;
	Mon, 30 Oct 2023 18:26:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 24FE29C3231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698704788; bh=dJpALff2FRALUs6m+BZZFjVAVIE4fVkTGptccUjZhD8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=RyPqr0f0MoxFmF4yKw3VoXgMHSh0JccPWXoNITzFYNAkcs6gy5XGT25WO1BLFhGTw
	 eSWMeqoBOEqkEJGwE4p8vMK0j5J0Ji2tUJH+dAaHTFxZEVMoKXLf9rUCddpFrheOJz
	 4DGHSIssZzJDMPHB9wTHEG96/BU2/3c9mNJ9x3jogDvRkGR6tU2i9LhDYurK5n7pNU
	 YUetbmv83RBshbm26ydbSNDDwTvBo6ijr8KBYQm3i45MzwXmNl/ineeNfg7xepbk/6
	 WkpVJPop14kuEzhLZm6kFOU0vpUyo5KvnB0nFrvMPZhVttQTvJtWdOBH3TMTUmnr/F
	 4hB+Vsil/uxvw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id PXDkPQd7_9lo; Mon, 30 Oct 2023 18:26:27 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1F0999C0C62;
	Mon, 30 Oct 2023 18:26:26 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/3] Toaster: Check info_sign is visible and clickable in landing page
Date: Mon, 30 Oct 2023 23:26:16 +0100
Message-Id: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 22:26:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15333

Check the information icon is visible and clickable
Also if popup appearing when clicked and contain "Toaster version informa=
tion"

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 17 +++++++++++++++++
 lib/toaster/toastergui/templates/base.html     |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index 8bb64b9f..2f092400 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -7,6 +7,7 @@
 # Copyright (C) 2013-2016 Intel Corporation
 #
=20
+from time import sleep
 from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
@@ -29,6 +30,22 @@ class TestLandingPage(SeleniumTestCase):
         self.project.is_default =3D True
         self.project.save()
=20
+    def test_icon_info_visible_and_clickable(self):
+        """ Test that the information icon is visible and clickable """
+        self.get(reverse('landing'))
+        info_sign =3D self.find('#toaster-version-info-sign')
+
+        # check that the info sign is visible
+        self.assertTrue(info_sign.is_displayed())
+
+        # check that the info sign is clickable
+        # and info modal is appearing when clicking on the info sign
+        info_sign.click() # click on the info sign make attribute 'aria-=
describedby' visible
+        info_model_id =3D info_sign.get_attribute('aria-describedby')
+        info_modal =3D self.find(f'#{info_model_id}')
+        self.assertTrue(info_modal.is_displayed())
+        self.assertTrue("Toaster version information" in info_modal.text=
)
+
     def test_only_default_project(self):
         """
         No projects except default
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toa=
stergui/templates/base.html
index e8600f3e..041448d1 100644
--- a/lib/toaster/toastergui/templates/base.html
+++ b/lib/toaster/toastergui/templates/base.html
@@ -94,7 +94,7 @@
             </a>
             <a class=3D"brand" href=3D"/">Toaster</a>
             {% if DEBUG %}
-            <span class=3D"glyphicon glyphicon-info-sign" title=3D"<stro=
ng>Toaster version information</strong>" data-content=3D"<dl><dt>Git bran=
ch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git revision</dt><dd>{{TOASTER_REVI=
SION}}</dd></dl>"></i>
+            <span id=3D"toaster-version-info-sign" class=3D"glyphicon gl=
yphicon-info-sign" title=3D"<strong>Toaster version information</strong>"=
 data-content=3D"<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Gi=
t revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
             {% endif %}
           </div>
         </div>
--=20
2.34.1


