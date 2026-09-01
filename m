Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CEFC61DD6
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 22:56:13 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.193.1788303364862702121
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Sep 2026 15:56:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AIpq/4Gl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-482fc3327fdso305361f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788303363; x=1788908163; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GrwQKkGxwvLSK+Q+NfMQfa4THH1p9OQVf+jL+RY8DFo=;
        b=AIpq/4GlBjOXJMe2G/rn44CjfWI7ugJs1vyzRH6p7Sjaerj8wOUruZxNYTTGxIxWK/
         /uhjV/LBVIWiZHv1mmgTTPR1zI56a39zTLUy8JS3AKituvKehSzQcsV9UX6KA6kLIY8X
         F6w6FxLthKWxTs1yijiTNNBJf7wlw89wQj/30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303363; x=1788908163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GrwQKkGxwvLSK+Q+NfMQfa4THH1p9OQVf+jL+RY8DFo=;
        b=IbzYaokWly19wxb5PBx7KieDaG4lsiVtaRVOuzN10vrESNERj0kjTvdVtGORUff5Qv
         nd97wMdQO+85TaT/56Fbm6BS11ITVsfWkOEQ6bzPtDC2GLv3x3OAZbRkUA+HAmGDKQR7
         zzuozL1ykp4KpHonkuG2VJpailk3sF10ny59fLanlm9t4nu6in/dlTtj61yqan5H3mmN
         7gZKblKDNTEC+VlGLSr3EIi5jv0KsgFKCLrEX/EVbB55uIliyDYijyHHHdrtt9RT98TL
         Lxd7CXbhbsSam7swA8jexQ7ZiZv00fbpyhetmCHWswUs1sVleWagrIIXRtfmgbc2L7ie
         uZnQ==
X-Gm-Message-State: AFuF++kn09cziZqDdWuK29g15xp+JdjGRFOH1gHRWu57b7mtGPLNcvvS
	kZdcbdFFUuP9SxkOxs9lCmKUCFGjUbk+rkgEwKPUe5QssPEFyolbj3It5Lkl7jmdBSVLV0KkCJz
	4XoMIV5g=
X-Gm-Gg: AYBFou18iWm0sXh5sDgINvWFHleDm+gfHSkpk3WUYhqBUgclqSNb2hWKCdfM7fHxQM/
	lhYGJiM8f1m9vhrEcOchb0raWhkMjGOce6dtOAQnuHonOo2VFck9XsFo2O8s7FOf5JSwLYjvaA5
	gw9Beu9IHtWs40GP5HRaw5JoNmcDHUos5w+il95u+G83kjr4qPQQjBGyxTC1FZ0y/QmyegRlFpN
	iUav4otxKkpLxiUJZqWS8LkTZ++hBG/UXU8fNuep5vtqtM5dPIhAzE+TqmLrxMZOwn4PfW9rB+j
	to3tgIQT20RqUQmZsCbWuMxYKUFh94xbZVy56khkjOpLrpDr+1RbAhm/qKWEpzFbqrO1NoJCNss
	9QGEg+5o24gAQkJHG/HS2vsY3D3UuOPx0u69sO6vuYjxikgnlelu6VVfMVxrLAflp7jPRTl017A
	qRdAaC0tIBmPtY7E0Dn3/pljtveByfvT3xWerOq82bKnk6Dnqstltniz9LpiIXslXjn/6LFTKNJ
	cCmf25Wd33peRJ7eu4=
X-Received: by 2002:a05:6000:40cb:b0:482:e1b0:8a1a with SMTP id ffacd0b85a97d-484913b80e8mr824460f8f.15.1788303363071;
        Tue, 01 Sep 2026 15:56:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9e4b:8577:fa6f:4727])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed37c4sm1644388f8f.21.2026.09.01.15.56.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:56:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/5] tests/selenium_helpers_base: Add wait_until_element_clickable
Date: Tue,  1 Sep 2026 23:55:54 +0100
Message-ID: <20260901225555.2254932-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
References: <20260901225555.2254932-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Sep 2026 22:56:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20143

Add a version of the wait function that works on a specific element but
can also scroll to make the element clickable. To do this we need
to add an optional scroll function to the core wait function, but this
may be useful in other functions here eventually.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/browser/selenium_helpers_base.py    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index ca27b3b9877..ce108e2fccc 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -27,7 +27,9 @@ from selenium.webdriver.common.by import By
 from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
 from selenium.common.exceptions import NoSuchElementException, \
         StaleElementReferenceException, TimeoutException, \
-        SessionNotCreatedException, WebDriverException
+        SessionNotCreatedException, WebDriverException, \
+        ElementNotInteractableException
+from selenium.webdriver.common.action_chains import ActionChains
 
 def create_selenium_driver(cls,browser='chrome'):
     # set default browser string based on env (if available)
@@ -98,7 +100,7 @@ class Wait(WebDriverWait):
         self._POLL_FREQUENCY = poll
         super(Wait, self).__init__(driver, self._TIMEOUT, self._POLL_FREQUENCY)
 
-    def until(self, method, message=''):
+    def until(self, method, message='', scroll=None):
         """
         Calls the method provided with the driver as an argument until the
         return value is not False.
@@ -107,9 +109,14 @@ class Wait(WebDriverWait):
         end_time = time.time() + self._timeout
         while True:
             try:
+                if scroll:
+                    scroll(self._driver)
                 value = method(self._driver)
                 if value:
                     return value
+
+            except ElementNotInteractableException:
+                pass
             except NoSuchElementException:
                 pass
             except StaleElementReferenceException:
@@ -255,6 +262,15 @@ class SeleniumTestCaseBase(unittest.TestCase):
         Wait(self.driver, timeout=timeout).until(is_clickable, msg)
         return finder(self.driver)
 
+    def wait_until_element_clickable(self, element, timeout=Wait._TIMEOUT):
+        """ Wait until element is clickable """
+        WebDriverWait(self.driver, timeout=timeout).until(lambda driver: self.driver.execute_script("return jQuery.active == 0"))
+        is_clickable = lambda driver: (element.is_displayed() and element.is_enabled())
+        scroll = lambda driver: ActionChains(driver).move_to_element(element).perform()
+        msg = 'A matching element never became be clickable'
+        Wait(self.driver, timeout=timeout).until(is_clickable, msg, scroll=scroll)
+        return
+
     def wait_until_focused(self, selector):
         """ Wait until element matching CSS selector has focus """
         is_focused = \

