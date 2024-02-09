Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9876C4829B
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 23:56:27 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.3035.1707522978983421260
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 15:56:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Iso0EwII;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4108cce1353so886115e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 15:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707522977; x=1708127777; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXv1HNggM4eoKZ4qPe19ZvSeYZG7lbLbGbHpUe3Tl9s=;
        b=Iso0EwII3JPzaQeS+plAo2huoenyLqr93sUGY3UbB1mpChMXVTTM6yCBNV5vi+bAsA
         sNt3oBAY4QszjvfCr9Pfc5ARcxXHFmbgMnM0dnuEj0GAJUChKo4aQJMFEw3ROPsQw0NV
         RU25wF/79PZetk0Tc30IHe/Iqe/tU73KW2RJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707522977; x=1708127777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXv1HNggM4eoKZ4qPe19ZvSeYZG7lbLbGbHpUe3Tl9s=;
        b=QsIvZZbvg2j6P7n1QYy42A5a+Xd8UVwXpCMJH5KiSSOf5717rXDCejxt4brVRhdkyJ
         Zm1Kc1a9iiR98TwVKIG2gYx4oKHLzu/KG+xYrQVrNpmY20J0KJabFU4Tho2NV10Uge+H
         e6/kmeBP+zyqF2PggdfVzegmnzVh//w3KrSb8AOWBq2+3Z+vqJtDCc85QHbBuz8vXUZf
         kDqvqFqgROx6sX9O8jNIVFYAVn4VHh2xJrlI3WohzQx1DdI9EvlEFIolgjwGxgy+Dcmz
         4zGGG8fOO02HRZzz2IlE4VBcTL/9L0mr3S4Rgjcgt24UU9jsYjD0yp4mSdUIJNpVWNxU
         0k+Q==
X-Gm-Message-State: AOJu0Yx45AjnwPJJIdSSbh9fLcYIewcrbjsht3Sz2hijifZFAwt6tV6C
	R1Sf9fAWmStBvXIXNmIuDJvOSY3HYbVEYQRndql3z1O6pyANVT4IQOWwB7ePWYcY9XmcslGnZKB
	1
X-Google-Smtp-Source: AGHT+IH7Zis8bFm46IBrmBWqCjc3S4Da5hg/zPXCO1yfQfzXNbK1exfcmsAc3eBaBhQ9JKB6YJGVeg==
X-Received: by 2002:a05:600c:4f13:b0:40f:ddce:cac4 with SMTP id l19-20020a05600c4f1300b0040fddcecac4mr499625wmq.17.1707522976940;
        Fri, 09 Feb 2024 15:56:16 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c350:b3c8:3bca:cef1])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c248700b0040fddaf9ff4sm1856750wms.40.2024.02.09.15.56.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:56:16 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] process: Add profile logging for main loop
Date: Fri,  9 Feb 2024 23:56:15 +0000
Message-Id: <20240209235615.3473502-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 23:56:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15869

When the idle/main loop was added, we didn't include profiling information
for it. There is a performance issue in there, add logging for it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 6d77ce4786..1ca8e02ba0 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -402,6 +402,22 @@ class ProcessServer():
                 serverlog("".join(msg))
 
     def idle_thread(self):
+        if self.cooker.configuration.profile:
+            try:
+                import cProfile as profile
+            except:
+                import profile
+            prof = profile.Profile()
+
+            ret = profile.Profile.runcall(prof, self.idle_thread_internal)
+
+            prof.dump_stats("profile-mainloop.log")
+            bb.utils.process_profilelog("profile-mainloop.log")
+            serverlog("Raw profiling information saved to profilemainloop.log and processed statistics to profilemainloop.log.processed")
+        else:
+            self.idle_thread_internal()
+
+    def idle_thread_internal(self):
         def remove_idle_func(function):
             with bb.utils.lock_timeout(self._idlefuncsLock):
                 del self._idlefuns[function]
-- 
2.40.1


