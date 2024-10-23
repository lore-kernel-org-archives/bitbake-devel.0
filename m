Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE7CDDE58
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:20 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.5160.1729677614261051786
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Oct 2024 03:00:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AfLAzlB3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d41894a32so480828f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729677612; x=1730282412; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqdAvMFjWfcaCRCe98kgUS6AG9Tg/vi9MC+kS3yohTw=;
        b=AfLAzlB3ujlhArEixzeaM8z8oQloxE/cB/aoKksYflg1E8ZU/LYJ9tEwCQXZEFsY99
         WoxO8+RZATbe82kj1RgVM7eLp/XI5BEJsmpkOf+TJTITQK8xRag4chA2cVGJROV2PZf3
         b+7LvzbPpCyh2IOu2DtLn/E/Skbu5IQV9U8SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729677612; x=1730282412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqdAvMFjWfcaCRCe98kgUS6AG9Tg/vi9MC+kS3yohTw=;
        b=II4sktd9dHm2KkHMw14amR3bDWTsjwvsn2IUvzi30VnNR2262EfFfwEZbIFdxRYwD0
         xduP2on1iIrbVl9d3LE0V8D17l/dpImirZ2DWej6E/hZTUKXik50B4hsFcg3+aUNSFvv
         XrT8arRt39929rPVje2/qjbDSpAIK7FyNPx1HFThfJgFx6ZuDq29QL74e4T98n3bnnBv
         8csVuritWvEsvIFVaBJyVvEn/b2BO9JPQh77KfEiQAWZSbzCnoK5uPnlVxBaGKitfYWA
         mOzvjOfGxKoR/WP3QF5+MFVcrcWd6l+9NE1BfxqDS8mUMjHJfCFOZKf7M0hRHAQ58+JQ
         CW+Q==
X-Gm-Message-State: AOJu0YyJZALkivxDT8FnjFKYLH8Of4I6p++ALAFLQ796MFGThgui9OSr
	Vy1yfjPnrZLIp+cS2EQb9LPbszQjU4fkrdxXurxTTaj8xZUCe9KeZfvXXRvlWcYczm1Qq60fsIs
	t
X-Google-Smtp-Source: AGHT+IFccLiQOUn0M6XmrE28Ti1sCc73BPMCOowFxH0BxRcnQQ3zYqBjjbBvP11BG2j42xmWExG3IA==
X-Received: by 2002:adf:ea43:0:b0:374:cee6:c298 with SMTP id ffacd0b85a97d-37ef14da61emr4183483f8f.21.1729677612214;
        Wed, 23 Oct 2024 03:00:12 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ad34:30ba:19ab:e41f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c001c7sm11668795e9.29.2024.10.23.03.00.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 03:00:11 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 20/28] toaster/tests/browser/helper: Improve wait_until_clickable exception handling
Date: Wed, 23 Oct 2024 10:59:41 +0100
Message-ID: <20241023095949.3351980-20-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
References: <20241023095949.3351980-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Oct 2024 10:00:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16711

Our own Wait() class allows exception handling which this form of wrapper
does not. Switch the code to use our Wait() class to allow retrying upon
encountering those exceptions (such as an element not being present yet).

The displayed and visible test is what Selenium would be doing internally,
there is no JS reprensetation of clickable directly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index 45eabaf1ce..82defea0f2 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -234,17 +234,9 @@ class SeleniumTestCaseBase(unittest.TestCase):
 
     def wait_until_clickable(self, selector, timeout=Wait._TIMEOUT):
         """ Wait until element matching CSS selector is visible on the page """
-        sel = selector
-        if sel.startswith('#'):
-            sel = selector[1:]
-        WebDriverWait(
-            self.driver,
-            timeout=timeout,
-        ).until(
-            EC.element_to_be_clickable((By.ID, sel
-                                        )
-                                       )
-        )
+        is_clickable = lambda driver: (self.find(selector).is_displayed() and self.find(selector).is_enabled())
+        msg = 'An element matching "%s" should be clickable' % selector
+        Wait(self.driver, timeout=timeout).until(is_clickable, msg)
         return self.find(selector)
 
     def wait_until_focused(self, selector):

