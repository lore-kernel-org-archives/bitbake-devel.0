Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C944C4167B
	for <webhook@archiver.kernel.org>; Wed, 29 Nov 2023 22:54:28 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.57411.1701298461492440158
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Nov 2023 14:54:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Ywg72fSQ;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C170F9C3636
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 17:54:20 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id CbYI9lQN2oMy; Wed, 29 Nov 2023 17:54:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5E4399C341E;
	Wed, 29 Nov 2023 17:54:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5E4399C341E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701298460; bh=b+X1Nxo9h2mxAwycXWsbLpYJ/UbzQ3mGaMOTvM09yYk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Ywg72fSQJGoq/vHeeMe6GlZXrB2fvK5xvNZYH/4w/rC1kr1whnSXhMBKFiDDx+X2w
	 SaBodxg/qVlvAzgBIcm9y9hpoyMv+w+s65EEd7mCHrlufzGtPtY2E8OojlO0sb9XsA
	 ofYChA4jlm7nPG5pjA8Sy+xT/aa4KPw5z7oELSTFaewlBDNxWUtl0/JgYT1HWXOLem
	 TCNhOOpYKPr0lh4Pv3K4dJQevN2irYGRtc2VvXrNbAOxmcmo0qFTho0HJpGI0irbaO
	 lj3Rd92ryoKe8B0HmwCvJP4ao7/CrJUZg73AqOD2zBHYO1Fux2V6XlxPpZoHWPm2Av
	 vt9Pw7U42pC8w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id myHQ34Nl9EnC; Wed, 29 Nov 2023 17:54:20 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A8F079C279F;
	Wed, 29 Nov 2023 17:54:19 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/9] toaster/tests: Update methods wait_until_~ to skip using time.sleep
Date: Wed, 29 Nov 2023 23:54:08 +0100
Message-Id: <20231129225416.479526-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Nov 2023 22:54:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15580

Update Class Wait from selenium_helpers_base, to override
wait_until_visible and wait_until_present with poll argument to better
handle delay between driver actions

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toa=
ster/tests/browser/selenium_helpers_base.py
index e0ac4376..d9ea7fd1 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -71,7 +71,9 @@ class Wait(WebDriverWait):
     _TIMEOUT =3D 10
     _POLL_FREQUENCY =3D 0.5
=20
-    def __init__(self, driver):
+    def __init__(self, driver, timeout=3D_TIMEOUT, poll=3D_POLL_FREQUENC=
Y):
+        self._TIMEOUT =3D timeout
+        self._POLL_FREQUENCY =3D poll
         super(Wait, self).__init__(driver, self._TIMEOUT, self._POLL_FRE=
QUENCY)
=20
     def until(self, method, message=3D''):
@@ -175,18 +177,19 @@ class SeleniumTestCaseBase(unittest.TestCase):
         """ Return the element which currently has focus on the page """
         return self.driver.switch_to.active_element
=20
-    def wait_until_present(self, selector):
+    def wait_until_present(self, selector, poll=3D0.5):
         """ Wait until element matching CSS selector is on the page """
         is_present =3D lambda driver: self.find(selector)
         msg =3D 'An element matching "%s" should be on the page' % selec=
tor
-        element =3D Wait(self.driver).until(is_present, msg)
+        element =3D Wait(self.driver, poll=3Dpoll).until(is_present, msg=
)
         return element
=20
-    def wait_until_visible(self, selector):
+    def wait_until_visible(self, selector, poll=3D1):
         """ Wait until element matching CSS selector is visible on the p=
age """
         is_visible =3D lambda driver: self.find(selector).is_displayed()
         msg =3D 'An element matching "%s" should be visible' % selector
-        Wait(self.driver).until(is_visible, msg)
+        Wait(self.driver, poll=3Dpoll).until(is_visible, msg)
+        time.sleep(poll)  # wait for visibility to settle
         return self.find(selector)
=20
     def wait_until_focused(self, selector):
--=20
2.34.1


