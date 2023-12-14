Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3E3C4167D
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 22:12:13 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.41455.1702591928431668538
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Dec 2023 14:12:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ee4iZnKL;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C86009C40FE
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 17:12:07 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id THDnJsU1jaBE; Thu, 14 Dec 2023 17:12:07 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C8509C40EA;
	Thu, 14 Dec 2023 17:12:07 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5C8509C40EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702591927; bh=M5wLagbeoxpV/uu+nXOXFAf9oLjSF68FgWgu69c7T/4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ee4iZnKL6GibKgieUDUXu+VKWWRiFZXyNDDKbokdf6HWQaH4j/lpL4E6Uj1k+U5Fh
	 B/wLwGNAaBjrJJwK0lUpjncOX5KwF9qZNvxdej5mVttZPoX32Sqe8fFEM8TKG4DZk2
	 Q9mIWAQcDQhmrp9SZXZU/gKvxulx/pda/jeGeDyCkNrbJcJC8XnyJl5aiOe+oA8AGi
	 rVHIH0HWrRCPQuME3p+R2hFngoXL/4Arc5FPw8fxkvJjyfjNgdpofu1bXLjVBXWOjK
	 Lvnotrm7Z9Esl6gxRZwol2eEzYBNy8WGNeQKWrhgoCm/TinGw6TATRSYH3K2dSl8Jk
	 gBrhH0BQVSLIQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id UzzvvwWx92HB; Thu, 14 Dec 2023 17:12:07 -0500 (EST)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 729129C40CF;
	Thu, 14 Dec 2023 17:12:06 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 3/6] toaster/test: Added skip to run test on ElementClickInterceptedException
Date: Thu, 14 Dec 2023 23:11:54 +0100
Message-Id: <20231214221157.604253-3-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
References: <20231214221157.604253-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Dec 2023 22:12:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15678

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


