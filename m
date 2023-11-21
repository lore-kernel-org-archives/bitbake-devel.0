Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D5DC61D92
	for <webhook@archiver.kernel.org>; Tue, 21 Nov 2023 13:51:40 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.40846.1700574700016725226
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Nov 2023 05:51:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YPWRQ3Mu;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5A2169C34C8
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 08:51:39 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IoHGmyISSTLU; Tue, 21 Nov 2023 08:51:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CB95A9C3373;
	Tue, 21 Nov 2023 08:51:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com CB95A9C3373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1700574698; bh=IbzO8ajXGLqcGJ3WeOF9EixSDD53qzKB/Ky1aD8zz5A=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YPWRQ3MuS4Rwge8BTg9J8iiEmfz761nB5U69ltfmcUZJp+6FkcrPZC9+yDt1C3IYN
	 LDAFLhs9C00R1t7J4raDUDj0Drsekt4VleUXhrS+2EpFa6u7oLk0xYPtS7FvzmmcWz
	 iCUBndH5q5+HQhOmsqrQrjiGHiQWhpquuphe+ifjCXpZ/MQORJ/xxeywO8VxJjk3vZ
	 QTM0rzySL38GQ+8KgB7mjBlnihnMEjenAxF7mW+flhqU9GBuADv26N3A/eF8Q6IhWD
	 yvuHmxmmHnhPb9QnoJg488gV7rMj/fgFbw0P4PDytTaLFYMAFK8sye0llJczoURzVy
	 uSsx4lNnGsCuA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id x3XIR0NtjjEE; Tue, 21 Nov 2023 08:51:38 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E86CD9C349D;
	Tue, 21 Nov 2023 08:51:37 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/7] Toaster: Write UI TestCase -> Test project page tab import layer
Date: Tue, 21 Nov 2023 14:51:27 +0100
Message-Id: <20231121135131.107330-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
References: <20231121135131.107330-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Nov 2023 13:51:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15554

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 .../test_project_page_tab_config.py           | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/lib/toaster/tests/functional/test_project_page_tab_config.py=
 b/lib/toaster/tests/functional/test_project_page_tab_config.py
index ca3b88d2..14a859a1 100644
--- a/lib/toaster/tests/functional/test_project_page_tab_config.py
+++ b/lib/toaster/tests/functional/test_project_page_tab_config.py
@@ -306,3 +306,46 @@ class TestProjectConfigTab(SeleniumFunctionalTestCas=
e):
         )
         cancel_button.click()
         self.assertTrue(len(lastest_builds) =3D=3D 2)
+
+    def test_project_page_tab_importlayer(self):
+        """ Test project page tab import layer """
+        # navigate to the project page
+        url =3D reverse("project", args=3D(1,))
+        self.get(url)
+
+        # navigate to "Import layers" tab
+        import_layers_tab =3D self._get_tabs()[2]
+        import_layers_tab.find_element(By.TAG_NAME, 'a').click()
+        self.wait_until_visible('#layer-git-repo-url')
+
+        # Check git repo radio button
+        git_repo_radio =3D self.find('#git-repo-radio')
+        git_repo_radio.click()
+
+        # Set git repo url
+        input_repo_url =3D self.find('#layer-git-repo-url')
+        input_repo_url.send_keys('git://git.yoctoproject.org/meta-fake')
+        # Blur the input to trigger the validation
+        input_repo_url.send_keys(Keys.TAB)
+
+        # Check name is set
+        input_layer_name =3D self.find('#import-layer-name')
+        self.assertTrue(input_layer_name.get_attribute('value') =3D=3D '=
meta-fake')
+
+        # Set branch
+        input_branch =3D self.find('#layer-git-ref')
+        input_branch.send_keys('master')
+
+        # Import layer
+        self.find('#import-and-add-btn').click()
+
+        # Check layer is added
+        self.wait_until_visible('#layer-container')
+        block_l =3D self.driver.find_element(
+            By.XPATH, '//*[@id=3D"project-page"]/div[2]')
+        layers =3D block_l.find_element(By.ID, 'layer-container')
+        layers_list =3D layers.find_element(By.ID, 'layers-in-project-li=
st')
+        layers_list_items =3D layers_list.find_elements(By.TAG_NAME, 'li=
')
+        self.assertTrue(
+            'meta-fake' in str(layers_list_items[-1].text)
+        )
--=20
2.34.1


