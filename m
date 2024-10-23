Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E96FCDDE51
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.5158.1729677612138175212
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Kr7teBdl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so53294255e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677610; x=1730282410; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv4xsGBB2jiSVmDLqiEaC6vVRq/BLs0Tmoem7ZFLu9k=;
        b=Kr7teBdlRc/YavNgzV46969zUtciJP1Gk/ewz2j4qvrN1vuxL0cfpqM9d60Q3roih7
         Eo8eZZFnAf8XPj0fUDzZogtFOUgq5NxII3XuZtsqWxAWZo/kNdx6JFYzdCrhtRR059hJ
         hd6qD+V5eKmmGmystOcUSk1dMfADnjNiy/WP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677610; x=1730282410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv4xsGBB2jiSVmDLqiEaC6vVRq/BLs0Tmoem7ZFLu9k=;
        b=NE5ljpA0Fsb3LVu+C60hM7VsJWS3x0Tj5I/ktyDtiqOJc0cE7eum6n7Vj+hCCnPHwb
         1r0/X5dP2NT7EnWSjhZfclBsHFdyBn0TNIte0MNe5TfaNZ9YzBJRru1W07+f3sAwxtO9
         OwpXPrgdRTTAiwDktW64PvPyZTr8UeeZhe+NRSHEviTKkA1nS8tUlrh6kM01w1AdaWoF
         NPdURiaJIgTzah/ubGw1IRou56RdIhYNmUsjF7SW8q0wgxvfG8XKZFwJ4ZUuuA8lx9xO
         GSjOSRGvWGzF/eEoZYXs1f5BWWIBkMBZNV2QJ8wrVQzE/tYHuYxqgxYh4wfGvp3mIe2f
         GtTg==
X-Gm-Message-State: AOJu0YysuHcyIUTdWMV/N6yNIpSAoAeBoGQfTfBZFZPBQKeDxSd7LCVX
	VHXdQP3tRS8P5EGdB2I4fyh1rfu4ldPXHk1xoEIkJvfPRkhg2YIkwinmCJJ/Mwnku6xJbvvoaC6
	M
X-Google-Smtp-Source: AGHT+IGt0HOy171bVjESY2q9BWKUlZ4lrfiUmtVJLyC91973kWh0599vUi9ooyabfnVzAFdtDAKXCg==
X-Received: by 2002:a5d:6487:0:b0:37d:3964:e0f1 with SMTP id ffacd0b85a97d-37efcef0c90mr1529259f8f.4.1729677610158;
        Wed, 23 Oct 2024 03:00:10 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:09 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 18/28] toaster/tests/browser/helpers: Drop remains of polling/sleep calls
Date: Wed, 23 Oct 2024 10:59:39 +0100
Message-ID: <20241023095949.3351980-18-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16709

Drop the remaining poll parameters from the helpers code along
with the remaining sleep call since the tests no longer depend
on this.

This has the nice benefit of significantly speeding up the toaster
test runs (45 minutes down to 12 minutes overall).

If a parameter is needed, it should be the timeout, not the polling
frequency.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../tests/browser/selenium_helpers_base.py      | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index b664166055..45eabaf1ce 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -186,7 +186,7 @@ class SeleniumTestCaseBase(unittest.TestCase):
         self.driver.get(abs_url)
 
         try:  # Ensure page is loaded before proceeding
-            self.wait_until_visible("#global-nav", poll=3)
+            self.wait_until_visible("#global-nav")
         except NoSuchElementException:
             self.driver.implicitly_wait(3)
         except TimeoutException:
@@ -211,20 +211,18 @@ class SeleniumTestCaseBase(unittest.TestCase):
         """ Return the element which currently has focus on the page """
         return self.driver.switch_to.active_element
 
-    def wait_until_present(self, selector, poll=0.5):
+    def wait_until_present(self, selector, timeout=Wait._TIMEOUT):
         """ Wait until element matching CSS selector is on the page """
         is_present = lambda driver: self.find(selector)
         msg = 'An element matching "%s" should be on the page' % selector
-        element = Wait(self.driver, poll=poll).until(is_present, msg)
-        if poll > 2:
-            time.sleep(poll)  # element need more delay to be present
+        element = Wait(self.driver, timeout=timeout).until(is_present, msg)
         return element
 
-    def wait_until_visible(self, selector, poll=1):
+    def wait_until_visible(self, selector, timeout=Wait._TIMEOUT):
         """ Wait until element matching CSS selector is visible on the page """
         is_visible = lambda driver: self.find(selector).is_displayed()
         msg = 'An element matching "%s" should be visible' % selector
-        Wait(self.driver, poll=poll).until(is_visible, msg)
+        Wait(self.driver, timeout=timeout).until(is_visible, msg)
         return self.find(selector)
 
     def wait_until_not_visible(self, selector, timeout=Wait._TIMEOUT):
@@ -234,15 +232,14 @@ class SeleniumTestCaseBase(unittest.TestCase):
         Wait(self.driver, timeout=timeout).until_not(is_visible, msg)
         return self.find(selector)
 
-    def wait_until_clickable(self, selector, poll=1):
+    def wait_until_clickable(self, selector, timeout=Wait._TIMEOUT):
         """ Wait until element matching CSS selector is visible on the page """
         sel = selector
         if sel.startswith('#'):
             sel = selector[1:]
         WebDriverWait(
             self.driver,
-            Wait._TIMEOUT,
-            poll_frequency=poll
+            timeout=timeout,
         ).until(
             EC.element_to_be_clickable((By.ID, sel
                                         )

