Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF8CDDE4E
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:09 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.5155.1729677608769940370
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RodZvtR9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43158625112so65540875e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677607; x=1730282407; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69jt7TcI06O6MGFJRh3cIVWgbv7OafvGIxjR78kPpM0=;
        b=RodZvtR94xpzGAJEY8s5IJKW6VMzUso8uzTHZAdS6/d5Ch+NZKmsndtRoYcJxCm3/k
         6D6SVvwETYqcpoQyJDaerFmlCQqJ5kEp7WiHhP3my0jDX7a5uqipvziajOC/kIRKm9pF
         iCOBVO/2Wjiy3AQVhQ4dLQ78cr4ClODk7bhq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677607; x=1730282407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69jt7TcI06O6MGFJRh3cIVWgbv7OafvGIxjR78kPpM0=;
        b=pbfRxSXnDxgBQeJ6G8Zj66dTAM/I2RFB/sh3O2N6IaGvhYF22OKyZEDx0RgZMxlh81
         4VsN+j+kjAyjelGmlluEaDBQTkr+ll/Y9scaqvmTu/R7o3fAFYkWR4hs81uFdAz2jYxE
         c0btl6RzZsjH4cP1gujlQ5qEWr6McF0rPYu+I2ufXMKaMX0+b4mJzFGnsH/HMXqKfFht
         BBp3RyYUb57dPw5WyxY/+IWTQYhb/WXpGn282U+R5yH4an4J6LELwXxKZVJt9F3a7Phx
         2ID1TOnB9Lv5KnBDGCoRQpPAVcCt5/16JBf4ZZAzJ82qHdXMAgMxX+uoqRnME6QTvvHA
         G2pA==
X-Gm-Message-State: AOJu0Yw3isI6rwqiL/WC4zm9SYVm16vDtjAn/XYHvDgUexiHkuGwzbOa
	njXSngLdK9PLUMJGjgJS6G2243OTRlvBNS6FrVsUSN4+z/MWLmHsxvhCQa1rzegKN0GAwRZIhiz
	1
X-Google-Smtp-Source: AGHT+IEx0+hEReGLZ4BPCCug7u2Yt642cBKIewmg5stdfN0k54y2DRqxHn5Q696oQZcTgOj9eFaX8A==
X-Received: by 2002:a05:600c:500a:b0:431:537d:b3b4 with SMTP id 5b1f17b1804b1-43184206669mr15055655e9.11.1729677606724;
        Wed, 23 Oct 2024 03:00:06 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:06 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 15/28] toaster/tests/browser/helpers: Add not visible wait function
Date: Wed, 23 Oct 2024 10:59:36 +0100
Message-ID: <20241023095949.3351980-15-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16706

In some cases we want to wait until some element is not visible.
Add such a function helper.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 5a4a4ef8b4..b664166055 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -227,6 +227,13 @@ class SeleniumTestCaseBase(unittest.TestCase):
         Wait(self.driver, poll=poll).until(is_visible, msg)
         return self.find(selector)
 
+    def wait_until_not_visible(self, selector, timeout=Wait._TIMEOUT):
+        """ Wait until element matching CSS selector is not visible on the page """
+        is_visible = lambda driver: self.find(selector).is_displayed()
+        msg = 'An element matching "%s" should be visible' % selector
+        Wait(self.driver, timeout=timeout).until_not(is_visible, msg)
+        return self.find(selector)
+
     def wait_until_clickable(self, selector, poll=1):
         """ Wait until element matching CSS selector is visible on the page """
         sel = selector

