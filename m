Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF626C3DA6E
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 21:10:15 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.1022.1704748214902235211
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 13:10:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=aY0I8YRs;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2FE759C327C
	for <bitbake-devel@lists.openembedded.org>; Mon,  8 Jan 2024 16:10:14 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id M9YwV09Xiq3D; Mon,  8 Jan 2024 16:10:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C16C19C4165;
	Mon,  8 Jan 2024 16:10:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C16C19C4165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1704748213; bh=kpj+6CIInwQFgN8SSYHTGNzQ3CjEKsnTJc/AuKY1yu8=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=aY0I8YRs5xKkD4trHwUfDuTxiHTd+EVreVzrrVpETO9xyFqCFTKNjQba1NotYCw+C
	 t8M//9azhSprk1GlKbZSKCjvhgWdQ/hOmVXTTqrfQNeKKx0AT4vtuC0JODsOQRTmZC
	 58ABQi9H8x+ZMdI7MWDSfLSYhmV2Y4SH0oaLtnddFSCiwuemPsTZXH25Q7PE7LDV6L
	 qws8vP0q5Pl8SyuglwC5t5+IfKPhvNm8w5m+wHfCuKjBPdBwlgtXORMdmsZG4mRXC0
	 vOgsi4oBZDbNfznSEpnyfNl/HBWLswg/XcZruIa3xOqnZSIg8P4jEC7FaRAkMGKBkj
	 9q+wNl/8+H74g==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 4yV7b8flGbSQ; Mon,  8 Jan 2024 16:10:13 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E190C9C327C;
	Mon,  8 Jan 2024 16:10:12 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] toaster/test: Setup delay after drvier action self.get(url)
Date: Mon,  8 Jan 2024 22:10:08 +0100
Message-Id: <20240108211008.229698-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 21:10:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15752

Recurring test failures result from insufficient delays in driver actions=
.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/selenium_helpers_base.py      | 7 +++++++
 lib/toaster/tests/browser/test_all_builds_page.py       | 4 +++-
 lib/toaster/tests/browser/test_builddashboard_page.py   | 1 +
 lib/toaster/tests/browser/test_new_custom_image_page.py | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index 562fedec..393be754 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -182,6 +182,13 @@ class SeleniumTestCaseBase(unittest.TestCase):
         abs_url =3D '%s%s' % (self.live_server_url, url)
         self.driver.get(abs_url)
=20
+        try:  # Ensure page is loaded before proceeding
+            self.wait_until_visible("#global-nav", poll=3D3)
+        except NoSuchElementException:
+            self.driver.implicitly_wait(3)
+        except TimeoutException:
+            self.driver.implicitly_wait(3)
+
     def find(self, selector):
         """ Find single element by CSS selector """
         return self.driver.find_element(By.CSS_SELECTOR, selector)
diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index 7019b3db..ab6da821 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -224,6 +224,7 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
         url =3D reverse('all-builds')
         self.get(url)
+        self.wait_until_visible('#allbuildstable', poll=3D3)
=20
         # get the project name cells from the table
         cells =3D self.find_all('#allbuildstable td[class=3D"project"]')
@@ -232,7 +233,7 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
         for cell in cells:
             content =3D cell.get_attribute('innerHTML')
-            help_icons =3D cell.find_elements_by_css_selector(selector)
+            help_icons =3D cell.find_elements(By.CSS_SELECTOR, selector)
=20
             if re.search(self.PROJECT_NAME, content):
                 # no help icon next to non-cli project name
@@ -256,6 +257,7 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
         url =3D reverse('all-builds')
         self.get(url)
+        self.wait_until_visible('#allbuildstable', poll=3D3)
=20
         # test recent builds area for successful build
         element =3D self._get_build_time_element(build1)
diff --git a/lib/toaster/tests/browser/test_builddashboard_page.py b/lib/=
toaster/tests/browser/test_builddashboard_page.py
index b713f300..d838ce36 100644
--- a/lib/toaster/tests/browser/test_builddashboard_page.py
+++ b/lib/toaster/tests/browser/test_builddashboard_page.py
@@ -162,6 +162,7 @@ class TestBuildDashboardPage(SeleniumTestCase):
         """
         url =3D reverse('builddashboard', args=3D(build.id,))
         self.get(url)
+        self.wait_until_visible('#global-nav', poll=3D3)
=20
     def _get_build_dashboard_errors(self, build):
         """
diff --git a/lib/toaster/tests/browser/test_new_custom_image_page.py b/li=
b/toaster/tests/browser/test_new_custom_image_page.py
index 4ad22c7a..9f0b6397 100644
--- a/lib/toaster/tests/browser/test_new_custom_image_page.py
+++ b/lib/toaster/tests/browser/test_new_custom_image_page.py
@@ -90,6 +90,7 @@ class TestNewCustomImagePage(SeleniumTestCase):
         """
         url =3D reverse('newcustomimage', args=3D(self.project.id,))
         self.get(url)
+        self.wait_until_visible('#global-nav', poll=3D3)
=20
         self.click('button[data-recipe=3D"%s"]' % self.recipe.id)
=20
--=20
2.34.1


