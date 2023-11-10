Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C328C05021
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 17:26:37 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.33403.1699637188772834071
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 09:26:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=rdL25uDd;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C581F9C34E1
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 12:26:27 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Mu5ZTRKnaGB2; Fri, 10 Nov 2023 12:26:27 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3FC939C34CA;
	Fri, 10 Nov 2023 12:26:27 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 3FC939C34CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699637187; bh=kIEwiVjvzZ70K0VDS0bIX9+mWNuiMSLUBeif/iWD8FI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=rdL25uDdaW6mImDcNFrMVmYa0T1w/l2tQ/bI8YKqzN/u4BByJPphcG2tk8AnJMzJc
	 HdDU68RAVOIG4iTc1PuOqkfjJBSHJm1fDxXKr1XDytEG+QKd8LRTO6IypAIiuu3bvd
	 GUhoII64zVWIILSZt7InQI9NnLmNDNhOq/LBvXtF+/UIt6ZVTdlWho2fs+NmYho7hR
	 HlRWzoVzRzwy142t0uEsdxq0fB/YmT3NawhItAtDHfgnIRlQHR0wczLKm+V14cQwo+
	 q8y0g0e8ZeF2ehJYV05vrMmTZppOEbNMLojo9eIKADzeKalRdif0F65Q3O3OmlwpzP
	 GrAxv0B0BQHcw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id iIYGwcqCBnmC; Fri, 10 Nov 2023 12:26:27 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 731B69C328E;
	Fri, 10 Nov 2023 12:26:26 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 2/6] Toaster: Write UI TestCase -> Visualize all builds
Date: Fri, 10 Nov 2023 18:26:16 +0100
Message-Id: <20231110172620.396838-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
References: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 17:26:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15507

Check search box for a build by recipe name
Test the search box in the builds table on the all builds page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index d4312bb3..eb14f89d 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -11,6 +11,7 @@ import re, time
=20
 from django.urls import reverse
 from django.utils import timezone
+from selenium.webdriver.remote.webdriver import WebElement
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
 from orm.models import BitbakeVersion, Release, Project, Build, Target
@@ -102,6 +103,18 @@ class TestAllBuildsPage(SeleniumTestCase):
=20
         return found_row
=20
+    def _get_create_builds(self, **kwargs):
+        """ Create a build and return the build object """
+        build1 =3D Build.objects.create(**self.project1_build_success)
+        build2 =3D Build.objects.create(**self.project1_build_failure)
+
+        # add some targets to these builds so they have recipe links
+        # (and so we can find the row in the ToasterTable corresponding =
to
+        # a particular build)
+        Target.objects.create(build=3Dbuild1, target=3D'foo')
+        Target.objects.create(build=3Dbuild2, target=3D'bar')
+        return build1, build2
+
     def test_show_tasks_with_suffix(self):
         """ Task should be shown as suffix on build name """
         build =3D Build.objects.create(**self.project1_build_success)
@@ -146,7 +159,6 @@ class TestAllBuildsPage(SeleniumTestCase):
         self.assertEqual(len(run_again_button), 0,
                          'should not see a rebuild button for cli builds=
')
=20
-
     def test_tooltips_on_project_name(self):
         """
         Test tooltips shown next to project name in the main table
@@ -188,14 +200,7 @@ class TestAllBuildsPage(SeleniumTestCase):
         recent builds area; failed builds should not have links on the t=
ime column,
         or in the recent builds area
         """
-        build1 =3D Build.objects.create(**self.project1_build_success)
-        build2 =3D Build.objects.create(**self.project1_build_failure)
-
-        # add some targets to these builds so they have recipe links
-        # (and so we can find the row in the ToasterTable corresponding =
to
-        # a particular build)
-        Target.objects.create(build=3Dbuild1, target=3D'foo')
-        Target.objects.create(build=3Dbuild2, target=3D'bar')
+        build1, build2 =3D self._get_create_builds()
=20
         url =3D reverse('all-builds')
         self.get(url)
@@ -223,3 +228,23 @@ class TestAllBuildsPage(SeleniumTestCase):
         links =3D build2_row.find_elements(By.CSS_SELECTOR, 'td.time a')
         msg =3D 'should not be a link on the build time for a failed bui=
ld'
         self.assertEquals(len(links), 0, msg)
+
+    def test_builds_table_search_box(self):
+        """ Test the search box in the builds table on the all builds pa=
ge """
+        self._get_create_builds()
+
+        url =3D reverse('all-builds')
+        self.get(url)
+
+        # Check search box is present and works
+        self.wait_until_present('#allbuildstable tbody tr')
+        search_box =3D self.find('#search-input-allbuildstable')
+        self.assertTrue(search_box.is_displayed())
+
+        # Check that we can search for a build by recipe name
+        search_box.send_keys('foo')
+        search_btn =3D self.find('#search-submit-allbuildstable')
+        search_btn.click()
+        self.wait_until_present('#allbuildstable tbody tr')
+        rows =3D self.find_all('#allbuildstable tbody tr')
+        self.assertTrue(len(rows) >=3D 1)
--=20
2.34.1


