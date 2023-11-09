Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15259C4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 15:17:56 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.124298.1699543075784637620
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Nov 2023 07:17:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=S3NwrYTF;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D15D79C321E
	for <bitbake-devel@lists.openembedded.org>; Thu,  9 Nov 2023 10:17:54 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id EYGQq0_ZZjqq; Thu,  9 Nov 2023 10:17:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D58719C34BD;
	Thu,  9 Nov 2023 10:17:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D58719C34BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699543073; bh=TrT/Cr+jy4rZ0rASZ4DjpwsMwJI5T5lROFANfgvcaTk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=S3NwrYTFUVF7Ea5OEbOkiOZfcr40Myi+8g6zEjhQaALNBhVla1Du54AMEXp7tgB+W
	 CiLS6bKVpChkVCA8hAeM1wT2vxSkbwgz6l6s6lQaKJjc/PfzRgy/z36z5SdyASguiB
	 M+p/92Ubt/NKcRK5OOgTwnTWCbyP2d7fqsyIsE2drguYVHgdLtc74UpwUjg9OIhe/J
	 ZoVBO7fhSwSJrQ83erfvS5SLI8a51my0nBeVLbSV31rCOO+atk+eAwR5uwRFuH2hKD
	 MMyfViw4i9nR/loywM8VjC/Bl+E17UZtwgWgzi0ZIjimvudG/QpcI3rPJPSY3wrAzg
	 008VdH7SCl0Vg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uSq3M1Z_88N1; Thu,  9 Nov 2023 10:17:53 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A71069C321E;
	Thu,  9 Nov 2023 10:17:44 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v4 3/3] Toaster: Test jumbotron links visible and clickable
Date: Thu,  9 Nov 2023 16:16:57 +0100
Message-Id: <20231109151657.53358-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109151657.53358-1-alassane.yattara@savoirfairelinux.com>
References: <20231109151657.53358-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Nov 2023 15:17:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15462

Test that the followings link are visible and clickable:
 - OpenEmbedded
 - BitBake
 - Yocto Project
 - Read the Toaster manual
 - Contribute to Toaster

 - Fixed typo: using instead of usign line:97
 - Remove whitespace

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_landing_page.py        | 89 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index 771e627a..7b425344 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -11,7 +11,7 @@ from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
-from orm.models import Project, Build
+from orm.models import Layer, Layer_Version, Project, Build
=20
 class TestLandingPage(SeleniumTestCase):
     """ Tests for redirects on the landing page """
@@ -60,6 +60,93 @@ class TestLandingPage(SeleniumTestCase):
             'http://docs.yoctoproject.org/toaster-manual/index.html#toas=
ter-user-manual')
         self.assertTrue("Documentation" in documentation_link.text)
=20
+    def test_openembedded_jumbotron_link_visible_and_clickable(self):
+        """ Test OpenEmbedded link jumbotron is visible and clickable: "=
""
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check OpenEmbedded
+        openembedded =3D jumbotron.find_element_by_link_text('OpenEmbedd=
ed')
+        self.assertTrue(openembedded.is_displayed())
+        openembedded.click()
+        self.assertTrue("openembedded.org" in self.driver.current_url)
+
+    def test_bitbake_jumbotron_link_visible_and_clickable(self):
+        """ Test BitBake link jumbotron is visible and clickable: """
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check BitBake
+        bitbake =3D jumbotron.find_element_by_link_text('BitBake')
+        self.assertTrue(bitbake.is_displayed())
+        bitbake.click()
+        self.assertTrue("yoctoproject.org/software-item/bitbake" in self=
.driver.current_url)
+
+    def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
+        """ Test Yocto Project link jumbotron is visible and clickable: =
"""
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check Yocto Project
+        yoctoproject =3D jumbotron.find_element_by_link_text('Yocto Proj=
ect')
+        self.assertTrue(yoctoproject.is_displayed())
+        yoctoproject.click()
+        self.assertTrue("yoctoproject.org" in self.driver.current_url)
+
+    def test_link_setup_using_toaster_visible_and_clickable(self):
+        """ Test big magenta button setting up and using toaster link in=
 jumbotron
+            if visible and clickable
+        """
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check Big magenta button
+        big_magenta_button =3D jumbotron.find_element_by_link_text(
+            'Toaster is ready to capture your command line builds'
+        )
+        self.assertTrue(big_magenta_button.is_displayed())
+        big_magenta_button.click()
+        self.assertTrue("docs.yoctoproject.org/toaster-manual/setup-and-=
use.html#setting-up-and-using-toaster" in self.driver.current_url)
+
+    def test_link_create_new_project_in_jumbotron_visible_and_clickable(=
self):
+        """ Test big blue button create new project jumbotron if visible=
 and clickable """
+        # Create a layer and a layer version to make visible the big blu=
e button
+        layer =3D Layer.objects.create(name=3D'bar')
+        Layer_Version.objects.create(layer=3Dlayer)
+
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check Big Blue button
+        big_blue_button =3D jumbotron.find_element_by_link_text(
+            'Create your first Toaster project to run manage builds'
+        )
+        self.assertTrue(big_blue_button.is_displayed())
+        big_blue_button.click()
+        self.assertTrue("toastergui/newproject/" in self.driver.current_=
url)
+
+    def test_toaster_manual_link_visible_and_clickable(self):
+        """ Test Read the Toaster manual link jumbotron is visible and c=
lickable: """
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check Read the Toaster manual
+        toaster_manual =3D jumbotron.find_element_by_link_text('Read the=
 Toaster manual')
+        self.assertTrue(toaster_manual.is_displayed())
+        toaster_manual.click()
+        self.assertTrue("https://docs.yoctoproject.org/toaster-manual/in=
dex.html#toaster-user-manual" in self.driver.current_url)
+
+    def test_contrib_to_toaster_link_visible_and_clickable(self):
+        """ Test Contribute to Toaster link jumbotron is visible and cli=
ckable: """
+        self.get(reverse('landing'))
+        jumbotron =3D self.find('.jumbotron')
+
+        # check Contribute to Toaster
+        contribute_to_toaster =3D jumbotron.find_element_by_link_text('C=
ontribute to Toaster')
+        self.assertTrue(contribute_to_toaster.is_displayed())
+        contribute_to_toaster.click()
+        self.assertTrue("wiki.yoctoproject.org/wiki/contribute_to_toaste=
r" in str(self.driver.current_url).lower())
+
     def test_only_default_project(self):
         """
         No projects except default
--=20
2.34.1


