Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2517C4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 14:28:21 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.13784.1699972093103549559
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 06:28:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=U8Ba4TY3;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 598D29C3596
	for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 09:28:12 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lpeDEXX-h9Za; Tue, 14 Nov 2023 09:28:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BABA49C3452;
	Tue, 14 Nov 2023 09:28:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BABA49C3452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699972091; bh=twnepvkhTDy00mIDQqNgLPrnHR9+yC/0gVty8Trp6MI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=U8Ba4TY3Q01fd4ZazWku+jTolp8H5EFNwZpa4oLdti8Q43iiDSQBUwA4zoPNciiKz
	 s2Fau4B5EphOUYK/j2w3n7zuTzK3B3TPcgLVSDalRotwAhSgbRldPedRRV2yEogP/D
	 PbTdPsu/LNqgLsDxx6KBmX5Na7ze2j4YoA0njAuemWTWfSrWSJLkqEDSEXXTq8orZz
	 88sLtAkVfEH0xAQQeAxIr2NcPGptg7khX9585gxtTXDUGlzwSFezwq3/UzW6wQUwmN
	 oNEFsVPTvNut82wygTTpKHvq+FEc3I1AmribchmJ5C3Ib8eJMUGK5pLj+VLRAcXlSX
	 f6fZ9NZwCo3gA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id e3s1FfcvMAeX; Tue, 14 Nov 2023 09:28:11 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 098369C354D;
	Tue, 14 Nov 2023 09:28:10 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 2/6] Toaster: Write UI TestCase -> Test search box on all build page
Date: Tue, 14 Nov 2023 15:28:02 +0100
Message-Id: <20231114142806.53894-2-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114142806.53894-1-alassane.yattara@savoirfairelinux.com>
References: <20231114142806.53894-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 14:28:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15521

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


