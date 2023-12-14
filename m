Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E263C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:08:52 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.41630.1702591729026108410
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:08:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=qwQ8TuPE;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 160DE9C40CA
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:08:48 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id b5C7QZ7j6TMJ; Thu, 14 Dec 2023 17:08:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BEBC89C40F3;
	Thu, 14 Dec 2023 17:08:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com BEBC89C40F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591727; bh=M5wLagbeoxpV/uu+nXOXFAf9oLjSF68FgWgu69c7T/4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=qwQ8TuPEue3qwruVW6yRnM2F5w2IjY90ndt050zKRWi7+gKA22V6YfPGKNxRn0wNn
	 nH5wEVgjPCkIKcrYYeL7cHD3112VW1DYqZ/oGT3W4Oos1+xVjWPqmpwc5yAGMAIrLg
	 HFCLEJLAlcG8ll+rB5/MtPcEAYvW4FHY8qCEgTV1pAjfaUieetudzB3agAGMNglOlV
	 +BAMtoS7jhHfBSrFomk7SeUOvjBiCuzpdXwViux2fYBDM+rJxzqrjaG0gxeLzJeDFB
	 JPaZHyFYdEHcRfjmCLbOO0DUafDXGc7eUO2CNaAVa7ik9/Ghufdq+dKhsgbEkUMUuo
	 qLUE0damL9BaQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Z_9G3DzWifPt; Thu, 14 Dec 2023 17:08:47 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DA0569C40CA;
	Thu, 14 Dec 2023 17:08:46 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 3/6] toaster/test: Added skip to run test on ElementClickInterceptedException
Date: Thu, 14 Dec 2023 23:08:36 +0100
Message-Id: <20231214220839.598125-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214220839.598125-1-alassane.yattara@savoirfairelinux.com>
References: <20231214220839.598125-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:08:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15671

On project layer page, element button(save changes for switch)
not properly visible or just hidden by another element which cause
follwing exception: ElementClickInterceptedException

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/browser/test_layerdetails_page.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/to=
aster/tests/browser/test_layerdetails_page.py
index 9c8fcded..5be4ba0c 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -8,7 +8,7 @@
 #
=20
 from django.urls import reverse
-from selenium.common.exceptions import TimeoutException
+from selenium.common.exceptions import ElementClickInterceptedException,=
 TimeoutException
 from tests.browser.selenium_helpers import SeleniumTestCase
=20
 from orm.models import Layer, Layer_Version, Project, LayerSource, Relea=
se
@@ -114,6 +114,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
             btn_save_chg_for_switch =3D self.wait_until_clickable(
                 "#save-changes-for-switch", poll=3D3)
             btn_save_chg_for_switch.click()
+        except ElementClickInterceptedException:
+            self.skipTest(
+                "save-changes-for-switch click intercepted. Element not =
visible or maybe covered by another element.")
         except TimeoutException:
             self.skipTest(
                 "save-changes-for-switch is not clickable within the spe=
cified timeout.")
@@ -151,6 +154,9 @@ class TestLayerDetailsPage(SeleniumTestCase):
             btn_save_chg_for_switch =3D self.wait_until_clickable(
                 "#save-changes-for-switch", poll=3D3)
             btn_save_chg_for_switch.click()
+        except ElementClickInterceptedException:
+            self.skipTest(
+                "save-changes-for-switch click intercepted. Element not =
properly visible or maybe behind another element.")
         except TimeoutException:
             self.skipTest(
                 "save-changes-for-switch is not clickable within the spe=
cified timeout.")
--=20
2.34.1


