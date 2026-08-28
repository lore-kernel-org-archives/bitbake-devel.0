Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC92DC61DB9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 21:33:43 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.645.1787952819806972514
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 14:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ANV+0nfQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b9320423cso13324055e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787952818; x=1788557618; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gzPJryDAbCSTyNGQi6zxuJJbvZWn6wwQV+IBVRDEZc4=;
        b=ANV+0nfQaNoSHtCVZ4klFr1FYGxAt6jJLjh2sm8RB0f6nfPn0YlLVeC4K0MgXUgu2A
         bwyIL0djrFIVuRc9SMQM1O9IVVJnMtBKXHZn+Oes4H+/WBK0cHaauB3aSFc4G0dvPdby
         j7KHVS/ny8c0N77EGshHFDrjO5jAP679sedco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787952818; x=1788557618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gzPJryDAbCSTyNGQi6zxuJJbvZWn6wwQV+IBVRDEZc4=;
        b=TtubvxKwy59axYZQJ/bGBgA3K+0/Y/D1gCms7To8eipIJH9IMon7aBu5PTswaQUX1G
         L3xMwnGAVFXD8V6EdwN0Emlb9Q35pgtdzBBBISjzBTLkkuxdf/pPPrDAJfBVg1YV6I+U
         fimiGhN0B4DAc3cKDZqGYEikbtNeZ4AilpGe6eq8TUXk9hUl4dywaYnPuZPZTBajvpOW
         UP06GHynWvzsY3TTfESgGCIg/steEgGngSmnY1vRA2he3uRr6iYA68sEm2MVT/NzNlY5
         cpfsQ2tZyCY3rqTkZBE83oK/UegmldRaQNbkhgQQ/VDqmvH4etqULP6MMhb8/DJJonaY
         Zdbw==
X-Gm-Message-State: AFuF++nVLoV5PxSlfUbMiAW4huM0/cjQzxNotAFyIKm/B0I4idczF7uo
	5kw0g30AdoCKctbZrX31r8Y5Vct8D9jIwXHr7DtBEsn1x0BsAgmKc1Dl1hGDhWsdZXlKIXvDsfQ
	tnAOFuW8=
X-Gm-Gg: AR+sD12HwL29vc+F34VMz7XQ8hrNEvWXNXie6FgwNg3AGbQiBNM4xDw9hvGXsQSu+qn
	3ftswHGM49SUb3u8xX1Uz0iJpBIZ6DRWr3iFv35g26vCo7Dpt2VquekWHL3Ziygu5e7KBvsrWD6
	3yIrKucWqWT0dfEaJZ2KaHZXjtzvuIc/uxc0otjMATh3k22FFgfD6Cgx6tDuQ7LOvd97GqSLawZ
	2NIRaROGv94xBGtzgFQT3F9MeJKShO6ADOulDt6bMIdURoVSY0UjA11ZQQnxsrNdg7eIziGRlOH
	UNnc+gblkIHqM/DfD1yiepJ2PJO6AA2/+Sg4vxhlTE4yon/CoTa9mHR3vLAloRBsvKpX4m2Wfhp
	8L1tLFbbb6u/p9l1spRTsJMNIvsvNkOnA4luEDWixfCQtsQk3d45FU61MhznRWt3re3f10TmPaK
	zOC+Gg2KGQZtAN12gY+gHa8xRFBe98DIAovmRqnLwBeesmXUNUcmVB+eRMAiX/9aOqcPpoFq6bX
	Bjuzt1YWyT4aP9/jA==
X-Received: by 2002:a05:600d:13:b0:49b:9205:45b3 with SMTP id 5b1f17b1804b1-49b920547fcmr137439295e9.15.1787952817759;
        Fri, 28 Aug 2026 14:33:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c3f1:c7b4:8368:83c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b926874fdsm88321505e9.4.2026.08.28.14.33.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 14:33:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] toaster/tests: Add and use wait_until_element_visible()
Date: Fri, 28 Aug 2026 22:33:35 +0100
Message-ID: <20260828213336.2038983-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 21:33:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20123

In this test case there are multiple elements matching the selector so the
usual wait function isn't effective. Switch to waiting on the element directly,
adding a new function to allow us to do so.

This function is probably needed in other unreliable places in the tests too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py  | 7 +++++++
 lib/toaster/tests/browser/test_layerdetails_page.py | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 6953541ab55..a901791aa16 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -218,6 +218,13 @@ class SeleniumTestCaseBase(unittest.TestCase):
         element = Wait(self.driver, timeout=timeout).until(is_present, msg)
         return element
 
+    def wait_until_element_visible(self, element, timeout=Wait._TIMEOUT):
+        """ Wait until element matching CSS selector is visible on the page """
+        is_visible = lambda driver: element.is_displayed()
+        msg = 'An element should be visible'
+        Wait(self.driver, timeout=timeout).until(is_visible, msg)
+        return
+
     def wait_until_visible(self, selector, timeout=Wait._TIMEOUT):
         """ Wait until element matching CSS selector is visible on the page """
         is_visible = lambda driver: self.find(selector).is_displayed()
diff --git a/lib/toaster/tests/browser/test_layerdetails_page.py b/lib/toaster/tests/browser/test_layerdetails_page.py
index 6abfdef6999..0b45ca6e0f1 100644
--- a/lib/toaster/tests/browser/test_layerdetails_page.py
+++ b/lib/toaster/tests/browser/test_layerdetails_page.py
@@ -100,7 +100,7 @@ class TestLayerDetailsPage(SeleniumTestCase):
                             (self.initial_values, value))
 
             # Make sure the input visible beofre sending keys
-            self.wait_until_clickable("#layer-git input[type=text]")
+            self.wait_until_element_visible(inputs)
             inputs.send_keys("-edited")
 
         # Save the new values

