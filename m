Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E68D0EE00
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 15:40:11 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.15059.1728661200916451667
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Oct 2024 08:40:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IR/BeH+x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4311fd48032so4935065e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728661199; x=1729265999; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AecoCllnHHNQLbaB6xIxRr9HW0t+SbXQisx0rEJTzAs=;
        b=IR/BeH+x0I805oB5cNbj6szLnl7AqjHHYzEdCDbBJTpqQeV0bwLM1C6XF2mR+QYwHP
         /qla8HrRtye9STPUsFApPdSOJr6Vtkl4JhBxx1FHHgpMv87zPcNxx8hl5d6k1QTSH6vF
         InToNh1/KSsYExU68oa4r5JlkBpiJ1c4/0o0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661199; x=1729265999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AecoCllnHHNQLbaB6xIxRr9HW0t+SbXQisx0rEJTzAs=;
        b=d9VgbJF08GuwTwtiTvLq9jh9+WXfr+P77AqGfoNjITbrmLDqaDZQuX4uCrC0JU5uyd
         irCzalzzWP217eG0HUqnc99WUmCpMiEgXp7XkDzQzxcDm/ICmvjKtXI/6R//C1wpmgUx
         G4tEdMLk+8dMKuSXkRwllvjSTuUC15shaFcBgjm7Wu89SF8JSC4mI8jd/q4Lup+f0X8X
         ZgzQ1zC8UVuho9ZEiNfS5GOhf6yGO90ng37S2DANs2Vzpz9NBA1BjTK57XZpGh6OZP83
         UBbfLC7Vs6B1mYTSApc1qqruRBF7Xt51tTmJvde0V0SiZBABioCnEYrkkmnqHioMUXjo
         LoQA==
X-Gm-Message-State: AOJu0YyACHisMml1aPPDrmlCFzsVu0eNajmG5aEJ7SWdEPaIV0csmMF5
	N+ArUc4weEhpIC+pQez/ZtbjDs2EZ+F27K/v6kRKOgnZZbaG/9wrL97GwIVe9mRIWkxhNnd6VUc
	a
X-Google-Smtp-Source: AGHT+IFzTiZ8h8QHisycwI1HO0MA24qukXi73azxrNiNqBETetPrW2P9VB5oxoSpIWehybUNNHNRVw==
X-Received: by 2002:a05:600c:4c86:b0:430:57f2:bafa with SMTP id 5b1f17b1804b1-4311df58831mr25224195e9.32.1728661199066;
        Fri, 11 Oct 2024 08:39:59 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8145:ba6d:a6de:28af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4441sm77732675e9.37.2024.10.11.08.39.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:39:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/browser: Avoid python 3.9 syntax
Date: Fri, 11 Oct 2024 16:39:57 +0100
Message-ID: <20241011153957.814078-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 15:40:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16672

Python 3.9 isn't our minimum version yet, avoid using removeprefix.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/browser/selenium_helpers_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toaster/tests/browser/selenium_helpers_base.py
index cc746511c3..7efc9ed34a 100644
--- a/lib/toaster/tests/browser/selenium_helpers_base.py
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py
@@ -231,12 +231,15 @@ class SeleniumTestCaseBase(unittest.TestCase):
 
     def wait_until_clickable(self, selector, poll=1):
         """ Wait until element matching CSS selector is visible on the page """
+        sel = selector
+        if sel.startswith('#'):
+            sel = selector[1:]
         WebDriverWait(
             self.driver,
             Wait._TIMEOUT,
             poll_frequency=poll
         ).until(
-            EC.element_to_be_clickable((By.ID, selector.removeprefix('#')
+            EC.element_to_be_clickable((By.ID, sel
                                         )
                                        )
         )

