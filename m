Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F3FCDDE46
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.5136.1729677601364586506
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DPvX7Ilk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso66924505e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677599; x=1730282399; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyrslNps/NUi6yiPu3AJoosTDm26ES04DdJ2F7mDL1c=;
        b=DPvX7IlkCFZraTK8u8BCBI6ym0rwnArQbMDLxS0HRQq8aQJJTCh4o05s/1cIKQuUd5
         TXk1FNxM7PH0NrwVmUW98HqaLS7QBUgxXgtpKvymlj7m9s+FJud/uEoAZVB07UK0tRvu
         oZc/5t/DJTnGpv7BbHPhv41Mfi2aOJsvj8jzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677599; x=1730282399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyrslNps/NUi6yiPu3AJoosTDm26ES04DdJ2F7mDL1c=;
        b=ZsGi7Ll35KaWAXeB39gKYuEgMtQI8w/VjHr+M0RW6cIi67kozqijXCA/tPddn470Ak
         UBZSZANa/IF2vvFjm9W7fuDScdbSBhld1Jc9vLWIhssoTexYwpZToVCa48kPQ1Jsr63i
         +FJ8JjxB3t8zG8XNivw5fQ++FCig9wKinQa4X54u/HCpv/rPNTzQR7nIbG8+jd5I2QaT
         kqAIuGrcd+LeV9FBAdtyU1jaE1xyoGi/HUh9jkFOmxjXWFk95yk2gxY2twDfdrmuyVTA
         nZ69yX/byTaQgdy4EehUqJfmYWaWl4BQmpcQmso4ZMfzlZWO0AIiayRiGiQ3RYUU5mms
         vt7Q==
X-Gm-Message-State: AOJu0Yzc7NwZj/sV77Fdru64lv6IX7XenMLiIrPANXdgOGmLATJ0YVCF
	76cB96zYV324nEhwhvgdpGIcAxNUjDuw9Fd/onJVlu49fcKog6YzxJ6k24peKNGp/0ZarLmta16
	h
X-Google-Smtp-Source: AGHT+IHbM1PdfIha0Hnnt/Nl/24CwxNxxL7iT8UPc2+VVz+tJk/OcN2yowipJyLEZRobF1pKoS8Taw==
X-Received: by 2002:adf:fa87:0:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-37efcf8ec89mr1287346f8f.48.1729677599512;
        Wed, 23 Oct 2024 02:59:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.02.59.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 02:59:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/28] toaster/tests/functional/helpers: Drop unneeded poll values and sleep
Date: Wed, 23 Oct 2024 10:59:30 +0100
Message-ID: <20241023095949.3351980-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16700

Drop the remaining poll values and the sleep within the main wait function
as the races this was working around now seem to be resolved with the
preceeding patches.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 1 -
 lib/toaster/tests/functional/functional_helpers.py | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index b060133b1d..5a4a4ef8b4 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -225,7 +225,6 @@ class SeleniumTestCaseBase(unittest.TestCase):
         is_visible = lambda driver: self.find(selector).is_displayed()
         msg = 'An element matching "%s" should be visible' % selector
         Wait(self.driver, poll=poll).until(is_visible, msg)
-        time.sleep(poll)  # wait for visibility to settle
         return self.find(selector)
 
     def wait_until_clickable(self, selector, poll=1):
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toaster/tests/functional/functional_helpers.py
index cc508e98d9..a7a3459630 100644
--- a/lib/toaster/tests/functional/functional_helpers.py
+++ b/lib/toaster/tests/functional/functional_helpers.py
@@ -167,7 +167,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
             self.assertEqual(del_response.status_code, 200)
 
         self.get(reverse('newproject'))
-        self.wait_until_visible('#new-project-name', poll=3)
+        self.wait_until_visible('#new-project-name')
         self.driver.find_element(By.ID,
                                  "new-project-name").send_keys(project_name)
 
@@ -187,7 +187,7 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):
 
         self.driver.find_element(By.ID, "create-project-button").click()
 
-        element = self.wait_until_visible('#project-created-notification', poll=3)
+        element = self.wait_until_visible('#project-created-notification')
         self.assertTrue(
             self.element_exists('#project-created-notification'),
             f"Project:{project_name} creation notification not shown"

