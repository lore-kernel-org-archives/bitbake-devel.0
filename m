Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC9CC07E97
	for <webhook@archiver.kernel.org>; Tue,  5 Dec 2023 16:40:31 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.105781.1701794429706277869
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Dec 2023 08:40:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=wTYCDwBv;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 1A7879C3D7B
	for <bitbake-devel@lists.openembedded.org>; Tue,  5 Dec 2023 11:40:29 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id gK3NtjRaVAVE; Tue,  5 Dec 2023 11:40:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B9DB79C3644;
	Tue,  5 Dec 2023 11:40:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B9DB79C3644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701794428; bh=DgDxLlogWFIcSWBXECT+LkkNme4uZm9L25rdKe/mRpU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=wTYCDwBvNCMMolkjJFQNWZGGGoxfi8Wg1Jwn74GOB/Fb/4jb2VqgjgG7h6r/apN/j
	 59LZT7ecekibaz/3xNt0/KzLkbg4sErLJKii5qAWW5a4NQQzp34BTuC3G3yY6OWI0s
	 Su267UeAOAqh/mzsPBXgKg2wjG5rKcdfL+LbVVkR1lMoHwFtUQwBM1kcvTAYEMqG1h
	 Fzjzu3FbdN5rOx/GruJLWZiMe6+NhW1iSZJdlGR86zve+sGvH8SD0Q5uEmPTVqZLbU
	 wpXS56li+FsvpMn3vhOorQDjRbiGm1P011dUvESZljf9df2a+QGyMOoGJmPkyotKG6
	 5h2XS5cGa9wbA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id T-DKG8RFuqTD; Tue,  5 Dec 2023 11:40:28 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 313899C339D;
	Tue,  5 Dec 2023 11:40:28 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v3 4/4] toaster/test: delay driver action until elements to appear
Date: Tue,  5 Dec 2023 17:40:22 +0100
Message-Id: <20231205164022.151951-4-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
References: <20231205164022.151951-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Dec 2023 16:40:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15616

Update  tests/browser/(test_landing_page.py and test_layerdetails_page.py=
)
to delay driver actions until for elements to appear

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_landing_page.py      | 1 +
 lib/toaster/tests/browser/test_layerdetails_page.py | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
index 7ec52a4b..ca0b2e63 100644
--- a/lib/toaster/tests/browser/test_landing_page.py
+++ b/lib/toaster/tests/browser/test_landing_page.py
@@ -206,6 +206,7 @@ class TestLandingPage(SeleniumTestCase):
=20
         self.get(reverse('landing'))
=20
+        self.wait_until_visible("#latest-builds")
         elements =3D self.find_all('#allbuildstable')
         self.assertEqual(len(elements), 1, 'should redirect to builds')
         content =3D self.get_page_source()
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index cb7b915b..27cda0f2 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -68,6 +68,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
         check that the new values exist"""
=20
         self.get(self.url)
+        self.wait_until_visible("#add-remove-layer-btn")
=20
         self.click("#add-remove-layer-btn")
         self.click("#edit-layer-source")
@@ -105,7 +106,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
         for save_btn in self.find_all(".change-btn"):
             save_btn.click()
=20
-        self.click("#save-changes-for-switch")
+        self.wait_until_visible("#save-changes-for-switch")
+        btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
+        btn_save_chg_for_switch.click()
         self.wait_until_visible("#edit-layer-source")
=20
         # Refresh the page to see if the new values are returned
@@ -134,7 +137,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
         new_dir =3D "/home/test/my-meta-dir"
         dir_input.send_keys(new_dir)
=20
-        self.click("#save-changes-for-switch")
+        self.wait_until_visible("#save-changes-for-switch")
+        btn_save_chg_for_switch =3D self.find("#save-changes-for-switch"=
)
+        btn_save_chg_for_switch.click()
         self.wait_until_visible("#edit-layer-source")
=20
         # Refresh the page to see if the new values are returned
--=20
2.34.1


