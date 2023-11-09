Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CE3C4167D
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 15:17:36 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.124279.1699543050649910770
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 07:17:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Mo2qEptQ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4CE3A9C321E
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 10:17:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id GLcyx2kT2lwX; Thu,  9 Nov 2023 10:17:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BD1579C34BD;
	Thu,  9 Nov 2023 10:17:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BD1579C34BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699543047; bh=JZmB3Td1xeI5Io6+U2xXxBZJobstBIZYu5bzKvGQZcg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Mo2qEptQShaoNTmGP0rDT+bdU5yNgj5TctOb9pjBg1Dp9n8zwSfawH75fXTDaUGvI
	 9lyaHMVfrL4tfXqBKSIwtM7ORtZs3hIrrkHLHjEYKW2BaUi4qnitwKOuxGPC+F7wp7
	 TEchO6EyclbptOdGcjmgLsRi5A1wxkrRYZoV85IYPxzOqI44iBuKh70WFBBe2nzfok
	 c3DKcRrJtOLa9kHmxpEIt3uFrq3T6pDcexVPeo46xYr4HgNuFOCMHQO95G/hKh1dmO
	 MH+Py2qH6zX7sERrmBW4uaHSQzHnG5mUrRqU9ah+0+BusLkQMN9wfv7qhLuvnffuDa
	 PlhTwnlEE2kzA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id tIHdmtwixcXW; Thu,  9 Nov 2023 10:17:27 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 48EFD9C321E;
	Thu,  9 Nov 2023 10:17:25 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 1/3] Toaster: Check info_sign is visible and clickable in landing page
Date: Thu,  9 Nov 2023 16:16:55 +0100
Message-Id: <20231109151657.53358-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 15:17:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15460

Check the information icon is visible and clickable
Also if popup appearing when clicked and contain "Toaster version informa=
tion"

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py | 16 ++++++++++++++++
 lib/toaster/toastergui/templates/base.html     |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index 8bb64b9f..a3aa2f93 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -29,6 +29,22 @@ class TestLandingPage(SeleniumTestCase):
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


