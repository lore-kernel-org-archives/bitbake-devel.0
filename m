Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0BDD0D7B4
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 14:52:01 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.13761.1728658311828051858
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Oct 2024 07:51:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dA2TQDdo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4b0943c7so1172029f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728658310; x=1729263110; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWJqyMgeLcii9XsalvSOt/B++FREAffE0MsdY+KyR4Q=;
        b=dA2TQDdoVFUoaRq2/fQiMt5IyWPaGZTUA4IRrOy3QST0dFkhGOTtJdv64YCOFH6dNm
         NmX0z0kWfa26OYvIliyXpYO4uGtDjHQViT8ikP/h10CHdW13ZlydxvbwE10ds1vMyogD
         HtwF6SUV6YdNuQy6b81i77de5Ggk3Bs53i9ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658310; x=1729263110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWJqyMgeLcii9XsalvSOt/B++FREAffE0MsdY+KyR4Q=;
        b=Rm6yYysHriM9HzJO4t6kJ+UX95A+dyPm7ZmxR/BYPmZsXOXmtOm6TO9k260wT9CktP
         /e7P4JfpCW3JB2LetP88JeZhkC0YKeBpEWFdK1bAh7ogMG8srjH3Zw7Rhg/Vbq5tOLIb
         bSJFl2cZMa2TEKVjV5smaxvF/6fFCQQDybcox1J3dAnSpYkU4yVf8gY20/B/HnNLJfDg
         E/OQEKGyUXsK8ML+ZeeYf9txbArc2p64SkvwgsevwEoskQFDMzgQ3qtwzPMBmu4/vJxj
         03uP07y76mt7QrgtB/h7H2GgLZeBSwc8SEiu7WXSsSduEGPJUQ8kG/PhqIbkCVLhMPZQ
         XdJw==
X-Gm-Message-State: AOJu0YyrcYJEvgu9W1yzjEeF9rkBlw+AwxlvP8s1vWKH5I7i0kXWk6VS
	Nhjo3+cvdx4Or/yAio94+HO9kWLBJNBnztg3Dj8n/YZXoE4/nsPuDwqfwqHQIUAcqdQ4J1Kar59
	J
X-Google-Smtp-Source: AGHT+IH8dtzvfFknMJNL4mx5IVvzFFdWatndKk5ngxaD6MVd44XdKESnhF1dGUSLyPkethfO8jKBLA==
X-Received: by 2002:a5d:564b:0:b0:37c:d2f0:7331 with SMTP id ffacd0b85a97d-37d54e161admr2448386f8f.0.1728658309799;
        Fri, 11 Oct 2024 07:51:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8145:ba6d:a6de:28af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd032sm4142053f8f.30.2024.10.11.07.51.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:51:49 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] toaster/tests/selenium_helper_base: Handle WebDriverException
Date: Fri, 11 Oct 2024 15:51:46 +0100
Message-ID: <20241011145148.800080-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 14:52:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16669

The WebDriverException can occur if elements are not present in the DOM
yet. Catch and handle this. It is our most frequently occuring failure
in automated testing now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 393be75496..22d4085b24 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -27,7 +27,7 @@ from selenium.webdriver.common.by import By
 from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
 from selenium.common.exceptions import NoSuchElementException, \
         StaleElementReferenceException, TimeoutException, \
-        SessionNotCreatedException
+        SessionNotCreatedException, WebDriverException
 
 def create_selenium_driver(cls,browser='chrome'):
     # set default browser string based on env (if available)
@@ -114,6 +114,9 @@ class Wait(WebDriverWait):
                 pass
             except StaleElementReferenceException:
                 pass
+            except WebDriverException:
+                # selenium.common.exceptions.WebDriverException: Message: unknown error: unhandled inspector error: {"code":-32000,"message":"Node with given id does not belong to the document"}
+                pass
 
             time.sleep(self._poll)
             if time.time() > end_time:

