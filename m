Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9C2CDDE4D
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:19 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.5163.1729677618663391337
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bhfI6Bij;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431688d5127so43005375e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677617; x=1730282417; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQyOznY/TigTPBoBdiooBbSy6xTCV0W3QIVBq7uC3FQ=;
        b=bhfI6BijnWOfNTdU/Pq7WD6Kz9r2uHIzeIOPmSj8ohhFsCv5Jg4TZRAAiZDp99Dn54
         CRLzDJT9sgZu3xMM22khsbsoQfmj8V2hYZJLZrNzFYcAM7UUJYduzzIgvaPujmQM9Bvw
         LCJHepSX9n+BAyVm31sMVRox7ThNv/tw7fnQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677617; x=1730282417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQyOznY/TigTPBoBdiooBbSy6xTCV0W3QIVBq7uC3FQ=;
        b=T9/6aCZY19vntDYgXYQTMm2TTbKsBVmDAjgM/qRn8Hn/4c2tLJMWWm/Gvmo/zsFpwu
         8n5QfoHIA8dWD99xSpJTpEDX/WAjUu2jm0uLByQmPHIg0zseYXPIr/ARH29+4iWgSWfz
         /zqAqE34ElW47C/ia5KvBG5mVEfY5P7aUXKHb4J9OR1ZGxXS2TyHeBLq/jvIJAV4iiql
         Y9Z1q6yR4cE1kWH8Y2m2TSQr2A0yMa69QuwQuJa+ywx5OBAO5iteahJ440SCaDpbzcnL
         nbqDIAcuU2lAbVvHXnvp2HTMTE+lezIeTZD/pIM2EuWn1JtA1qp3TYsfKW216BUVcJFO
         QEGg==
X-Gm-Message-State: AOJu0Yzd+9re93z0w9oJQgKEvmZ5FU8yHbBER/KM5rCsne0BJHzJJocf
	2AVnd9b8SpoAvmJr/iRsHPqD3nYsW7fB0DyldkwRPNMWyEqcMK6I2IVeQDpUehkqmdVnJ3ZFqeq
	Q
X-Google-Smtp-Source: AGHT+IFEYtxamF3IRYRv55CXVXFPhDA+rcFPgfsFTY9xrwcfTjyfiBSTn+KxNFhdN27LiWthFFwq3Q==
X-Received: by 2002:a05:600c:35cd:b0:431:4c14:abf4 with SMTP id 5b1f17b1804b1-43184150bc4mr18948055e9.14.1729677616726;
        Wed, 23 Oct 2024 03:00:16 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:16 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 25/28] toaster/tests/browser/helper: Add wait for jquery to complete
Date: Wed, 23 Oct 2024 10:59:46 +0100
Message-ID: <20241023095949.3351980-25-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16716

Most of the tests that click on buttons need the DOM to stablise, including
any running JQuery code before the test can proceed. Add calls to do this
whenever we're about to click on an element.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 4eea2267cc..6953541ab5 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -234,6 +234,7 @@ class SeleniumTestCaseBase(unittest.TestCase):
 
     def wait_until_clickable(self, selector, timeout=Wait._TIMEOUT):
         """ Wait until element matching CSS selector is visible on the page """
+        WebDriverWait(self.driver, timeout=timeout).until(lambda driver: self.driver.execute_script("return jQuery.active == 0"))
         is_clickable = lambda driver: (self.find(selector).is_displayed() and self.find(selector).is_enabled())
         msg = 'An element matching "%s" should be clickable' % selector
         Wait(self.driver, timeout=timeout).until(is_clickable, msg)
@@ -241,6 +242,7 @@ class SeleniumTestCaseBase(unittest.TestCase):
 
     def wait_until_element_clickable(self, finder, timeout=Wait._TIMEOUT):
         """ Wait until element is clickable """
+        WebDriverWait(self.driver, timeout=timeout).until(lambda driver: self.driver.execute_script("return jQuery.active == 0"))
         is_clickable = lambda driver: (finder(driver).is_displayed() and finder(driver).is_enabled())
         msg = 'A matching element never became be clickable'
         Wait(self.driver, timeout=timeout).until(is_clickable, msg)

