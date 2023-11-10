Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53638C4167D
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 17:26:37 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33672.1699637189492096419
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 09:26:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=HFf07Meo;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D032C9C34CE
	for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 12:26:28 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5NHgrM_K2hNK; Fri, 10 Nov 2023 12:26:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 591679C34CA;
	Fri, 10 Nov 2023 12:26:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 591679C34CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1699637188; bh=dMSUvnJ4UdwccVBzbieZFfOxYEHmH/jbYoRYcw4DpHc=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=HFf07MeoV+vXee5A6K9KMEPKz6e6NfXtQ+EGmZomjb89X6+wyPAyZsuSBPs2wGd6D
	 o2Uhf9fnfAc/DQDErG4HQ52QgVOahpt75x/0WGuXk0SzGPZ9/SrHbthO8OLm3XeWW8
	 72RcenLniKudELSv1d0XwalFkIpRwOlLfWTFTBrpBM62sOYDYykcGlem8ML1AHKvox
	 qQnDKF8j/uSJBAl19rxoFIMwuwq43NUY41mzaUpEAFwslgizygY9Ccxna3Ja4m61nJ
	 YqY1ifT4UBWGuRz/2XjZfCETZiDoLEUPhefiESgtx+emrq4BuMrKI/jC5PxT3bjeMZ
	 I9RoB0HzH+vRA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id rHSK-S2KSyZW; Fri, 10 Nov 2023 12:26:28 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 7954C9C328E;
	Fri, 10 Nov 2023 12:26:27 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/6] Toaster: Write UI TestCase -> Visualize all builds
Date: Fri, 10 Nov 2023 18:26:17 +0100
Message-Id: <20231110172620.396838-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
References: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 17:26:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15508

Test the filtering on failure tasks column in the builds table on the all=
 builds page

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../tests/browser/test_all_builds_page.py     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/toaster/tests/browser/test_all_builds_page.py b/lib/toas=
ter/tests/browser/test_all_builds_page.py
index eb14f89d..81498aa8 100644
--- a/lib/toaster/tests/browser/test_all_builds_page.py
+++ b/lib/toaster/tests/browser/test_all_builds_page.py
@@ -113,6 +113,20 @@ class TestAllBuildsPage(SeleniumTestCase):
         # a particular build)
         Target.objects.create(build=3Dbuild1, target=3D'foo')
         Target.objects.create(build=3Dbuild2, target=3D'bar')
+
+        if kwargs:
+            # Create kwargs.get('success') builds with success status wi=
th target
+            # and kwargs.get('failure') builds with failure status with =
target
+            for i in range(kwargs.get('success', 0)):
+                build =3D Build.objects.create(**self.project1_build_suc=
cess)
+                Target.objects.create(build=3Dbuild,
+                                      target=3Df'{i}_success_recipe',
+                                      task=3Df'{i}_success_task')
+            for i in range(kwargs.get('failure', 0)):
+                build =3D Build.objects.create(**self.project1_build_fai=
lure)
+                Target.objects.create(build=3Dbuild,
+                                      target=3Df'{i}_fail_recipe',
+                                      task=3Df'{i}_fail_task')
         return build1, build2
=20
     def test_show_tasks_with_suffix(self):
@@ -248,3 +262,27 @@ class TestAllBuildsPage(SeleniumTestCase):
         self.wait_until_present('#allbuildstable tbody tr')
         rows =3D self.find_all('#allbuildstable tbody tr')
         self.assertTrue(len(rows) >=3D 1)
+
+    def test_filtering_on_failure_tasks_column(self):
+        """ Test the filtering on failure tasks column in the builds tab=
le on the all builds page """
+        self._get_create_builds(success=3D10, failure=3D10)
+
+        url =3D reverse('all-builds')
+        self.get(url)
+
+        # Check filtering on failure tasks column
+        self.wait_until_present('#allbuildstable tbody tr')
+        failed_tasks_filter =3D self.find('#failed_tasks_filter')
+        failed_tasks_filter.click()
+        # Check popup is visible
+        time.sleep(1)
+        self.wait_until_present('#filter-modal-allbuildstable')
+        self.assertTrue(self.find('#filter-modal-allbuildstable').is_dis=
played())
+        # Check that we can filter by failure tasks
+        build_without_failure_tasks =3D self.find('#failed_tasks_filter\=
\:without_failed_tasks')
+        build_without_failure_tasks.click()
+        # click on apply button
+        self.find('#filter-modal-allbuildstable .btn-primary').click()
+        self.wait_until_present('#allbuildstable tbody tr')
+        # Check if filter is applied, by checking if failed_tasks_filter=
 has btn-primary class
+        self.assertTrue(self.find('#failed_tasks_filter').get_attribute(=
'class').find('btn-primary') !=3D -1)
--=20
2.34.1


