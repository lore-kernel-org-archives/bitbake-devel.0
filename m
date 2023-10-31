Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E84C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 18:45:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.3760.1698777918747394310
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 11:45:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=CQ0FM7ZC;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1CE7A9C0BB2
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:45:18 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id cae9cRONNljK; Tue, 31 Oct 2023 14:45:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 616B79C2929;
	Tue, 31 Oct 2023 14:45:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 616B79C2929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698777917; bh=MBSnmLTwcXDbaohcWaAGUlvvbZe6pLTYUEpAY3L08ZQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=CQ0FM7ZCy+cgNpX/uJX6CU4gMcgfgpr2f6EBDPF5rn+adtnqX+tn8WLlLSIZ3k56I
	 iKrFP/bhHML9j8KVISpRowarKAKdbfKRQP7KYlbCTN7CumR3plpXZAIIQ0k/hRuocQ
	 HdAOHmo3+3oQPDeEP/WgACkKlSdGmRuW8dq4FdNVnwUmtoXofDsDA6ckzX8BwiOK4k
	 FsBhC//6gNbraZEN7Gxo3PBQ0p6vrcn40glrRSf3O6g7hhGcFxJaQDA5IdYsBIDEAe
	 MaBpY58qu3OvB8uKd0Yl6PSMe9rCeJ8dvsFC3iNEWL1Z/wRn5ORoMzyO/8SHRLXsyq
	 gyzzI+dM+S7oA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Dw1l6O6V08yH; Tue, 31 Oct 2023 14:45:17 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1BDE69C0BB2;
	Tue, 31 Oct 2023 14:45:15 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 3/3] Toaster: Test jumbotron links visible and clickable
Date: Tue, 31 Oct 2023 19:44:38 +0100
Message-Id: <20231031184438.743924-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 18:45:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15379

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
index e731af22..756497bd 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -12,7 +12,7 @@ from django.urls import reverse
 from django.utils import timezone
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
-from orm.models import Project, Build
+from orm.models import Layer, Layer_Version, Project, Build
=20
 class TestLandingPage(SeleniumTestCase):
     """ Tests for redirects on the landing page """
@@ -61,6 +61,93 @@ class TestLandingPage(SeleniumTestCase):
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


