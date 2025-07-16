Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88BC83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 15:22:56 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.25322.1752679375887855231
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 08:22:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=La/AM1mg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d6ade159so49587985e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752679374; x=1753284174; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvDjIny/jFjz6X9EywLy6Fk/Hf6+FQazl+h5OrxV0WM=;
        b=La/AM1mgnGcPH6qfuaxhzo3dvUJ2ueH7A4+PU0d0TXLX3OGVcFAx0IksVfylOTmKbA
         IArtA31QNmmzN2XEncfky7j8zW2B1lpJLyuBQ9QAkF+P2oUw+j3Wq2GtGX6NxmCY/Evn
         UFYb5YSb4Uj4ghYEbKH6RJ1r9UQbS4tDMS2Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679374; x=1753284174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvDjIny/jFjz6X9EywLy6Fk/Hf6+FQazl+h5OrxV0WM=;
        b=aECPKUg+5fZlOdGpSAsA/CxIt0Lh4wR4pcrRha/IhEe1c//dKCCke6XlV6KcEo+IQR
         YvR2ZK19eKY70as+1GjgGVwx4NBtJNdyJItWGPBmkHZbepO0rQV9mCb7mAZeDC7iYs8h
         8MaafU1/lM0B59WabF2uuTY8wr+4KAja0tQzF9/Dc5LD7L6iO+JTwWDr+pG+Lcx6O/IS
         27lQ/1a1sRT7V24eUrvpm6DFI+48Q/8svwv04/nZSRj1RvOhvVGWP8fslbJo0Cq95wx0
         BgL943xORi9N2KaFboDpzgZcNnhhUgPmjXWToh3i2Wuw4e0NMKfOoxJN/MaAK8XcUM4N
         feig==
X-Gm-Message-State: AOJu0YyWSPQhnSFQyvzRwEi9pJNztok1WvkW6AxQtvDXxIsMfZXs8orX
	esRnFpF1J0WBnMURUKguY8LhBeKTl1Abf/+CPYE9gQzufN/wuCoVg72MzvXvhnNC4yHstKoI1Mg
	xdZjO
X-Gm-Gg: ASbGncvWPns1NyKTgNij7dui5Um7DQ9lv3PnoNiOlhuJF7BKvnGwS1lt9x6KSVMJvgU
	PayPEZxP48wfD/3akA+Tct14izkt2LL1repgObyQ3NALkStjpnN4/1LRf0/v0GjsGqBCsHYIy0n
	ixSbyF5AVKpYhQO3C9r+A9k+22kev9CDviziLEfg/BgEsEfGlZJ6zpAHYic03d0bICrjyyTYWTF
	HPpI7073uifejyjmu4ZBxf9Po1tlaNPtEk924hoXsKx/P/Dx4lQPZAhqpAu/6pq787j5CMzY+QR
	yrFP0fVBQh4PN6FTYczi4kLcnHYnRVVib/oM/lM/RvH9ROqOSANnYrgrEfOL6ahEeTvipMoXHjz
	nAPzrmVGllHWOC/x3NpTfLMKKGNTIjAJQxVCdpMjqkVhHFAnBwPY=
X-Google-Smtp-Source: AGHT+IFw6Yv33VGkQubDD99nygIAwQbVLFn9jnRYfQCQfuunfnTBkWPUtNmTvxtWha6XlRqrgnaP6w==
X-Received: by 2002:a05:600c:1c0f:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-45631f025aemr18070015e9.0.1752679373645;
        Wed, 16 Jul 2025 08:22:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:22ad:92e1:8848:8bb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm18362725f8f.60.2025.07.16.08.22.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] event: Fix an event duplication race
Date: Wed, 16 Jul 2025 16:22:48 +0100
Message-ID: <20250716152249.96126-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
References: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 15:22:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17781

It is possible for multple bitbake threads to empty ui_queue in parallel
leading to duplicate console messages and much confusion when debuging.

Use the lock to extract the queue data which means only one thread will
processing, removing the duplicate out of order messages.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index b29f0a55687..2256fed7648 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -236,9 +236,12 @@ def fire(event, d):
         # If messages have been queued up, clear the queue
         global _uiready, ui_queue
         if _uiready and ui_queue:
-            for queue_event in ui_queue:
+            with bb.utils.lock_timeout_nocheck(_thread_lock):
+                queue = ui_queue
+                ui_queue = []
+            for queue_event in queue:
                 fire_ui_handlers(queue_event, d)
-            ui_queue = []
+
         fire_ui_handlers(event, d)
 
 def fire_from_worker(event, d):

